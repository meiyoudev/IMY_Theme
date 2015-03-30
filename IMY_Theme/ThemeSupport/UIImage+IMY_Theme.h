//
// Created by Ivan Chua on 15/3/20.
// Copyright (c) 2015 MeiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (IMY_Theme)

/**
*   @brief  通过图片名来获取图片,默认使用缓存
*   @param  key 图片的名字,如 icon.png icon.jpg icon
*/
+ (instancetype)imy_imageForKey:(NSString *)key;

/**
*   @brief  通过图片名来获取图片
*   @param  key 图片的名字,如 icon.png icon.jpg icon
*   @param  usingCache  是否使用缓存
*/
+ (instancetype)imy_imageForKey:(NSString *)key usingCache:(BOOL)usingCache;

/**
*   @brief  图片从中间拉伸
*/
- (instancetype)imy_resizableImageCenter;
@end