#import "GTMainViewController.h"

#import "GTZalgo.h"
#import "GTGlitchViewController.h"
#import "GTSymbolViewController.h"
#import "GTShapeViewController.h"
#import "GTFontTableViewController.h"
#import "GTTextRange.h"
#import "NSString+GlitchText.h"
#import "GTTipViewController.h"
#import "SKProduct+GlitchText.h"

@import StoreKit;
#import <SVProgressHUD/SVProgressHUD.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <FrameAccessor/FrameAccessor.h>
#import <pop/POP.h>

@interface GTMainViewController () <UITextViewDelegate, GTInputDelegate, GTFontTableViewControllerDelegate, UIActivityItemSource, UIPopoverControllerDelegate, SKProductsRequestDelegate, GTTipViewControllerDelegate>

@end

@implementation GTMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.buttons = @[self.fontButton,
                     self.glitchButton,
                     self.symbolButton,
                     self.shapeButton,
                     self.shareButton];

    // add animations
    [self setupAnimations];

    // in app purchases
    [self setupInAppPurchases];

    // add extra lines
    self.textView.text = @"\r\r\r";
    self.textView.selectedRange = NSMakeRange(0, 0);
    self.textView.delegate = self;

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    }

    self.glitchVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"GlitchViewController"];
    self.glitchVC.delegate = self;

    self.symbolVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"SymbolViewController"];
    self.symbolVC.delegate = self;

    self.shapeVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"ShapeViewController"];
    self.shapeVC.delegate = self;

    self.fontTVC.delegate = self;


    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [self.textView becomeFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"fontEmbedSegue"]) {
        self.fontTVC = segue.destinationViewController;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    NSLog(@"MEMORY WARNING");
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Menu buttons

- (IBAction)fontButtonAction:(id)sender
{
    [self deselectAllExcept:@[self.fontButton]];
    self.textView.inputView = nil;
    if (self.fontButton.selected) {
        self.fontButton.selected = NO;
        [self.textView becomeFirstResponder];
    }
    else {
        self.fontButton.selected = YES;
        [self.textView resignFirstResponder];
    }
}

- (IBAction)glitchButtonAction:(UIButton *)sender
{
    [self touchUpInsideButton:self.glitchButton inputView:self.glitchVC.view];
}

- (IBAction)symbolButtonAction:(id)sender
{
    [self touchUpInsideButton:self.symbolButton inputView:self.symbolVC.view];
}

- (IBAction)shapeButtonAction:(id)sender
{
    [self touchUpInsideButton:self.shapeButton inputView:self.shapeVC.view];
}

- (IBAction)shareButtonAction:(UIButton *)button
{
    BOOL presented = [self presentTipVC];
    if (presented) {
        return;
    }
    [self presentShareSheet];
}

- (void)presentShareSheet
{
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[self] applicationActivities:nil];
    [activityVC setCompletionHandler:^(NSString *activityType, BOOL completed) {
        if (activityType == UIActivityTypeCopyToPasteboard) {
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Copied to pasteboard", nil)];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        [self.textView becomeFirstResponder];
        if (!completed) {
            [Flurry logEvent:@"share.cancelled"];
        }
        else {
            [Flurry logEvent:[NSString stringWithFormat:@"share.completed.%@", activityType]];
        }
    }];
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypeAirDrop];

    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    else {
        if (!self.popover) {
            self.popover = [[UIPopoverController alloc] initWithContentViewController:activityVC];
        }
        CGRect popoverFrame = CGRectMake(CGRectGetMidX(self.shareButton.frame),
                                         CGRectGetMaxY(self.textView.frame) + 50,
                                         self.shareButton.width, self.shareButton.height);
        [self.popover presentPopoverFromRect:popoverFrame
                                      inView:self.view
                    permittedArrowDirections:UIPopoverArrowDirectionDown
                                    animated:YES];
    }
}

- (void)deselectAllExcept:(NSArray *)buttons
{
    for (UIButton *b in self.buttons) {
        if (![buttons containsObject:b]) {
            b.selected = NO;
        }
    }
}

- (void)touchUpInsideButton:(UIButton *)button inputView:(UIView *)view
{
    [self deselectAllExcept:@[button]];

    if (button.selected) {
        button.selected = NO;
        [self.textView resignFirstResponder];
        self.textView.inputView = nil;
        [self.textView becomeFirstResponder];
    }
    else {
        button.selected = YES;
        [self.textView resignFirstResponder];
        self.textView.inputView = view;
        [self.textView becomeFirstResponder];
    }
}

#pragma mark - Animations

- (void)setupAnimations
{
    [self.fontButton addTarget:self action:@selector(scaleToLarge:)
              forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self.fontButton addTarget:self action:@selector(scaleAnimation:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.fontButton addTarget:self action:@selector(scaleToDefault:)
              forControlEvents:UIControlEventTouchDragExit];

    [self.glitchButton addTarget:self action:@selector(scaleToLarge:)
              forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self.glitchButton addTarget:self action:@selector(scaleAnimation:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.glitchButton addTarget:self action:@selector(scaleToDefault:)
              forControlEvents:UIControlEventTouchDragExit];

    [self.symbolButton addTarget:self action:@selector(scaleToLarge:)
              forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self.symbolButton addTarget:self action:@selector(scaleAnimation:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.symbolButton addTarget:self action:@selector(scaleToDefault:)
              forControlEvents:UIControlEventTouchDragExit];

    [self.shapeButton addTarget:self action:@selector(scaleToLarge:)
              forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self.shapeButton addTarget:self action:@selector(scaleAnimation:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.shapeButton addTarget:self action:@selector(scaleToDefault:)
              forControlEvents:UIControlEventTouchDragExit];

    [self.shareButton addTarget:self action:@selector(scaleToLarge:)
              forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self.shareButton addTarget:self action:@selector(scaleAnimation:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.shareButton addTarget:self action:@selector(scaleToDefault:)
              forControlEvents:UIControlEventTouchDragExit];      
}

- (void)scaleToLarge:(UIButton *)button
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.7f, 1.7f)];
    [button.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleLargeAnimation"];
}

- (void)scaleAnimation:(UIButton *)button
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(2.f, 2.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.springBounciness = 20.0f;
    [button.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}

- (void)scaleToDefault:(UIButton *)button
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [button.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleDefaultAnimation"];
}

#pragma mark - text util buttons

- (IBAction)moveLeft:(id)sender
{
    NSRange currentRange = self.textView.selectedRange;
    if (!currentRange.location) {
        return;
    }
    NSRange newRange = NSMakeRange(currentRange.location - 1, currentRange.length);
    self.textView.selectedRange = newRange;
    if ([[self.textView.text substringWithRange:NSMakeRange(newRange.location, 1)] isZalgo]) {
        [self moveLeft:nil];
    }
}

- (IBAction)moveRight:(id)sender
{
    NSRange currentRange = self.textView.selectedRange;
    if (currentRange.location == self.textView.text.length) {
        return;
    }
    NSRange newRange = NSMakeRange(currentRange.location + 1, currentRange.length);
    self.textView.selectedRange = newRange;
    if (newRange.location != self.textView.text.length &&
        [[self.textView.text substringWithRange:NSMakeRange(newRange.location, 1)] isZalgo]) {
        [self moveRight:nil];
    }
}

- (IBAction)insertLineBelow:(id)sender
{
    NSString *currentText = self.textView.text;
    NSRange currentRange = self.textView.selectedRange;
    NSString *newText = [currentText stringByReplacingCharactersInRange:currentRange withString:@"\n"];
    self.textView.text = newText;
    self.textView.selectedRange = NSMakeRange(currentRange.location + 1, 0);
    self.textView.textAlignment = self.textView.textAlignment;
}

- (IBAction)showKeyboard:(id)sender {
    [self.textView resignFirstResponder];
    self.textView.inputView = nil;
    [self.textView becomeFirstResponder];
}

- (IBAction)delete:(id)sender
{
    NSRange currentRange = self.textView.selectedRange;
    if (!currentRange.location && !currentRange.length) {
        return;
    }
    NSRange newRange = currentRange;
    NSString *currentText = self.textView.text;
    NSString *newText = currentText;

    if (!currentRange.length) {
        NSString *firstHalf = [currentText substringToIndex:currentRange.location];
        NSString *secondHalf = [currentText substringFromIndex:currentRange.location];

        // check for surrogate pair
        NSUInteger lastCharLength = 1;
        if (firstHalf.length >= 2) {
            NSMutableArray *a = [NSMutableArray new];
            [firstHalf enumerateSubstringsInRange:NSMakeRange(firstHalf.length - 2, 2)
                                          options:NSStringEnumerationByComposedCharacterSequences | NSStringEnumerationReverse
                                       usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                           [a addObject:substring];
            }];
            if (a.count == 1) {
                lastCharLength = 2;
            }
        }

        firstHalf = [firstHalf substringToIndex:firstHalf.length - lastCharLength];
        newText = [firstHalf stringByAppendingString:secondHalf];
        newRange = NSMakeRange(currentRange.location - 1, currentRange.length);
    }
    else {
        newText = [currentText stringByReplacingCharactersInRange:currentRange withString:@""];
        newRange = NSMakeRange(currentRange.location, 0);
    }

    self.textView.text = newText;
    self.textView.selectedRange = newRange;
    self.textView.textAlignment = self.textView.textAlignment;
}


#pragma mark - GTInputDelegate

- (void)shouldEnterText:(NSString *)text
{
    NSRange selectedRange = self.textView.selectedRange;
    NSString *currentText = self.textView.text;
    if (selectedRange.length) {
        NSString *selectedString = [currentText substringWithRange:selectedRange];
        NSString *newSelectedString = [selectedString appendToEachCharacter:text];
        self.textView.text = [currentText stringByReplacingCharactersInRange:selectedRange
                                                                  withString:newSelectedString];
        self.textView.textAlignment = self.textView.textAlignment;
        // reselect
        NSRange newRange = [self.textView.text rangeOfString:newSelectedString];
        self.textView.selectedRange = newRange;
    }
    else {
        NSString *firstHalf = [currentText substringToIndex:selectedRange.location];
        NSString *secondHalf = [currentText substringFromIndex:selectedRange.location];
        firstHalf = [firstHalf stringByAppendingString:text];
        self.textView.text = [firstHalf stringByAppendingString:secondHalf];
        NSRange newRange = NSMakeRange(selectedRange.location + text.length, 0);
        self.textView.selectedRange = newRange;
    }
}

- (void)showDefaultKeyboard;
{
    [self deselectAllExcept:nil];
    [self.textView resignFirstResponder];
    self.textView.inputView = nil;
    [self.textView becomeFirstResponder];   
}


#pragma mark - GTFontTableViewControllerDelegate

- (void)didSelectFont
{
    self.fontButton.selected = NO;
    self.textView.inputView = nil;
    [self.textView becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length == 0) {
        return YES;
    }

    else {
        NSString *processedText = [self.fontTVC applyFont:text];
        NSString *newText =
        [textView.text stringByReplacingCharactersInRange:range
                                               withString:processedText];
        textView.text = newText;
        textView.selectedRange = NSMakeRange(range.location + processedText.length, 0);
        textView.textAlignment = textView.textAlignment;
        return NO;
    }

    return YES;
}

#pragma mark - Keyboard notifications

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect frameEnd = [[info valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.containerViewHeight.constant = frameEnd.size.height;

    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    if (!self.textView.inputView) {
        [self deselectAllExcept:nil];
    }
}


#pragma mark - UIActivityItemSource

- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    return @"";
}

- (id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType
{
    return self.textView.text;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark - Purchases

- (void)setupInAppPurchases {

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"product_ids"
                                         withExtension:@"plist"];
    NSArray *productIDs = [NSArray arrayWithContentsOfURL:url];
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc]
                                          initWithProductIdentifiers:[NSSet setWithArray:productIDs]];
    productsRequest.delegate = self;
    [productsRequest start];
}

// SKProductsRequestDelegate protocol method
- (void)productsRequest:(SKProductsRequest *)request
     didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = response.products;
    if (products.count == 2) {
        self.smallTip = products[0];
        self.largeTip = products[1];
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{

}

- (BOOL)presentTipVC
{
    BOOL hasTipped = [[NSUserDefaults standardUserDefaults] boolForKey:GTUserDefaultsKeyHasTipped];
    if (!self.smallTip || !self.largeTip || hasTipped) {
        return NO;
    }
    GTTipViewController *tipVC = [GTTipViewController new];
    tipVC.delegate = self;
#warning TODO: iOS8
    tipVC.modalPresentationStyle = UIModalPresentationCurrentContext; // Change this to UIModalPresentationCoverCurrentContext on iOS8
    [tipVC.smallTipButton setTitle:self.smallTip.priceString forState:UIControlStateNormal];
    [tipVC.largeTipButton setTitle:self.largeTip.priceString forState:UIControlStateNormal];
    [self presentViewController:tipVC animated:YES completion:nil];
    return YES;
}

// GTTipViewControllerDelegate

- (void)didSelectSmallTip
{
    [Flurry logEvent:@"tip.small.selected"];
    SKProduct *product = self.smallTip;
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)didSelectLargeTip
{
    [Flurry logEvent:@"tip.large.selected"];
    SKProduct *product = self.largeTip;
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)didDismiss
{
    [Flurry logEvent:@"tip.no.selected"];
    [self presentShareSheet];
}

@end
