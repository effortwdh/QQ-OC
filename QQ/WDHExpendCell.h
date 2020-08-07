//
//  WDHExpendCell.h
//  QQ
//
//  Created by 敦豪魏 on 2020/7/31.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDHExpendCell : UITableViewCell
//靠左图片
@property (nonatomic,strong) UIImageView *leftImage;
//文字内容
@property (nonatomic,strong) UILabel *QQName;
//QQ动态
@property (nonatomic,strong) UILabel *QQDynamic;
@end

NS_ASSUME_NONNULL_END
