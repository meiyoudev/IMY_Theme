//
// Created by Ivan on 15/4/1.
//
//


#import "UINavigationBar+IMY_Theme.h"
#import "UIImage+IMY_Theme.h"
#import "NSObject+IMY_Theme.h"
#import "NSInvocation+BlocksKit.h"


@implementation UINavigationBar (IMY_Theme)
- (void)imy_setBackgroundImageWithKey:(NSString *)key forBarMetrics:(UIBarMetrics)barMetrics
{
    IMYBlockWeakToWeakSelf
    [self setBackgroundImage:[UIImage imy_imageForKey:key] forBarMetrics:barMetrics];
    [self addInvocationWithBlock:^NSInvocation * {
        return [NSInvocation bk_invocationWithTarget:weakSelf block:^(id target) {
            [target imy_setBackgroundImageWithKey:key forBarMetrics:barMetrics];
        }];
    } andCMD:_cmd forState:barMetrics key:key];
}

@end