//
//  WDHNavigationBarView.m
//  QQ
//
//  Created by 敦豪魏 on 2020/7/23.
//  Copyright © 2020 魏敦豪. All rights reserved.
//
#import "WDHNavigationBarView.h"
#import "WDHAddContactsVIew.h"
#import "WDHAddContactsVIew.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@implementation WDHNavigationBarView

//设置导航栏视图
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
    }
    return self;
}
- (void)touchCammera{
    self.block();
}
//弹出添加好友列表
- (void)touchadd{
    WDHAddContactsVIew *addView =[[WDHAddContactsVIew alloc] initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH, SCREEN_HEIGHT)];
    CGRect point = CGRectMake(260, 144, 30, 20);
    [addView showViewFromPoint:point.origin clickBlock:^{
        NSLog(@"添加好友");
    }];
    
    NSLog(@"添加好友列表");
}

- (void)drawRect:(CGRect)rect{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    //设置头像
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,7, height-14, height-14)];
    UIImage *image = [UIImage imageNamed:@"ic_appeal"];
    imageView.image = image;
    imageView.layer.borderColor = [UIColor orangeColor].CGColor;
    //imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = (height-14)/2.0;
    imageView.layer.borderWidth = 2;
    //添加点击 触发回调
    imageView.userInteractionEnabled = YES;//打开用户交互
    //初始化一个手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    //为图片添加手势
    [imageView addGestureRecognizer:singleTap];
    //显示
    [self addSubview:imageView];
    
    //状态栏提示角标
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(10+height-14+5,7+height-20, 10,10)];
    statusView.backgroundColor = [UIColor greenColor];
    statusView.layer.cornerRadius = 5;
    [self addSubview:statusView];
    switch (self.navagationBarViewType) {
        case WDHNavigationBarViewNews:
        {
            //QQ名称
            UILabel *textField = [[UILabel alloc]initWithFrame:CGRectMake(10+height-14+5, 7,width/3,height-20)];
            //textField.backgroundColor = [UIColor whiteColor];
            textField.textColor = [UIColor whiteColor];
            textField.text = @"名称~";
            [self addSubview:textField];
            //手机在线文字提示
            UILabel *statustextField = [[UILabel alloc]initWithFrame:CGRectMake(10+height-14+5+12, 7+height-20,width/3-12,10)];
            statustextField.textColor = [UIColor whiteColor];
            statustextField.font = [UIFont systemFontOfSize:10];
            statustextField.text = @"手机在线 >";
            [self addSubview:statustextField];
            //右边拍照按钮
            UIButton *cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(10+height-14+width*2/3, 7, height-14, height-14)];
            [cameraButton setImage:[UIImage imageNamed:@"icon_calendar_camera"] forState:UIControlStateNormal];
            [cameraButton addTarget:self action:@selector(touchCammera) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:cameraButton];
            //右边添加好友按钮
            UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(10+height-14+5+width*2/3+height-14+2, 7, height-14, height-14)];
            [addButton setImage:[UIImage imageNamed:@"icon_calendar_add"] forState:UIControlStateNormal];
            [addButton addTarget:self action:@selector(touchadd) forControlEvents:UIControlEventTouchUpInside    ];
            [self addSubview:addButton];
            break;
        }
        case WDHNavigationBarViewContact:{
            //QQ名称
            UILabel *textField = [[UILabel alloc]initWithFrame:CGRectMake((width-width/3)/2,(height-20)/2,width/3,20)];
            //textField.backgroundColor = [UIColor whiteColor];
            textField.textColor = [UIColor whiteColor];
            textField.text = @"联系人";
            textField.textAlignment = NSTextAlignmentCenter;
            [self addSubview:textField];
            //右边添加好友按钮
            UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(10+height-14+5+width*2/3+height-14+2, 7, height-14, height-14)];
            [addButton setImage:[UIImage imageNamed:@"icon_calendar_add"] forState:UIControlStateNormal];
            [addButton addTarget:self action:@selector(touchadd) forControlEvents:UIControlEventTouchUpInside    ];
            [self addSubview:addButton];
            break;
        }
        case WDHNavigationBarViewDynamic:{
            //QQ名称
            UILabel *textField = [[UILabel alloc]initWithFrame:CGRectMake((width-width/3)/2,(height-20)/2,width/3,20)];
            //textField.backgroundColor = [UIColor whiteColor];
            textField.textColor = [UIColor whiteColor];
            textField.text = @"动态";
            textField.textAlignment = NSTextAlignmentCenter;
            [self addSubview:textField];
            //右边添加好友按钮
            UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(10+height-14+5+width*2/3+height-14+2, 7, height-14, height-14)];
            [addButton setImage:[UIImage imageNamed:@"icon_calendar_add"] forState:UIControlStateNormal];
            [addButton addTarget:self action:@selector(touchadd) forControlEvents:UIControlEventTouchUpInside    ];
            [self addSubview:addButton];
            break;
            
        }
        default:
            break;
    }
}
- (void)singleTapAction:(UIGestureRecognizer *)sing{
    switch (self.navagationBarViewType) {
        case WDHNavigationBarViewNews:
            //使用回调方式打开抽屉
            self.QQImageBlock();
            break;
        case WDHNavigationBarViewContact:
            [[NSNotificationCenter defaultCenter]postNotificationName:@"OpenLeftMenu" object:nil];
            break;
        case WDHNavigationBarViewDynamic:{
            if([self.delegate respondsToSelector:@selector(OpenLeftMenu)]){
                [self.delegate OpenLeftMenu];
            }
            break;
        }
        default:
            break;
    }
}

- (void)layoutSubviews{
}
@end
