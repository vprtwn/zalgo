#import <Foundation/Foundation.h>

@protocol GTInputDelegate <NSObject>

- (void)shouldEnterText:(NSString *)text;
- (void)showDefaultKeyboard;

@end
