//
//  Standard.h
//  CRMProjectDemo
//
//  Created by 刘闻天 on 16/8/29.
//  Copyright © 2016年 Raymon. All rights reserved.
//

/*
1.项目名称使用英文

*/
// 一.规范命名
/**
 *  1.常量的命名最好在前面加上字母k作为标记.(全局常量(通知或者关键字等)尽量用const来定义. 因为如果使用宏定义, 一来宏可能被重定义. 二来引用不同的文件可能会导致宏的不同) 如:
    (1) 如需外界引用
 */

static const NSTimeInterval kAnimationDuration = 0.3;


/**
 *  2.尽量使用OC的定义方式,避免C的定义方式.(命名:枚举类型命名要加相关类名前缀并且枚举值命名要加枚举类型前缀)如:
 */
typedef NS_ENUM(NSInteger, UIViewAnimationTransition) {
    UIViewAnimationTransitionNone,
    UIViewAnimationTransitionFlipFromLeft,
    UIViewAnimationTransitionFlipFromRight,
    UIViewAnimationTransitionCurlUp,
    UIViewAnimationTransitionCurlDown,
};

/**
 *  3.变量和对象的命名采用修饰+类型的方式,如:
 */
    UILabel *titleLabel;
    UIButton *confirmButton;


/**
 *  4.类名命名采用项目名简称+功能命名方式,如:
 */
    CRMApplicationController

/**
 *  5.实例变量声明时变量名前面加下划线“_”
 */
  UILabel _titleLabel;

/**
 *  6.其他方法命名方法以类名+功能为基准
 */

// 二.编码规范
/**
 *  1.判断语句(格式和判断方式)
 */
Preferred:
if (someObject) {
    ...
}
if (!someObject) {
    ...
}

Not preferred:
if (someObject == YES)
{
    ...
}
if (someObject != nil)
{
    ...
}

/**
 *  2.初始化推荐使用语法糖方式
 */
// 数组@[@"",@""]
// 字典@{@"":@"",@"":@""}

/**
 *  3.回调方法(函数调用的可知性, 回调时被调用者要知道其调用者, 方便信息的传递, 所以建议在回调方法中第一个参数中加上调用者)
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  注意
 */
/*
    a.如果用到了Observer,至少要在dealloc里移除掉(如果是在ARC中使用,不用调用super方法)
    b.当用到addObject或insertObject时注意对NSArray,NSDictionary成员的判空保护
    c.加上必要注释
    d.写delegate的时候类型应该为weak弱引用，以避免循环引用
    e.在适当的位置建议加上#pragma mark ,便于阅读代码
    f.引入第三方尽量使用cocoaPod
    g.
 */








