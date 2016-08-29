//
//  RMTabBarController.m
//  CRMProjectDemo
//
//  Created by 刘闻天 on 16/8/29.
//  Copyright © 2016年 Raymon. All rights reserved.
//

#import "RMTabBarController.h"
#import "RMNavigationController.h"
#import "CRMApplicationController.h"

@interface RMTabBarController ()

@end

@implementation RMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTabbarShowApplication];
}

- (void)setTabbarShowApplication
{
    // 应用  ApplicationController
    CRMApplicationController *applicationVC = [[CRMApplicationController alloc] init];
    [self addChildViewController:applicationVC image:@"apply" seletedImage:@"apply_blue" title:@"应用"];
}

- (void)addChildViewController:(UIViewController *)childController image:(NSString *)imageName seletedImage:(NSString *)seletedImageName title:(NSString *)title
{
    childController.title = title;
    // 设置文字样式
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childController.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:seletedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    RMNavigationController *nav = [[RMNavigationController alloc] initWithRootViewController:childController];
    childController.navigationController.navigationBar.translucent = NO;
    childController.navigationController.navigationBar.barTintColor =[UIColor lightGrayColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[RMUtils expenseFontWith:18.0],NSFontAttributeName,nil];
    [childController.navigationController.navigationBar setTitleTextAttributes:attributes];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    // 添加为子控制器
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
