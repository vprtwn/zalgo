#import "GTGlitchInputCell.h"

@interface GTGlitchInputCell ()


@end

@implementation GTGlitchInputCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }

    CALayer *layer = [self layer];
    [layer setCornerRadius:4];
    [layer setRasterizationScale:[[UIScreen mainScreen] scale]];
    [layer setShouldRasterize:YES];

    return self;
}

@end
