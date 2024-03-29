#import "GTGlitchViewController.h"

#import "GTButtonCell.h"
#import "GTGlitchHeaderView.h"
#import "GTZalgo.h"
#import "NSString+GlitchText.h"
#import "UIColor+GlitchText.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <pop/POP.h>

typedef NS_ENUM(NSUInteger, GTGlitchSection) {
    GTGlitchSectionUp,
    GTGlitchSectionMid,
    GTGlitchSectionDown
};

@interface GTGlitchViewController ()

@property (strong, nonatomic) GTZalgo *zalgo;
@property (strong, nonatomic) GTGlitchHeaderView *headerView;
@property (assign, nonatomic) GTGlitchSection selectedSection;

@end

@implementation GTGlitchViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (!self) {
        return nil;
    }

    self.zalgo = [GTZalgo sharedInstance];
    self.selectedSection = GTGlitchSectionUp;
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

- (GTGlitchHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                              withReuseIdentifier:@"glitchHeaderView"
                                                                     forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            [_headerView.segmentedControl setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:GTHeaderFontSizeIpad*0.8]}
                                                        forState:UIControlStateNormal];
        }
        else {
            [_headerView.segmentedControl setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:GTHeaderFontSizeIphone*0.8]}
                                                        forState:UIControlStateNormal];
        }

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


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTButtonCell *cell = (GTButtonCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.delegate shouldEnterText:cell.button.titleLabel.text];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count;
    switch (self.selectedSection) {
        case GTGlitchSectionUp:
            count = [self.zalgo.up count];
            break;

        case GTGlitchSectionMid:
            count = [self.zalgo.mid count];
            break;

        case GTGlitchSectionDown:
            count = [self.zalgo.down count];
            break;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"buttonCell" forIndexPath:indexPath];
    NSUInteger row = indexPath.row;

    switch (self.selectedSection) {
        case GTGlitchSectionUp:
            [cell.button setTitle:self.zalgo.up[row] forState:UIControlStateNormal];
            break;

        case GTGlitchSectionMid:
            [cell.button setTitle:self.zalgo.mid[row] forState:UIControlStateNormal];
            break;

        case GTGlitchSectionDown:
            [cell.button setTitle:self.zalgo.down[row] forState:UIControlStateNormal];
            break;
    }
    [cell.button addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

- (void)touchUpInside:(UIButton *)button
{
    [self.delegate shouldEnterText:button.titleLabel.text];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return self.headerView;
}

@end
