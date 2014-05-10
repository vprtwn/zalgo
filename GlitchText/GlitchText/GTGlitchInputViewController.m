#import "GTGlitchInputViewController.h"

#import "GTGlitchInputCell.h"
#import "GTGlitchInputHeaderView.h"
#import "GTZalgoFooterView.h"
#import "GTZalgo.h"
#import "NSString+GlitchText.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

typedef NS_ENUM(NSUInteger, GTGlitchSection) {
    GTGlitchSectionZalgo,
    GTGlitchSectionUp,
    GTGlitchSectionMid,
    GTGlitchSectionDown
};

@interface GTGlitchInputViewController ()

@property (strong, nonatomic) GTZalgo *zalgo;
@property (strong, nonatomic) GTGlitchInputHeaderView *headerView;
@property (strong, nonatomic) GTZalgoFooterView *footerView;
@property (assign, nonatomic) GTGlitchSection selectedSection;

@end

@implementation GTGlitchInputViewController

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (!self) {
        return nil;
    }

    self.zalgo = [GTZalgo new];
    self.selectedSection = GTGlitchSectionZalgo;
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
    [self.delegate shouldGlitch:cell.label.text];
}


#pragma mark - UICollectionViewControllerDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count;
    switch (self.selectedSection) {
        case GTGlitchSectionZalgo:
            count = 0;
            break;
        case GTGlitchSectionUp:
            count = [GTZalgoUp length];
            break;

        case GTGlitchSectionMid:
            count = [GTZalgoMid length];
            break;

        case GTGlitchSectionDown:
            count = [GTZalgoDown length];
            break;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTGlitchInputCell * cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"glitchInputCell" forIndexPath:indexPath];
    NSUInteger row = indexPath.row;

    GTZalgo *zalgo = [GTZalgo sharedInstance];
    switch (self.selectedSection) {
        case GTGlitchSectionZalgo:
            break;
        case GTGlitchSectionUp:
            cell.label.text = zalgo.up[row];
            break;

        case GTGlitchSectionMid:
            cell.label.text = zalgo.mid[row];
            break;

        case GTGlitchSectionDown:
            cell.label.text = zalgo.down[row];
            break;
    }

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (!self.headerView) {
            self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                 withReuseIdentifier:@"glitchInputHeaderView"
                                                                        forIndexPath:indexPath];

            RAC(self, selectedSection) =
            [[[self.headerView.segmentedControl rac_signalForControlEvents:UIControlEventValueChanged]
             map:^NSNumber *(UISegmentedControl *control) {
                 return @(control.selectedSegmentIndex);
            }] doNext:^(NSNumber *index) {
                [UIView animateWithDuration:0 animations:^{
                    [self.collectionView performBatchUpdates:^{
                        [self.collectionView setContentOffset:CGPointZero animated:YES];
                        [self.collectionViewLayout invalidateLayout];
                    } completion:^(BOOL finished) {
                        [self.collectionView reloadData];
                    }];
                }];

            }];
        }
        return self.headerView;
    }
    if (!self.footerView) {
        self.footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                             withReuseIdentifier:@"zalgoFooterView"
                                                                    forIndexPath:indexPath];
    }
    return self.footerView;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.selectedSection == GTGlitchSectionZalgo) {
        return CGSizeMake(320, 166);
    }
    return CGSizeZero;
}


@end
