//
//  CRMApplicationController.m
//  CRMProjectDemo
//
//  Created by 刘闻天 on 16/8/29.
//  Copyright © 2016年 Raymon. All rights reserved.
//

#import "CRMApplicationController.h"

@interface CRMApplicationController ()

@end

@implementation CRMApplicationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    [self setUI];
}

- (void)setUI
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth - 20, kScreenHeight - 150)];
    imageView.image = [UIImage imageNamed:@"standard"];
    [self.view addSubview:imageView];
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
