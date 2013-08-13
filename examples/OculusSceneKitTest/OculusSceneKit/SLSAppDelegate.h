//
//  SLSAppDelegate.h
//  OculusSceneKit
//
//  Created by Brad Larson on 8/9/2013.
//  Copyright (c) 2013 Sunset Lake Software LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SLSOculusView.h"
#import "OculusRiftSceneKitView.h"

@interface SLSAppDelegate : NSObject <NSApplicationDelegate>

@property(assign) IBOutlet NSWindow *window;
@property(assign) IBOutlet OculusRiftSceneKitView *oculusView;
@property(assign) IBOutlet SLSOculusView *oculusView2;

- (IBAction)increaseIPD:(id)sender;
- (IBAction)decreaseIPD:(id)sender;
- (IBAction)increaseDistance:(id)sender;
- (IBAction)decreaseDistance:(id)sender;

@end
