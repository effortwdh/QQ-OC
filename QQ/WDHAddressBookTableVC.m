//
//  WDHAddressBookTableVC.m
//  QQ
//
//  Created by 敦豪魏 on 2020/8/3.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHAddressBookTableVC.h"
#import "WDHExpendCell.h"
@interface WDHAddressBookTableVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WDHAddressBookTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDHExpendCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AddressBook"];
    if(!cell){
        cell = [[WDHExpendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddressBook"];
    }
    UIButton *addPeople = [[UIButton alloc] initWithFrame:CGRectMake(self.tableView.bounds.size.width-100,(80-20)/2,80, 20)];
    [addPeople setTitle:@"添加" forState:UIControlStateNormal];
    addPeople.backgroundColor = [UIColor grayColor];
    [addPeople setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addPeople.layer.cornerRadius = 8;
    [cell addSubview:addPeople];
    cell.leftImage.image = [UIImage imageNamed:@"ic_appeal"];
    cell.QQName.text = @"QQ名称";
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
@end
