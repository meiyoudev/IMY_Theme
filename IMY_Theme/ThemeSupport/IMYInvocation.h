//
// Created by Ivan Chua on 15/3/23.
// Copyright (c) 2015 MeiYou. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, IMYImageViewState)
{
    IMYUIImageViewNormalState = 0,
    IMYUIImageViewHighlightedState
};

@interface NSInvocation (IMYTheme)
@property(strong) NSString *key;
@end

@interface IMYInvocation : NSObject

- (BOOL)shouldAddInvocation:(NSInteger)state andCMD:(SEL)cmd key:(NSString *)key;

- (void)removeAddInvocationForState:(NSInteger)state andCMD:(SEL)cmd;

- (void)addInvocation:(NSInvocation *)invocation cmd:(SEL)cmd forState:(NSInteger)state andKey:(NSString *)key;

@end