#import "NSDictionary+GlitchText.h"

@implementation NSDictionary (GlitchText)

+ (NSDictionary *)dictionaryWithPlistNamed:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

@end
