//
//  UIImage+WDHGetMyselfImage_h.h
//  QQ
//
//  Created by 敦豪魏 on 2020/8/4.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WDHGetMyselfImage_h)
//获取一个圆形图片 类方法
+(instancetype) WDHGetCircleImageWith:(NSString *)name;
//获取一个圆形图片
-(instancetype) WDHCircleImage;

- (UIImage *) scaleImage:(UIImage *)image toScale:(float)scaleSize;

@end

NS_ASSUME_NONNULL_END
