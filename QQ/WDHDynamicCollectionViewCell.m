//
//  WDHDynamicCollectionViewCell.m
//  QQ
//
//  Created by 敦豪魏 on 2020/8/3.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHDynamicCollectionViewCell.h"

@implementation WDHDynamicCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        //添加图片
        self.dynamicImage = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-64)/2,10, 64, 64)];
        [self addSubview:self.dynamicImage];
        //添加名称
        self.dynamicLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80,frame.size.width, 20)];
        self.dynamicLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.dynamicLabel];
    }
    return self;
}
@end
