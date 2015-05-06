//
// Created by Ivan Chua on 15/3/23.
// Copyright (c) 2015 MeiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IMYSetImageProtocol.h"

#define IMYBlockWeakObject(o) __typeof__(o) __weak
#define IMYBlockWeakSelf IMYBlockWeakObject(self)
#define IMYBlockWeakToWeakSelf IMYBlockWeakSelf weakSelf = self;

@protocol IMY_ThemeChangeProtocol
@required
- (void)imy_themeChanged;
@end

@class IMYInvocation;

@interface NSObject (IMY_Theme)

@property(nonatomic, strong) IMYInvocation *imyInvocation;


+ (void)imy_invoke;

- (void)addToThemeChangeObserver;

- (void)addInvocationWithBlock:(NSInvocation *(^)(void))block andCMD:(SEL)cmd key:(NSString *)key;

- (void)addInvocationWithBlock:(NSInvocation *(^)(void))block andCMD:(SEL)cmd forState:(NSInteger)state key:(NSString *)key;

@end

@interface UIView (IMY_Theme_BackgroundColor)
- (void)imy_setBackgroundColorForKey:(NSString *)key;

- (void)imy_setTextColorForKey:(NSString *)key;

- (void)imy_setHighlightedTextColorForKey:(NSString *)key;
@end
