#import <UIKit/UIKit.h>
#import "GTInputDelegate.h"

@interface GTArrowViewController : UICollectionViewController

@property (weak, nonatomic) id<GTInputDelegate> delegate;

@end
