#import "GTTipViewController.h"
#import "UIColor+GlitchText.h"
#import "GTBounceButton.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import <pop/POP.h>

@interface GTTipViewController()
- (void)dismiss:(id)sender;
@end

@implementation GTTipViewController

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(transactionPurchased)
                                                 name:GTNotificationNameTransactionPurchased
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(transactionFailed)
                                                 name:GTNotificationNameTransactionFailed
                                               object:nil];
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor glitchBlueColor];
#warning TODO: iOS8
//    self.view.backgroundColor = [[UIColor glitchBlueColor] colorWithAlphaComponent:0.95];
    [self addDismissButton];
    [self addTitleLabel];
    [self addTipButtons];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self bounceSmallTipButton];
    [self bounceLargeTipButton];
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

- (UIButton *)largeTipButton
{
    if (!_largeTipButton) {
        _largeTipButton = [GTBounceButton button];
        [_largeTipButton setTitle:@"$4.99" forState:UIControlStateNormal];
        [_largeTipButton addTarget:self action:@selector(tip:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _largeTipButton;
}

- (void)addTipButtons
{
    [self.view addSubview:self.largeTipButton];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.largeTipButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.largeTipButton
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

- (void)bounceLargeTipButton
{
    POPSpringAnimation *scaleDownAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleDownAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.1, 1.1)];
    scaleDownAnimation.springBounciness = 20.f;
    [scaleDownAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        POPSpringAnimation *scaleUpAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleUpAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
        scaleUpAnimation.springBounciness = 20.f;
        [self.largeTipButton.layer pop_addAnimation:scaleUpAnimation forKey:@"scaleUpAnimation"];
    }];
    [self.largeTipButton.layer pop_addAnimation:scaleDownAnimation forKey:@"scaleDownAnimation"];

}

- (void)addTitleLabel
{
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = NSLocalizedString(@"Tip me?", nil); // A/B test
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.textColor = [UIColor glitchGreenColor];
    titleLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:45];
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
    dismissButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:25];
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

#pragma mark Actions

- (void)tip:(UIButton *)button
{
    if (button == self.smallTipButton) {
        [self.delegate didSelectSmallTip];
    }
    else if (button == self.largeTipButton) {
        [self.delegate didSelectLargeTip];
    }
    [SVProgressHUD showWithStatus:NSLocalizedString(@"🐢", nil) maskType:SVProgressHUDMaskTypeClear];
}


- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate didDismiss];
    }];
}

#pragma mark Notifications

- (void)transactionPurchased {
    [Flurry logEvent:@"tip.payment.complete"];
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:^{
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Payment complete", nil)];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        [self.delegate didDismiss];
    }];
}

- (void)transactionFailed {
    [Flurry logEvent:@"tip.payment.failed"];
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:^{
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Payment failed", nil)];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        [self.delegate didDismiss];
    }];
}

@end
