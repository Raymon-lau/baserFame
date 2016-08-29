//
//  UIView+Expense.m
//  SkyGoods
//
//  Created by 刘闻天 on 15/12/21.
//  Copyright © 2015年 Raymon. All rights reserved.
//

#import "UIView+Expense.h"
#import "AppDelegate.h"
CGFloat const MENU_SLIDE_ANIMATION_DURATION  = 0.2;
// 筛选画面的左边距
CGFloat const kLeftSpaceInFilterView = 40;
CGFloat const kRightSpaceInFilterView = 60;
CGFloat kHeightToTopInView = 0;
enum
{
    kTagForBackgroundView = 2321,
    kTagForToControllerView,
};

@implementation UIView (Expense)
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height{
    return self.frame.size.height;
}


- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}

+ (void)switchToRightView:(UIView *)toView
                    toTop:(CGFloat)toTop
                 animated:(BOOL)animated
{
    kHeightToTopInView = toTop;
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = delegate.window;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, toTop, kScreenWidth, kScreenHeight)];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:0.1725 green:0.1725 blue:0.1725 alpha:0.6]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePopViewWithGesture:)];
    [backgroundView addGestureRecognizer:tapGesture];
    backgroundView.tag = kTagForBackgroundView;
    [window addSubview:backgroundView];
    
    [toView setFrame:CGRectMake(-(kScreenWidth - kRightSpaceInFilterView), toTop, kScreenWidth - kRightSpaceInFilterView, kScreenHeight - toTop)];
    [toView setTag:kTagForToControllerView];
    [window addSubview:toView];
    
    CGFloat time = 0;
    if (animated) {
        time = MENU_SLIDE_ANIMATION_DURATION;
    }
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [toView setFrame:CGRectMake(0, toTop, kScreenWidth- kRightSpaceInFilterView, kScreenHeight- toTop)];
    } completion:nil];
}

+ (void)closeViewWithAnimated:(BOOL)animated
{
    CGFloat time = 0;
    if (animated) {
        time = MENU_SLIDE_ANIMATION_DURATION;
    }
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = delegate.window;
    
    UIView *view = [window viewWithTag:kTagForToControllerView];
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [view setFrame:CGRectMake(-(kScreenWidth - kRightSpaceInFilterView), kHeightToTopInView, kScreenWidth - kRightSpaceInFilterView, kScreenHeight)];
    } completion:^(BOOL finished) {
        [[window viewWithTag:kTagForBackgroundView] removeFromSuperview];
        [view removeFromSuperview];
    }];
}

+ (void)closePopViewWithGesture:(UITapGestureRecognizer *)gesture
{
    [UIView closeViewWithAnimated:YES];
}

@end
