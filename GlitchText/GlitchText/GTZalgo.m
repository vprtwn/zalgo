#import "GTZalgo.h"
#import "NSString+GlitchText.h"















NSString *const GTZalgoUp = @"̄̅̿̑̆̐͒͗͑̇̈̊͂̓̈͊͋͌̃̂̌͐̀́̋̏̒̓̔̽̉ͣͤͥͦͧͨͩͪͫͬͭͮͯ̾͛͆̚";



NSString *const GTZalgoDown = @"̗̘̙̜̝̞̟̠̤̥̦̪̫̬̭̮̯̰̱̲̳̹̺̻̼͇͈͉͍͎͓͔͕͖͙͚̣ͅ";












NSString *const GTZalgoMid = @"̴̵̶̸̷̡̢̧̨̛̀́̕͘͜͟͢͝͞͠͡҉";





@implementation GTZalgo

//
// BEHOLD THE ZALGORITHM
//
+ (NSString *)process:(NSString *)text {

#warning optimize this in C
    NSMutableString *newText = [NSMutableString new];
    NSUInteger len = [text length];
    for (int i = 0; i < len; i++) {
        NSUInteger upCount = arc4random_uniform(8);
        NSUInteger downCount = arc4random_uniform(8);
        NSUInteger midCount = arc4random_uniform(2);

        [newText appendString:text];
        
        for (int j = 0; j < upCount; j++) {
            NSString *c = [GTZalgoUp randomCharacter];
            [newText appendString:c];
        }
        
        for (int j = 0; j < downCount; j++) {
            NSString *c = [GTZalgoDown randomCharacter];
            [newText appendString:c];
        }
        
        for (int j = 0; j < midCount; j++) {
            NSString *c = [GTZalgoMid randomCharacter];
            [newText appendString:c];
        }       

    }
    return newText;
}

@end
