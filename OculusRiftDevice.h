#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>

@interface OculusRiftDevice : NSObject

- (SCNVector4)currentHeadRotation;

@end
