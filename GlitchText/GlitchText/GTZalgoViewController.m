#import "GTZalgoViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "GTZalgo.h"

@interface GTZalgoViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) GTZalgo *zalgo;
@property (strong, nonatomic) NSMutableArray *processedStrings;

@end

@implementation GTZalgoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.zalgo = [GTZalgo new];
    self.processedStrings = [NSMutableArray new];
    self.textField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect kbRect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect toView:nil];
}

- (void)updateTextView
{
    self.textView.text = [self.processedStrings componentsJoinedByString:@""];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string length] == 1) {
        NSString *newString = [self.zalgo process:string];
        [self.processedStrings addObject:newString];
        [self updateTextView];
    }
    return YES;
}

@end
