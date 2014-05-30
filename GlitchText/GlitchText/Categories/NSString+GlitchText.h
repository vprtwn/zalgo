#import <Foundation/Foundation.h>

@interface NSString (GlitchText)

- (BOOL)containsString:(NSString *)string;

- (NSArray *)characterArray;

- (NSArray *)composedCharacterArray;

- (BOOL)isZalgo;

- (BOOL)isWhitespace;

- (NSString *)appendToEachCharacter:(NSString *)text;

@end
