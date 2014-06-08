#import <UIKit/UIKit.h>
#import "GTBounceButton.h"

@protocol GTTipViewControllerDelegate <NSObject>

- (void)didSelectSmallTip;
- (void)didSelectLargeTip;
- (void)didDismiss;

@end

@interface GTTipViewController : UIViewController

@property (strong, nonatomic) GTBounceButton *smallTipButton;
@property (strong, nonatomic) GTBounceButton *largeTipButton;
@property (strong, nonatomic) id <GTTipViewControllerDelegate> delegate;

@end
