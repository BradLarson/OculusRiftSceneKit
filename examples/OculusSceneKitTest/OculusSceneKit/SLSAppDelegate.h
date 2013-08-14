#import <Cocoa/Cocoa.h>
#import "OculusRiftSceneKitView.h"

@interface SLSAppDelegate : NSObject <NSApplicationDelegate>

@property(assign) IBOutlet NSWindow *window;
@property(assign) IBOutlet OculusRiftSceneKitView *oculusView;

- (IBAction)increaseIPD:(id)sender;
- (IBAction)decreaseIPD:(id)sender;
- (IBAction)increaseDistance:(id)sender;
- (IBAction)decreaseDistance:(id)sender;

@end
