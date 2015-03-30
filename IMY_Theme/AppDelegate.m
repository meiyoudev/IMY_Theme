//
//  AppDelegate.m
//  IMY_Theme
//
//  Created by Ivan Chua on 15/3/30.
//  Copyright (c) 2015年 Ivan Chua. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    ViewController *viewController = [[ViewController alloc] init];
    ViewController *viewController1 = [[ViewController alloc] init];
    tabBarController.viewControllers = @[viewController,viewController1];
    _window.rootViewController = tabBarController;
    return YES;
}

@end
