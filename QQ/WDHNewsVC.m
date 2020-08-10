//
//  WDHNewsVC.m
//  QQ
//
//  Created by 敦豪魏 on 2020/7/23.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHNewsVC.h"
#import "WDHNavigationBarView.h" //导航栏View
#import "WDHChatTableViewCell.h" //cell视图
#import "WDHTableHeaderView.h"   //table头部视图
#import "WDHChatroomVC.h"        //聊天室视图
@interface WDHNewsVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation WDHNewsVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化TabBer
        [self initTabBer];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"QQ名称";    //设置导航栏视图
    WDHNavigationBarView *searchBar = [[WDHNavigationBarView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 46) navigationBarViewType:WDHNavigationBarViewNews];
    [self.navigationItem setTitleView:searchBar];
    searchBar.block=^(void){
        NSLog(@"开启摄像头");
    };
    searchBar.QQImageBlock = ^{
        self.openLeftBlock();
    };
    //添加tableView
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    //设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    //添加头部视图
    WDHTableHeaderView *headerView = [[WDHTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    headerView.type = WDHTableHeaderViewTypeNews;
    self.tableView.tableHeaderView = headerView;
    //回收键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}
//- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event{
//    return self.tableView;
//}
//收回键盘
- (void)viewTapped:(UITapGestureRecognizer *) tap1{
    [self.view endEditing:YES];
}
//初始化TabBer
- (void)initTabBer{
    self.view.backgroundColor=[UIColor whiteColor];
    self.tabBarItem.image = [UIImage imageNamed:@"dkw_消息"];
    self.tabBarItem.title = @"消息";
    self.tabBarItem.badgeValue =@"123";
}
//在视图将要出现时候先处理好导航栏
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
//实现代理
#pragma mark "实现代理"
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WDHChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    if(!cell){
        cell = [[WDHChatTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"newsCell"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
//让tableView可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
////右滑动
//-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
//    //删除
//   UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//       NSLog(@"删除");
//       completionHandler (YES);
//   }];
//   //deleteRowAction.image = [UIImage imageNamed:@"icon_del"];
//   deleteRowAction.backgroundColor = [UIColor blueColor];
//
//   UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
//   return config;
//}
//左滑动
-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSLog(@"删除操作");
        //完成操作 隐藏回去
        completionHandler(YES);
    }];
    //标记为已读
    UIContextualAction *readedRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"标记未读" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSLog(@"标记未读操作");
        completionHandler(YES);
    }];
    readedRowAction.backgroundColor = [UIColor grayColor];
    //置顶
    UIContextualAction *topRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"置顶" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSLog(@"置顶操作");
        completionHandler(YES);
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OpenSwipeAction" object:nil];
    topRowAction.backgroundColor = [UIColor blueColor];
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
        return config;
    }
    else if(indexPath.section == 0 && indexPath.row == 1)
    {
        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction,readedRowAction]];
        return config;
    }
    else
    {
        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction,readedRowAction,topRowAction]];
        return config;
    }
}
//选中一个cell 跳转到新页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WDHChatroomVC *vc = [[WDHChatroomVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)event{
    NSLog(@"12");
}
@end
