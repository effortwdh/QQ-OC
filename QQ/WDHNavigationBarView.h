//
//  WDHNavigationBarView.h
//  QQ
//
//  Created by 敦豪魏 on 2020/7/23.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,WDHNavigationBarViewType){
    WDHNavigationBarViewNews = 1,//
    WDHNavigationBarViewContact = 2,
    WDHNavigationBarViewDynamic = 3,
};
typedef void(^TouchBlock)(void);
typedef void(^TouchQQIamgeBlock)(void);
//定义协议
@protocol WDHNavigationBarViewDelegate <NSObject>
@optional
//打开菜单
-(void)OpenLeftMenu;
@end
@interface WDHNavigationBarView : UIView
//回调 点击相机
@property(nonatomic,copy)TouchBlock block;
//回调 点击QQ头像
@property (nonatomic,copy) TouchQQIamgeBlock QQImageBlock;
//属于分别属于不同界面的 导航栏类型
@property(nonatomic,assign) WDHNavigationBarViewType navagationBarViewType;
//打开左边菜单 之所以使用weak 是为了防止循环引用
@property(nonatomic,weak) id<WDHNavigationBarViewDelegate>delegate;
//初始化
-(instancetype)initWithFrame:(CGRect)frame navigationBarViewType:(WDHNavigationBarViewType)navigationBarViewType;
@end

NS_ASSUME_NONNULL_END
