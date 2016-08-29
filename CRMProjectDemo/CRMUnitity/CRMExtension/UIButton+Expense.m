//
//  UIButton+Expense.m
//  StaffManagement
//
//  Created by 刘闻天 on 16/6/2.
//  Copyright © 2016年 Raymon. All rights reserved.
//

#import "UIButton+Expense.h"

@implementation UIButton (Expense)

- (void)setNumberOfLine:(NSInteger)numberOfLine
{
    self.titleLabel.numberOfLines = numberOfLine;
}

- (NSInteger)numberOfLine
{
    return self.numberOfLine;
}


@end
