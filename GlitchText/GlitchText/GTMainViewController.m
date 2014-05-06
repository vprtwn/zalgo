#import "GTMainViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "GTZalgo.h"
#import "GTZalgoInputViewController.h"

@interface GTMainViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) GTZalgo *zalgo;
@property (strong, nonatomic) GTZalgoInputViewController *zalgoInputVC;


// menu buttons
@property (weak, nonatomic) IBOutlet UIButton *fontButton;

@end

@implementation GTMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.delegate = self;
    [self.textView becomeFirstResponder];
    
    self.zalgo = [GTZalgo new];
    self.zalgoInputVC = [[GTZalgoInputViewController alloc] initWithNibName:@"GTZalgoInputViewController" bundle:nil];
    self.textView.inputView = self.zalgoInputVC.view;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"MEMORY WARNING");
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)fontButtonAction:(id)sender
{
    [self.textView resignFirstResponder];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length == 0) {
        return YES;
    }

    // zalgo
    NSString *processed = [self.zalgo process:text];
    NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:processed];
    textView.text = newText;
    return NO;
}

@end
