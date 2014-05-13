#import <Foundation/Foundation.h>

@protocol GTInputDelegate <NSObject>

- (void)shouldEnterText:(NSString *)text;
- (void)shouldInvokeTheHiveMind;
- (void)showDefaultKeyboard;

@end
