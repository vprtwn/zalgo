#import "GTTextRange.h"

@implementation GTTextRange

@synthesize range = _range;

// Class method to create an instance with a given range
+ (GTTextRange *)rangeWithNSRange:(NSRange)nsRange
{
    if (nsRange.location == NSNotFound)
        return nil;
    
    GTTextRange *range = [GTTextRange new];
    range.range = nsRange;
    return range;
}

@end

