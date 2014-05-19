#import "GTFontTableViewController.h"
#import "NSString+GlitchText.h"
#import "NSDictionary+GlitchText.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface GTFontTableViewController ()

@property (assign, nonatomic) NSUInteger previousRow;

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
    self.clearsSelectionOnViewWillAppear = NO;
}

- (void)loadFonts
{
    self.normal = @{};
    self.subway = [NSDictionary dictionaryWithPlistNamed:@"subway"];
    self.circles = [NSDictionary dictionaryWithPlistNamed:@"circles"];
    self.squares = [NSDictionary dictionaryWithPlistNamed:@"stamps"];
    self.light = [NSDictionary dictionaryWithPlistNamed:@"light"];
    self.tiny = [NSDictionary dictionaryWithPlistNamed:@"tiny"];
    self.smallcaps = [NSDictionary dictionaryWithPlistNamed:@"smallcaps"];
    self.copperplate = [NSDictionary dictionaryWithPlistNamed:@"copperplate"];

    self.fonts = @[self.normal,
                   self.subway,
                   self.circles,
                   self.squares,
                   self.light,
                   self.tiny,
                   self.smallcaps,
                   self.copperplate];
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

    [self.delegate didSelectFont];
}

@end
