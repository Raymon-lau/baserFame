//
//  RMUtils.m
//  SkyGoodsTests
//
//  Created by SkyGoodsTests on 15/12/16.
//  Copyright © 2015年 Raymon. All rights reserved.
//
#ifndef IS_IOS7
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f
#endif
#import "RMUtils.h"
#import "ProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@implementation RMUtils

#pragma mark - 基础属性设置
+ (BOOL)isIPhone6
{
    if (kScreenWidth == 375) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isIPhone6Plus
{
    if (kScreenWidth == 414) {
        return YES;
    }
    
    return NO;
}

// 字体
+ (UIFont *)expenseFontWith:(CGFloat)size
{
    return [UIFont systemFontOfSize:[RMUtils resetSize:size]];
}

+ (UIFont *)defaultFont
{
    if ([RMUtils isIPhone6Plus]) {
        return [UIFont systemFontOfSize:17.0];
    }
    return [UIFont systemFontOfSize:15.0];
}

+ (CGFloat)resetSize:(CGFloat)size
{
    if ([RMUtils isIPhone6]) {
        size += 2;
    } else if ([RMUtils isIPhone6Plus]) {
        size += 4;
    }
    return size;
}



#pragma mark - 转动菊花
+ (void) hudShow
{
    [ProgressHUD show:@"正在加载..."];
}

+ (void) hudShow : (NSString*) msg
{
    [ProgressHUD show:msg];
}

+ (void) hudSuccessHidden
{
    [ProgressHUD dismiss];
}

+ (void) hudSuccessHidden : (NSString*) msg
{
    [ProgressHUD showSuccess:msg];
}

+ (void) hudFailHidden
{
    [ProgressHUD showError:nil];
}

+ (void) hudFailHidden : (NSString*) msg
{
    [ProgressHUD showError:msg];
}

+ (UIActivityIndicatorView *)showActivityIndicatorViewInView:(UIView *)view
{
    UIActivityIndicatorView * activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicatorView setFrame:[UIScreen mainScreen].bounds];
    activityIndicatorView.center = view.center;
    [view addSubview:activityIndicatorView];
    return activityIndicatorView;
}

+ (void)showAlertControllerWithMessage:(NSString *)message onViewController:(UIViewController *)viewController
{
    [viewController.view endEditing:YES];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 工具方法
//获取判断之后的字符串
+ (NSString *)getString:(NSString *)aStr
{
    if (!aStr||[aStr isKindOfClass:[NSNull class]]||[aStr isEqual:@"(null)"]){
        
        aStr = @"0";
        
    }
    
    return aStr;
    
}

// JSON转换数据
+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString
{
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

// 数据转JSON进行编码
+ (NSString *)dataToJson:(NSMutableArray *)array
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
    jsonData = [GTMBase64 encodeData:jsonData];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    jsonData = [GTMBase64 encodeData:jsonData];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark - 提示视图
+(void)showMessage:(NSString *)content {
    if ([NSString isNil:content]) {
        return;
    }
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[RMUtils getString:content] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

+(void)alertWithTitle:(NSString *)title
              message:(NSString *)message
             delegate:(id)delegate
                  tag:(NSInteger)tag
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:[RMUtils getString:message] delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    alert.tag = tag;
    [alert show];
}

+(void)showActionSheetInView:(UIView *)view
                    delegate:(id)delegate
                         tag:(NSInteger)tag
                       title:(NSString *)title
           cancelButtonTitle:(NSString *)cancelButtonTitle
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
           otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];
    
    actionSheet.tag = tag;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:view];
    
}

#pragma mark  - 创建控件
// 创建 label
+ (UILabel *)labelWith:(CGRect)frame
                  font:(UIFont *)font
                  text:(NSString *)text
             textColor:(UIColor *)textColor
{
    if (font == nil) {
        font  = [UIFont systemFontOfSize:15.0];
    }
    
    if (textColor == nil) {
        textColor = [UIColor whiteColor];
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    return label;
}

// 创建button
+ (UIButton *)buttonWith:(CGRect)frame
                    text:(NSString *)text
               backColor:(UIColor *)backColor
               textColor:(UIColor *)textColor
                     tag:(NSInteger)tag
{
    if (textColor == nil) {
        textColor = [UIColor whiteColor];
    }
    if (backColor == nil) {
        backColor = [UIColor whiteColor];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:text forState:UIControlStateNormal];
    button.backgroundColor = backColor;
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.tag = tag;
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame BackGroundColor:(UIColor *)backgroundColor TextColor:(UIColor *)textColor IsBound:(BOOL)isBound CornerRadius:(CGFloat)cornerRadius Text:(NSString *)text ButtonTag:(NSInteger)buttonTag
{
    UIButton *button=  [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=frame;
    [button.layer setMasksToBounds:isBound];
    [button.layer setCornerRadius:cornerRadius];//设置矩形四个圆角半径
    [button setTitle:text forState:UIControlStateNormal];
    button. titleLabel.textAlignment=NSTextAlignmentCenter;
    button.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.backgroundColor=backgroundColor;
    button.tag=buttonTag;
    return button;
}



// 创建分割线
+ (UIView *)lineViewWith:(CGRect)frame
{
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor colorWithWhite:0.899 alpha:1.000];
    return lineView;
}

// 画虚线
+ (void)dashedLineWith:(CGRect)frame point:(CGPoint)point CGColor:(CGColorRef)CGColor dashedWidth:(CGFloat)width dashedY:(CGFloat)Y addView:(UIView *)view
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:frame];
    [shapeLayer setPosition:point];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    // 设置虚线颜色
    [shapeLayer setStrokeColor:CGColor];
    // 设置虚线宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 3是线的宽度  1是线的间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3],[NSNumber numberWithInt:1], nil]];
    // 设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 10, Y);
    CGPathAddLineToPoint(path, NULL, width*2, Y);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [[view layer] addSublayer:shapeLayer];
}

// 日期转换成字符串
+ (NSString *)dateTransformToStringWithDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

// 请求url
//+ (NSString *)requestURL:(NSString *)string
//{
//    NSString *URLString = [NSString stringWithFormat:@"%@%@",FirstURL,string];
//    return URLString;
//}

// uid/sign
+ (NSDictionary *)userBaseMessage
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefault objectForKey:@"CRMUserData"];
    return dic;
}




// 获取当前日期
+ (NSString *)currentDateWithFormatter:(NSString *)formatter
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:formatter];
    NSString *locationString = [dateformatter stringFromDate:date];
    return locationString;
}

+ (CGFloat)createAttrNameLabel:(CGRect)frame Text:(NSString *)text  SuperView:(id)view{
    UILabel *attrNameLabel = [RMUtils labelWith:frame font:[UIFont systemFontOfSize:9] text:text textColor:RGB(0, 141, 223)];
    [attrNameLabel.layer setMasksToBounds:YES];
    [attrNameLabel.layer setCornerRadius:2.0];
    [attrNameLabel.layer setBorderWidth:1.0];
    [attrNameLabel.layer setBorderColor:RGB(0, 141, 223).CGColor];
    attrNameLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:attrNameLabel];
    attrNameLabel.numberOfLines=1;
    attrNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize citySize = [attrNameLabel sizeThatFits:CGSizeMake(MAXFLOAT, attrNameLabel.frame.size.height)];
    attrNameLabel.frame =CGRectMake(frame.origin.x, frame.origin.y, citySize.width+5, frame.size.height);
    return frame.origin.x+citySize.width+5+3;
}


// 提示框
+ (void)addSuccessAnimatingWithTest:(NSString*)text onView:(UIView *)view isSucess:(BOOL)isSucess
{
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 100)];
    [backView.layer setMasksToBounds:YES];
    [backView.layer setCornerRadius:4.0];//设置矩形四个圆角半径
    backView.backgroundColor=[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0];
    [view addSubview:backView];
    CGPoint centerPoint={view.center.x,view.center.y-64};
    backView.center=centerPoint;
    UIImageView *addSuccessImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/4-20, 10, 40, 40)];
    [backView addSubview:addSuccessImageView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0 ,60, kScreenWidth/2, 20)];
    //[label setText: @"成功加入采购清单"];
    label.text=text;
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:15];
    [backView addSubview: label];
    
    if(!isSucess)
    {
        addSuccessImageView.image=[UIImage imageNamed:@"orderList_null"];
    }
    else
    {
        addSuccessImageView.image=[UIImage imageNamed:@"alert_success"];
    }
    
    [UIView animateWithDuration:2 animations:^{
        backView.alpha = 0;
    } completion:^(BOOL finished) {
        [backView removeFromSuperview];
    }];
    
}


+ (void)startAbnormalNetworkAnimatingOnView:(UIView *)view
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,0, 200, 30)];
    label.center=view.center;
    [label setText: @"网络异常，请重新加载"];
    [label.layer setMasksToBounds:YES];
    [label.layer setCornerRadius:4.0];//设置矩形四个圆角半径
    label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor=[UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0 alpha:1.0];
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:15];
    [view addSubview: label];
    [UIView animateWithDuration:2 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}

//数字逗号分隔
+ (NSString *)countNumAndChangeformat:(NSString *)num{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0){
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}


// 根据内容计算 Label 高度
+ (CGFloat)adjustHeightWithContent:(NSString *)content font:(UIFont *)font ContentWidth:(CGFloat)contentwidth
{
    CGRect contentBounds = [content boundingRectWithSize:CGSizeMake(contentwidth, 1000)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:[NSDictionary
                                                          dictionaryWithObject:
                                                          font
                                                          forKey:NSFontAttributeName] context:nil];
    
    return contentBounds.size.height + 5;
    
}


+ (CGSize)labelheight:(UILabel *)label{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 5.f;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName:paragraphStyle};
    CGSize size = CGSizeMake(label.frame.size.width, MAXFLOAT);
    CGSize contentactually = [label.text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    return contentactually;
}

// 根据astr 获取字符串宽度
+ (CGSize)getWidthWithString:(NSString *)aStr WithFont:(UIFont *)aFont
{
    CGSize size;
    if (IS_IOS7) {
        size = [aStr sizeWithAttributes:@{NSFontAttributeName: aFont}];
    }
    else
    {
        // size = [aStr sizeWithFont:aFont];
    }
    return size;
}

//正则表达式判断手机号是否正确
+ (BOOL)checkTel:(NSString *)str
{
    if ([str length] == 0) {
        [RMUtils showMessage:@"手机号不能为空,请重新输入"];
        return NO;
    }
    //1[0-9]{10}
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    //    NSString *regex = @"[0-9]{11}";
//    NSString *regex = @"^((13[0-9])|(147)|(177)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSString * regex = @"^1[34578]\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        return NO;
    }
    return YES;
}

+ (NSString *)getUserNickName:(NSString *)title{
    NSString *nickname = nil;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *friendList = [userDefault objectForKey:@"OrganizationListArray"];
    int i = 0;
    for ( ;i < friendList.count;i++) {
        if (![NSString isNil:friendList[i][@"hx_username"]]  && [title isEqualToString:friendList[i][@"hx_username"]]) {
            nickname = friendList[i][@"nickname"];
            break;
        }
    }
    if (i == friendList.count) {
        nickname = @"陌生人";
    }
    return nickname;
}

// 将时间戳转换成时间
+ (NSString *)TimestampTransformToStandardTimeWithTimestamp:(NSString *)time dateFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    NSString *standardTime = [formatter stringFromDate:date];
    return standardTime;
}

+ (NSString *)transformTypeToLetterWith:(NSString *)type
{
    NSString *letter;
    switch ([type integerValue]) {
        case 1:
            letter = @"事假";
            break;
        case 2:
            letter = @"调休";
            break;
        case 3:
            letter = @"病假";
            break;
        case 4:
            letter = @"年假";
            break;
        case 5:
            letter = @"婚假";
            break;
        case 6:
            letter = @"节育假";
            break;
        case 7:
            letter = @"看护假";
            break;
        case 8:
            letter = @"产/检假";
            break;
        case 9:
            letter = @"丧假";
            break;
            
        default:
            break;
    }
    return letter;
}

+ (NSDictionary *)dictionaryFromModel
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        id value = [self valueForKey:key];
        
        //only add it to dictionary if it is not nil
        if (key && value) {
            if ([value isKindOfClass:[NSString class]]
                || [value isKindOfClass:[NSNumber class]]) {
                // 普通类型的直接变成字典的值
                [dict setObject:value forKey:key];
            }
            else if ([value isKindOfClass:[NSArray class]]
                     || [value isKindOfClass:[NSDictionary class]]) {
                // 数组类型或字典类型
                [dict setObject:[self idFromObject:value] forKey:key];
            }
            else {
                // 如果model里有其他自定义模型，则递归将其转换为字典
                [dict setObject:[value dictionaryFromModel] forKey:key];
            }
        } else if (key && value == nil) {
            // 如果当前对象该值为空，设为nil。在字典中直接加nil会抛异常，需要加NSNull对象
            [dict setObject:[NSNull null] forKey:key];
        }
    }
    
    free(properties);
    return dict;
}

+ (id)idFromObject:(nonnull id)object
{
    if ([object isKindOfClass:[NSArray class]]) {
        if (object != nil && [object count] > 0) {
            NSMutableArray *array = [NSMutableArray array];
            for (id obj in object) {
                // 基本类型直接添加
                if ([obj isKindOfClass:[NSString class]]
                    || [obj isKindOfClass:[NSNumber class]]) {
                    [array addObject:obj];
                }
                // 字典或数组需递归处理
                else if ([obj isKindOfClass:[NSDictionary class]]
                         || [obj isKindOfClass:[NSArray class]]) {
                    [array addObject:[self idFromObject:obj]];
                }
                // model转化为字典
                else {
                    [array addObject:[obj dictionaryFromModel]];
                }
            }
            return array;
        }
        else {
            return object ? : [NSNull null];
        }
    }
    else if ([object isKindOfClass:[NSDictionary class]]) {
        if (object && [[object allKeys] count] > 0) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for (NSString *key in [object allKeys]) {
                // 基本类型直接添加
                if ([object[key] isKindOfClass:[NSNumber class]]
                    || [object[key] isKindOfClass:[NSString class]]) {
                    [dic setObject:object[key] forKey:key];
                }
                // 字典或数组需递归处理
                else if ([object[key] isKindOfClass:[NSArray class]]
                         || [object[key] isKindOfClass:[NSDictionary class]]) {
                    [dic setObject:[self idFromObject:object[key]] forKey:key];
                }
                // model转化为字典
                else {
                    [dic setObject:[object[key] dictionaryFromModel] forKey:key];
                }
            }
            return dic;
        }
        else {
            return object ? : [NSNull null];
        }
    }
    
    return [NSNull null];
}


+ (CGFloat)heightForLabel:(UILabel *)label{
    label.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //注意，每一行的行间距分两部分，topSpacing和bottomSpacing。
    paragraphStyle.lineSpacing=5.0;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    label.attributedText = attributedString;
    CGSize size = [label sizeThatFits:CGSizeMake(CGRectGetWidth(label.frame), MAXFLOAT)];
    label.frame =CGRectMake(CGRectGetMinX(label.frame), CGRectGetMinY(label.frame), CGRectGetWidth(label.frame), size.height);
    return size.height;
}

+ (void)labelWith:(UILabel *)label RangeOfNote:(NSRange)range NoteColor:(UIColor *)noteColor        NoteFont:(UIFont *)noteFont
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    [noteStr addAttributes:@{NSForegroundColorAttributeName:noteColor,NSFontAttributeName:noteFont} range:range];
    [label setAttributedText:noteStr] ;
}

+ (NSString *)base64WithObject:(id)object
{
    NSError *error = nil;
    //NSJSONWritingPrettyPrinted:指定生成的JSON数据应使用空格旨在使输出更加可读。如果这个选项是没有设置,最紧凑的可能生成JSON表示。
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    jsonData =[GTMBase64 encodeData:jsonData];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

}

+ (NSString *)getRequestHeadString{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDict = [userDefaults objectForKey:@"CRMUserData"];
    NSString *DeviceToken =  [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *Version = @"1.0";
    NSString *UserId = [NSString ridObject:userDict[@"uid"]] ;
    NSString *Plat = @"3";
    NSString *OSInformation = [[UIDevice currentDevice]systemVersion];
    NSString *Channel =  [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"];
    NSDictionary *location = [RMUtils getLocation];
    NSString *longitude = location[@"longitude"];
    NSString *latitude = location[@"latitude"];
    NSDictionary *headDict = @{
                               @"Version" : Version,
                               @"DeviceToken" : [NSString ridObject:DeviceToken],
                               @"UserId" : UserId,
                               @"Plat" : Plat,
                               @"OSInformation" : OSInformation,
                               @"Channel" : Channel,
                               @"CertType" : @"",
                               @"Certification" : @"",
                               @"longitude" : [NSString ridObject:longitude],
                               @"latitude" : [NSString ridObject:latitude]
                               };
    NSString *coder =  [self base64WithObject:headDict];
    return coder;
}

/**
 *  请求体
 *
 *  @param RGuid   请求接口
 *  @param content 请求参数
 *
 *  @return request请求体
 */
+ (NSString *)getResquestCoderWithRGuid:(NSString*)RGuid Content:(NSDictionary *)content{
    NSDictionary *userDict = [RMUtils userBaseMessage];
    NSMutableDictionary *requestContent = [NSMutableDictionary
                                           dictionaryWithObjectsAndKeys:userDict[@"sign"], @"sign",
                                           userDict[@"uid"], @"uid",
                                           userDict[@"province_id"], @"province_id",
                                           userDict[@"city_id"], @"city_id",
                                           userDict[@"zone_id"], @"zone_id",
                                           userDict[@"county_id"], @"county_id", nil];
    if (content) {
        [requestContent setValuesForKeysWithDictionary:content];
    }
    NSString *contentCoder = [self base64WithObject:requestContent];
    NSDictionary *requestDict = @{
                                  @"RGuid" : RGuid,
                                  @"Pri" : @"PZ.TXH.CRM",
                                  @"UIServiceId" : @"",
                                  @"UIUserId" : @"",
                                  @"IsTest" : @"1",
                                  @"Content" : contentCoder
                                  };
    NSString *coder = [self base64WithObject:requestDict];
    return coder;
}

+ (NSString *)getResquestCoderWithRGuid:(NSString*)RGuid noneProvinceContent:(NSDictionary *)content{
    NSDictionary *userDict = [RMUtils userBaseMessage];
    NSMutableDictionary *requestContent = [NSMutableDictionary
                                           dictionaryWithObjectsAndKeys:[NSString ridObject:userDict[@"sign"]] , @"sign",
                                           [NSString ridObject:userDict[@"uid"]], @"uid",nil];
    if (content) {
        [requestContent setValuesForKeysWithDictionary:content];
    }
    NSString *contentCoder = [self base64WithObject:requestContent];
    NSDictionary *requestDict = @{
                                  @"RGuid" : RGuid,
                                  @"Pri" : @"PZ.TXH.CRM",
                                  @"UIServiceId" : @"",
                                  @"UIUserId" : @"",
                                  @"IsTest" : @"1",
                                  @"Content" : contentCoder
                                  };
    NSString *coder = [self base64WithObject:requestDict];
    return coder;
}


/**
 *  返回请求参数体(包含请求头和请求参数)
 *
 *  @return 请求体
 */
+ (NSDictionary *)paramDicWithparam:(NSString *)url content:(NSDictionary *)content isCity:(BOOL)city
{
    NSString *headString = [RMUtils getRequestHeadString];
    NSString *requestString;
    if (city) {
        requestString = [RMUtils getResquestCoderWithRGuid:url Content:content];
    }else{
        requestString = [RMUtils getResquestCoderWithRGuid:url noneProvinceContent:content];
    }
    NSDictionary *paramDic = @{@"Head":headString, @"Request":requestString};
    return paramDic;
}

+ (NSDictionary *)getLocation{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *location = [userDefaults objectForKey:@"Location"];
    return location;
}

+ (void)locationAtCashe{
    __block BOOL isLocation = YES;
    [RMMapLocation getGps:^(double latitude, double longitude) {
        if (isLocation) {
            isLocation = NO;
            [RMMapLocation stop];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *location = @{
                                       @"latitude" : [NSString stringWithFormat:@"%f", latitude],
                                       @"longitude" : [NSString stringWithFormat:@"%f", longitude]
                                       };
            [userDefaults setObject:location forKey:@"Location"];
            [userDefaults synchronize];
        }
    }];
}


+ (void)locationAtCasheWtih:(void(^)())success{
    __block BOOL isLocation = YES;
    [RMMapLocation getGps:^(double latitude, double longitude) {
        if (isLocation) {
            isLocation = NO;
            [RMMapLocation stop];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *location = @{
                                       @"latitude" : [NSString stringWithFormat:@"%f", latitude],
                                       @"longitude" : [NSString stringWithFormat:@"%f", longitude]
                                       };
            [userDefaults setObject:location forKey:@"Location"];
            [userDefaults synchronize];
            if (success) {
                success();
            }
        }
    }];
}

+ (NSString *)numberTransforToStringWith:(NSInteger)number
{
    return [NSString stringWithFormat:@"%ld",(long)number];
}

+ (UIColor *)getColorWithHexString:(NSString *)hexColor
{
    if ([hexColor hasPrefix:@"#"]) {
        hexColor = [hexColor substringFromIndex:1];
    }
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

+ (NSAttributedString *)transformHtmlWithString:(NSString *)htmlString
{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attributedString;
}

+ (NSString *)setBadgeTypeWithString:(NSString *)badgeStr
{
    if ([badgeStr integerValue]<1) {
        badgeStr = @"";
    }
    
    if (badgeStr.length == 1) {
        badgeStr = [NSString stringWithFormat:@" %@ ",badgeStr];
    }
    return badgeStr;
}

@end
