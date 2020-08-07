//
//  WDHLeftSildeMenuVC.m
//  QQ
//
//  Created by 敦豪魏 on 2020/8/5.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "WDHLeftSildeMenuVC.h"
#import "WDHMenuVC.h"
#define WeakSelf()         __weak typeof (self) weakself = self
#define ScreenSize         [UIScreen mainScreen].bounds.size
#define ScreenWidth        ScreenSize.width
#define ScreenHeight       ScreenSize.height
#define MainVCShowWidth    ScreenWidth * .25f// when open left menu, main view width

NSTimeInterval const SlideMenuDuration = .2f;

@interface WDHLeftSildeMenuVC () <UIGestureRecognizerDelegate>
//navigation控制器 里面保存的内容是tabBarVC 主窗口
@property (nonatomic, strong) UIViewController *mainVC;
//具体的菜单VC
@property (nonatomic, strong) WDHMenuVC *leftMenuVC;
//点击手势
//@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
//滑动手势
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
//滑动back手势
@property (nonatomic, strong) UIPanGestureRecognizer *panBackGesture;
//判断是否菜单是否打开
@property (nonatomic, assign) BOOL menuOpened;

@end
@implementation WDHLeftSildeMenuVC

#pragma mark - life cycle
- (instancetype)initWithMainVC:(UIViewController *)mainVC leftMenuVC:(UIViewController *)leftMenuVC {
    if (self = [super init]) {
        self.menuOpened = NO;
        self.mainVC = mainVC;
        self.leftMenuVC = (WDHMenuVC *)leftMenuVC;
        
        [self.view addSubview:self.mainVC.view];
        [self.view insertSubview:self.leftMenuVC.view belowSubview:self.mainVC.view];
        [self addPanGestureToMainVC];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __block WDHLeftSildeMenuVC *strongBlock = self;
    self.leftMenuVC.backBlock = ^{
        [strongBlock closeLeftMenu];
    };
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openLeftMenu) name:@"OpenLeftMenu" object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - open / close left menu

- (void)switchMenu {
    if (self.menuOpened == NO) {
        [self openLeftMenu];
    } else {
        [self closeLeftMenu];
    }
}
//打开左边抽屉菜单
- (void)openLeftMenu {
    self.menuOpened = YES;
    //[self addTapGestureToMainVC];
    WeakSelf();
    [UIView animateWithDuration:SlideMenuDuration animations:^{
//        weakself.mainVC.view.center = CGPointMake(ScreenWidth + ScreenWidth / 2.f - MainVCShowWidth, ScreenHeight / 2.f);
        [self addPanBackGestureToLeftMenuVc];
        weakself.mainVC.view.center = CGPointMake(ScreenWidth + ScreenWidth / 2.f, ScreenHeight / 2.f);
    }];
    
}
//关闭菜单
- (void)closeLeftMenu {
    self.menuOpened = NO;
    //[self removeTapGestureFromMainVC];
    WeakSelf();
    [UIView animateWithDuration:SlideMenuDuration animations:^{
        weakself.mainVC.view.center = CGPointMake(ScreenWidth / 2.f, ScreenHeight / 2.f);
    }];
}

#pragma mark - add / remove gestures
//- (void)addTapGestureToMainVC {
//    [self.mainVC.view addGestureRecognizer:self.tapGesture];
//}

//- (void)removeTapGestureFromMainVC {
//    [self.mainVC.view removeGestureRecognizer:self.tapGesture];
//}

- (void)addPanGestureToMainVC {
    [self.mainVC.view addGestureRecognizer:self.panGesture];
}

- (void)removePanGestureFromMainVC {
    [self.mainVC.view removeGestureRecognizer:self.panGesture];
}

- (void)addPanBackGestureToLeftMenuVc{
    [self.leftMenuVC.view addGestureRecognizer:self.panBackGesture];
}
- (void)removePanBackGestureToLeftMenuVc{
    [self.leftMenuVC.view removeGestureRecognizer:self.panBackGesture];
}

#pragma mark - handle gestures
- (void)handleTapGesture:(UITapGestureRecognizer *)tap {
    if (self.menuOpened) {
        [self closeLeftMenu];
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)pan {
    // pan手势 根据偏移进行具体的判断
    CGPoint offsetPoint = [pan translationInView:pan.view];
    if(offsetPoint.x < 0){
        [self closeLeftMenu];
        return ;
    }
    NSLog(@"left:%f",offsetPoint.x);
    //主窗口进行移动
    pan.view.center = CGPointMake(pan.view.center.x + offsetPoint.x, pan.view.center.y);
    //pan 手势的位置根据 主窗口进行移动
    [pan setTranslation:CGPointZero inView:self.view];
    //NSLog(@"滑动手势进行中~~");
    //滑动手势结束时进行状态改变
    if (pan.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"滑动手势结束");
        CGFloat mainVCLeft = pan.view.frame.origin.x;
        NSLog(@"end:%f",mainVCLeft);
        if (mainVCLeft < ScreenWidth / 2.f) {
            [self closeLeftMenu];
        } else {
            [self openLeftMenu];
        }
    }
}

- (void)handlePanBackGesture:(UIPanGestureRecognizer *)pan{
    // pan手势 根据偏移进行具体的判断
    CGPoint offsetPoint = [pan translationInView:self.mainVC.view];
    NSLog(@"right:%f",self.mainVC.view.center.x + offsetPoint.x);
    //主窗口进行移动
    self.mainVC.view.center = CGPointMake(self.mainVC.view.center.x + offsetPoint.x, self.mainVC.view.center.y);
    //pan 手势的位置根据 主窗口进行移动
    [pan setTranslation:CGPointZero inView:self.mainVC.view];
    //滑动手势结束时进行状态改变
    if (pan.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"滑动手势结束");
        CGFloat mainVCLeft = self.mainVC.view.frame.origin.x;
        NSLog(@"end:%f",mainVCLeft);
        if (mainVCLeft < ScreenWidth / 2.f) {
            [self closeLeftMenu];
        } else {
            [self openLeftMenu];
        }
    }
}


#pragma mark - getters
//- (UITapGestureRecognizer *)tapGesture {
//    if (!_tapGesture) {
//        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
//    }
//    return _tapGesture;
//}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    // pan手势 根据偏移进行具体的判断
    CGPoint offsetPoint = [gestureRecognizer translationInView:self.mainVC.view];
    if(offsetPoint.x < 5){
        return NO;
    }
    return YES;
}
- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        _panGesture.delegate = self;
        //[_panGesture requireGestureRecognizerToFail:];
    }
    return _panGesture;
}
- (UIPanGestureRecognizer *)panBackGesture{
    if(!_panBackGesture) {
        _panBackGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanBackGesture:)];
    }
    return _panBackGesture;
}


@end
