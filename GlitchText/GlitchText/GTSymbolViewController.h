#import <UIKit/UIKit.h>
#import "GTInputDelegate.h"

@interface GTSymbolViewController : UICollectionViewController

@property (weak, nonatomic) id<GTInputDelegate> delegate;

@end
