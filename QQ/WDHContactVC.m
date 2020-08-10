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
#import "WDHTableHeaderView.h"
@interface WDHContactVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *QQTableView;
@property (nonatomic,strong) WDHNavigationBarView *searchBar;
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
    _searchBar = [self searchBar];
    _searchBar.block=^(void){
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
    WDHTableHeaderView *headerView =  [[WDHTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    headerView.type = WDHTableHeaderViewTypeContact;
    [view addSubview:headerView];
    
    //回收键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    return view;
    
}
//收回键盘
- (void)viewTapped:(UITapGestureRecognizer *) tap1{
    [self.view endEditing:YES];
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
    
    CGFloat bottomCellOffset = [self.QQTableView rectForSection:0].origin.y;
    NSLog(@"%f",bottomCellOffset);
    
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
- (WDHNavigationBarView *)searchBar {
    if(!_searchBar) {
        _searchBar = [[WDHNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 46) navigationBarViewType:WDHNavigationBarViewContact];
        [self.navigationItem setTitleView:_searchBar];
    }
    return _searchBar;
}
@end
