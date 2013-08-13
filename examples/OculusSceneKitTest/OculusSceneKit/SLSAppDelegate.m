//
//  SLSAppDelegate.m
//  OculusSceneKit
//
//  Created by Brad Larson on 8/9/2013.
//  Copyright (c) 2013 Sunset Lake Software LLC. All rights reserved.
//

#import "SLSAppDelegate.h"

@implementation SLSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    SCNScene *scene = [SCNScene scene];
    
//    SCNFloor *floor = [SCNFloor floor];
//    floor.reflectivity = 0.25f;
//    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
//    [scene.rootNode addChildNode:floorNode];

    SCNBox *cube = [SCNBox boxWithWidth:60 height:60 length:60 chamferRadius:0.0];
    SCNNode *cubeNode = [SCNNode nodeWithGeometry:cube];
//    CATransform3D rot2 = CATransform3DMakeRotation(45.0 * M_PI / 180.0, 1, 0, 0);
//    cubeNode.transform = rot2;
    cubeNode.position = SCNVector3Make(0, 0, 0);
    [scene.rootNode addChildNode:cubeNode];
    
    SCNTorus *torus = [SCNTorus torusWithRingRadius:60 pipeRadius:20];
    SCNNode *torusNode = [SCNNode nodeWithGeometry:torus];
//    CATransform3D rot = CATransform3DMakeRotation(45.0 * M_PI / 180.0, 1, 0, 0);
//    torusNode.transform = rot;
    torusNode.position = SCNVector3Make(0, 0, 0);
    [scene.rootNode addChildNode:torusNode];
    
    // Create ambient light
    SCNLight *ambientLight = [SCNLight light];
	SCNNode *ambientLightNode = [SCNNode node];
    ambientLight.type = SCNLightTypeAmbient;
	ambientLight.color = [NSColor colorWithDeviceWhite:0.1 alpha:1.0];
	ambientLightNode.light = ambientLight;
    [scene.rootNode addChildNode:ambientLightNode];
    
    // Create a diffuse light
	SCNLight *diffuseLight = [SCNLight light];
    SCNNode *diffuseLightNode = [SCNNode node];
    diffuseLight.type = SCNLightTypeOmni;
    diffuseLightNode.light = diffuseLight;
	diffuseLightNode.position = SCNVector3Make(-30, 30, 50);
	[scene.rootNode addChildNode:diffuseLightNode];
    
    // Animate the torus
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 0 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 1 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 2 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 3 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(torusNode.transform, 4 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        nil];
    animation.duration = 3.f;
    animation.repeatCount = HUGE_VALF;
    
    [torusNode addAnimation:animation forKey:@"transform"];
    [cubeNode addAnimation:animation forKey:@"transform"];

    NSLog(@"Oculus view: %@", self.oculusView);
    self.oculusView.scene = scene;
    self.oculusView2.scene = scene;
}


- (IBAction)increaseIPD:(id)sender;
{
    self.oculusView.interpupillaryDistance = self.oculusView.interpupillaryDistance + 2.0;
    self.oculusView2.interpupillaryDistance = self.oculusView2.interpupillaryDistance + 2.0;
}

- (IBAction)decreaseIPD:(id)sender;
{
    self.oculusView.interpupillaryDistance = self.oculusView.interpupillaryDistance - 2.0;
    self.oculusView2.interpupillaryDistance = self.oculusView2.interpupillaryDistance - 2.0;
}

- (IBAction)increaseDistance:(id)sender;
{
    SCNVector3 currentLocation = self.oculusView.cameraLocation;
    currentLocation.z = currentLocation.z - 50.0;
    self.oculusView.cameraLocation = currentLocation;
    self.oculusView2.cameraLocation = currentLocation;
}

- (IBAction)decreaseDistance:(id)sender;
{
    SCNVector3 currentLocation = self.oculusView.cameraLocation;
    currentLocation.z = currentLocation.z + 50.0;
    self.oculusView.cameraLocation = currentLocation;
    self.oculusView2.cameraLocation = currentLocation;
}

@end
