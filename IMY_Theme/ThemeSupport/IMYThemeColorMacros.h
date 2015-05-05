//
//  IMYThemeColorMacros.h
//  IMY_Theme
//
//  Created by ljh on 15/4/22.
//  Copyright (c) 2015年 Ivan Chua. All rights reserved.
//

#ifndef IMY_COLOR_KEY

#define IMY_COLOR_KEY(key) [[IMYThemeManager sharedIMYThemeManager] colorForKey:key]

#define IMY_RED @"SY_RED"
#define IMY_BLACK @"SY_BLACK"
#define IMY_GREY @"SY_GREY"
#define IMY_BROWN @"SY_BROWN"

#define IMY_COLOR_RED IMY_COLOR_KEY(IMY_RED)
#define IMY_COLOR_BLACK IMY_COLOR_KEY(IMY_BLACK)
#define IMY_COLOR_GREY IMY_COLOR_KEY(IMY_GREY)
#define IMY_COLOR_BROWN IMY_COLOR_KEY(IMY_BROWN)

#endif