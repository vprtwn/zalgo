#import "NSArray+GlitchText.h"

@implementation NSArray (GlitchText)

- (id)randomObject
{
    return [self objectAtIndex:arc4random_uniform((int)[self count])];
}

@end
