//
//  CRMRootViewController.m
//  CRMProjectDemo
//
//  Created by 刘闻天 on 16/8/29.
//  Copyright © 2016年 Raymon. All rights reserved.
//

#import "CRMRootViewController.h"
#import "CRMNavigationController.h"

@interface CRMRootViewController ()

@end

@implementation CRMRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self createViewController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateViewController];
}

- (void)createViewController
{
    
}

- (void)updateViewController
{
    
}

- (UINavigationController *)navigationController
{
    return _topNavigationController;
}

- (void)setNavBarTitle:(NSString *)title RightCustomView:(UIView *)customView
{
    [self.topNavigationController setNavigationBarHidden:NO ];
    [self.navigationController setNavigationBarHidden:NO];
    
    self.topNavigationController.navigationBar.barTintColor = [UIColor blueColor];
    
    self.topNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    
#warning mark - 如需要自己定义
    // 左边按钮
    UIButton *leftButton = [RMUtils buttonWith:CGRectMake(0, 0, kMinCommonButtonWidth, 44) text:nil backColor:nil textColor:nil tag:0];
    [leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [leftButton addTarget:self action:@selector(popToPreviousView) forControlEvents:UIControlEventTouchUpInside];
    
    [leftButton setImage:[UIImage imageNamed:@"back_arrow_white"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"back_arrow_white"] forState:UIControlStateHighlighted];
    
    // 左边样式
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    // 中间标题
    if (![NSString isNil:title]) {
        CGFloat x = 60;
        UILabel *customLab = [RMUtils labelWith:CGRectMake(x, 0, self.view.width - 2 * x, self.topNavigationController.navigationBar.height) font:[RMUtils expenseFontWith:18.0] text:title textColor:nil];
        [customLab setTextAlignment:NSTextAlignmentCenter];
        self.navigationItem.titleView = customLab;
    }
    
    // 右边样式
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:customView];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -20;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
}


- (void)popToPreviousView
{
    [self.topNavigationController popViewControllerAnimated:YES];
}


#pragma mark - 高度
- (CGFloat)topNavBarHeight
{
    return 64;
}

- (CGFloat)bottomTabBarHeight
{
    return 44;
}

- (void)closeKeyboard
{
    [self.view endEditing:YES];
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
