#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GTFontID) {
    GTFontIDNormal,
    GTFontIDSubway
};

@protocol GTFontTableViewControllerDelegate <NSObject>

- (void)didSelectFont;

@end

@interface GTFontTableViewController : UITableViewController

@property (strong, nonatomic) id<GTFontTableViewControllerDelegate> delegate;

- (NSString *)applyFont:(NSString *)text;

@end
