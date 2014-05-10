#import <UIKit/UIKit.h>

@interface GTTextRange : UITextRange {
    NSRange _range;
}

@property (nonatomic) NSRange range;
+ (GTTextRange *)rangeWithNSRange:(NSRange)range;

@end


