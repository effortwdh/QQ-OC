//
//  WDHNewsVC.h
//  QQ
//
//  Created by 敦豪魏 on 2020/7/23.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^OpenLeftMenuBlock)(void);
@interface WDHNewsVC : UIViewController
@property (nonatomic,copy) OpenLeftMenuBlock openLeftBlock;

@end

NS_ASSUME_NONNULL_END
