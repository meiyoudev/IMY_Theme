//
// Created by Ivan Chua on 15/3/24.
// Copyright (c) 2015 MeiYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IMYSetImageProtocol
@optional
- (void)_imy_setImageForKey:(NSString *)key forState:(NSInteger)state;

- (void)_imy_setImageForKey:(NSString *)key usingCache:(BOOL)usingCache forState:(NSInteger)state;

- (void)_imy_setCenterResizeImageForKey:(NSString *)key forState:(NSInteger)state;

- (void)_imy_setCenterResizeImageForKey:(NSString *)key usingCache:(BOOL)usingCache forState:(NSInteger)state;

- (void)_imy_setImageForKey:(NSString *)key resizableImageWithCapInsets:(UIEdgeInsets)capInsets forState:(NSInteger)state;

- (void)_imy_setImageForKey:(NSString *)key stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight forState:(NSInteger)state;

- (void)_imy_setImageForKey:(NSString *)key usingCache:(BOOL)usingCache stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight forState:(NSInteger)state;

- (void)_imy_setImageForKey:(NSString *)key usingCache:(BOOL)usingCache resizableImageWithCapInsets:(UIEdgeInsets)capInsets forState:(NSInteger)state;

- (void)_imy_setBackgroundImageForKey:(NSString *)key forState:(NSInteger)state;

- (void)_imy_setBackgroundImageForKey:(NSString *)key usingCache:(BOOL)usingCache forState:(NSInteger)state;

- (void)_imy_setCenterResizeBackgroundImageForKey:(NSString *)key forState:(NSInteger)state;

- (void)_imy_setCenterResizeBackgroundImageForKey:(NSString *)key usingCache:(BOOL)usingCache forState:(NSInteger)state;

- (void)_imy_setBackgroundImageForKey:(NSString *)key resizableImageWithCapInsets:(UIEdgeInsets)capInsets forState:(NSInteger)state;

- (void)_imy_setBackgroundImageForKey:(NSString *)key stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight forState:(NSInteger)state;

- (void)_imy_setBackgroundImageForKey:(NSString *)key usingCache:(BOOL)usingCache stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight forState:(NSInteger)state;

- (void)_imy_setBackgroundImageForKey:(NSString *)key usingCache:(BOOL)usingCache resizableImageWithCapInsets:(UIEdgeInsets)capInsets forState:(NSInteger)state;
@end