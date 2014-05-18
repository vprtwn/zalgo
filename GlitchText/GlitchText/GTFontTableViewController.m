#import "GTFontTableViewController.h"
#import "NSString+GlitchText.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface GTFontTableViewController ()

@property (assign, nonatomic) NSUInteger previousRow;

// fonts
@property (strong, nonatomic) NSArray *fonts;
@property (strong, nonatomic) NSDictionary *currentFont;
@property (strong, nonatomic) NSDictionary *normal;
@property (strong, nonatomic) NSDictionary *subway;

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
    self.clearsSelectionOnViewWillAppear = NO;
}

- (void)loadFonts
{
    self.normal = @{};
    NSString *subwayPath = [[NSBundle mainBundle] pathForResource:@"subway" ofType:@"plist"];
    self.subway = [NSDictionary dictionaryWithContentsOfFile:subwayPath];
    self.fonts = @[self.normal,
                   self.subway];
    self.currentFont = self.normal;
    self.previousRow = 0;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger nextRow = indexPath.row;
    self.currentFont = self.fonts[nextRow];

    NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:self.previousRow inSection:0];
    UITableViewCell *previousCell = [self.tableView cellForRowAtIndexPath:previousIndexPath];
    previousCell.accessoryType = UITableViewCellAccessoryNone;

    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:nextRow inSection:0];
    UITableViewCell *nextCell = [self.tableView cellForRowAtIndexPath:nextIndexPath];
    nextCell.accessoryType = UITableViewCellAccessoryCheckmark;

    self.previousRow = nextRow;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
