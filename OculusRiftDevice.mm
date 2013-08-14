#import "OculusRiftDevice.h"
#include "OVR.h"

@interface OculusRiftDevice()
{
    OVR::DeviceManager  *pManager;
    OVR::SensorDevice   *pSensor;
    OVR::HMDDevice      *pHMD;
    OVR::SensorFusion        SFusion;
    OVR::HMDInfo        HMDInfo;
    
    // Last update seconds, used for move speed timing.
    double              LastUpdate;
    OVR::UInt64         StartupTicks;
    
    // Position and look. The following apply:
    OVR::Vector3f            EyePos;
    float               EyeYaw;         // Rotation around Y, CCW positive when looking at RHS (X,Z) plane.
    float               EyePitch;       // Pitch. If sensor is plugged in, only read from sensor.
    float               EyeRoll;        // Roll, only accessible from Sensor.
    float               LastSensorYaw;  // Stores previous Yaw value from to support computing delta.
}

- (void)setupHMD;

@end

@implementation OculusRiftDevice

#pragma mark -
#pragma mark Initialization and teardown

- (id)init
{
    if (!(self = [super init]))
    {
		return nil;
    }
    
    OVR::System::Init(OVR::Log::ConfigureDefaultLog(OVR::LogMask_All));

    [self setupHMD];
    
    return self;
}

- (void)setupHMD;
{
    pManager = OVR::DeviceManager::Create();
    
	// We'll handle it's messages in this case.
//	pManager->SetMessageHandler(this);
    
    CFOptionFlags detectionResult;
    const char* detectionMessage;
    
    do
    {
        // Release Sensor/HMD in case this is a retry.
        delete(pSensor);
        delete(pHMD);
        
        pHMD  = pManager->EnumerateDevices<OVR::HMDDevice>().CreateDevice();
        if (pHMD)
        {
            pSensor = pHMD->GetSensor();
            
            // This will initialize HMDInfo with information about configured IPD,
            // screen size and other variables needed for correct projection.
            // We pass HMD DisplayDeviceName into the renderer to select the
            // correct monitor in full-screen mode.
            if (pHMD->GetDeviceInfo(&HMDInfo))
            {
//                RenderParams.MonitorName = HMDInfo.DisplayDeviceName;
//                RenderParams.DisplayId = HMDInfo.DisplayId;
//                SConfig.SetHMDInfo(HMDInfo);
            }
        }
        else
        {
            // If we didn't detect an HMD, try to create the sensor directly.
            // This is useful for debugging sensor interaction; it is not needed in
            // a shipping app.
            pSensor = pManager->EnumerateDevices<OVR::SensorDevice>().CreateDevice();
        }
        
        
        // If there was a problem detecting the Rift, display appropriate message.
        detectionResult  = kCFUserNotificationAlternateResponse;
        
        if (!pHMD && !pSensor)
            detectionMessage = "Oculus Rift not detected.";
        else if (!pHMD)
            detectionMessage = "Oculus Sensor detected; HMD Display not detected.";
        else if (!pSensor)
            detectionMessage = "Oculus HMD Display detected; Sensor not detected.";
        else if (HMDInfo.DisplayDeviceName[0] == '\0')
            detectionMessage = "Oculus Sensor detected; HMD display EDID not detected.";
        else
            detectionMessage = 0;
        
        if (detectionMessage)
        {
            OVR::String messageText(detectionMessage);
            messageText += "\n\n"
            "Press 'Try Again' to run retry detection.\n"
            "Press 'Continue' to run full-screen anyway.";
            
            CFStringRef headerStrRef  = CFStringCreateWithCString(NULL, "Oculus Rift Detection", kCFStringEncodingMacRoman);
            CFStringRef messageStrRef = CFStringCreateWithCString(NULL, messageText, kCFStringEncodingMacRoman);
            
            //launch the message box
            CFUserNotificationDisplayAlert(0,
                                           kCFUserNotificationNoteAlertLevel,
                                           NULL, NULL, NULL,
                                           headerStrRef, // header text
                                           messageStrRef, // message text
                                           CFSTR("Try again"),
                                           CFSTR("Continue"),
                                           CFSTR("Cancel"),
                                           &detectionResult);
            
            //Clean up the strings
            CFRelease(headerStrRef);
            CFRelease(messageStrRef);
            
            if (detectionResult == kCFUserNotificationCancelResponse ||
                detectionResult == kCFUserNotificationOtherResponse)
                return;
//                return 1;
        }
        
    } while (detectionResult != kCFUserNotificationAlternateResponse);
    
    
//    if (HMDInfo.HResolution > 0)
//    {
//        Width  = HMDInfo.HResolution;
//        Height = HMDInfo.VResolution;
//    }
    
    if (pSensor)
    {
        // We need to attach sensor to SensorFusion object for it to receive
        // body frame messages and update orientation. SFusion.GetOrientation()
        // is used in OnIdle() to orient the view.
        SFusion.AttachToSensor(pSensor);
//        SFusion.SetDelegateMessageHandler(this);
//		SFusion.SetPredictionEnabled(true);
    }
}

#pragma mark -
#pragma mark Current status extraction

- (SCNVector3)currentHeadRotationAngles;
{
    if (pSensor)
    {
        OVR::Quatf    hmdOrient = SFusion.GetOrientation();
        float    yaw = 0.0f;
        
        hmdOrient.GetEulerAngles<OVR::Axis_Y, OVR::Axis_X, OVR::Axis_Z>(&yaw, &EyePitch, &EyeRoll);
        
        EyeYaw += (yaw - LastSensorYaw);
        LastSensorYaw = yaw;
    }
    
    if (!pSensor)
    {
        const float maxPitch = ((3.1415f/2)*0.98f);
        if (EyePitch > maxPitch)
            EyePitch = maxPitch;
        if (EyePitch < -maxPitch)
            EyePitch = -maxPitch;
    }

    return SCNVector3Make(EyeYaw, EyePitch, EyeRoll);
}

- (CATransform3D)currentHeadTransform;
{
    SCNVector3 currentHeadRotationAngles = [self currentHeadRotationAngles];
    
    CATransform3D rotation1 = CATransform3DMakeRotation(currentHeadRotationAngles.x, 0.0f, 1.0f, 0.0f);
    rotation1 = CATransform3DRotate(rotation1, currentHeadRotationAngles.y, 1.0, 0.0, 0.0);
    rotation1 = CATransform3DRotate(rotation1, currentHeadRotationAngles.z, 0.0, 0.0, 1.0);
    return rotation1;
}

@end
