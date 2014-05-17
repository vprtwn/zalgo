#import "GTSymbolViewController.h"
#import "GTSymbolHeaderView.h"
#import "GTButtonCell.h"
#import "NSString+GlitchText.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef NS_ENUM(NSUInteger, GTSymbolSection) {
    GTSymbolSection1,
    GTSymbolSection2,
    GTSymbolSection3
};


@interface GTSymbolViewController ()

@property (strong, nonatomic) GTSymbolHeaderView *headerView;

@property (strong, nonatomic) NSArray *s1;
@property (strong, nonatomic) NSArray *s2;
@property (strong, nonatomic) NSArray *s3;
@property (assign, nonatomic) GTSymbolSection selectedSection;

@end

@implementation GTSymbolViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;

    self.s1 = [@"→⇒⇨⇾➾⇢➔➜➙➛☛☞➝➞➟➠➢➣➤➥➦➧➨⥤⇀⇁⇰➩➪➫➬➭➮➯➱➲➳➵➸➻➺➼➽⇉⇶⇛⇏↛↝↣↠↦⇥⇝↬⇴⇸⇻" characterArray];
    self.s2 = [@"←⇐⇦⇽⇠☚☜↼↽↚↜↢↞↤⇇⇤⇚⇍⇜↫⇷⇺" characterArray];
    self.s3 = [@"↑⇑⇡⇧⇪⥣↟↾↿↥⇫⇬⇭⇮⇯⇈⇞↓⇓⇩⇣☟⥥↡⇂⇃⇊↧↯⇟" characterArray];

    return self;
}

- (GTSymbolHeaderView *)headerView
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
        case GTSymbolSection1:
            count = [self.s1 count];
            break;

        case GTSymbolSection2:
            count = [self.s2 count];
            break;

        case GTSymbolSection3:
            count = [self.s3 count];
            break;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTButtonCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"symbolButtonCell" forIndexPath:indexPath];
    NSUInteger row = indexPath.row;

    switch (self.selectedSection) {
        case GTSymbolSection1:
            cell.label.text = self.s1[row];
            break;

        case GTSymbolSection2:
            cell.label.text = self.s2[row];
            break;

        case GTSymbolSection3:
            cell.label.text = self.s3[row];
            break;
    }
    return cell;
}

@end
