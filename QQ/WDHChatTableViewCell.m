//
//  WDHChatTableViewCell.m
//  QQ
//
//  Created by 敦豪魏 on 2020/7/23.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHChatTableViewCell.h"
#import <Masonry.h>
#import "UIImage+WDHGetMyselfImage_h.h"
//聊天室cell
@interface WDHChatTableViewCell()
@property (nonatomic,strong,readwrite) UIImageView *avatar;//群头像
@property (nonatomic,strong) UILabel *name;                //群名称
@property (nonatomic,strong) UILabel *context;             //群最新消息
@property (nonatomic,strong) UILabel *time;                //群最后消息时间
@end
@implementation WDHChatTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        //群头像
        self.avatar = [[UIImageView alloc] init];
        self.avatar.image = [UIImage WDHGetCircleImageWith:@"ic_appeal"];
        //self.avatar.backgroundColor = [UIColor redColor];
        //按比例缩放
        self.avatar.image = [self.avatar.image scaleImage:self.avatar.image toScale:1];
        [self.contentView addSubview:self.avatar];
        [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-300);
            //make.size.mas_equalTo(CGSizeMake(self.bounds.size.height, self.bounds.size.height));
        }];
        //群名称
        self.name = [[UILabel alloc] init];
        self.name.text = @"某某群";
        [self.contentView addSubview:self.name];
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatar.mas_right).offset(5);
            make.top.equalTo(self).offset(10);
        }];
        //群最新消息
        self.context = [[UILabel alloc] init];
        self.context.text = @"某某人撤回一条消息某某人撤回一条消息某某人撤回一条消息某某人撤回一条消息某某人撤回一条消息某某人撤回一条消息";
        self.context.textColor = [UIColor grayColor];
        self.context.font = [UIFont systemFontOfSize:15];
        self.context.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.context];
        [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(15);
            make.left.equalTo(self.avatar.mas_right).offset(5);
            make.size.mas_equalTo(CGSizeMake(self.frame.size.width-80, 10));
        }];
        //群最后消息时间
        self.time = [[UILabel alloc] initWithFrame:CGRectMake(80+self.bounds.size.width-80,10,80 ,self.bounds.size.height-20)];
        self.time.text = @"星期三";
        self.time.textColor = [UIColor grayColor];
        self.time.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.time];
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
