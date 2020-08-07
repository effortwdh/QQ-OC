//
//  WDHSegmentView.h
//  QQ
//
//  Created by 敦豪魏 on 2020/8/3.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^indexBlock)(NSInteger index);

@interface WDHSegmentView : UIView
//默认选中下标
@property (nonatomic, assign) NSInteger defaultSelectIndex;

/**
 通过给定frame，控住器数组，标题数组，返回segmentView;

 @param frame frame
 @param viewControllersArr 控住器数组
 @param titleArr 标题数组
 @param parentViewController 父控制器
 @param indexBlock 返回点击索引
 @return segmentView
 */
- (instancetype)initWithFrame:(CGRect)frame ViewControllersArr:(NSArray *)viewControllersArr TitleArr:(NSArray *)titleArr TitleNormalSize:(CGFloat)titleNormalSize TitleSelectedSize:(CGFloat)titleSelectedSize ParentViewController:(UIViewController *)parentViewController ReturnIndexBlock: (indexBlock)indexBlock;

/**
  默认选中item的下标
 */
- (void)setSelectedItemAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END






