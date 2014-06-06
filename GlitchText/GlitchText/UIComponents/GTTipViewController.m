#import "GTTipViewController.h"
#import "UIColor+GlitchText.h"
#import "GTBounceButton.h"

#import <pop/POP.h>

@interface GTTipViewController()
- (void)dismiss:(id)sender;
@end

@implementation GTTipViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.layer.cornerRadius = 8.f;
    self.view.backgroundColor = [UIColor glitchBlueColor];
    [self addDismissButton];
    [self addTitleLabel];
    [self addTipButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self bounceTipButton];
}

#pragma mark - Private Instance methods

- (void)addTitleLabel
{
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"Tip me"; // A/B test this
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.textColor = [UIColor glitchGreenColor];
    titleLabel.font = [UIFont fontWithName:@"Avenir" size:35];
    [self.view addSubview:titleLabel];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];

    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-[titleLabel]"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(titleLabel)]];

}

- (UIButton *)tipButton
{
    if (!_tipButton) {
        _tipButton = [GTBounceButton button];

        [_tipButton setTitle:@"$0.99"
                    forState:UIControlStateNormal];
        [_tipButton addTarget:self action:@selector(tip:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tipButton;
}

- (void)addTipButton
{
    [self.view addSubview:self.tipButton];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f
                                                           constant:0.f]];      
}

- (void)tip:(id)sender
{

}

- (void)bounceTipButton
{
    POPSpringAnimation *scaleDownAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleDownAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.1, 1.1)];
    scaleDownAnimation.springBounciness = 20.f;
    [scaleDownAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        POPSpringAnimation *scaleUpAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleUpAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
        scaleUpAnimation.springBounciness = 20.f;
        [self.tipButton.layer pop_addAnimation:scaleUpAnimation forKey:@"scaleUpAnimation"];
    }];
    [self.tipButton.layer pop_addAnimation:scaleDownAnimation forKey:@"scaleDownAnimation"];

}

- (void)addDismissButton
{
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    dismissButton.tintColor = [UIColor glitchGreenColor];
    dismissButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    [dismissButton setTitle:NSLocalizedString(@"Not now", nil)
                   forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dismissButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[dismissButton]-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(dismissButton)]];
}

- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
