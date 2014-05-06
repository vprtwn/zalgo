#import "NSString+GlitchText.h"

@implementation NSString (GlitchText)

+ (NSString *)stringWithUnichar:(unichar)u {
    NSString *string = [NSString stringWithCharacters:&u length:1];
    return string;
}

- (unichar)unichar {
    return [self characterAtIndex:0];
}

- (const char *)randomUnichar {
    NSString *letter = [self substringWithRange:NSMakeRange(arc4random_uniform([self length]), 1)];
    return [letter UTF8String];
}


- (NSString *)randomCharacter {
    NSString *letter = [self substringWithRange:NSMakeRange(arc4random_uniform([self length]), 1)];
    return letter;
}

@end
