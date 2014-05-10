#import <UIKit/UIKit.h>

@protocol GTGlitchInputDelegate <NSObject>

- (void)shouldGlitch:(NSString *)text;

@end

@interface GTGlitchInputViewController : UICollectionViewController

@property (weak, nonatomic) id<GTGlitchInputDelegate> delegate;

@end
