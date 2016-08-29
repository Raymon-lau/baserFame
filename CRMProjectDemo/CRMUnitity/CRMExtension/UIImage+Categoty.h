//
//  UIImage+Categoty.h
//  ReactiveCocoa
//
//  Created by 刘闻天 on 16/1/21.
//  Copyright © 2016年 刘闻天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Categoty)

/**
 *  给图片加水印,设置水印大小
 */
+ (UIImage *)imageWithOriginImg:(UIImage *)originImg WaterMask:(UIImage *)mask inRect:(CGRect)rect;

/**
 *  给图片加水印
 */
+ (UIImage *)watermarkImage:(UIImage *)img withName:(NSString *)name;

/**
 *  设置图片大小
 */
- (UIImage *)scaleToSize:(CGSize)size;

/**
 *  给UIimage添加圆角(layer层属于离屏渲染,太耗内存)
 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;
@end
