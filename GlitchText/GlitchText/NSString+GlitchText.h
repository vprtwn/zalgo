#import <Foundation/Foundation.h>

@interface NSString (GlitchText)

+ (NSString *)stringWithUnichar:(unichar)value;
- (unichar)unichar;
- (NSString *)randomCharacter;

@end
