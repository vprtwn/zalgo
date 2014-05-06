#import <UIKit/UIKit.h>

extern NSString *const kReuseIDGlitchInputHeaderView;

@interface GTGlitchInputHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end
