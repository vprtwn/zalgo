#import "NSArray+GlitchText.h"

@implementation NSArray (GlitchText)

- (id)randomObject
{
    return self[arc4random_uniform((int)[self count])];
}

@end
