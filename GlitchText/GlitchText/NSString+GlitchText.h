#import <Foundation/Foundation.h>

@interface NSString (GlitchText)

+ (NSString *)stringWithUnichar:(unichar)value;

- (NSString *)randomCharacter;

- (NSString *)stringCharacterAtIndex:(NSUInteger)index;

- (BOOL)isZalgo;

- (NSString *)appendToEachCharacter:(NSString *)text;

@end
