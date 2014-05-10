#import <Foundation/Foundation.h>

extern NSString *const GTZalgoUp;
extern NSString *const GTZalgoMid;
extern NSString *const GTZalgoDown;

@interface GTZalgo : NSObject

@property (strong, nonatomic) NSArray *up;
@property (strong, nonatomic) NSArray *mid;
@property (strong, nonatomic) NSArray *down;
@property (strong, nonatomic) NSArray *all;

@property (assign, nonatomic) BOOL enabled;

+ (instancetype)sharedInstance;

/// BEHOLD THE ZALGORITHM
- (NSString *)process:(NSString *)text;

@end
