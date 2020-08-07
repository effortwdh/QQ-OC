//
//  WDHPartnerTableVC.m
//  QQ
//
//  Created by 敦豪魏 on 2020/7/31.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHPartnerTableVC.h"
#import "WDHExpendCell.h"
@interface WDHPartnerTableVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *indexArray;
@end

@implementation WDHPartnerTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    //隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _indexArray = [[NSMutableArray alloc] init];
    //self.tableView.scrollEnabled = NO;
    
    for(int i=0; i<26; i++)
    {
        NSString *string = [NSString stringWithFormat:@"%c",(i+65)]; // A
        [_indexArray addObject:string];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 26;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _indexArray[section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _indexArray;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WDHExpendCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PartnerCell"];
    if(!cell){
        cell = [[WDHExpendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PartnerCell"];
    }
    cell.leftImage.image = [UIImage imageNamed:@"ic_appeal"];
    NSString *string = [NSString stringWithFormat:@"%c QQ名称",(indexPath.section+65)];
    cell.QQName.text = string;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
@end
