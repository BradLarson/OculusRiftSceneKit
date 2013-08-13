//
//  SLSOculusView.h
//  OculusSceneKit
//
//  Created by Brad Larson on 8/10/2013.
//  Copyright (c) 2013 Sunset Lake Software LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SceneKit/SceneKit.h>

@interface SLSOculusView : NSView
{
    SCNView *leftEyeView, *rightEyeView;
    SCNNode *leftEyeCameraNode, *rightEyeCameraNode;
}

@property(readwrite, retain, nonatomic) SCNScene *scene;
@property(readwrite, nonatomic) CGFloat interpupillaryDistance;
@property(readwrite, nonatomic) SCNVector3 cameraLocation;

@end
