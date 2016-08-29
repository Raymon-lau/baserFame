//
//  UIImage+Categoty.m
//  ReactiveCocoa
//
//  Created by 刘闻天 on 16/1/21.
//  Copyright © 2016年 刘闻天. All rights reserved.
//

#import "UIImage+Categoty.h"

@implementation UIImage (Categoty)

+ (UIImage *)imageWithOriginImg:(UIImage *)originImg WaterMask:(UIImage *)mask inRect:(CGRect)rect
{
    UIGraphicsBeginImageContextWithOptions(originImg.size, NO, 0.0);
    
    //原图
    [originImg drawInRect:CGRectMake(0, 0, originImg.size.width, mask.size.height)];
    //水印图
    [mask drawInRect:rect];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}

+ (UIImage *)watermarkImage:(UIImage *)img withName:(NSString *)name
{
    NSString *mark = name;
    int w = img.size.width;
    int h = img.size.height;
    UIGraphicsBeginImageContext(img.size);
    [img drawInRect:CGRectMake( 0, 0, w, h)];
    NSDictionary *attr = @{
                           NSFontAttributeName:[UIFont boldSystemFontOfSize:55.0],
                           NSForegroundColorAttributeName:[UIColor redColor]
                           };
    [mark drawInRect:CGRectMake(30, 20, 100, 50) withAttributes:attr];
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    return aimg;
}

- (UIImage *)scaleToSize:(CGSize)size {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}


- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    CGRect rect = (CGRect){0.f, 0.f, self.size};
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect
                                                cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
