//
//  WDHSegmentView.m
//  QQ
//
//  Created by 敦豪魏 on 2020/8/3.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHSegmentView.h"

@interface WDHSegmentView() <UIScrollViewDelegate>
//控制器数组
@property (nonatomic, strong) NSArray *viewControllersArr;
//标题数组
@property (nonatomic, strong) NSArray *titleArr;
//标题Btn数组
@property (nonatomic, strong) NSArray *BtnArr;
//segmentView的Size的大小
@property (nonatomic, assign) CGSize size;
//按钮title到边的间距
@property (nonatomic, assign) CGFloat buttonSpace;
//存放按钮的宽度
@property (nonatomic, strong) NSMutableArray *widthBtnArr;
//segmentView头部标题视图
@property (nonatomic, strong) UIScrollView *segmentTitleView;
//segmentView控制器视图
@property (nonatomic, strong) UIScrollView *segmentContentView;
//指示移动视图
@property (nonatomic, strong) UIView *indicateView;
//当前被选中的按钮
@property (nonatomic, strong) UIButton *selectedButton;
//父控制器
@property (nonatomic, weak) UIViewController *parentViewController;
//底部分割线
@property (nonatomic, strong) UIView *bottomLineView;
//屏幕宽度
@property (nonatomic, assign) CGFloat ScrollView_Y;
//结果回调 点击按钮时
@property (nonatomic, strong) indexBlock resultBlock;

@end

static CGFloat Font_Default_size = 0;
static CGFloat Font_Selected_size = 0;
///头部高度
#define SegmentViewHeight 44.f
///最小Item之间的间距
#define MinItemSpace 5.f
///标题未被选中时的颜色
#define NormalColor [UIColor grayColor]
///标题被选中的颜色
#define SegmentTintColor [UIColor colorWithRed:0 green:120.0/255.0 blue:255/255 alpha:0.5]

@implementation WDHSegmentView

#pragma mark -- initVC

- (instancetype)initWithFrame:(CGRect)frame ViewControllersArr:(NSArray *)viewControllersArr TitleArr:(NSArray *)titleArr TitleNormalSize:(CGFloat)titleNormalSize TitleSelectedSize:(CGFloat)titleSelectedSize ParentViewController:(UIViewController *)parentViewController ReturnIndexBlock:(indexBlock)resultBlock {
    if (self = [super initWithFrame:frame]) {
        _viewControllersArr = viewControllersArr;
        _titleArr = titleArr;
        _size = frame.size;
        Font_Default_size = titleNormalSize;
        Font_Selected_size = titleSelectedSize;
        _buttonSpace = [self calculateSpace];
        _parentViewController = parentViewController;
        [self loadSegmentTitleView];
        [self addSubview:self.segmentContentView];
        _resultBlock = resultBlock;
    }
    return self;
}

/// 计算间距
- (CGFloat)calculateSpace {
    CGFloat space = 0.f;
    CGFloat totalWidth = 0.f;
    
    for (NSString *title in _titleArr) {
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:Font_Selected_size]}];
        totalWidth += titleSize.width;
    }
    space = (_size.width - totalWidth) / _titleArr.count / 2;
    ///最小间距
    if (space > MinItemSpace / 2) {
        return space;
    } else {
        return MinItemSpace / 2;
    }
    return space;
}

/// 载入菜单视图
- (void)loadSegmentTitleView{
    [self addSubview:self.segmentTitleView];
    [self addSubview:self.bottomLineView];
    
    CGFloat item_x = 0; //初始位置
    NSString *title;
    NSMutableArray *mutBtnArr = [NSMutableArray array];
    for (int i = 0; i < _titleArr.count; i++) {
        //添加按钮
        title = _titleArr[i];
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:Font_Selected_size]}];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //按钮宽度 比文字宽度 宽_buttonSpace*2*2
        button.frame = CGRectMake(item_x, 0,titleSize.width+_buttonSpace*2*2, SegmentViewHeight);
        //button.backgroundColor = [UIColor redColor];
        [button setTag:i];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:NormalColor forState:UIControlStateNormal];
        [button setTitleColor:SegmentTintColor forState:UIControlStateSelected];
        button.layer.cornerRadius = 16;
        [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [mutBtnArr addObject:button];
        [self.widthBtnArr addObject:[NSNumber numberWithDouble:CGRectGetWidth(button.frame)]];
        item_x += _buttonSpace * 2 + titleSize.width+_buttonSpace*2*2;
        //开始所在第一个按钮
        if (i == 0) {
            button.selected = YES;
            _selectedButton = button;
            _selectedButton.titleLabel.font = [UIFont boldSystemFontOfSize:Font_Selected_size];
            self.indicateView.frame = button.frame;
            [_segmentTitleView addSubview:_indicateView];
        }
        [_segmentTitleView addSubview:button];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:Font_Default_size];
    }
    self.BtnArr = [mutBtnArr copy];
    self.segmentTitleView.contentSize = CGSizeMake(item_x, SegmentViewHeight);
}


/// 根据输入值返回对应按钮宽度
/// @param index 选择按钮的tag
- (CGFloat)widthAtIndex:(NSInteger)index {
    if (index < 0 || index > _titleArr.count - 1) {
        return .0;
    }
    return [[_widthBtnArr objectAtIndex:index] doubleValue];
}


/// 点击按钮触发的事件
/// @param button 一个按钮对象
- (void)didClickButton:(UIButton *)button {
    if (button != _selectedButton) {
        button.selected = YES;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:Font_Selected_size];
        _selectedButton.selected = !_selectedButton.selected;
        _selectedButton.titleLabel.font = [UIFont boldSystemFontOfSize:Font_Default_size];
        _selectedButton = button;
        [self scrollIndicateView];
        [self scrollSegementView];
    }
    // 点击第几个标题加载第几个控制器
    [self loadOtherVCWith:_selectedButton.tag];
    //回调函数
    if (_resultBlock) {
        _resultBlock(_selectedButton.tag);
    }
    
}
//载入其他的VC
- (void)loadOtherVCWith:(NSInteger)tag {

    UIViewController *viewController = self.viewControllersArr[tag];
    [viewController.view setFrame:CGRectMake(_size.width * tag, 0, _size.width, _size.height-_ScrollView_Y)];
    [_parentViewController addChildViewController:viewController];
    [viewController didMoveToParentViewController:_parentViewController];
    [_segmentContentView addSubview:viewController.view];
}


# pragma mark -- lazy
///下方分隔距离 加入一个View 高度为5
- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, SegmentViewHeight, _size.width, 5)];
        if (@available(iOS 13.0, *)) {
            _bottomLineView.backgroundColor = [UIColor systemGroupedBackgroundColor];
        } else {
            _bottomLineView.backgroundColor = [UIColor whiteColor];
        }
        _ScrollView_Y = SegmentViewHeight + 5;
    }
    return _bottomLineView;
}

- (NSMutableArray *)widthBtnArr {
    if (!_widthBtnArr) {
        _widthBtnArr = [NSMutableArray array];
    }
    return _widthBtnArr;
}
///返回上方的 一个Scrollview 里面有多个按钮
- (UIScrollView *)segmentTitleView {
    if (!_segmentTitleView) {
        _segmentTitleView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _size.width, SegmentViewHeight)];
        _segmentTitleView.backgroundColor = [UIColor whiteColor];
        //消除左右滑竿
        _segmentTitleView.showsHorizontalScrollIndicator = NO;
        _segmentTitleView.showsVerticalScrollIndicator = NO;
        
    }
    return _segmentTitleView;
}

/// 内容页Scrollview 里面有多个ControllerView
- (UIScrollView *)segmentContentView {
    if (!_segmentContentView) {
        _segmentContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,SegmentViewHeight+5, _size.width, _size.height - _ScrollView_Y-49-20)];
        NSLog(@"ScrollViewVC_HH:%f",_size.height - _ScrollView_Y);
        _segmentContentView.delegate = self;
        _segmentContentView.showsHorizontalScrollIndicator = NO;
        _segmentContentView.pagingEnabled = YES;
        _segmentContentView.bounces = NO;
        [self addSubview:_segmentContentView];
        
        // 设置segmentScrollView的尺寸
        _segmentContentView.contentSize = CGSizeMake(_size.width * self.viewControllersArr.count, 0);
        // 默认加载第一个控制器
        UIViewController *viewController = self.viewControllersArr[0];
        viewController.view.frame = CGRectMake(_size.width * 0, 0, _size.width, _size.height-_ScrollView_Y-49-20);
        [_parentViewController addChildViewController:viewController];
        [viewController didMoveToParentViewController:_parentViewController];
        [_segmentContentView addSubview:viewController.view];
        NSLog(@"123");
    }
    return _segmentContentView;
}

/// 滑动view 初始化
- (UIView *)indicateView {
    if (!_indicateView) {
        _indicateView = [[UIView alloc] init];
        _indicateView.layer.cornerRadius = 16;
        _indicateView.backgroundColor = SegmentTintColor;
    }
    return _indicateView;
}
/**
 根据选中的按钮滑动指示杆
 */
- (void)scrollIndicateView {
    NSInteger index = [self selectedAtIndex];
    CGFloat buttonwidth = [self widthAtIndex:index];
    NSLog(@"buttonwidth:%f",buttonwidth);
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        weakSelf.indicateView.frame = CGRectMake(CGRectGetMinX(weakSelf.selectedButton.frame), 0, buttonwidth, SegmentViewHeight);
        [weakSelf.segmentContentView setContentOffset:CGPointMake(index * weakSelf.size.width, 0)];
    } completion:^(BOOL finished) {
        
    }];
}

/**
 根据选中调整segementView的offset
 */
- (void)scrollSegementView {
    CGFloat selectedWidth = _selectedButton.frame.size.width;
    CGFloat offsetX = (_size.width - selectedWidth) / 2;
    
    if (_selectedButton.frame.origin.x <= _size.width / 2) {
        [_segmentTitleView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (CGRectGetMaxX(_selectedButton.frame) >= (_segmentTitleView.contentSize.width - _size.width / 2)) {
        [_segmentTitleView setContentOffset:CGPointMake(_segmentTitleView.contentSize.width - _size.width, 0) animated:YES];
    } else {
        [_segmentTitleView setContentOffset:CGPointMake(CGRectGetMinX(_selectedButton.frame) - offsetX, 0) animated:YES];
    }
}

#pragma mark -- index

- (NSInteger)selectedAtIndex {
    return _selectedButton.tag;
}


- (void)setSelectedItemAtIndex:(NSInteger)index {
    for (UIView *view in _segmentTitleView.subviews) {
        if ([view isKindOfClass:[UIButton class]] && view.tag == index) {
            UIButton *button = (UIButton *)view;
            [self didClickButton:button];
        }
    }
}

#pragma mark -- scrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = round(scrollView.contentOffset.x / _size.width);
    self.defaultSelectIndex = index;
    [self setSelectedItemAtIndex:index];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat newX = scrollView.contentOffset.x;
    NSInteger currentIndex = [self selectedAtIndex];
    NSInteger index = currentIndex;
    // 当当前的偏移量大于被选中index的偏移量的时候，就是在右侧
    CGFloat offset; // 在同一侧的偏移量
    if (newX >= [self selectedAtIndex] * _size.width) {
        offset = newX - [self selectedAtIndex] * _size.width;
        index += 1;
    } else {
        offset = [self selectedAtIndex] * _size.width - newX;
        index -= 1;
    }
    if(index <= 0){
        index = 1;
    }
    CGFloat originMovedX = CGRectGetMinX(_selectedButton.frame);
    CGFloat targetMovedWidth = [self widthAtIndex:index]+_buttonSpace*2;//需要移动的距离
    
    CGFloat moved; // 移动的距离
    moved = newX - currentIndex * _size.width;
    NSLog(@"x:%f",originMovedX + targetMovedWidth / _size.width * moved);
    NSLog(@"h:%f",[self widthAtIndex:index-1]);
    _indicateView.frame = CGRectMake(originMovedX + targetMovedWidth / _size.width * moved, 0,[self widthAtIndex:index-1], SegmentViewHeight);
}

@end
