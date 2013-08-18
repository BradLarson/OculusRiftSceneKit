#import "SLSAppDelegate.h"

@implementation SLSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    SCNScene *scene = [SCNScene scene];
    
    SCNNode *objectsNode = [SCNNode node];
    [scene.rootNode addChildNode:objectsNode];
    
    objectsNode.scale = SCNVector3Make(0.02, 0.02, 0.02);
    objectsNode.position = SCNVector3Make(0, -300.0, -250);
    objectsNode.rotation = SCNVector4Make(1, 0, 0, -M_PI/2);
    
    // Chess model is from the WWDC 2013 Scene Kit presentation
    SCNScene *chessboardScene = [SCNScene sceneNamed:@"chess"];
    SCNNode *chessboardNode = [chessboardScene.rootNode childNodeWithName:@"Line01" recursively:YES];
    NSLog(@"Chess node: %@", chessboardNode);
    [objectsNode addChildNode:chessboardNode];
    
    SCNNode *bishop = [chessboardNode childNodeWithName:@"bishop" recursively:YES];
    bishop.geometry.firstMaterial.reflective.intensity = 0.7;
    bishop.geometry.firstMaterial.fresnelExponent = 1.5;
    
    SCNNode *L = [chessboardNode childNodeWithName:@"L" recursively:YES];
    L.geometry.firstMaterial.reflective.intensity = 0.7;
    L.geometry.firstMaterial.fresnelExponent = 1.5;

    // Create a diffuse light
	SCNLight *diffuseLight = [SCNLight light];
    diffuseLight.color = [NSColor colorWithDeviceRed:0.1 green:0.1 blue:0.1 alpha:0.5];
    SCNNode *diffuseLightNode = [SCNNode node];
    diffuseLight.type = SCNLightTypeOmni;
    diffuseLightNode.light = diffuseLight;
	diffuseLightNode.position = SCNVector3Make(200.0, 400.0, -100);
	[scene.rootNode addChildNode:diffuseLightNode];

    // Create a top-down spotlight
	SCNLight *spotLight = [SCNLight light];
    SCNNode *spotLightNode = [SCNNode node];
    spotLight.type = SCNLightTypeSpot;
    spotLightNode.light = diffuseLight;
	spotLightNode.position = SCNVector3Make(0, 300, -250);
    spotLightNode.rotation = SCNVector4Make(1, 0, 0, M_PI_2);
    [spotLight setAttribute:@30 forKey:SCNLightShadowNearClippingKey];
    [spotLight setAttribute:@50 forKey:SCNLightShadowFarClippingKey];
    [spotLight setAttribute:@10 forKey:SCNLightSpotInnerAngleKey];
    [spotLight setAttribute:@45 forKey:SCNLightSpotOuterAngleKey];
	[scene.rootNode addChildNode:spotLightNode];
    
    self.oculusView.scene = scene;
    [self.oculusView setBackgroundColorRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    
    // Have this start in fullscreen so that the rendering matches up to the Oculus Rift
    [self.window toggleFullScreen:nil];
}


- (IBAction)increaseIPD:(id)sender;
{
    self.oculusView.interpupillaryDistance = self.oculusView.interpupillaryDistance + 2.0;
}

- (IBAction)decreaseIPD:(id)sender;
{
    self.oculusView.interpupillaryDistance = self.oculusView.interpupillaryDistance - 2.0;
}

- (IBAction)increaseDistance:(id)sender;
{
    SCNVector3 currentLocation = self.oculusView.headLocation;
    currentLocation.z = currentLocation.z - 50.0;
    self.oculusView.headLocation = currentLocation;
}

- (IBAction)decreaseDistance:(id)sender;
{
    SCNVector3 currentLocation = self.oculusView.headLocation;
    currentLocation.z = currentLocation.z + 50.0;
    self.oculusView.headLocation = currentLocation;
}

@end
