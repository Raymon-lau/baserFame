//
//  RMNetWork.h
//  SkyGoods
//
//  Created by 刘闻天 on 16/1/7.
//  Copyright © 2016年 Raymon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMNetWork : NSObject
+ (RMNetWork *)shareInstance;

- (BOOL)rechability;
@end
