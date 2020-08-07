//
//  WDHGroupingTableVC.m
//  QQ
//
//  Created by 敦豪魏 on 2020/7/31.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHGroupingTableVC.h"
#import "WDHExpendCell.h"
#define kCell_Height 44

@interface WDHGroupingTableVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataSource;//总名称数据 一个二维数组
@property (nonatomic,strong) NSMutableArray *dataDynamic;//总动态数据 一个二维数组
@property (nonatomic,strong) NSMutableArray *sectionArray;//标题数组
@property (nonatomic,strong) NSMutableArray *stateArray;//状态数组
@property (nonatomic, strong) NSMutableArray *onlineNumber;//在线人数比
@end
@implementation WDHGroupingTableVC
- (void)initDataSource
{
    _sectionArray  = [NSMutableArray arrayWithObjects:@"我的好友",
                     @"朋友",
                     @"亲人",
                     @"同学",nil];
    _onlineNumber  = [NSMutableArray arrayWithObjects:@"4/5",
                     @"2/3",
                     @"7/8",
                     @"2/5",nil];
    
    NSArray *one = @[@"鬼才今天",@"ddd",@"不是珊珊",@"电气",@"快速打印"];
    NSArray *two = @[@"朋友一",@"朋友二",@"朋友三"];
    NSArray *three = @[@"亲人一",@"亲人二",@"亲人三",@"亲人四",@"亲人五",@"亲人六",@"亲人七",@"亲人八"];
    NSArray *four = @[@"同学一",@"同学二",@"同学三",@"同学四",@"同学五"];
    
    _dataSource = [NSMutableArray arrayWithObjects:one,two,three,four, nil];
    
    NSArray *oneDynamic = @[@"[手机在线]分享了什么？？",@"[手机在线]分享了什么？？",@"[手机在线]分享了什么？？",@"[手机在线]分享了什么？？",@"[手机在线]分享了什么？？"];
    NSArray *twoDynamic = @[@"[手机在线]分享了什么？？",@"[手机在线]分享了什么？？",@"[手机在线]分享了什么？？"];
    NSArray *threeDynamic = @[@"[手机在线]分享了什么？？",@"[手机在线]分享了什么？？",@"[手机在线]分享了什么？？",@"[离线]",@"[离线]",@"[离线]",@"[离线]",@"[离线]"];
    NSArray *fourDynamic = @[@"[离线]",@"[离线]",@"[离线]",@"[iPhone在线]",@"[在线]"];
    
    _dataDynamic = [NSMutableArray arrayWithObjects:oneDynamic,twoDynamic,threeDynamic,fourDynamic, nil];
    _stateArray = [NSMutableArray array];
    
    for (int i = 0; i < _dataSource.count; i++)
    {
        //所有的分区都是闭合 初始状态 0代表关闭 1代表打开
        [_stateArray addObject:@"0"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0,80-10, 0);
    [self initDataSource];
}

#pragma mark - Table view data source

/// section数目
/// @param tableView tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

/// 判断是否展开
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_stateArray[section] isEqualToString:@"1"]){
        //如果是展开状态
        NSArray *array = [_dataSource objectAtIndex:section];
        return array.count;
    }else{
        //如果是闭合，返回0
        return 0;
    }
}

/// 返回具体cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDHExpendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExpendCell"];
    if(cell == nil){
        cell = [[WDHExpendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ExpendCell"];
    }
    cell.QQName.text = _dataSource[indexPath.section][indexPath.row];
    cell.QQDynamic.text = _dataDynamic[indexPath.section][indexPath.row];
    return cell;
}

/// section头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //按钮初始化
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    //标签
    [button setTag:section+1];
    button.backgroundColor = [UIColor whiteColor];
    //按钮触法事件
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (kCell_Height-6)/2, 10, 6)];
    
    if ([_stateArray[section] isEqualToString:@"0"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listdown"];
    }else if ([_stateArray[section] isEqualToString:@"1"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listup"];
    }
    [button addSubview:_imgView];
    
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(45, (kCell_Height-20)/2, 200, 20)];
    [tlabel setBackgroundColor:[UIColor clearColor]];
    [tlabel setFont:[UIFont systemFontOfSize:14]];
    [tlabel setText:_sectionArray[section]];
    [button addSubview:tlabel];
    
    UILabel *onlineNumber = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-50, (kCell_Height-20)/2, 40, 20)];
    [onlineNumber setBackgroundColor:[UIColor clearColor]];
    [onlineNumber setFont:[UIFont systemFontOfSize:12]];
    [onlineNumber setText:_onlineNumber[section]];
    [onlineNumber setTextColor:[UIColor grayColor]];
    [button addSubview:onlineNumber];
    return button;
}
#pragma mark
#pragma mark  -select cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (void)buttonPress:(UIButton *)sender//headButton点击
{
    //判断状态值
    if ([_stateArray[sender.tag - 1] isEqualToString:@"1"]){
        //修改
        [_stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
    }else{
        [_stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCell_Height;
}


@end
