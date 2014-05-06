#import "GTGlitchInputCell.h"

NSString *const kReuseIDGlitchInputCell = @"glitchInputCell";

@interface GTGlitchInputCell ()


@end

@implementation GTGlitchInputCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }

    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.contentView.layer.cornerRadius = 20;

    return self;
}


- (void)prepareForReuse
{

}



@end
