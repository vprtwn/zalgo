#import "NSString+GlitchText.h"
#import "GTZalgo.h"

@implementation NSString (GlitchText)

- (NSArray *)characterArray
{
    NSUInteger length = [self length];
    NSMutableArray *mutableArray = [NSMutableArray new];
    for (int i = 0; i < length; i++) {
        [mutableArray addObject:[self substringWithRange:NSMakeRange(i, 1)]];
    }
    return [mutableArray copy];
}


- (BOOL)isZalgo
{
    return [[GTZalgo sharedInstance].all containsObject:self];
}


- (NSString *)appendToEachCharacter:(NSString *)text
{
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:self.length*text.length];
    NSArray *cs = [self characterArray];
    for (NSString *c in cs) {
        [newString appendString:c];
        if (![c isZalgo]) {
            [newString appendString:text];
        }
    }
    return newString;
}

@end
