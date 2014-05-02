#import "GTZalgoViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface GTZalgoViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation GTZalgoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // debug colors
    self.textView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.textField.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
}

- (void)dealloc {
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

@end
