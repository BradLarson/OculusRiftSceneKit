#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>

@interface OculusRiftDevice : NSObject

- (SCNVector3)currentHeadRotationAngles;
- (CATransform3D)currentHeadTransform;

@end
