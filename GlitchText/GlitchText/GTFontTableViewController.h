#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GTFontID) {
    GTFontIDNormal,
    GTFontIDSubway
};

@interface GTFontTableViewController : UITableViewController

- (NSString *)applyFont:(NSString *)text;

@end
