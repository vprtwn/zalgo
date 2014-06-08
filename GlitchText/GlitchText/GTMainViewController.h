#import <UIKit/UIKit.h>

@class GTZalgo, GTGlitchViewController, GTSymbolViewController, GTShapeViewController, GTFontTableViewController, SKProduct;

@interface GTMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) GTGlitchViewController *glitchVC;
@property (strong, nonatomic) GTSymbolViewController *symbolVC;
@property (strong, nonatomic) GTShapeViewController *shapeVC;
@property (strong, nonatomic) GTFontTableViewController *fontTVC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeight;

// menu buttons
@property (weak, nonatomic) IBOutlet UIView *menuBar;
@property (weak, nonatomic) IBOutlet UIButton *fontButton;
@property (weak, nonatomic) IBOutlet UIButton *glitchButton;
@property (weak, nonatomic) IBOutlet UIButton *symbolButton;
@property (weak, nonatomic) IBOutlet UIButton *shapeButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) NSArray *buttons;
@property (strong, nonatomic) UIPopoverController *popover;

// In App Purchases
@property (strong, nonatomic) SKProduct *smallTip;
@property (strong, nonatomic) SKProduct *largeTip;


@end
