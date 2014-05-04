#import <Foundation/Foundation.h>

@interface NSString (GlitchText)

+ (NSString *)stringWithUnichar:(unichar)value;
- (unichar)unichar;
- (const char *)randomUnichar;
- (NSString *)randomCharacter;

@end
