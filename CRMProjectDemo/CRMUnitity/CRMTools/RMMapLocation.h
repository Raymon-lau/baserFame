//
//  RMMapLocation.h
//  StaffManagement
//
//  Created by 刘闻天 on 16/4/14.
//  Copyright © 2016年 Raymon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMMapLocation : NSObject
{
    void (^saveGpsCallBack)(double latitude,double longitude);
}
+ (void)getGps:(void(^)(double latitude,double longitude))block;
+ (void)stop;
@end
