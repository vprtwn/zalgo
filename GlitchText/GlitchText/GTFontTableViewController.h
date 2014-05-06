#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GTFontID) {
    GTFontIDNormal,
    GTFontIDZalgo
};

@protocol GTFontTableViewControllerDelegate <NSObject>

- (void)didSelectFontWithID:(GTFontID)fontID;

@end

@interface GTFontTableViewController : UITableViewController

@property (weak, nonatomic) id<GTFontTableViewControllerDelegate> delegate;

@end
