//
//  RMUtils.h
//  SkyGoodsTests
//
//  Created by SkyGoodsTests on 15/12/16.
//  Copyright © 2015年 Raymon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RMTextField;
@interface RMUtils : NSObject

// 字体
+ (UIFont *)expenseFontWith:(CGFloat)size;
+ (UIFont *)defaultFont;

// 菊花加载效果
+ (void) hudShow;
+ (void) hudShow : (NSString*) msg;
+ (void) hudSuccessHidden;
+ (void) hudSuccessHidden : (NSString*) msg;
+ (void) hudFailHidden;
+ (void) hudFailHidden : (NSString*) msg;

// 系统自动网络加载效果
+ (UIActivityIndicatorView *)showActivityIndicatorViewInView:(UIView *)view;

// 添加alertController提示框
+ (void)showAlertControllerWithMessage:(NSString *)message onViewController:(UIViewController *)viewController;

// 判断字符串是否为空
+ (NSString *)getString:(NSString *)aStr;

// 提示框alerview,仅显示确定按钮
+(void)showMessage:(NSString *)content;

// 现实提示框alertview
+(void)alertWithTitle:(NSString *)title
              message:(NSString *)message
             delegate:(id)delegate
                  tag:(NSInteger)tag
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ... ;

// 弹出actionSheet
+(void)showActionSheetInView:(UIView *)view
                    delegate:(id)delegate
                         tag:(NSInteger)tag
                       title:(NSString *)title
           cancelButtonTitle:(NSString *)cancelButtonTitle
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
           otherButtonTitles:(NSString *)otherButtonTitles, ... ;

// 创建label
+ (UILabel *)labelWith:(CGRect)frame
                  font:(UIFont *)font
                  text:(NSString *)text
             textColor:(UIColor *)textColor;

// 创建button
+ (UIButton *)buttonWith:(CGRect)frame
                   text:(NSString *)text
               backColor:(UIColor *)backColor
               textColor:(UIColor *)textColor
                     tag:(NSInteger)tag;

+ (UIButton *)buttonWithFrame:(CGRect)frame
              BackGroundColor:(UIColor *)backgroundColor
                    TextColor:(UIColor *)textColor
                      IsBound:(BOOL)isBound
                 CornerRadius:(CGFloat)cornerRadius
                         Text:(NSString *)text
                    ButtonTag:(NSInteger)buttonTag;

// 创建分割线
+ (UIView *)lineViewWith:(CGRect)frame;

/**
 *  添加虚线
 */
+ (void)dashedLineWith:(CGRect)frame point:(CGPoint)point CGColor:(CGColorRef)CGColor dashedWidth:(CGFloat)width dashedY:(CGFloat)Y addView:(UIView *)view;

// JSON数据转换
+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;

// date转换成string
+ (NSString *)dateTransformToStringWithDate:(NSDate *)date format:(NSString *)format;

// 数据转JSON并编码
+ (NSString *)dataToJson:(NSMutableArray *)array;

+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

// 请求url
//+ (NSString *)requestURL:(NSString *)string;

// uid/sign
+ (NSDictionary *)userBaseMessage;

// 获取当前日期(字符串)
+ (NSString *)currentDateWithFormatter:(NSString *)formatter;

/*
 * 添加标签
 */
+ (CGFloat)createAttrNameLabel:(CGRect)frame Text:(NSString *)text  SuperView:(id)view;


// 默认提示框
//+ (void)addSuccessAnimatingWithTest:(NSString*)text onView:(UIView *)view isSucess:(BOOL)isSucess;

//+ (void)startAbnormalNetworkAnimatingOnView:(UIView *)view;


//数字逗号分隔
+ (NSString *)countNumAndChangeformat:(NSString *)num;

// 控件根据文本内容进行高度自适应
+ (CGFloat)adjustHeightWithContent:(NSString *)content font:(UIFont *)font ContentWidth:(CGFloat)contentwidth;
+ (CGSize)labelheight:(UILabel *)label;

// 根据astr 判断字符串宽度
+ (CGSize)getWidthWithString:(NSString *)aStr WithFont:(UIFont *)aFont;
/**
 *    @brief  正则表达式判断手机号是否正确
 *
 *    @param phone  手机号
 *
 *    @return YES：手机号正确；NO：手机号错误
 */
+ (BOOL)checkTel:(NSString *)str;

+ (NSString *)getUserNickName:(NSString *)title;

// 将时间戳转换成时间
+ (NSString *)TimestampTransformToStandardTimeWithTimestamp:(NSString *)time dateFormat:(NSString *)format;

// 根据type类型返回请假类型
+ (NSString *)transformTypeToLetterWith:(NSString *)type;

// 比较两个日期相差时间
//+ (NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2;

// 将model转换为dictionary
+ (NSDictionary *)dictionaryFromModel;

/**
 *    @brief label的多行显示（有行间距）
 *
 *    @param label 需要处理的label
 *
 *    @return label的高度
 */
+ (CGFloat)heightForLabel:(UILabel *)label;

/**
 *    @brief label不同颜色不同字体大小设置
 *
 *    @param label     需要处理的label
 *    @param range     需要处理的文字范围
 *    @param noteColor 显示的不同的颜色
 *    @param noteFont  显示的不同字体大小
 */
+ (void)labelWith:(UILabel *)label RangeOfNote:(NSRange)range NoteColor:(UIColor *)noteColor        NoteFont:(UIFont *)noteFont;

/**
 *  转64编码
 */
+ (NSString *)base64WithObject:(id)object;

/**
 *  获取位置
 *
 *  @return 返回经纬度字典信息
 */
+ (NSDictionary *)getLocation;

/**
 *  获取请求头head
 */
+ (NSString *)getRequestHeadString;

/**
 *  获取请求request
 */
+ (NSString *)getResquestCoderWithRGuid:(NSString*)RGuid Content:(NSDictionary *)content;

/**
 *  获取请求request(没有城市信息)
 */
+ (NSString *)getResquestCoderWithRGuid:(NSString*)RGuid noneProvinceContent:(NSDictionary *)content;

/**
 *  获取请求体params
 */
+ (NSDictionary *)paramDicWithparam:(NSString *)url content:(NSDictionary *)content isCity:(BOOL)city;

/**
 *  获取经纬度
 */
+ (void)locationAtCashe;

/**
 *  获取经纬度(在block内调用函数)
 *
 */
+ (void)locationAtCasheWtih:(void(^)())success;

/**
 *  NSNumber 转 NSSTring
 */
+ (NSString *)numberTransforToStringWith:(NSInteger)number;

/**
 *  将16进制颜色转换成UIColor
 */
+ (UIColor *)getColorWithHexString:(NSString *)hexColor;

// 将html格式转为AttributeString格式
+ (NSAttributedString *)transformHtmlWithString:(NSString *)htmlString;

/**
 *  屏蔽角标显示问题
 */
+ (NSString *)setBadgeTypeWithString:(NSString *)badgeStr;


@end
