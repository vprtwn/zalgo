#import <Foundation/Foundation.h>

@interface NSString (GlitchText)

- (BOOL)containsString:(NSString *)string;

- (NSArray *)characterArray;

- (BOOL)isZalgo;

- (NSString *)appendToEachCharacter:(NSString *)text;

@end
