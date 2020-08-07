//
//  WDHMyNavigationBar.m
//  QQ
//
//  Created by 敦豪魏 on 2020/7/24.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHMyNavigationBar.h"

@implementation WDHMyNavigationBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"icon_audio_save"];
    [image drawInRect:rect];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/

@end
