//
//  UIView+Expense.h
//  SkyGoods
//
//  Created by 刘闻天 on 15/12/21.
//  Copyright © 2015年 Raymon. All rights reserved.
//

#import <UIKit/UIKit.h>

// 筛选画面的左边距
UIKIT_EXTERN CGFloat const kLeftSpaceInFilterView;
// 筛选画面的右边距
UIKIT_EXTERN CGFloat const kRightSpaceInFilterView;

@interface UIView (Expense)
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGSize size;

/**
 *  打开侧滑画面
 *
 *  @param toView   要打开的画面
 *  @param toTop    画面距离顶部距离
 *  @param animated 是否动画
 */
+ (void)switchToRightView:(UIView *)toView
                    toTop:(CGFloat)toTop
                 animated:(BOOL)animated;


/**
 *  关闭画面
 *
 *  @param animated 是否动画
 */
+ (void)closeViewWithAnimated:(BOOL)animated;


@end
