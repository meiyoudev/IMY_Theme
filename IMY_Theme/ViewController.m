//
//  ViewController.m
//  IMY_Theme
//
//  Created by Ivan Chua on 15/3/30.
//  Copyright (c) 2015年 Ivan Chua. All rights reserved.
//

#import "ViewController.h"
#import "View+MASAdditions.h"
#import "UIButton+IMY_Theme.h"
#import "NSObject+IMY_Theme.h"
#import "IMYThemeManager.h"
#import "UIImageView+IMY_Theme.h"
#import "UIColor+IMY_Theme.h"
#import "UITabBarItem+IMY_Theme.h"
#import "UINavigationBar+IMY_Theme.h"

@interface ViewController () <IMY_ThemeChangeProtocol>

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self.tabBarItem imy_setFinishedSelectedImageName:@"all_bottomnews" withFinishedUnselectedImageName:@"all_bottomnews_up"];
    }

    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar imy_setBackgroundImageWithKey:@"nav" forBarMetrics:UIBarMetricsDefault];
    UIButton *button = [[UIButton alloc] init];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    [button imy_setImageForKey:@"all_bottommeetyou" andState:UIControlStateNormal];
    [button imy_setImageForKey:@"all_bottommeetyou_up" andState:UIControlStateHighlighted];
    [button setTitle:@"change theme" forState:UIControlStateNormal];
    [button imy_setTitleColorForKey:@"SY_BROWN" andState:UIControlStateNormal];
    [button imy_setTitleColorForKey:@"SY_RED" andState:UIControlStateHighlighted];
    [button imy_setBackgroundColorForKey:@"SY_GREY"];


    UIButton *button1 = [[UIButton alloc] init];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button);
        make.left.equalTo(button.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [button1 imy_setBackgroundImageForKey:@"all_bottomnews" andState:UIControlStateNormal];
    [button1 imy_setBackgroundImageForKey:@"all_bottomnews_up" andState:UIControlStateHighlighted];

    UILabel *label = [[UILabel alloc] init];
    label.text = @"support textColor and backgroundColor";
    label.preferredMaxLayoutWidth = self.view.frame.size.width;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button.mas_bottom).offset(10);
        make.left.equalTo(button);
    }];
    [label imy_setBackgroundColorForKey:@"SY_GREY"];
    [label imy_setTextColorForKey:@"SY_RED"];
    [button addTarget:self action:@selector(changeTheme) forControlEvents:UIControlEventTouchUpInside];

    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(10);
        make.left.equalTo(label);
        make.size.mas_equalTo(CGSizeMake(300, 80));
    }];
    [imageView imy_setImageForKey:@"chat_pinkbg.png" stretchableImageWithLeftCapWidth:10 topCapHeight:30];

    UITextField *textField = [[UITextField alloc] init];
    [self.view addSubview:textField];
    textField.text = @"UITextField support change color";
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(40);
    }];
    [textField imy_setTextColorForKey:@"SY_RED"];
    [textField imy_setBackgroundColorForKey:@"SY_GREY"];

    UITextView *textView = [[UITextView alloc] init];
    [self.view addSubview:textView];
    textView.text = @"UITextView support too";
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textField.mas_bottom).offset(10);
        make.size.equalTo(textField);
        make.left.equalTo(textField);
    }];
    [textView imy_setTextColorForKey:@"SY_GREY"];
    [textView imy_setBackgroundColorForKey:@"SY_RED"];
    //手动处理主题变化,需要实现 IMY_ThemeChangeProtocol
    [self addToThemeChangeObserver];

}

- (void)changeTheme
{
    IMYThemeManager *themeManager = [IMYThemeManager sharedIMYThemeManager];
    if ([themeManager.themePath hasSuffix:@"bundle"])
    {
        themeManager.themePath = nil;
    }
    else
    {
        themeManager.themePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"theme2.bundle"];
    }
}

- (void)imy_themeChanged
{
    self.view.backgroundColor = [UIColor imy_colorForKey:@"SY_BLACK"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
