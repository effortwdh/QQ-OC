//
//  WDHContactVC.m
//  QQ
//
//  Created by 敦豪魏 on 2020/7/30.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHContactVC.h"
#import "WDHSegmentView.h"
#import "WDHPartnerTableVC.h"
#import "WDHGroupingTableVC.h"
#import "WDHGroupChatTableVC.h"
#import "WDHDeviceTableVC.h"
#import "WDHAddressBookTableVC.h"
#import "WDHSubscriptionNumberTableVC.h"
#import "WDHNavigationBarView.h"
#import "WDHMyselfTextField.h"
@interface WDHContactVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *QQTableView;
@end

@implementation WDHContactVC
-(instancetype)init{
    self =  [super init];
    if(self){
        self.tabBarItem.image = [UIImage imageNamed:@"联系人"];
        self.tabBarItem.title = @"联系人";
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"QQ名称";    //设置导航栏视图
    WDHNavigationBarView *searchBar = [[WDHNavigationBarView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 46)];
    searchBar.navagationBarViewType = WDHNavigationBarViewContact;
    [self.navigationItem setTitleView:searchBar];
    searchBar.block=^(void){
        NSLog(@"开启摄像头");
    };
    self.QQTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame))];
    self.QQTableView.delegate = self;
    self.QQTableView.dataSource = self;
    self.QQTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.QQTableView];
    
    
}
#pragma mark -table data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    NSMutableArray *mutArr = [NSMutableArray array];
    NSArray *titleArr = @[@"好友",@"分组",@"群聊",@"设备",@"通讯录",@"订阅号"];
    //好友VC
    WDHPartnerTableVC *partnerTableVC = [[WDHPartnerTableVC alloc]init];
    [mutArr addObject:partnerTableVC];
    //分组VC
    WDHGroupingTableVC *GroupingVC = [WDHGroupingTableVC new];
    [mutArr addObject:GroupingVC];
    //群聊VC
    WDHGroupChatTableVC *groupChat = [WDHGroupChatTableVC new];
    [mutArr addObject:groupChat];
    //设备VC
    WDHDeviceTableVC *deviec = [WDHDeviceTableVC new];
    [mutArr addObject:deviec];
    //通讯录VC
    WDHAddressBookTableVC *addressBook = [WDHAddressBookTableVC new];
    [mutArr addObject:addressBook];
    //订阅号VC
    WDHSubscriptionNumberTableVC *sn = [WDHSubscriptionNumberTableVC new];
    [mutArr addObject:sn];
    
    WDHSegmentView *segmentView = [[WDHSegmentView alloc]
                                   initWithFrame:CGRectMake(0,0, self.view.bounds.size.width,[UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame))
                                   ViewControllersArr:[mutArr copy]
                                   TitleArr:titleArr
                                   TitleNormalSize:16
                                   TitleSelectedSize:16
                                   ParentViewController:self
                                   ReturnIndexBlock:^(NSInteger index) {
         NSLog(@"点击了%ld模块",(long)index);
    }];
    [cell.contentView addSubview: segmentView];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    view.backgroundColor = [UIColor whiteColor];
    //添加搜索栏
    WDHMyselfTextField *textField =[[WDHMyselfTextField alloc] initWithFrame:CGRectMake(10, 5,view.bounds.size.width-10*2 , view.bounds.size.height/2-10)];
    [view addSubview:textField];
    //添加按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,view.bounds.size.height/2-10+10, view.bounds.size.width, view.bounds.size.height/2-10)];
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
    
    [view addSubview:button];
    return view;
}
#pragma mark table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame)-200;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat headerViewHeight = 100.0;
    
    if (scrollView.contentOffset.y < headerViewHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(- scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= headerViewHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(- headerViewHeight, 0, 0, 0);
    }
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat bottomCellOffset = [_tableView rectForSection:1].origin.y - 64;
//    NSLog(@"%f",bottomCellOffset);
//    if (scrollView.contentOffset.y >= bottomCellOffset) {
//        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
//        if (self.canScroll) {
//            self.canScroll = NO;
//            self.contentCell.cellCanScroll = YES;
//        }
//    }else{
//        if (!self.canScroll) {//子视图没到顶部
//            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
//        }
//    }
//    self.tableView.showsVerticalScrollIndicator = _canScroll?YES:NO;
//}
@end
