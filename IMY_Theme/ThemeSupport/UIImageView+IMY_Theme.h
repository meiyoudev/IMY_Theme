//
// Created by Ivan Chua on 15/3/24.
// Copyright (c) 2015 MeiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (IMY_Theme)
- (void)imy_setImageForKey:(NSString *)key;

- (void)imy_setHighlightedImageForKey:(NSString *)key;

- (void)imy_setImageForKey:(NSString *)key stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

- (void)imy_setHighlightedImageForKey:(NSString *)key stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

- (void)imy_setCenterResizeImageForKey:(NSString *)key;

- (void)imy_setCenterResizeHighlightedImageForKey:(NSString *)key;
@end