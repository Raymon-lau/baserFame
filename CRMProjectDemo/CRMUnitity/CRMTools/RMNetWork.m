//
//  RMNetWork.m
//  SkyGoods
//
//  Created by 刘闻天 on 16/1/7.
//  Copyright © 2016年 Raymon. All rights reserved.
//

#import "RMNetWork.h"
#import "Reachability.h"
//#import "AFNetworkReachabilityManager"

@implementation RMNetWork

+ (RMNetWork *)shareInstance
{
    static RMNetWork *netWork = nil;
    if (netWork == nil) {
        netWork = [[RMNetWork alloc] init];
    }
    return netWork;
}

- (BOOL)rechability
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable: // 没有网络连接
            RMLog(@"没有网络连接");
            return NO;
            break;
        case ReachableViaWWAN: // 使用无线广域网
            // 开始网络请求解析
            RMLog(@"使用3g网络");
            return YES;
            break;
        case ReachableViaWiFi: // 使用WiFi网络
            // 开始网络请求解析
            RMLog(@"使用wifi网络");
            return YES;
            break;
    }
}

@end
