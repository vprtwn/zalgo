//
//  GTXViewController.m
//  GlitchText
//
//  Created by Ben Guo on 4/29/14.
//  Copyright (c) 2014 bguo. All rights reserved.
//

#import "GTXZalgoViewController.h"

@interface GTXZalgoViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation GTXZalgoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.textField becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardDidShow:)
     name:UIKeyboardDidShowNotification
     object:nil];
    [self.textView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    @try {
        [self.textView removeObserver:self
                           forKeyPath:@"contentSize"];
    }
    @catch (NSException * __unused exception) {}
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    UITextView *textView = object;
    CGFloat topOffset = ([textView bounds].size.height - [textView contentSize].height * [textView zoomScale])/2.0;
    topOffset = ( topOffset < 0.0 ? 0.0 : topOffset );
    textView.contentOffset = (CGPoint){.x = 0, .y = -topOffset};
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
