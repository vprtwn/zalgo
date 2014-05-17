#import "GTZalgo.h"
#import "NSString+GlitchText.h"
#import "NSArray+GlitchText.h"















NSString *const GTZalgoUp = @"̄̅̿̑̆̐͒͗͑̇̈̊͂̓̈͊͋͌̃̂̌͐̀́̋̏̒̓̔̽̉ͣͤͥͦͧͨͩͪͫͬͭͮͯ̾͛͆̚";



NSString *const GTZalgoDown = @"̗̘̙̜̝̞̟̠̤̥̦̪̫̬̭̮̯̰̱̲̳̹̺̻̼͇͈͉͍͎͓͔͕͖͙͚̣ͅ";












NSString *const GTZalgoMid = @"̛̕꙰҈̴̵̶̸̷̡̢̧̨̀́͘͜͟͢͝͞͠͡҉";





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
    self.mode = GTZalgoModeOff;

    return self;
}


//
// BEHOLD THE ZALGORITHM
//
- (NSString *)processOne:(NSString *)c mode:(GTZalgoMode)mode
{
    if (mode == GTZalgoModeOff) {
        return c;
    }
    NSUInteger upMaxRand, midMaxRand, downMaxRand;
    NSUInteger upMin, midMin, downMin;
    NSUInteger midDivisor = 1;
    switch (mode) {
        case GTZalgoModeNormal:
            upMaxRand = downMaxRand = 8;
            midMaxRand = 6;
            upMin = downMin = 1;
            midMin = 0;
            midDivisor = 2;
            break;
        case GTZalgoModeUltra:
            upMaxRand = downMaxRand = 16;
            midMaxRand = 4;
            upMin = downMin = 3;
            midMin = 1;
            break;
        default:
            break;
    }

    NSUInteger upCount = arc4random_uniform(upMaxRand) + upMin;
    NSUInteger midCount = (arc4random_uniform(midMaxRand) + midMin)/midDivisor;
    NSUInteger downCount = arc4random_uniform(downMaxRand) + downMin;
    NSUInteger length = 1 + upCount + midCount + downCount;
    
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
    if (self.mode == GTZalgoModeOff) {
        return text;
    }
    return [self process:text mode:self.mode];
}


- (NSString *)process:(NSString *)text mode:(GTZalgoMode)mode
{
    if (mode == GTZalgoModeOff) {
        return text;
    }
    NSArray *cs = [text characterArray];
    NSMutableString *newText = [NSMutableString new];
    for (NSString *c in cs) {
        if (![c isZalgo] && ![c isWhitespace]) {
            [newText appendString:[self processOne:c mode:mode]];
        }
        else {
            [newText appendString:c];
        }
    }
    return newText;
}


@end
