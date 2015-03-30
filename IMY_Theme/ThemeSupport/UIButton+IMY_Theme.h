//
// Created by Ivan Chua on 15/3/24.
// Copyright (c) 2015 MeiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButton (IMY_Theme)

- (void)imy_setImageForKey:(NSString *)key andState:(UIControlState)state;

- (void)imy_setImageForKey:(NSString *)key andState:(UIControlState)state stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

- (void)imy_setCenterResizeImageForKey:(NSString *)key andState:(UIControlState)state;

- (void)imy_setBackgroundImageForKey:(NSString *)key andState:(UIControlState)state;

- (void)imy_setCenterResiseBackgroudImageForKey:(NSString *)key andState:(UIControlState)state;

- (void)imy_setBackgroudImageForKey:(NSString *)key stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight forState:(UIControlState)state;

- (void)imy_setTitleColorForKey:(NSString *)key andState:(UIControlState)state;

@end