//
//  SLSOculusView.m
//  OculusSceneKit
//
//  Created by Brad Larson on 8/10/2013.
//  Copyright (c) 2013 Sunset Lake Software LLC. All rights reserved.
//

#import "SLSOculusView.h"

@implementation SLSOculusView

@synthesize scene = _scene;
@synthesize interpupillaryDistance = _interpupillaryDistance;
@synthesize cameraLocation = _cameraLocation;

#pragma mark -
#pragma mark Initialization and teardown

- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame]))
    {
		return nil;
    }
    
    [self commonInit];
    
    return self;
}

-(id)initWithCoder:(NSCoder *)coder
{
	if (!(self = [super initWithCoder:coder]))
    {
        return nil;
	}
    
    [self commonInit];
    
	return self;
}

- (void)commonInit;
{
    NSRect currentFrame = self.frame;
    
    _interpupillaryDistance = 64.0;
    _cameraLocation = SCNVector3Make(0.0, 0.0, 200.0);

    leftEyeView = [[SCNView alloc] initWithFrame:NSMakeRect(0.0, 0.0, round(currentFrame.size.width / 2.0), currentFrame.size.height)];
    rightEyeView = [[SCNView alloc] initWithFrame:NSMakeRect(round(currentFrame.size.width / 2.0), 0.0, currentFrame.size.width - round(currentFrame.size.width / 2.0), currentFrame.size.height)];

    leftEyeView.backgroundColor = [NSColor redColor];
    rightEyeView.backgroundColor = [NSColor redColor];

    leftEyeView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable |NSViewMaxXMargin;
    rightEyeView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable | NSViewMinXMargin;
    
    NSLog(@"Initial frame: %f, %f, %f, %f", currentFrame.origin.x, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
    
    [self addSubview:leftEyeView];
    [self addSubview:rightEyeView];
}

#pragma mark -
#pragma mark Accessors

- (void)setScene:(SCNScene *)newValue;
{
    _scene = newValue;
    leftEyeView.scene = _scene;
    rightEyeView.scene = _scene;
    
    // TODO: Deal with re-adding camera nodes for setting the same scene
    // 64 mm interpupillary distance
    SCNCamera *leftEyeCamera = [SCNCamera camera];
    leftEyeCamera.xFov = 90;
    leftEyeCamera.yFov = 90;
    leftEyeCamera.zNear = 0.1;
    leftEyeCamera.zFar = 2000;
	leftEyeCameraNode = [SCNNode node];
	leftEyeCameraNode.camera = leftEyeCamera;
    leftEyeCameraNode.transform = CATransform3DMakeTranslation(-(_interpupillaryDistance / 2.0) + _cameraLocation.x, _cameraLocation.y, _cameraLocation.z);
    [_scene.rootNode addChildNode:leftEyeCameraNode];
    
    SCNCamera *rightEyeCamera = [SCNCamera camera];
    rightEyeCamera.xFov = 90;
    rightEyeCamera.yFov = 90;
    rightEyeCamera.zNear = 0.1;
    rightEyeCamera.zFar = 2000;
	rightEyeCameraNode = [SCNNode node];
	rightEyeCameraNode.camera = rightEyeCamera;
    rightEyeCameraNode.transform = CATransform3DMakeTranslation((_interpupillaryDistance / 2.0) + _cameraLocation.x, _cameraLocation.y, _cameraLocation.z);
    [_scene.rootNode addChildNode:rightEyeCameraNode];

    // Tell each view which camera in the scene to use
    leftEyeView.pointOfView = leftEyeCameraNode;
    rightEyeView.pointOfView = rightEyeCameraNode;
}

- (void)setInterpupillaryDistance:(CGFloat)newValue;
{
    _interpupillaryDistance = newValue;
    leftEyeCameraNode.transform = CATransform3DMakeTranslation(-(_interpupillaryDistance / 2.0) + _cameraLocation.x, _cameraLocation.y, _cameraLocation.z);
    rightEyeCameraNode.transform = CATransform3DMakeTranslation((_interpupillaryDistance / 2.0) + _cameraLocation.x, _cameraLocation.y, _cameraLocation.z);
}

- (void)setCameraLocation:(SCNVector3)newValue;
{
    _cameraLocation = newValue;
    leftEyeCameraNode.transform = CATransform3DMakeTranslation(-(_interpupillaryDistance / 2.0) + _cameraLocation.x, _cameraLocation.y, _cameraLocation.z);
    rightEyeCameraNode.transform = CATransform3DMakeTranslation((_interpupillaryDistance / 2.0) + _cameraLocation.x, _cameraLocation.y, _cameraLocation.z);
}

@end
