#import "GTZalgo.h"
#import "NSString+GlitchText.h"
#import "NSArray+GlitchText.h"















NSString *const GTZalgoUp = @"̄̅̿̑̆̐͒͗͑̇̈̊͂̓̈͊͋͌̃̂̌͐̀́̋̏̒̓̔̽̉ͣͤͥͦͧͨͩͪͫͬͭͮͯ̾͛͆̚";



NSString *const GTZalgoDown = @"̗̘̙̜̝̞̟̠̤̥̦̪̫̬̭̮̯̰̱̲̳̹̺̻̼͇͈͉͍͎͓͔͕͖͙͚̣ͅ";












NSString *const GTZalgoMid = @"̴̵̶̸̷̡̢̧̨̛̀́̕͘͜͟͢͝͞͠͡҉";



@implementation GTZalgo

+ (instancetype)sharedInstance
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (!self) return nil;

    self.up = [GTZalgoUp characterArray];
    self.mid = [GTZalgoMid characterArray];
    self.down = [GTZalgoDown characterArray];
    self.all = [[self.up arrayByAddingObjectsFromArray:self.mid] arrayByAddingObjectsFromArray:self.down];

    return self;
}


//
// BEHOLD THE ZALGORITHM
//
- (NSString *)processOne:(NSString *)c
{
    NSUInteger upCount = arc4random_uniform(8);
    NSUInteger downCount = arc4random_uniform(8);
    NSUInteger midCount = arc4random_uniform(2);
    NSUInteger length = 1 + upCount + downCount + midCount;
    
    unichar buffer[length + 1];
    NSUInteger i = 0;
    buffer[i] = [c characterAtIndex:0];
    i++;
    for (int j = 0; j < upCount; j++) {
        NSString *c = [self.up randomObject];
        buffer[i] = [c characterAtIndex:0];
        i++;
    }

    for (int j = 0; j < downCount; j++) {
        NSString *c = [self.down randomObject];
        buffer[i] = [c characterAtIndex:0];
        i++;       
    }

    for (int j = 0; j < midCount; j++) {
        NSString *c = [self.mid randomObject];
        buffer[i] = [c characterAtIndex:0];
        i++;
    }
    buffer[i] = 0x0000;

    return [NSString stringWithCharacters:buffer length:length];
}


- (NSString *)process:(NSString *)text
{
    NSArray *cs = [text characterArray];
    NSMutableString *newText = [NSMutableString new];
    for (NSString *c in cs) {
        if (![c isZalgo]) {
            [newText appendString:[self processOne:c]];
        }
    }
    return newText;
}


@end