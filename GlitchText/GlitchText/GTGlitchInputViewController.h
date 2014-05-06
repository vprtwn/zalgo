#import <UIKit/UIKit.h>

@protocol GTGlitchInputDelegate <NSObject>

- (void)shouldEnterText:(NSString *)text;

@end

@interface GTGlitchInputViewController : UICollectionViewController

@property (weak, nonatomic) id<GTGlitchInputDelegate> delegate;

@end
