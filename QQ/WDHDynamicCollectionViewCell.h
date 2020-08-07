//
//  WDHDynamicCollectionViewCell.h
//  QQ
//
//  Created by 敦豪魏 on 2020/8/3.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDHDynamicCollectionViewCell : UICollectionViewCell
//动态图片
@property (nonatomic,strong) UIImageView *dynamicImage;
//动态名称
@property (nonatomic,strong) UILabel *dynamicLabel;
@end

NS_ASSUME_NONNULL_END
