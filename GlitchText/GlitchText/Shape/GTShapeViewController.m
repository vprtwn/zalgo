#import "GTShapeViewController.h"
#import "GTShapeHeaderView.h"
#import "GTButtonCell.h"
#import "NSString+GlitchText.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <pop/POP.h>

typedef NS_ENUM(NSUInteger, GTShapeSection) {
    GTShapeSection1,
    GTShapeSection2,
    GTShapeSection3
};


@interface GTShapeViewController ()

@property (strong, nonatomic) GTShapeHeaderView *headerView;

@property (strong, nonatomic) NSArray *s1;
@property (strong, nonatomic) NSArray *s2;
@property (strong, nonatomic) NSArray *s3;
@property (assign, nonatomic) GTShapeSection selectedSection;

@end

@implementation GTShapeViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;

    self.s1 = [@"▖▗▘▙▚▛▜▝▞▟❘❙❚▀▔▁▂▂▄▇█▉▊▋▌▍▎▏▕▐░▒▓◢◣◤◥╱╲╳╭╮╰╯│┃┊┋┆┇╎╏║─━┈┉┄┅╌╍═－-∕" characterArray];
    self.s2 = [@"⦁◦∘∙●○◯❍◌◍◎◉⦿Ꙭꙭ■□▣❏❐❑❒◆◇►▻◄◅▼▽▲△▰▱◬◭◮◸◹◺◿◆◇◊◈❖◘◙◚◛▧▥▦▨▩◧◨◩◪⿰⿱⿲⿳⿴⿵⿶⿷⿸⿹⿺◰◱◱◳⊠⊞⊟⧈⊡" characterArray];
    self.s3 = [@"ლʕ༼◕°︺∡∢⦣╹◠εᴥ︹༽ʖ益∀ಥω≖╥ヮʔﾐ彡ヽ」っ╯┛ﾉノ︵﹏∟∠≀∽⧺⧻⋓⋐⋑⋒⋇⋘⋙⋉⋊⋋⋌≡≣⊙☉⊗⊖⦾⦿⊕⊛⫨⟠" characterArray];

    return self;
}


- (GTShapeHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                              withReuseIdentifier:@"shapeHeaderView"
                                                                     forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            [_headerView.segmentedControl setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:GTHeaderFontSizeIpad]}
                                                        forState:UIControlStateNormal];
        }
        else {
            [_headerView.segmentedControl setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:GTHeaderFontSizeIphone]}
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        case GTShapeSection1:
            count = [self.s1 count];
            break;

        case GTShapeSection2:
            count = [self.s2 count];
            break;

        case GTShapeSection3:
            count = [self.s3 count];
            break;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GTButtonCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"buttonCell" forIndexPath:indexPath];
    NSUInteger row = indexPath.row;

    switch (self.selectedSection) {
        case GTShapeSection1:
            [cell.button setTitle:self.s1[row] forState:UIControlStateNormal];
            break;

        case GTShapeSection2:
            [cell.button setTitle:self.s2[row] forState:UIControlStateNormal];
            break;

        case GTShapeSection3:
            [cell.button setTitle:self.s3[row] forState:UIControlStateNormal];
            break;
    }
    [cell.button addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

- (void)touchUpInside:(UIButton *)button
{
    [self.delegate shouldEnterText:button.titleLabel.text];
}

@end
