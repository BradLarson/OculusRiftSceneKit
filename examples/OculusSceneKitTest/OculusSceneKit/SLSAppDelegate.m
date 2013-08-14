#import "SLSAppDelegate.h"

@implementation SLSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    SCNScene *scene = [SCNScene scene];
    
    SCNNode *objectsNode = [SCNNode node];
    [scene.rootNode addChildNode:objectsNode];
    
    CGFloat roomRadius = 600.0;

    // Set up the object and wall materials
    SCNMaterial *holodeckWalls = [SCNMaterial material];
    holodeckWalls.diffuse.minificationFilter = SCNLinearFiltering;
    holodeckWalls.diffuse.magnificationFilter = SCNLinearFiltering;
    holodeckWalls.diffuse.mipFilter = SCNLinearFiltering;
    NSImage *diffuseImage = [NSImage imageNamed:@"Holodeck"];
    holodeckWalls.diffuse.contents  = diffuseImage;
    holodeckWalls.diffuse.wrapS = SCNWrapModeRepeat;
    holodeckWalls.diffuse.wrapT = SCNWrapModeRepeat;
    holodeckWalls.diffuse.contentsTransform = CATransform3DMakeScale(1.0/20.0, 1.0/20.0, 1.0/20.0);
    holodeckWalls.specular.contents = [NSColor colorWithWhite:0.5 alpha:0.5];
    holodeckWalls.shininess = 0.25;

    SCNMaterial *torusReflectiveMaterial = [SCNMaterial material];
    torusReflectiveMaterial.diffuse.contents = [NSColor blueColor];
    torusReflectiveMaterial.specular.contents = [NSColor whiteColor];
    torusReflectiveMaterial.shininess = 100.0;
    
    // Configure the room
    SCNFloor *floor = [SCNFloor floor];
    floor.materials = @[holodeckWalls];
    floor.reflectivity = 0.1f;
    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
    floorNode.position = SCNVector3Make(0.0, -roomRadius, 0.0);
    [scene.rootNode addChildNode:floorNode];

    SCNFloor *ceiling = [SCNFloor floor];
    ceiling.materials = @[holodeckWalls];
    ceiling.reflectivity = 0.1f;
    SCNNode *ceilingNode = [SCNNode nodeWithGeometry:ceiling];
    ceilingNode.transform = CATransform3DMakeRotation(-M_PI, 0.0, 0.0, 1.0);
    ceilingNode.position = SCNVector3Make(0.0, roomRadius, 0.0);
    [scene.rootNode addChildNode:ceilingNode];

    SCNFloor *leftWall = [SCNFloor floor];
    leftWall.materials = @[holodeckWalls];
    leftWall.reflectivity = 0.1f;
    SCNNode *leftWallNode = [SCNNode nodeWithGeometry:leftWall];
    leftWallNode.transform = CATransform3DMakeRotation(-M_PI/2.0, 0.0, 0.0, 1.0);
    leftWallNode.position = SCNVector3Make(-roomRadius, 0.0, 0.0);
    [scene.rootNode addChildNode:leftWallNode];
    
    SCNFloor *rightWall = [SCNFloor floor];
    rightWall.materials = @[holodeckWalls];
    rightWall.reflectivity = 0.1f;
    SCNNode *rightWallNode = [SCNNode nodeWithGeometry:rightWall];
    rightWallNode.transform = CATransform3DMakeRotation(M_PI/2.0, 0.0, 0.0, 1.0);
    rightWallNode.position = SCNVector3Make(roomRadius, 0.0, 0.0);
    [scene.rootNode addChildNode:rightWallNode];

    SCNFloor *frontWall = [SCNFloor floor];
    frontWall.materials = @[holodeckWalls];
    frontWall.reflectivity = 0.1f;
    SCNNode *frontWallNode = [SCNNode nodeWithGeometry:frontWall];
    frontWallNode.transform = CATransform3DMakeRotation(M_PI/2.0, 1.0, 0.0, 0.0);
    frontWallNode.position = SCNVector3Make(0.0, 0.0, -roomRadius);
    [scene.rootNode addChildNode:frontWallNode];

    SCNFloor *rearWall = [SCNFloor floor];
    rearWall.materials = @[holodeckWalls];
    rearWall.reflectivity = 0.1f;
    SCNNode *rearWallNode = [SCNNode nodeWithGeometry:rearWall];
    rearWallNode.transform = CATransform3DMakeRotation(-M_PI/2.0, 1.0, 0.0, 0.0);
    rearWallNode.position = SCNVector3Make(0.0, 0.0, roomRadius);
    [scene.rootNode addChildNode:rearWallNode];

    // Throw a few objects into the room
    SCNBox *cube = [SCNBox boxWithWidth:200 height:200 length:200 chamferRadius:0.0];
    SCNNode *cubeNode = [SCNNode nodeWithGeometry:cube];
    cubeNode.position = SCNVector3Make(300, 0, -300);
    [objectsNode addChildNode:cubeNode];
    
    SCNTorus *torus = [SCNTorus torusWithRingRadius:60 pipeRadius:20];
    SCNNode *torusNode = [SCNNode nodeWithGeometry:torus];
    torusNode.position = SCNVector3Make(-50, 0, -100);
    torus.materials = @[torusReflectiveMaterial];
    [objectsNode addChildNode:torusNode];
    
    SCNCylinder *cylinder = [SCNCylinder cylinderWithRadius:40.0 height:100.0];
    SCNNode *cylinderNode = [SCNNode nodeWithGeometry:cylinder];
    cylinderNode.position = SCNVector3Make(-400, -400, -400);
    [objectsNode addChildNode:cylinderNode];

    SCNSphere *sphere = [SCNSphere sphereWithRadius:40.0];
    SCNNode *sphereNode = [SCNNode nodeWithGeometry:sphere];
    sphereNode.position = SCNVector3Make(200, -200, 0);
    [objectsNode addChildNode:sphereNode];

    SCNPyramid *pyramid = [SCNPyramid pyramidWithWidth:60 height:60 length:60];
    SCNNode *pyramidNode = [SCNNode nodeWithGeometry:pyramid];
    pyramidNode.position = SCNVector3Make(200, 200, -200);
    [objectsNode addChildNode:pyramidNode];
    
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
	diffuseLightNode.position = SCNVector3Make(0, 300, 0);
	[scene.rootNode addChildNode:diffuseLightNode];
    
    // Animate the objects
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

    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation2.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DRotate(cubeNode.transform, 0 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(cubeNode.transform, 1 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(cubeNode.transform, 2 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(cubeNode.transform, 3 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(cubeNode.transform, 4 * M_PI / 2, 1.f, 0.5f, 0.f)],
                        nil];
    animation2.duration = 7.f;
    animation2.repeatCount = HUGE_VALF;

    
    [torusNode addAnimation:animation forKey:@"transform"];
    [cubeNode addAnimation:animation2 forKey:@"transform"];

    NSLog(@"Oculus view: %@", self.oculusView);
    self.oculusView.scene = scene;
    
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
