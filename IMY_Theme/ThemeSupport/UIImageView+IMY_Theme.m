//
// Created by Ivan on 15/3/24.
//
//


#import "UIImageView+IMY_Theme.h"
#import "NSObject+IMY_Theme.h"
#import "IMYInvocation.h"

@implementation UIImageView (IMY_Theme)
- (void)imy_setImageForKey:(NSString *)key
{
    [(id <IMYSetImageProtocol>) self _imy_setImageForKey:key forState:IMYUIImageViewNormalState];
}

- (void)imy_setHighlightedImageForKey:(NSString *)key
{
    [(id <IMYSetImageProtocol>) self _imy_setImageForKey:key forState:IMYUIImageViewHighlightedState];
}

- (void)imy_setImageForKey:(NSString *)key stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight
{
    [(id <IMYSetImageProtocol>) self _imy_setImageForKey:key stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight forState:IMYUIImageViewNormalState];
}

- (void)imy_setHighlightedImageForKey:(NSString *)key stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight
{
    [(id <IMYSetImageProtocol>) self _imy_setImageForKey:key stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight forState:IMYUIImageViewHighlightedState];
}

- (void)imy_setCenterResizeImageForKey:(NSString *)key
{
    [(id <IMYSetImageProtocol>) self _imy_setCenterResizeImageForKey:key forState:IMYUIImageViewNormalState];
}

- (void)imy_setCenterResizeHighlightedImageForKey:(NSString *)key
{
    [(id <IMYSetImageProtocol>) self _imy_setCenterResizeImageForKey:key forState:IMYUIImageViewHighlightedState];
}


@end