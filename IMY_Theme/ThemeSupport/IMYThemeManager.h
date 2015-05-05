//
// Created by Ivan Chua on 15/3/20.
// Copyright (c) 2015 MeiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface IMYThemeManager : NSObject

@property(nonatomic, copy) NSString *themePath;

+ (IMYThemeManager *)sharedIMYThemeManager;

/**
 *  @brief 添加别的配置文件名进来 相同key 后加入的配置会覆盖之前的
 *
 *  @param configName 配置文件的完整名字
 */
-(void)addConfigFileName:(NSString*)configName;

/**
*   @brief  返回图片名相对应的资源路径,根据皮肤路径(themePath)来的
*           如果,主题中没有,则会读取mainBundle中的
*
*   @param  key 图片名
*/
- (NSString *)imageResourcePathForKey:(NSString *)key;

- (UIColor *)colorForKey:(NSString *)key;

/**
*   @brief  需要实现 imy_themeChanged方法
*/
- (void)addThemeChangeObserver:(id)object;

- (void)themeDidChanged;
@end