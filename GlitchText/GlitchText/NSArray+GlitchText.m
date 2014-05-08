#import "NSArray+GlitchText.h"

@implementation NSArray (GlitchText)

- (id)randomObject
{
    return [self objectAtIndex:arc4random_uniform([self count])];
}

@end
