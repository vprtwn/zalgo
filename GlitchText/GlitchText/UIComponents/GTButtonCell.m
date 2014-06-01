#import "GTButtonCell.h"
#import "UIColor+GlitchText.h"

@interface GTButtonCell ()

@end

@implementation GTButtonCell

- (id)initWithCoder:(NSCoder *)aDecoder
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
    CGRect rect = CGRectMake(self.x + 1, self.y + 1, self.width - 2, self.height - 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    cornerRadius:shadowCornerRadius];
    cellLayer.shadowPath = path.CGPath;

    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    if (self.highlighted) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetGrayFillColor(context, 0.41, 0.5);
        CGContextFillRect(context, self.bounds);
    }
}

@end
