#import "GTFontTableViewController.h"
#import "NSString+GlitchText.h"
#import "NSDictionary+GlitchText.h"
#import "UIColor+GlitchText.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface GTFontTableViewController ()

@property (assign, nonatomic) NSUInteger selectedRow;

// fonts
@property (strong, nonatomic) NSArray *fonts;
@property (strong, nonatomic) NSDictionary *currentFont;
@property (strong, nonatomic) NSDictionary *normal;
@property (strong, nonatomic) NSDictionary *subway;
@property (strong, nonatomic) NSDictionary *circles;
@property (strong, nonatomic) NSDictionary *squares;
@property (strong, nonatomic) NSDictionary *stamps;
@property (strong, nonatomic) NSDictionary *light;
@property (strong, nonatomic) NSDictionary *tiny;
@property (strong, nonatomic) NSDictionary *smallcaps;
@property (strong, nonatomic) NSDictionary *copperplate;

@end

@implementation GTFontTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;

    [self loadFonts];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
    self.clearsSelectionOnViewWillAppear = NO;
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                animated:NO
                          scrollPosition:UITableViewScrollPositionTop];
}

- (void)loadFonts
{
    self.normal = @{};
    self.subway = [NSDictionary dictionaryWithPlistNamed:@"subway"];
    self.circles = [NSDictionary dictionaryWithPlistNamed:@"circles"];
    self.squares = [NSDictionary dictionaryWithPlistNamed:@"squares"];
    self.stamps = [NSDictionary dictionaryWithPlistNamed:@"stamps"];
    self.light = [NSDictionary dictionaryWithPlistNamed:@"light"];
    self.tiny = [NSDictionary dictionaryWithPlistNamed:@"tiny"];
    self.smallcaps = [NSDictionary dictionaryWithPlistNamed:@"smallcaps"];
    self.copperplate = [NSDictionary dictionaryWithPlistNamed:@"copperplate"];

    self.fonts = @[self.normal,
                   self.subway,
                   self.circles,
                   self.squares,
                   self.stamps,
                   self.light,
                   self.tiny,
                   self.smallcaps,
                   self.copperplate];
    self.currentFont = self.normal;
    self.selectedRow = 0;
}

- (NSString *)applyFont:(NSString *)text
{
    NSMutableString *newString = [NSMutableString stringWithString:@""];
    NSArray *characters = [text characterArray];
    for (NSString *c in characters) {
        NSString *lc = [c lowercaseString];
        BOOL didLower = [c isEqualToString:lc];
        NSString *lower = self.currentFont[lc];
        NSString *upper = self.currentFont[[lc uppercaseString]];
        if (!didLower) {
            if (lower) {
                [newString appendString:lower];
            }
            else if (upper) {
                [newString appendString:upper];
            }
            else {
                [newString appendString:c];
            }
        }
        else {
            if (upper) {
                [newString appendString:upper];
            }
            else if (lower) {
                [newString appendString:lower];
            }
            else {
                [newString appendString:c];
            }
        }
    }
    return newString;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = [UIColor glitchGreenColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRow = indexPath.row;
    [self.delegate didSelectFont];
}

@end
