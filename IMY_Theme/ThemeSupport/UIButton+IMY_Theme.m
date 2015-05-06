//
// Created by Ivan on 15/3/24.
//
//


#import "UIButton+IMY_Theme.h"
#import "NSObject+IMY_Theme.h"
#import "IMYThemeManager.h"
#import "NSInvocation+BlocksKit.h"
#import "UIColor+IMY_Theme.h"


@implementation UIButton (IMY_Theme)

- (void)imy_setImageForKey:(NSString *)key andState:(UIControlState)state
{
    [(id <IMYSetImageProtocol>)self _imy_setImageForKey:key forState:state];
}

- (void)imy_setImageForKey:(NSString *)key andState:(UIControlState)state stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight
{
    [(id <IMYSetImageProtocol>)self _imy_setImageForKey:key stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight forState:state];
}

- (void)imy_setCenterResizeImageForKey:(NSString *)key andState:(UIControlState)state
{
    [(id <IMYSetImageProtocol>)self _imy_setCenterResizeImageForKey:key forState:state];
}

- (void)imy_setBackgroundImageForKey:(NSString *)key andState:(UIControlState)state
{
    [(id <IMYSetImageProtocol>)self _imy_setBackgroundImageForKey:key forState:state];
}

- (void)imy_setCenterResiseBackgroudImageForKey:(NSString *)key andState:(UIControlState)state
{
    [(id <IMYSetImageProtocol>)self _imy_setCenterResizeBackgroundImageForKey:key forState:state];
}

- (void)imy_setBackgroudImageForKey:(NSString *)key stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight forState:(UIControlState)state
{
    [(id <IMYSetImageProtocol>)self _imy_setBackgroundImageForKey:key stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight forState:state];
}

- (void)imy_setTitleColorForKey:(NSString *)key andState:(UIControlState)state
{
    UIColor *color = [UIColor imy_colorForKey:key];
    [self setTitleColor:color forState:state];
    IMYBlockWeakToWeakSelf
    [self addInvocationWithBlock:^NSInvocation * {
        return [NSInvocation bk_invocationWithTarget:weakSelf block:^(id target) {
            [target imy_setTitleColorForKey:key andState:state];
        }];
    } andCMD:_cmd forState:state key:key];
}


@end