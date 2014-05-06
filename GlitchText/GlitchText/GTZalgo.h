#import <Foundation/Foundation.h>

extern NSString *const GTZalgoUp;
extern NSString *const GTZalgoMid;
extern NSString *const GTZalgoDown;

@interface GTZalgo : NSObject

- (NSString *)process:(NSString *)text;

@end
