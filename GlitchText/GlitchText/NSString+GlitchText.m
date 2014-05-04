#import "NSString+GlitchText.h"

@implementation NSString (GlitchText)

+ (NSString *)stringWithUnichar:(unichar)utf8char {
    
//    char chars[2];
//    int len = 1;
//    
//    if (utf8char > 127) {
//        chars[0] = (utf8char >> 8) & (1 << 8) - 1;
//        chars[1] = utf8char & (1 << 8) - 1; 
//        len = 2;
//    } else {
//        chars[0] = utf8char;
//    }
//
//    NSString *string = [[NSString alloc] initWithBytes:chars
//                                                length:len 
//                                              encoding:NSUTF8StringEncoding];
    NSString *string = [NSString stringWithCharacters:&utf8char length:1];
    
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
