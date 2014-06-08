#import <UIKit/UIKit.h>
@import StoreKit;

@interface GTAppDelegate : UIResponder <UIApplicationDelegate, SKPaymentTransactionObserver>

@property (strong, nonatomic) UIWindow *window;

@end
