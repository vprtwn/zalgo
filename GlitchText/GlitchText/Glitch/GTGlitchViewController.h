#import <UIKit/UIKit.h>
#import "GTInputDelegate.h"

@interface GTGlitchViewController : UICollectionViewController

@property (weak, nonatomic) id<GTInputDelegate> delegate;

@end
