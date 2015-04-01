//
//  AppDelegate.m
//  IMY_Theme
//
//  Created by Ivan Chua on 15/3/30.
//  Copyright (c) 2015年 Ivan Chua. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NSObject+IMY_Theme.h"
#import "UIImage+IMY_Theme.h"

@interface AppDelegate ()<IMY_ThemeChangeProtocol>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    ViewController *viewController = [[ViewController alloc] init];
    ViewController *viewController1 = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    tabBarController.viewControllers = @[nav,nav1];
    _window.rootViewController = tabBarController;

    [self addToThemeChangeObserver];

    return YES;
}


@end
