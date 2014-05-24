#import <UIKit/UIKit.h>

@class GTZalgo, GTGlitchViewController, GTSymbolViewController, GTShapeViewController, GTFontTableViewController;

@interface GTMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) GTGlitchViewController *glitchVC;
@property (strong, nonatomic) GTSymbolViewController *symbolVC;
@property (strong, nonatomic) GTShapeViewController *shapeVC;
@property (strong, nonatomic) GTFontTableViewController *fontTVC;

// menu buttons
@property (weak, nonatomic) IBOutlet UIButton *fontButton;
@property (weak, nonatomic) IBOutlet UIButton *glitchButton;
@property (weak, nonatomic) IBOutlet UIButton *symbolButton;
@property (weak, nonatomic) IBOutlet UIButton *shapeButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) NSArray *buttons;


@end
