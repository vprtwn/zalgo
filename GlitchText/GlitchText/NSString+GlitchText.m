#import "NSString+GlitchText.h"

@implementation NSString (GlitchText)

+ (NSString *)stringWithUnichar:(unichar)u
{
    NSString *string = [NSString stringWithCharacters:&u length:1];
    return string;
}


- (NSString *)randomCharacter
{
    NSString *letter = [self substringWithRange:NSMakeRange(arc4random_uniform([self length]), 1)];
    return letter;
}


- (NSString *)stringCharacterAtIndex:(NSUInteger)index
{
    unichar u = [self characterAtIndex:index];
    return [NSString stringWithUnichar:u];
}


- (NSString *)appendToEachCharacter:(NSString *)text
{
#warning optimize this
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:self.length*text.length];
    NSUInteger len = [self length];
    for (int i = 0; i < len; i++) {
        NSString *s = [self stringCharacterAtIndex:i];
        [newString appendString:s];
        [newString appendString:text];
    }
    return newString;
}

@end
