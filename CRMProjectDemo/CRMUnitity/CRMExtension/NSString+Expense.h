//
//  NSString+Expense.h
//  SkyGoods
//
//  Created by 刘闻天 on 15/12/21.
//  Copyright © 2015年 Raymon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Expense)
// 判断字符串是否为空或者nil
+ (BOOL)isNil:(NSString *)string;

// 判断手机号格式是否正确
- (BOOL)isCorrectTelOrPhone:(BOOL)allCheck;

// 自适应字体宽度
- (CGSize)customSizeWithFont:(UIFont *)font;

// 当参数为空时返回@""
+(NSString*)ridObject:(id)object;

// 计算当前输入数字个数
+ (NSInteger)chineseCountOfString:(NSString *)string;

// 判断是字母还是汉字
//+ (BOOL)isChinesecharacter:(NSString *)string;

// 字符串是否含有空格
+ (BOOL)isBlankString:(NSString *)string;


@end
