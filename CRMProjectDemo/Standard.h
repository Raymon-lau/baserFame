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
// 一.规范命名(驼峰法)
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
 *  6.方法命名
 */
// 方法一般以小写字母打头，每一个后续的单词首字母大写，方法名中不应该有标点符号（包括下划线），有两个例外：
//  (1)可以用一些通用的大写字母缩写打头方法，比如 PDF,TIFF 等。
//  (2)可以用带下划线的前缀来命名私有方法或者类别中的方法。
// a.如果方法是为了获取对象的一个属性值，直接用属性名称来命名这个方法，注意不要添加 get 或者其他的动词前缀：如:
// 正确，使用属性名来命名方法
- (NSSize)cellSize;
// 错误，添加了多余的动词前缀
- (NSSize)calcCellSize;
- (NSSize)getCellSize;
// b.对于有多个参数的方法，务必在每一个参数前都添加关键词，关键词应当清晰说明参数的作用：如:
// 正确，保证每个参数都有关键词修饰
- (void)sendAction:(SEL)aSelector toObject:(id)anObject forAllCells:(BOOL)flag;
// 错误，遗漏关键词
- (void)sendAction:(SEL)aSelector :(id)anObject :(BOOL)flag;
// 正确
- (id)viewWithTag:(NSInteger)aTag;
// 错误，关键词的作用不清晰
- (id)taggedView:(int)aTag;
// c.不要用 and 来连接两个参数，通常 and 用来表示方法执行了两个相对独立的操作（从设计上来说，这时候应该拆分成两个独立的方法）：
// 错误，不要使用 "and" 来连接参数
- (int)runModalForDirectory:(NSString *)path andFile:(NSString *)name andTypes:(NSArray *)fileTypes;
// 正确，使用 "and" 来表示两个相对独立的操作
- (BOOL)openFile:(NSString *)fullPath withApplication:(NSString *)appName andDeactivate:(BOOL)flag;
/*
 方法的参数命名也有一些需要注意的地方 :
 
 和方法名类似，参数的第一个字母小写，后面的每一个单词首字母大写
 不要再方法名中使用类似 pointer,ptr 这样的字眼去表示指针，参数本身的类型足以说明
 不要使用只有一两个字母的参数名
 不要使用简写，拼出完整的单词
 不适用 get 前缀来表示属性获取方法

 */

/**
 *  7.通知命名
 */
//通知常用于在模块间传递消息，所以通知要尽可能地表示出发生的事件，通知的命名范式如:
[ 触发通知的类名 ] + [Did | Will] + [ 动作 ] + Notification


/**
 *  8.其他方法命名方法以类名+功能为基准
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
 *  4.函数书写
 */
//在 - 和 (void) 之间应该有一个空格，第一个大括号 { 的位置在函数所在行的末尾，同样应该有一个空格。
- (void)selectButton {
    
}
    




/**
 *  注意
 */
/*
    a.如果用到了Observer,至少要在dealloc里移除掉(如果是在ARC中使用,不用调用super方法)
    b.当用到addObject或insertObject时注意对NSArray,NSDictionary成员的判空保护
    c.加上必要注释(推荐安装 VVDocumenter,进行注释)
    d.写delegate的时候类型应该为weak弱引用，以避免循环引用
    e.在适当的位置建议加上#pragma mark ,便于阅读代码
    f.引入第三方尽量使用cocoaPod
    g.不要在工程里使用 Tab 键，使用空格来进行缩进。在 Xcode > Preferences > Text Editing 将 Tab 和自动缩进都设置为 4 个空格。（Google 的标准是使用两个空格来缩进，但这里还是推荐使用 Xcode 默认的设置。）
    h.同样的，在 Xcode > Preferences > Text Editing > Page guide at column: 中将最大行长设置为 80 ，过长的一行代码将会导致可读性问题。
    i.不用使用new方法,尽量使用alloc init方法(因为new会在调试内存是出现不可预料问题,也会使人困惑)
    j.NSString使用 copy属性

 */








