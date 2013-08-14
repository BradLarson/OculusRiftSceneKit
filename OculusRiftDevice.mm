#import "OculusRiftDevice.h"

@interface OculusRiftDevice
{
    
}
@end

@implementation OculusRiftDevice

#pragma mark -
#pragma mark Initialization and teardown

- (id)init
{
    if (!(self = [super init]))
    {
		return nil;
    }
    
    return self;
}

#pragma mark -
#pragma mark Current status extraction

- (SCNVector4)currentHeadRotation;
{
    return SCNVector3Make(0.0, 0.0, 0.0);
}

@end
