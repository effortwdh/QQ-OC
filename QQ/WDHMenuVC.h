//
//  WDHMenuVC.h
//  QQ
//
//  Created by 敦豪魏 on 2020/8/5.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ backButtonBlock)(void);
@interface WDHMenuVC : UIViewController
@property (nonatomic,copy) backButtonBlock backBlock;
@end

NS_ASSUME_NONNULL_END
