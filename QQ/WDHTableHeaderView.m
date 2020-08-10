//
//  WDHTableHeaderView.m
//  QQ
//
//  Created by 敦豪魏 on 2020/7/24.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHTableHeaderView.h"
#import "WDHMyselfTextField.h"
#import <Masonry.h>
@interface WDHTableHeaderView()

@end
@implementation WDHTableHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    
    switch (_type) {
        case WDHTableHeaderViewTypeNews:{
            //添加搜索栏
            WDHMyselfTextField *textField =[[WDHMyselfTextField alloc] initWithFrame:CGRectMake(10, 5,self.frame.size.width-10*2 , self.frame.size.height/2-10)];
            [self addSubview:textField];
            //添加按钮
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,self.frame.size.height/2-10+10, self.frame.size.width, self.frame.size.height/2-10)];
            button.backgroundColor =[UIColor whiteColor];
            //添加文字
            [button setTitle:@"Mac QQ 已经登录" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            //添加图片
            [button setImage:[UIImage imageNamed:@"icon_goselect"] forState:UIControlStateNormal];
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 330, 0, 0);
            [self addSubview:button];
            break;
        }
        case WDHTableHeaderViewTypeContact:{
            //添加搜索栏
            WDHMyselfTextField *textField =[[WDHMyselfTextField alloc] initWithFrame:CGRectMake(10, 5,self.frame.size.width-10*2 , self.frame.size.height/2-10)];
            [self addSubview:textField];
            //添加按钮
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,self.frame.size.height/2-10+10, self.frame.size.width, self.frame.size.height/2-10)];
            button.backgroundColor =[UIColor whiteColor];
            //添加文字
            [button setTitle:@"新朋友" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            //添加图片
            [button setImage:[UIImage imageNamed:@"icon_goselect"] forState:UIControlStateNormal];
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 330, 0, 0);
            [self addSubview:button];
            break;
        }
        case WDHTableHeaderViewTypeDynamic:{
            //添加搜索栏
            WDHMyselfTextField *textField =[[WDHMyselfTextField alloc] initWithFrame:CGRectMake(10, 5,self.frame.size.width-10*3 , self.frame.size.height/2-10)];
            [self addSubview:textField];
            //添加按钮
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,self.frame.size.height/2-10+10, self.frame.size.width-10*2, self.frame.size.height/2-10)];
            button.backgroundColor =[UIColor blueColor];
            //添加文字
            [button setTitle:@"好友动态" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            //添加图片
            [button setImage:[UIImage imageNamed:@"icon_goselect"] forState:UIControlStateNormal];
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 310, 0, 0);
            [self addSubview:button];
            break;
        }
        default:
            break;
    }
}
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 16.0f, bounds.origin.y, bounds.size.width, bounds.size.height);
}

@end
