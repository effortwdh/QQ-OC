//
//  WDHMyselfTextField.m
//  QQ
//
//  Created by 敦豪魏 on 2020/7/24.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHMyselfTextField.h"
//自己定义的搜索栏
@implementation WDHMyselfTextField
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
        self.leftViewMode = UITextFieldViewModeUnlessEditing;
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.placeholder = @"推荐";
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor orangeColor].CGColor;
        self.layer.cornerRadius = 20;
        
    }
    return self;
}
//未编辑状态下的起始位置
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}
// 编辑状态下的起始位置
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}
//placeholder起始位置
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
