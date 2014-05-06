#import "GTGlitchInputCell.h"

NSString *const kReuseIDGlitchInputCell = @"glitchInputCell";

@interface GTGlitchInputCell ()


@end

@implementation GTGlitchInputCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.label.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)prepareForReuse
{

}



@end
