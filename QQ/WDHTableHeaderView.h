//
//  WDHTableHeaderView.h
//  QQ
//
//  Created by 敦豪魏 on 2020/7/24.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSInteger, WDHTableHeaderViewType)
{
    WDHTableHeaderViewTypeNews = 1<<0, //消息界面

    WDHTableHeaderViewTypeContact = 1<<1,//联系人

    WDHTableHeaderViewTypeDynamic = 1<<2,//动态
};
//头部视图
@interface WDHTableHeaderView : UIView
@property (nonatomic,assign) WDHTableHeaderViewType type;
@end

NS_ASSUME_NONNULL_END
