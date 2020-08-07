//
//  WDHExpendCell.m
//  QQ
//
//  Created by 敦豪魏 on 2020/7/31.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHExpendCell.h"
#import "WDHAddressBookTableVC.h"
#define QQCell_Hight 80
@interface WDHExpendCell()
@end
@implementation WDHExpendCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //QQ头像
        self.leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,((QQCell_Hight-20)/4)-10, 60, QQCell_Hight-20)];
        self.leftImage.image = [UIImage imageNamed:@"ic_appeal"];
        [self addSubview:self.leftImage];
        //QQ名称
        self.QQName = [[UILabel alloc] initWithFrame:CGRectMake(70,((QQCell_Hight-20)/4),250, (QQCell_Hight-20)/4)];
        [self addSubview:self.QQName];
        //QQ动态
        self.QQDynamic = [[UILabel alloc]initWithFrame:CGRectMake(70, ((QQCell_Hight-20)/2)+10, 250, (QQCell_Hight-20)/4)];
        self.QQDynamic.font = [UIFont systemFontOfSize:12];
        self.QQDynamic.textColor = [UIColor grayColor];
        [self addSubview:self.QQDynamic];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
