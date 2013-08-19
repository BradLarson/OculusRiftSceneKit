#import "SLSAppDelegate.h"

@implementation SLSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    SCNScene *scene = [SCNScene scene];
    
    SCNNode *objectsNode = [SCNNode node];
    [scene.rootNode addChildNode:objectsNode];
    
    objectsNode.scale = SCNVector3Make(0.1, 0.1, 0.1);
    objectsNode.position = SCNVector3Make(0, -100.0, 0.0);
    objectsNode.rotation = SCNVector4Make(1, 0, 0, -M_PI / 2.0);
    
    // Chess model is from the WWDC 2013 Scene Kit presentation
    SCNScene *chessboardScene = [SCNScene sceneWithURL:[[NSBundle mainBundle] URLForResource:@"chess" withExtension:@"dae"] options:nil error:nil];
    SCNNode *chessboardNode = [chessboardScene.rootNode childNodeWithName:@"Line01" recursively:YES];
    NSLog(@"Chess node: %@", chessboardNode);
    [objectsNode addChildNode:chessboardNode];
    
    // Create a diffuse light
	SCNLight *diffuseLight = [SCNLight light];
    diffuseLight.color = [NSColor colorWithDeviceRed:1.0 green:1.0 blue:0.8 alpha:1.0];
    SCNNode *diffuseLightNode = [SCNNode node];
    diffuseLight.type = SCNLightTypeOmni;
    diffuseLightNode.light = diffuseLight;
	diffuseLightNode.position = SCNVector3Make(0.0, 1000.0, 300);
    [diffuseLight setAttribute:@4500 forKey:SCNLightAttenuationEndKey];
    [diffuseLight setAttribute:@500 forKey:SCNLightAttenuationStartKey];
	[scene.rootNode addChildNode:diffuseLightNode];
    
    self.oculusView.scene = scene;
    [self.oculusView setBackgroundColorRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    self.oculusView.headLocation = SCNVector3Make(0.0, 300.0, 0.0);
    
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
