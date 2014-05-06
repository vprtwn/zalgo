#import "GTGlitchInputViewController.h"

#import "GTGlitchInputCell.h"
#import "GTGlitchInputHeaderView.h"
#import "GTZalgo.h"
#import "NSString+GlitchText.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

typedef NS_ENUM(NSUInteger, GTGlitchType) {
    GTGlitchTypeUp,
    GTGlitchTypeMid,
    GTGlitchTypeDown,
    GTGlitchTypeCombo
};

@interface GTGlitchInputViewController ()

@property (strong, nonatomic) GTZalgo *zalgo;
@property (strong, nonatomic) GTGlitchInputHeaderView *headerView;
@property (assign, nonatomic) GTGlitchType glitchType;

@end

@implementation GTGlitchInputViewController

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (!self) {
        return nil;
    }

    self.zalgo = [GTZalgo new];
    self.glitchType = GTGlitchTypeUp;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewControllerDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTGlitchInputCell *cell = (GTGlitchInputCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.delegate shouldEnterText:cell.label.text];
}


#pragma mark - UICollectionViewControllerDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count;
    switch (self.glitchType) {
        case GTGlitchTypeUp:
            count = [self.zalgo.up length];
            break;

        case GTGlitchTypeMid:
            count = [self.zalgo.mid length];
            break;

        case GTGlitchTypeDown:
            count = [self.zalgo.down length];
            break;

        case GTGlitchTypeCombo:
            count = 0;
            break;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *characters = @"";
    switch (self.glitchType) {
        case GTGlitchTypeUp:
            characters = self.zalgo.up;
            break;

        case GTGlitchTypeMid:
            characters = self.zalgo.mid;
            break;

        case GTGlitchTypeDown:
            characters = self.zalgo.down;
            break;

        case GTGlitchTypeCombo:
            break;
    }

    GTGlitchInputCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIDGlitchInputCell forIndexPath:indexPath];
    cell.label.text = [NSString stringWithUnichar:[characters characterAtIndex:indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (!self.headerView) {
        self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                             withReuseIdentifier:@"glitchInputHeaderView"
                                                                    forIndexPath:indexPath];

        RAC(self, glitchType) =
        [[[self.headerView.segmentedControl rac_signalForControlEvents:UIControlEventValueChanged]
         map:^NSNumber *(UISegmentedControl *control) {
             return @(control.selectedSegmentIndex);
        }] doNext:^(NSNumber *index) {
            [self.collectionView reloadData];
        }];
    }
    return self.headerView;
}

@end
