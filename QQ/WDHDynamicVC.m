//
//  WDHDynamicVC.m
//  QQ
//
//  Created by 敦豪魏 on 2020/8/3.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHDynamicVC.h"
#import "WDHNavigationBarView.h"
#import "WDHTableHeaderView.h"
#import "WDHDynamicCollectionViewCell.h"

@interface WDHDynamicVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *QQCollectionView;
@end

@implementation WDHDynamicVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initTabBer];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat selfWidth = self.view.bounds.size.width;
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏视图
    self.navigationItem.title = @"QQ名称";
    _searchBar = [[WDHNavigationBarView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 46)];
    _searchBar.navagationBarViewType = WDHNavigationBarViewDynamic;
    [self.navigationItem setTitleView:_searchBar];
    _searchBar.block=^(void){
        NSLog(@"开启摄像头");
    };
    //使用的是Flow方式布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 110);
    layout.itemSize = CGSizeMake(selfWidth/3-10, 110);
    //创建QQCollectionView
    self.QQCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0,self.view.bounds.size.width-20, self.view.bounds.size.height+54) collectionViewLayout:layout];
    self.QQCollectionView.delegate = self;
    self.QQCollectionView.dataSource = self;
    _QQCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.QQCollectionView];
    //注册collectionViewCell
    [self.QQCollectionView registerClass:[WDHDynamicCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    //注册头部cell
    [self.QQCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell"];
    //四周距离
    self.QQCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    //隐藏滚动条
    self.QQCollectionView.showsVerticalScrollIndicator = NO;
}
//初始化TabBer
- (void)initTabBer{
    self.view.backgroundColor=[UIColor whiteColor];
    self.tabBarItem.image = [UIImage imageNamed:@"动态"];
    self.tabBarItem.title = @"动态";
}

#pragma mark -collection data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 15;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//下方cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WDHDynamicCollectionViewCell *cell = [self.QQCollectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.dynamicImage.image =[UIImage imageNamed:@"附近"];
    cell.dynamicLabel.text = @"附近";
    return cell;
}
//头部cell
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = [self.QQCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
    WDHTableHeaderView *headerView =  [[WDHTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    headerView.type = WDHTableHeaderViewTypeDynamic;
    [view addSubview:headerView];
    return view;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
@end
