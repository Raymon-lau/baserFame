//
//  CRMNavigationController.m
//  CRMProjectDemo
//
//  Created by 刘闻天 on 16/8/29.
//  Copyright © 2016年 Raymon. All rights reserved.
//

#import "CRMNavigationController.h"

@interface CRMNavigationController ()

@end

@implementation CRMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        [self addLeftButtonItemsOnView:viewController];
    }
    [super pushViewController:viewController animated:animated];
}

- (void) addLeftButtonItemsOnView:(UIViewController *)VC{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 70, 44);
    [backBtn setImage:[UIImage imageNamed:@"back_arrow_white"] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    VC.navigationItem.leftBarButtonItems =  [NSArray arrayWithObjects:negativeSpacer, backItem, nil];
}

- (void)goBack{
    [self popViewControllerAnimated:YES];
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
