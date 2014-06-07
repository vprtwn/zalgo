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

//    self.view.layer.cornerRadius = 40.f;
    self.view.backgroundColor = [UIColor glitchBlueColor];
    [self addDismissButton];
    [self addTitleLabel];
    [self addTipButtons];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self bounceSmallTipButton];
    [self bounceBigTipButton];
}

#pragma mark - Private Instance methods

- (UIButton *)smallTipButton
{
    if (!_smallTipButton) {
        _smallTipButton = [GTBounceButton button];

        [_smallTipButton setTitle:@"$0.99"
                    forState:UIControlStateNormal];
        [_smallTipButton addTarget:self action:@selector(tip:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smallTipButton;
}

- (UIButton *)bigTipButton
{
    if (!_bigTipButton) {
        _bigTipButton = [GTBounceButton button];
        [_bigTipButton setTitle:@"$4.99" forState:UIControlStateNormal];
        [_bigTipButton addTarget:self action:@selector(tip:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigTipButton;
}

- (void)addTipButtons
{
    [self.view addSubview:self.bigTipButton];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bigTipButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bigTipButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f
                                                           constant:-60.f]];

    [self.view addSubview:self.smallTipButton];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.smallTipButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.smallTipButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f
                                                           constant:60.f]];
}

- (void)tip:(UIButton *)button
{

}

- (void)bounceSmallTipButton
{
    POPSpringAnimation *scaleDownAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleDownAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.1, 1.1)];
    scaleDownAnimation.springBounciness = 20.f;
    [scaleDownAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        POPSpringAnimation *scaleUpAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleUpAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
        scaleUpAnimation.springBounciness = 20.f;
        [self.smallTipButton.layer pop_addAnimation:scaleUpAnimation forKey:@"scaleUpAnimation"];
    }];
    [self.smallTipButton.layer pop_addAnimation:scaleDownAnimation forKey:@"scaleDownAnimation"];

}

- (void)bounceBigTipButton
{
    POPSpringAnimation *scaleDownAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleDownAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.1, 1.1)];
    scaleDownAnimation.springBounciness = 20.f;
    [scaleDownAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        POPSpringAnimation *scaleUpAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleUpAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
        scaleUpAnimation.springBounciness = 20.f;
        [self.bigTipButton.layer pop_addAnimation:scaleUpAnimation forKey:@"scaleUpAnimation"];
    }];
    [self.bigTipButton.layer pop_addAnimation:scaleDownAnimation forKey:@"scaleDownAnimation"];

}

- (void)addTitleLabel
{
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = NSLocalizedString(@"Tip me?", nil); // A/B test
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.textColor = [UIColor glitchGreenColor];
    titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:45];
    [self.view addSubview:titleLabel];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];

    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-30-[titleLabel]"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(titleLabel)]];
    
}

- (void)addDismissButton
{
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    dismissButton.tintColor = [UIColor glitchGreenColor];
    dismissButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:25];
    [dismissButton setTitle:NSLocalizedString(@"Not now", nil) // AB Test this
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
                               constraintsWithVisualFormat:@"V:[dismissButton]-30-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(dismissButton)]];
}

- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
