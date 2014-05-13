#import "GTArrowViewController.h"
#import "GTArrowHeaderView.h"
#import "GTButtonCell.h"
#import "NSString+GlitchText.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef NS_ENUM(NSUInteger, GTArrowSection) {
    GTArrowSectionRight,
    GTArrowSectionLeft,
    GTArrowSectionUp,
    GTArrowSectionOpposing,
    GTArrowSectionMisc
};


@interface GTArrowViewController ()

@property (strong, nonatomic) GTArrowHeaderView *headerView;

@property (strong, nonatomic) NSArray *right;
@property (strong, nonatomic) NSArray *left;
@property (strong, nonatomic) NSArray *up;
@property (strong, nonatomic) NSArray *opposing;
@property (strong, nonatomic) NSArray *misc;
@property (assign, nonatomic) GTArrowSection selectedSection;

@end

@implementation GTArrowViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;

    self.right = [@"→⇒⇨⇾➾⇢➔➜➙➛☛☞➝➞➟➠➢➣➤➥➦➧➨⥤⇀⇁⇰➩➪➫➬➭➮➯➱➲➳➵➸➻➺➼➽⇉⇶⇛⇏↛↝↣↠↦⇥⇝↬⇴⇸⇻" characterArray];
    self.left = [@"←⇐⇦⇽⇠☚☜↼↽↚↜↢↞↤⇇⇤⇚⇍⇜↫⇷⇺" characterArray];
    self.up = [@"↑⇑⇡⇧⇪⥣↟↾↿↥⇫⇬⇭⇮⇯⇈⇞↓⇓⇩⇣☟⥥↡⇂⇃⇊↧↯⇟" characterArray];
    self.opposing = [@"⇔⇿⇋⇌⇄⇆↹⇎↭↮⇹⇼⇕⇳⇅↨" characterArray];
    self.misc = [@"➘⇘⇲➷➴⤷➚⇗➹➶⇖↸⇱⇙⤶⤹↵↲↳↰↱↴↶↷↺↻⎯⏐" characterArray];

    return self;
}

- (GTArrowHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                              withReuseIdentifier:@"symbolHeaderView"
                                                                     forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        RAC(self, selectedSection) =
        [[[_headerView.segmentedControl rac_signalForControlEvents:UIControlEventValueChanged]
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTButtonCell *cell = (GTButtonCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.delegate shouldEnterText:cell.label.text];
}

#pragma mark - UICollectionViewDataSource

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSArray *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return self.headerView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count;
    switch (self.selectedSection) {
        case GTArrowSectionRight:
            count = [self.right count];
            break;

        case GTArrowSectionLeft:
            count = [self.left count];
            break;

        case GTArrowSectionUp:
            count = [self.up count];
            break;

        case GTArrowSectionOpposing:
            count = [self.opposing count];
            break;

        case GTArrowSectionMisc:
            count = [self.misc count];
            break;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTButtonCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"arrowButtonCell" forIndexPath:indexPath];
    NSUInteger row = indexPath.row;

    switch (self.selectedSection) {
        case GTArrowSectionRight:
            cell.label.text = self.right[row];
            break;

        case GTArrowSectionLeft:
            cell.label.text = self.left[row];
            break;

        case GTArrowSectionUp:
            cell.label.text = self.up[row];
            break;

        case GTArrowSectionOpposing:
            cell.label.text = self.opposing[row];
            break;

        case GTArrowSectionMisc:
            cell.label.text = self.misc[row];
            break;
    }

    return cell;
}

@end
