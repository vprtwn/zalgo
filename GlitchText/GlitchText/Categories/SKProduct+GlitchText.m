#import "SKProduct+GlitchText.h"

@implementation SKProduct (GlitchText)

- (NSString *)priceString
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:self.priceLocale];
    NSString *formattedPrice = [numberFormatter stringFromNumber:self.price];
    return formattedPrice;
}

@end
