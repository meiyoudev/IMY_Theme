//
// Created by Ivan Chua on 15/3/20.
// Copyright (c) 2015 MeiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
*   主题的图片缓存
*/
@interface IMYThemeImageCache : NSCache
+ (IMYThemeImageCache *)sharedIMYThemeImageCache;

- (void)clear;
@end