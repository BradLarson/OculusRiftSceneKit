//
//  SLSAppDelegate.h
//  OculusRiftLeapMotionTest
//
//  Created by Brad Larson on 8/14/2013.
//  Copyright (c) 2013 Sunset Lake Software LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OculusRiftSceneKitView.h"
#import "LeapObjectiveC.h"

@interface SLSAppDelegate : NSObject <NSApplicationDelegate, LeapListener>
{
    LeapController *controller;
    SCNNode *firstHandNode, *secondHandNode;
    NSMutableArray *firstHandFingerNodes, *secondHandFingerNodes;
    LeapHand *firstHand, *secondHand;
    SCNVector3 leapMotionControllerPosition;
    CGFloat leapMotionToVirtualWorldScalingFactor;
}

@property (assign) IBOutlet NSWindow *window;
@property(assign) IBOutlet OculusRiftSceneKitView *oculusView;

- (void)setupSceneRendering;
- (void)setupHandRendering;
- (void)moveFingers:(NSMutableArray *)fingerNodes andHand:(SCNNode *)handNode toMatchLeapHand:(LeapHand *)leapHand;

- (IBAction)increaseIPD:(id)sender;
- (IBAction)decreaseIPD:(id)sender;
- (IBAction)increaseDistance:(id)sender;
- (IBAction)decreaseDistance:(id)sender;

@end
