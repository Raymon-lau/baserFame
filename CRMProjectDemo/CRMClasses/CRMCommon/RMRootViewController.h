//
//  CRMRootViewController.h
//  CRMProjectDemo
//
//  Created by 刘闻天 on 16/8/29.
//  Copyright © 2016年 Raymon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RMNavigationController;
@interface RMRootViewController : UIViewController

@property (strong, nonatomic) RMNavigationController *topNavigationController;

// 顶部的导航栏的高度
@property(nonatomic,readonly) CGFloat topNavBarHeight;

// 底部tabbar的高度
@property(nonatomic,readonly) CGFloat bottomTabBarHeight;

/**
 *  创建画面 viewDidLoad
 */
- (void)createViewController;

/**
 *  更新画面，viewWillAppear
 */
- (void)updateViewController;

/**
 *  设定导航栏样式
 *
 *  @param title      标题
 *  @param customView 右边
 */
- (void)setNavBarTitle:(NSString *)title
       RightCustomView:(UIView *)customView;

/**
 *  返回至前一画面
 */
- (void)popToPreviousView;

// 关闭键盘
- (void)closeKeyboard;

@end
