//
//  WDHLeftSildeMenuVC.h
//  QQ
//
//  Created by 敦豪魏 on 2020/8/5.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDHLeftSildeMenuVC : UIViewController

/// 初始化方法
- (instancetype)initWithMainVC:(UIViewController *)mainVC leftMenuVC:(UIViewController *)leftMenuVC;

/// 打开关闭菜单
- (void)switchMenu;

@end

NS_ASSUME_NONNULL_END
