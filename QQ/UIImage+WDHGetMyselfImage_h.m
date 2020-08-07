//
//  UIImage+WDHGetMyselfImage_h.m
//  QQ
//
//  Created by 敦豪魏 on 2020/8/4.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "UIImage+WDHGetMyselfImage_h.h"

@implementation UIImage (WDHGetMyselfImage_h)
- (instancetype) WDHCircleImage{
    //开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //添加矩形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddRect(ctx, rect);
    //切割 成圆形
    CGContextClip(ctx);
    //绘制矩形
    [self drawInRect:rect];
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}
+(instancetype) WDHGetCircleImageWith:(NSString *)name{
    return [[self imageNamed:name] WDHCircleImage];
}
//等比缩放
- (UIImage *) scaleImage:(UIImage *)image toScale:(float)scaleSize {
    //开启图形上下文
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    //图片绘制到一个小矩形上
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    //获取图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
//定义大小
- (UIImage *) reSizeImage:(UIImage *)image toSize:(CGSize)reSize {
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}
@end
