#import "GTGlitchViewController.h"

#import "GTButtonCell.h"
#import "GTSectionHeaderView.h"
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

@interface GTGlitchViewController ()

@property (strong, nonatomic) GTZalgo *zalgo;
@property (strong, nonatomic) GTSectionHeaderView *headerView;
@property (strong, nonatomic) GTZalgoFooterView *footerView;
@property (assign, nonatomic) GTGlitchSection selectedSection;

@end

@implementation GTGlitchViewController

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

#pragma mark - header and footer views

- (GTSectionHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                              withReuseIdentifier:@"glitchHeaderView"
                                                                     forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

        RAC(self, selectedSection) =
        [[[self.headerView.segmentedControl rac_signalForControlEvents:UIControlEventValueChanged]
          map:^NSNumber *(UISegmentedControl *control) {
              return @(control.selectedSegmentIndex);
          }] doNext:^(NSNumber *index) {
              [UIView animateWithDuration:0 animations:^{
                  [self.collectionView setContentOffset:CGPointZero animated:YES];
                  [self.collectionViewLayout invalidateLayout];
                  [self.collectionView reloadData];
              } completion:nil];
          }];
    }
    return _headerView;
}

- (GTZalgoFooterView *)footerView
{
    if (!_footerView) {
        _footerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                              withReuseIdentifier:@"zalgoFooterView"
                                                                     forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    return _footerView;
}

#pragma mark - UICollectionViewControllerDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTButtonCell *cell = (GTButtonCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.delegate didSelectGlitch:cell.label.text];
}

#pragma mark - UICollectionViewControllerDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count;
    GTZalgo *zalgo = [GTZalgo sharedInstance];
    switch (self.selectedSection) {
        case GTGlitchSectionZalgo:
            count = 0;
            break;
        case GTGlitchSectionUp:
            count = [zalgo.up count];
            break;

        case GTGlitchSectionMid:
            count = [zalgo.mid count];
            break;

        case GTGlitchSectionDown:
            count = [zalgo.down count];
            break;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTButtonCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"glitchButtonCell" forIndexPath:indexPath];
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
        return self.headerView;
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
