malloc(), free()

NSString *sentence = @"A long unicode sentence";

NSUInteger length = [sentence length];
unichar aBuffer[length + 1];

[sentence getCharacters:aBuffer range:NSMakeRange(0, length)];
aBuffer[length] = 0x0;

NSString *newStr = [NSString stringWithCharacters:aBuffer length:length];

NSLog(@"%@", newStr);