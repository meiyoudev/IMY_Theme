//
// Created by Ivan Chua on 15/3/24.
// Copyright (c) 2015 MeiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+IMY_WebImage.h"
#import "NSObject+IMY_Theme.h"

@protocol IMY_WebImageProgressProtocol;

/**
*   @brief  网络图片下载,用的是SDWebImage这个库
*   支持图片下载中的图片和显示模式
*   支持图片下载失败的图片和显示模式
*   支持进度条,进度条到时候随便换就是了
*   支持设置背景颜色的key
*   以上的资源都默认支持了换肤,不需要关心换肤后的设置
*/
@interface UIImageView (IMY_WebImage) <IMY_ThemeChangeProtocol>

@property UIViewContentMode downloadContentMode UI_APPEARANCE_SELECTOR;
@property UIViewContentMode failureContentMode UI_APPEARANCE_SELECTOR;
@property BOOL showProgress;
@property(copy) NSString *placeholderImageName UI_APPEARANCE_SELECTOR;
@property(copy) NSString *failureImageName UI_APPEARANCE_SELECTOR;
@property(copy) NSString *backgroundColorKey UI_APPEARANCE_SELECTOR;
@property(strong) UIView *progressView;


/**
*   @brief 下载图片
*   @param  URL 可以是NSString 也可以是 NSURL
*/
- (void)imy_setImageURL:(id)URL;

/**
*   @brief  下载图片,并且根据试图的大小,自动在七牛的API上加载裁剪的功能.
*/

- (void)imy_setImageURL:(id)URL quality:(NSInteger)quality;

- (void)imy_setImageURL:(id)URL resise:(CGSize)size;

- (void)imy_setImageURL:(id)URL resise:(CGSize)size quality:(NSInteger)quality;

- (void)imy_setImageURL:(id)URL resise:(CGSize)size quality:(NSInteger)quality type:(IMY_QiNiu_ImageType)type;


@end