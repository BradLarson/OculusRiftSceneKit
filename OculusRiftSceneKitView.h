#import <Cocoa/Cocoa.h>
#import <SceneKit/SceneKit.h>
#import <OpenGL/OpenGL.h>
#import <OpenGL/gl.h>
#import "GLProgram.h"

@interface OculusRiftSceneKitView : NSOpenGLView <SCNSceneRendererDelegate>

@property(readwrite, retain, nonatomic) SCNScene *scene;
@property(readwrite, nonatomic) CGFloat interpupillaryDistance;
@property(readwrite, nonatomic) SCNVector3 cameraLocation;

- (CVReturn)renderTime:(const CVTimeStamp *)timeStamp;

@end
