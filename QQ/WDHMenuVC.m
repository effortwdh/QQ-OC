//
//  WDHMenuVC.m
//  QQ
//
//  Created by 敦豪魏 on 2020/8/5.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHMenuVC.h"
#import "UIImage+WDHGetMyselfImage_h.h"
#define H ([UIScreen mainScreen].bounds.size.height)
#define W ([UIScreen mainScreen].bounds.size.width)
@interface WDHMenuVC ()

@end

@implementation WDHMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    UIImageView *QQImage = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 65, 65)];
    QQImage.image = [UIImage WDHGetCircleImageWith:@"头像"];
    [self.view addSubview:QQImage];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(W-60,66, 50, 50)];
    [backButton setBackgroundColor:[UIColor redColor]];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    // Do any additional setup after loading the view.
}

- (void)back{
    self.backBlock();
}
@end
