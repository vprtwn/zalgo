#import "GTZalgoFooterView.h"

@implementation GTZalgoFooterView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;

    self.invokeButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.invokeButton.layer.borderWidth = 1.5;
    self.invokeButton.layer.cornerRadius = 4.0f;
    self.invokeButton.backgroundColor = [UIColor blackColor];
    [self.invokeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    return self;
}

@end
