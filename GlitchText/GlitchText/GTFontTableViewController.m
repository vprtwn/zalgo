#import <ReactiveCocoa/ReactiveCocoa.h>
#import "GTFontTableViewController.h"

@interface GTFontTableViewController ()

@property (assign, nonatomic) GTFontID selectedFontID;

@end

@implementation GTFontTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.selectedFontID = GTFontIDZalgo;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setSelectedFontID:(GTFontID)fontID
{
    GTFontID previousFont = _selectedFontID;
    _selectedFontID = fontID;
    NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:previousFont inSection:0];
    UITableViewCell *previousCell = [self.tableView cellForRowAtIndexPath:previousIndexPath];
    previousCell.accessoryType = UITableViewCellAccessoryNone;

    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:fontID inSection:0];
    UITableViewCell *nextCell = [self.tableView cellForRowAtIndexPath:nextIndexPath];
    nextCell.accessoryType = UITableViewCellAccessoryCheckmark;

    [self.delegate didSelectFontWithID:fontID];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedFontID = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
