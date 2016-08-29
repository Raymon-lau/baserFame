//
//  NSString+Expense.m
//  SkyGoods
//
//  Created by 刘闻天 on 15/12/21.
//  Copyright © 2015年 Raymon. All rights reserved.
//

#import "NSString+Expense.h"

@implementation NSString (Expense)

// 判断字符串是否为空
+ (BOOL)isNil:(NSString *)string
{
    if ([string isKindOfClass:[NSNumber class]]) {
        string = [NSString stringWithFormat:@"%@",string];
    }
    
    if (string == nil || string.length == 0) {
        return YES;
    }
    
    return NO;
}

// 用于请求参数,避免参数为空
+(NSString*)ridObject:(id)object
{
    if ([object isKindOfClass:[NSString class]])
    {
        return object;
    }
    
    if ([object isKindOfClass:[NSNull class]] || object == nil)
    {
        return @"";
    }
    
    return [object description];
}

// 判断手机号格式
- (BOOL)isCorrectTelOrPhone:(BOOL)allCheck
{
    if ([NSString isNil:self]) {
        return YES;
    }
    
    NSString *regex = @"^(130|131|132|133|134|135|136|137|138|139|150|151|152|153|155|156|157|158|159|177|180|181|182|183|184|185|186|187|188|189)\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    NSString *other;
    if (allCheck) {
        other = @"^(0[0-9]{2,3}\\-)?([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?$";
        NSPredicate *otherPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", other];
        if ([otherPred evaluateWithObject:self]) {
            return YES;
        }
    }
    
    
    
    BOOL isMatch = [pred evaluateWithObject:self];
    
    return isMatch;
}

// 自适应字体宽度
- (CGSize)customSizeWithFont:(UIFont *)font
{
    CGSize size = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    return size;
}

+ (NSInteger)chineseCountOfString:(NSString *)string{
    int ChineseCount = 0;
    if (string.length == 0) {        return 0;
    }
    for (int i = 0; i<string.length; i++) {
    unichar c = [string characterAtIndex:i];
    if (c >=0x4E00 && c <=0x9FA5)        {
        ChineseCount++ ;//汉字
        }
    }
    return ChineseCount;
}

// 字符串是否含有空格
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0) {
        return YES;
    }
    return NO;
}

@end
