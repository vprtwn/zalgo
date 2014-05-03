#import "GTZalgo.h"
#import "NSString+GlitchText.h"

@implementation GTZalgo

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    self.up = @""
               " ̍ ̎ ̄ ̅"
               " ̿ ̑ ̆ ̐"
               " ͒ ͗ ͑ ̇"
               " ̈ ̊ ͂ ̓"
               " ̈ ͊ ͋ ͌"
               " ̃ ̂ ̌ ͐"
               " ̀ ́ ̋ ̏"
               " ̒ ̓ ̔ ̽"
               " ̉ ͣ ͤ ͥ"
               " ͦ ͧ ͨ ͩ"
               " ͪ ͫ ͬ ͭ"
               " ͮ ͯ ̾ ͛"
               " ͆ ̚"
               "";
    
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
        NSUInteger upCount = arc4random_uniform(8);
        NSUInteger midCount = arc4random_uniform(2);
        NSUInteger downCount = arc4random_uniform(8);
        for (int j = 0; j < upCount; j++) {
            unichar ch = [[self.up randomCharacter] unichar];
            [newText appendString:[NSString stringWithUnichar:ch]];
        }

        for (int j = 0; j < midCount; j++) {
            unichar ch = [[self.mid randomCharacter] unichar];
            [newText appendString:[NSString stringWithUnichar:ch]];
        }
        for (int j = 0; j < downCount; j++) {
            unichar ch = [[self.down randomCharacter] unichar];
            [newText appendString:[NSString stringWithUnichar:ch]];
        }
    }
    return newText;
}

@end
