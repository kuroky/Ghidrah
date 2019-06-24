//
//  NSString+EMString.m
//  Emucoo
//
//  Created by kuroky on 2017/6/22.
//  Copyright © 2017年 Emucoo. All rights reserved.
//

#import "NSString+EMString.h"
#import "NSData+EMData.h"
#import "NSNumber+EMNumber.h"

@implementation NSString (EMString)

#pragma mark- 哈希相关String

- (NSString *)em_md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] em_md5String];
}

- (NSString *)em_sha1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] em_sha1String];
}

- (NSString *)em_sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] em_sha512String];
}

- (NSString *)em_hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            em_hmacMD5StringWithKey:key];
}

- (NSString *)em_hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            em_hmacSHA1StringWithKey:key];
}

- (NSString *)em_hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            em_hmacSHA512StringWithKey:key];
}

- (NSString *)em_crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] em_crc32String];
}


#pragma mark- 编码和解码

- (NSString *)em_base64EncodedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] em_base64EncodedString];
}

+ (NSString *)em_stringWithBase64EncodedString:(NSString *)base64EncodedString {
    NSData *data = [NSData em_dataWithBase64EncodedString:base64EncodedString];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)em_stringByURLEncode {
    NSCharacterSet *charSet = [NSCharacterSet URLFragmentAllowedCharacterSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:charSet];
}

- (NSString *)em_stringByURLDecode {
    return [self stringByRemovingPercentEncoding];
}

- (NSString *)em_stringByEscapingHTML {
    NSUInteger len = self.length;
    if (!len) return self;
    
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return nil;
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        unichar c = buf[i];
        NSString *esc = nil;
        switch (c) {
            case 34: esc = @"&quot;"; break;
            case 38: esc = @"&amp;"; break;
            case 39: esc = @"&apos;"; break;
            case 60: esc = @"&lt;"; break;
            case 62: esc = @"&gt;"; break;
            default: break;
        }
        if (esc) {
            [result appendString:esc];
        } else {
            CFStringAppendCharacters((CFMutableStringRef)result, &c, 1);
        }
    }
    free(buf);
    return result;
}

#pragma mark- 正则表达式相关
- (BOOL)em_matchesRegex:(NSString *)regex options:(NSRegularExpressionOptions)options {
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:NULL];
    if (!pattern) return NO;
    return ([pattern numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)] > 0);
}

- (void)em_enumerateRegexMatches:(NSString *)regex
                         options:(NSRegularExpressionOptions)options
                      usingBlock:(nullable void (^)(NSString *match, NSRange matchRange, BOOL *stop))block {
    if (regex.length == 0 || !block) return;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:nil];
    if (!regex) return;
    [pattern enumerateMatchesInString:self options:kNilOptions range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        block([self substringWithRange:result.range], result.range, stop);
    }];
}

- (NSString *)em_stringByReplacingRegex:(NSString *)regex
                                options:(NSRegularExpressionOptions)options
                             withString:(NSString *)replacement; {
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:nil];
    if (!pattern) return self;
    return [pattern stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:replacement];
}

#pragma mark- NSNumber
- (NSNumber *)em_numberValue {
    return [NSNumber em_numberWithString:self];
}

- (char)em_charValue {
    return self.em_numberValue.charValue;
}

- (unsigned char) em_unsignedCharValue {
    return self.em_numberValue.unsignedCharValue;
}

- (short) em_shortValue {
    return self.em_numberValue.shortValue;
}

- (unsigned short) em_unsignedShortValue {
    return self.em_numberValue.unsignedShortValue;
}

- (unsigned int) em_unsignedIntValue {
    return self.em_numberValue.unsignedIntValue;
}

- (long) em_longValue {
    return self.em_numberValue.longValue;
}

- (unsigned long) em_unsignedLongValue {
    return self.em_numberValue.unsignedLongValue;
}

- (unsigned long long) em_unsignedLongLongValue {
    return self.em_numberValue.unsignedLongLongValue;
}

- (NSUInteger) em_unsignedIntegerValue {
    return self.em_numberValue.unsignedIntegerValue;
}

#pragma mark- Utilities

- (BOOL)em_isNotBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 过滤指定的字符串
- (NSString *)em_removeCharacters:(NSArray *)charaters {
    
    NSString *str = self;
    for (NSString *ch in charaters) {
        str = [str stringByReplacingOccurrencesOfString:ch withString:@""];
    }
    return str;
}

- (NSData *)em_dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)em_jsonValueDecoded {
    return [[self em_dataValue] em_jsonValueDecoded];
}

+ (NSString *)em_stringNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    if (!str) {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
        str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    }
    return str;
}

- (BOOL)em_isPhoneNumber {
    BOOL match = NO;
    match = [self em_matchesRegex:@"^\\d{11}$"
                          options:NSRegularExpressionCaseInsensitive];
    return match;
}

- (BOOL)em_pwdIsLegal {
    BOOL match = NO;
    match = [self em_matchesRegex:@"^[\\p{Punct}a-zA-Z0-9]{6,20}$"
                          options:NSRegularExpressionCaseInsensitive];
    return match;
}

- (BOOL)em_realNmaeIsLegal {
    BOOL match = NO;
    match = [self em_matchesRegex:@"^[\u4e00-\u9fa5]{2,7}$|^[A-Za-z]{4,14}$"
                          options:NSRegularExpressionCaseInsensitive];
    return match;
}

- (BOOL)em_isPercentNumber {
    BOOL match = NO;
    match = [self em_matchesRegex:@"^100$|^(\\d|[1-9]\\d)(\\.\\d+)*$"
                          options:NSRegularExpressionCaseInsensitive];
    return match;
}

- (BOOL)em_isRenminbi {
    BOOL match = NO;
    match = [self em_matchesRegex:@"((^[-]?([1-9]\\d*))|^0)(\\.\\d{1,2})?$|(^[-]0\\.\\d{1,2}$)"
                          options:NSRegularExpressionCaseInsensitive];
    return match;
}

- (BOOL)em_isInteger {
    BOOL match = NO;
    match = [self em_matchesRegex:@"^(0|[1-9][0-9]*|-[1-9][0-9]*)$"
                          options:NSRegularExpressionCaseInsensitive];
    return match;
}

@end
