//
//  UploadParam.m
//  StaffManagement
//
//  Created by 刘闻天 on 16/1/21.
//  Copyright © 2016年 Raymon. All rights reserved.
//

#import "RMUploadParam.h"

@implementation RMUploadParam

- (void)setMimeType:(NSString *)mimeType
{
    if (mimeType.length < 1) {
        _mimeType = @"image/jpg/file/png";
    }else{
        _mimeType = mimeType;
    }
}

@end
