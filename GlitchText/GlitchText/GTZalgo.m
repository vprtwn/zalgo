#import "GTZalgo.h"
#import "NSString+GlitchText.h"

unichar up[50] =
    {0x030d, 0x030e, 0x0304, 0x0305,
    0x033f, 0x0311, 0x0306, 0x0310,
    0x0352, 0x0357, 0x0351, 0x0307,
    0x0308, 0x030a, 0x0342, 0x0343,
    0x0344, 0x034a, 0x034b, 0x034c,
    0x0303, 0x0302, 0x030c, 0x0350,
    0x0300, 0x0301, 0x030b, 0x030f,
    0x0312, 0x0313, 0x0314, 0x033d,
    0x0309, 0x0363, 0x0364, 0x0365,
    0x0366, 0x0367, 0x0368, 0x0369,
    0x036a, 0x036b, 0x036c, 0x036d,
    0x036e, 0x036f, 0x033e, 0x035b,
    0x0346, 0x031a};

@implementation GTZalgo

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    
    
    
    
    
    
    
    
    self.up = @"̎̄̅̿̑̆̐͒͗͑̇̈̊͂̓̈͊͋͌̃̂̌͐"
//               " ̀ ́ ̋ ̏"
//               " ̒ ̓ ̔ ̽"
//               " ̉ ͣ ͤ ͥ"
//               " ͦ ͧ ͨ ͩ"
//               " ͪ ͫ ͬ ͭ"
//               " ͮ ͯ ̾ ͛"
//               " ͆ ̚"
    

    
    self.down = @""
                 " ̖ ̗ ̘ ̙"
                 " ̜ ̝ ̞ ̟"
                 " ̠ ̤ ̥ ̦"
                 " ̩ ̪ ̫ ̬"
                 " ̭ ̮ ̯ ̰"
                 " ̱ ̲ ̳ ̹"
                 " ̺ ̻ ̼ ͅ"
                 " ͇ ͈ ͉ ͍"
                 " ͎ ͓ ͔ ͕"
                 " ͖ ͙ ͚ ̣"
                 "";
    
    self.mid = @""
                " ̕ ̛ ̀ ́"
                " ͘ ̡ ̢ ̧"
                " ̨ ̴  ̵ ̶"
                " ͏ ͜  ͝ ͞"
                " ͟ ͠  ͢ ̸"
                " ̷ ͡ ҉_"
                "";
    
    self.all = [NSString stringWithFormat:@"%@%@%@", self.up, self.down, self.mid];
    
    
    return self;
}

- (BOOL)isZalgoChar:(unichar)character {
    return [self.all rangeOfString:[NSString stringWithUnichar:character]].location != NSNotFound;
}

//
// http://nshipster.com/random/
//
- (NSString *)process:(NSString *)text {
    NSMutableString *newText = [NSMutableString new];
    NSUInteger len = [text length];
    for (int i = 0; i < len; i++) {
        NSUInteger upCount = 4;
        NSUInteger midCount = 4;
        NSUInteger downCount = 4;
        
        unichar buffer[upCount + 2];
        buffer[0] = [text unichar];
        [newText appendString:text];
        for (int j = 0; j < upCount; j++) {
            const char *ch = [self.up randomUnichar];
            NSString *c = [self.up randomCharacter];
            [newText appendString:c];
            NSLog(@"%@", c);
        }
        buffer[upCount + 2] = '\0';

//        for (int j = 0; j < midCount; j++) {
//            unichar ch = [[self.mid randomCharacter] unichar];
//            [newText appendString:[NSString stringWithUnichar:ch]];
//        }
//        for (int j = 0; j < downCount; j++) {
//            unichar ch = [[self.down randomCharacter] unichar];
//            [newText appendString:[NSString stringWithUnichar:ch]];
//        }
    }
    return newText;
}

@end
