//
//  WDHInputTextView.h
//  QQ
//
//  Created by 敦豪魏 on 2020/8/4.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TCTextHeightChangedBlock)(NSString *text, CGFloat textHeight);
@interface WDHInputTextView : UITextView
@property (nonatomic, copy) TCTextHeightChangedBlock textHeightChangedBlock;
@property (nonatomic, assign) NSInteger maxNumberOfLines;
@property (nonatomic, assign) NSUInteger cornerRadius;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

// 当文字改变时应该调用该方法
- (void)textDidChange;

@end
NS_ASSUME_NONNULL_END
