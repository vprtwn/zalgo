#import <UIKit/UIKit.h>

@protocol GTGlitchInputDelegate <NSObject>

- (void)didSelectGlitch:(NSString *)text;

@end

@interface GTGlitchViewController : UICollectionViewController

@property (weak, nonatomic) id<GTGlitchInputDelegate> delegate;

@end
