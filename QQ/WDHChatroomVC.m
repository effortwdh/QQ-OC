//
//  WDHChatroomVC.m
//  QQ
//
//  Created by 敦豪魏 on 2020/7/24.
//  Copyright © 2020 魏敦豪. All rights reserved.
//
//聊天室VC
#import "WDHChatroomVC.h"
#import "WDHMyNavigationBar.h"
#import <Masonry.h>
#import "WDHInputView.h"
#import "WDHInputTextView.h"
@interface WDHChatroomVC ()<UITableViewDelegate,UITableViewDataSource>
//聊天视图
@property (nonatomic,strong)UITableView *tableView;
//聊天输入框
@property (nonatomic,strong)WDHInputTextView *inputContext;
//发送按钮
@property (nonatomic,strong)UIButton *sendButton;
//消息数组
@property (nonatomic,strong)NSMutableArray *messageArr;
//行高
@property (nonatomic,copy)  NSNumber *rowHeight;
//行高数组
@property (nonatomic,strong)NSMutableArray *rowHeightArr;
@end
#define W ([UIScreen mainScreen].bounds.size.width)
#define H ([UIScreen mainScreen].bounds.size.height)
@implementation WDHChatroomVC
-(instancetype)init{
    if(self = [super init]){
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDate];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.navigationItem.titleView = titleView;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    titleLabel.text = @"QQ群名称";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    [titleView addSubview:titleLabel];
    //back 按钮
    UIBarButtonItem *firstButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back (2)"] style:(UIBarButtonItemStyleDone) target:self action:@selector(Buttionback)];
    firstButton.tintColor = [UIColor whiteColor];
    [self.navigationItem setLeftBarButtonItem:firstButton];
    //功能按钮
    UIBarButtonItem *secondButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Category (1)"] style:(UIBarButtonItemStyleDone) target:self action:nil];
    secondButton.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *thirdButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"trust"] style:(UIBarButtonItemStyleDone) target:self action:nil];
    thirdButton.tintColor = [UIColor whiteColor];
    NSArray *buttonItems = @[secondButton,thirdButton];
    [self.navigationItem setRightBarButtonItems:buttonItems];
    
    //去除tabbar 自定义下方view
    WDHInputView *inputfield = [[WDHInputView alloc]init];
    [self.view addSubview:inputfield];
    inputfield.backgroundColor=[UIColor blueColor];
    [inputfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_bottom).offset(-80);
    }];
    //输入框
    _inputContext = [[WDHInputTextView alloc] initWithFrame:CGRectMake(5, 4, 300, 30)];
    _inputContext.textHeightChangedBlock = ^(NSString * _Nonnull text, CGFloat textHeight) {
        NSLog(@"%@ %f",text,textHeight);
    };
    _inputContext.backgroundColor =[UIColor whiteColor];
//    _inputContext.borderStyle = UITextBorderStyleRoundedRect;
//    _inputContext.adjustsFontSizeToFitWidth = YES;
    [_inputContext.layer setCornerRadius:8.0];
    [inputfield addSubview:_inputContext];
    _inputContext.maxNumberOfLines = 10;
    //_inputContext.delegate = self;
    
    //发送按钮
    self.sendButton = [[UIButton alloc] initWithFrame:CGRectMake(310, 4, 375-310-5, 30)];
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    self.sendButton.backgroundColor = [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:0.5];
    [self.sendButton.layer setCornerRadius:8.0];
    [self.sendButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    
    [inputfield addSubview:self.sendButton];
    
    //添加一个聊天信息
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20+46, W, H-46-20-80) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //设置分割线(设置为无样式)
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    //_tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_tableView];
    //监视键盘回收
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardWillAppear:)
     name:UIKeyboardWillShowNotification
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardWillDisAppear:)
     name:UIKeyboardWillHideNotification
     object:nil];
}
//预存好 数据
-(void)setDate{
    //设置聊天信息数值
    _messageArr =[NSMutableArray arrayWithObjects:@"消息一一一消息一一一消息一一一消息一一一消息一一一消息一一一消息一一一消息一一一消息一一一消息一一一消息一一一消息一一一",@"消息一一一",@"消息一一一",@"消息一一一消息一一一消息一一一消息一一一",@"消息一一一消息一一一",@"消息一一一消息一一一消息一一一消息一一一消息一一一",@"消息一一一消息一一一消息一一一消息一一一消息一一一", nil];
    _rowHeightArr = [[NSMutableArray alloc] init];
    for(NSString *str in _messageArr){
        //因为boundingRectWithSize: options: attributes: context: 函数中参数三需要使用字典数组
        //P1:文本显示的最大宽度和最大高度
        //P2:计算的类型 NSStringDrawingUsesLineFragmentOrigin 绘制文本时使用，一般使用这项
        //P3:文本属性
        //P4:包括一些信息，例如如何调整字间距以及缩放。该参数一般可为 nil
        [self addStrToRowHeightArr:str];
    }
}
-(void)addStrToRowHeightArr:(NSString *)str{
    NSDictionary *attri = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize size = [str boundingRectWithSize:CGSizeMake(H*0.5, W*40.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil].size;
    int height = size.height + W*0.20;
    _rowHeight = [NSNumber numberWithInt:height];
    [_rowHeightArr addObject:_rowHeight];
}
//页面将要展示的时候隐藏 tabBar
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
//页面将要消失的时候显示
- (void)viewWillDisappear:(BOOL)animated{
  self.tabBarController.tabBar.hidden = NO;
}
-(void)Buttionback{
    [self.navigationController popViewControllerAnimated:YES];
}
//点击发送按钮
-(void)send{
    [_messageArr addObject:_inputContext.text];
    [self addStrToRowHeightArr:_inputContext.text];
    //_messageArr.count - 1 ： 显示的最后一行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(_messageArr.count - 1) inSection:0];
    //加入一个cell
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    //更新tableView
    [_tableView reloadData];
    //滚动界面（随着消息发送上移）
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    //清空textField
    _inputContext.text = @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [_rowHeightArr[indexPath.row] floatValue];
    return height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rowHeightArr.count;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //当手指离开某行时，就让某行的选中状态消失
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    } else {
        //tableView的复用，如果不删除，会出现bug
        //删除cell所有的子视图
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.backgroundColor= [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row %2 == 0){
        //设置头像
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"ic_appeal"]];
        imageView.frame = CGRectMake(W * 0.01, W * 0.01, W * 0.1, W * 0.1);
        [cell.contentView addSubview:imageView];
        //设置名称
        UILabel *namelabel = [[UILabel alloc] init];
        namelabel.numberOfLines = 0;
        namelabel.text = @"小z";
        namelabel.font = [UIFont systemFontOfSize:12];
        namelabel.textColor = [UIColor grayColor];
        namelabel.frame = CGRectMake(W * 0.13, W * 0.01,W*0.5, W*0.05);
        [cell.contentView addSubview:namelabel];
        //设置对话框
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.text = _messageArr[indexPath.row];
        label.font = [UIFont systemFontOfSize:15];
        NSDictionary *attri = @{NSFontAttributeName:label.font};
        //自适应高度
        CGSize size = [label.text boundingRectWithSize:CGSizeMake(W * 0.5, H * 40.0)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:attri
                                               context:nil].size;
        
        //设置聊天气泡
        UIImageView *imageViewBubble = [[UIImageView alloc] init];
        imageViewBubble.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
        imageViewBubble.frame = CGRectMake(W * 0.13, W * 0.07, size.width + W * 0.05, size.height + W * 0.03);
        
        [cell.contentView addSubview:imageViewBubble];
        
        //设置对话框 位置
        label.frame = CGRectMake(W * 0.14, W * 0.07, size.width, size.height + W * 0.05);
        [cell.contentView addSubview:label];
    }else {
        //设置头像
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"头像"]];
        imageView.frame = CGRectMake(W * 0.89, W * 0.01, W * 0.1, W * 0.1);
        [cell.contentView addSubview:imageView];
        //设置名称
        UILabel *namelabel = [[UILabel alloc] init];
        namelabel.numberOfLines = 0;
        namelabel.text = @"小h";
        namelabel.font = [UIFont systemFontOfSize:12];
        namelabel.textColor = [UIColor grayColor];
        namelabel.frame = CGRectMake(W * 0.89-W*0.10, W * 0.01,W*0.1, W*0.05);
        [cell.contentView addSubview:namelabel];
        //设置对话框
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.text = _messageArr[indexPath.row];
        label.font = [UIFont systemFontOfSize:15];
        NSDictionary *attri = @{NSFontAttributeName:label.font};
        //自适应高度
        CGSize size = [label.text boundingRectWithSize:CGSizeMake(W * 0.5, H * 40.0)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:attri
                                               context:nil].size;
        
        //设置聊天气泡
        UIImageView *imageViewBubble = [[UIImageView alloc] init];
        imageViewBubble.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
        imageViewBubble.frame = CGRectMake(W * 0.82 - size.width, W * 0.08, size.width + W * 0.05, size.height + W * 0.03);
        
        [cell.contentView addSubview:imageViewBubble];
        
        //设置对话框 位置
        label.frame = CGRectMake(W * 0.86-size.width, W * 0.10, size.width, size.height);
        [cell.contentView addSubview:label];
    }
    
    return cell;
}

//显示简单的键盘回收
- (void)keyboardWillDisAppear:(NSNotification *)notification{
    //第一个参数是动画持续时间
    //第二个参数是方法，这里让视图恢复原来的位置就好
    [UIView animateWithDuration:1 animations:^{self.view.transform = CGAffineTransformMakeTranslation(0, 0);}];
    
}

- (void)keyboardWillAppear:(NSNotification *)notification{
    //计算键盘高度
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    
    CGRect frame = CGRectMake(0, 66+H-keyboardY, W, H-keyboardY);
    //视图整体上升
    [UIView animateWithDuration:1.0 animations:^{self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - self.view.frame.size.height);}];
    self.tableView.frame = frame;
    //_messageArr.count - 1 ： 显示的最后一行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(_messageArr.count - 1) inSection:0];
    //滚动界面（随着消息发送上移）
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

//点击空白处回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGRect frame = CGRectMake(0, 66, W, H-46-20-80);
    self.tableView.frame = frame;
    [self.inputContext endEditing:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect frame = CGRectMake(0, 66, W, H-46-20-80);
    self.tableView.frame = frame;
    [self.inputContext endEditing:YES];
}

//点击return回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}



@end
