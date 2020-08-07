//
//  WDHAddContactsVIew.m
//  QQ
//
//  Created by 敦豪魏 on 2020/7/23.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHAddContactsVIew.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
//添加好友弹框 页面
@interface WDHAddContactsVIew()
@property (nonatomic,strong) UIButton *AddPeopleButton; //添加好友页面按钮
@property (nonatomic,copy) dispatch_block_t backBlock;  //回调到上个页面的一些数据
@property (nonatomic,strong) UIView *backgroundView;    //背景View 用来点击添加弹窗页面外的数据
@end
@implementation WDHAddContactsVIew

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //背景阴影
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        self.backgroundView.alpha = 0.1;
        [self.backgroundView addGestureRecognizer:({
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissDeleteView)];
            tapGesture;
        })];
        //按钮区域
        [self addSubview:self.backgroundView];
        self.AddPeopleButton =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.AddPeopleButton.backgroundColor = [UIColor blueColor];
        [self.AddPeopleButton addTarget:self action:@selector(_clickButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.AddPeopleButton];
    }
    return self;
}
//执行弹出操作
-(void)showViewFromPoint:(CGPoint) pointk clickBlock:(dispatch_block_t) clickBlock{
    self.AddPeopleButton.frame = CGRectMake(pointk.x, pointk.y, 0, 0);
    self.backBlock = [clickBlock copy];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:1.f delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.AddPeopleButton.frame = CGRectMake(150, 87.5, 200, 300);
    } completion:^(BOOL finished) {
        //NSLog(@"123");
    }];
}
//回调方法
-(void)_clickButton{
    if(_backBlock)
    {
        _backBlock();
    }
    [self removeFromSuperview];
}

//点击阴影部分 消失弹出框
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
@end
