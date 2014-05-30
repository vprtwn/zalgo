#import <UIKit/UIKit.h>
#import "GTInputDelegate.h"

@interface GTShapeViewController : UICollectionViewController

@property (weak, nonatomic) id<GTInputDelegate> delegate;

@end

