#import <Foundation/Foundation.h>

@interface NSString (GlitchText)

- (BOOL)containsString:(NSString *)string;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray *characterArray;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray *composedCharacterArray;

@property (NS_NONATOMIC_IOSONLY, getter=isZalgo, readonly) BOOL zalgo;

@property (NS_NONATOMIC_IOSONLY, getter=isWhitespace, readonly) BOOL whitespace;

- (NSString *)appendToEachCharacter:(NSString *)text;

@end
