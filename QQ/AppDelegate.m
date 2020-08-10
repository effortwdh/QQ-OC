//
//  AppDelegate.m
//  QQ
//
//  Created by 敦豪魏 on 2020/7/23.
//  Copyright © 2020 魏敦豪. All rights reserved.
//

#import "AppDelegate.h"
#import "WDHNewsVC.h"
#import "WDHContactVC.h"
#import "WDHDynamicVC.h"
#import "WDHLeftSildeMenuVC.h"
#import "WDHMenuVC.h"
#import "WDHNavigationBarView.h"

@interface AppDelegate ()<WDHNavigationBarViewDelegate>
@property (nonatomic,strong) WDHLeftSildeMenuVC *slideVC;
@end

@implementation AppDelegate
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if(@available(iOS 13.0,*)){
        
    }else{
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.window makeKeyAndVisible];
        
        UITabBarController *tabBar = [[UITabBarController alloc] init];
        //消息界面
        WDHNewsVC *newsView = [[WDHNewsVC alloc] init];
        UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:newsView];
        nc1.navigationBar.barTintColor = [UIColor blueColor];
        
        
        //联系人界面
        WDHContactVC *contactVC = [[WDHContactVC alloc] init];
        UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:contactVC];
        nc2.navigationBar.barTintColor = [UIColor blueColor];

        //动态界面
        WDHDynamicVC *dynamic = [[WDHDynamicVC alloc] init];
        UINavigationController *nc3 = [[UINavigationController alloc] initWithRootViewController:dynamic];
        nc3.navigationBar.barTintColor = [UIColor blueColor];
        dynamic.searchBar.delegate = self;
        [tabBar setViewControllers:@[nc1,nc2,nc3] animated:YES];
        //添加一个外层的Navigation控制器来实现全屏滑动
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabBar];
        //自定义的最底层VC
        _slideVC = [[WDHLeftSildeMenuVC alloc] initWithMainVC:nav leftMenuVC:[WDHMenuVC new]];
        newsView.openLeftBlock = ^{
            [self.slideVC switchMenu];
        };
        //隐藏上方导航栏
        [tabBar.navigationController setNavigationBarHidden:YES animated:YES];
        [self.window setRootViewController:_slideVC];
    }
    return YES;
}
//打开右侧菜单
-(void)OpenLeftMenu{
    [_slideVC switchMenu];
}

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    return YES;
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    if(@available(iOS 13.0,*)){
        return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
    }
    else{
        return nil;
    }
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
}


@end
