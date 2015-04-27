//
// Created by Ivan Chua on 15/3/25.
// Copyright (c) 2015 MeiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (IMY_Theme)
+ (UIColor *)imy_colorForKey:(NSString *)key;
+ (UIColor *)imy_colorWithHexString:(id)hexString;
@end