#import "GTButtonCell.h"
#import "UIColor+GlitchText.h"

#import <UIImage+Additions/UIImage+Additions.h>
#import <pop/POP.h>

@interface GTButtonCell ()

@end

@implementation GTButtonCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }

    NSUInteger cellCornerRadius = 4;
    NSUInteger shadowCornerRadius = 1;

    CALayer *bgLayer = self.backgroundView.layer;
    bgLayer.cornerRadius = cellCornerRadius;
    bgLayer.rasterizationScale = [[UIScreen mainScreen] scale];
    bgLayer.shouldRasterize = YES;

    CALayer *cellLayer = self.layer;
    cellLayer.cornerRadius = cellCornerRadius;
    cellLayer.masksToBounds = NO;
    cellLayer.shadowRadius = shadowCornerRadius;
    cellLayer.shadowColor = [[UIColor glitchMagentaColor] CGColor];
    cellLayer.shadowOffset = CGSizeMake(0, 2);
    cellLayer.shadowOpacity = 1;
    CGRect rect = CGRectMake(self.frame.origin.x + 1,
                             self.frame.origin.y + 1,
                             self.frame.size.width - 2,
                             self.frame.size.height - 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    cornerRadius:shadowCornerRadius];
    cellLayer.shadowPath = path.CGPath;

    return self;
}

- (IBAction)touchUp:(id)sender {
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
}

- (IBAction)touchDragExit:(id)sender {
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
}

- (IBAction)touchDown:(id)sender {
    self.layer.backgroundColor = [UIColor lightGrayColor].CGColor;

}


@end
