//
// Created by Ivan on 15/3/23.
//
//


#import "NSObject+IMY_Theme.h"
#import "IMYInvocation.h"
#import "NSObject+BKAssociatedObjects.h"
#import "UIImage+IMY_Theme.h"
#import "NSInvocation+BlocksKit.h"
#import "IMYThemeManager.h"

@implementation NSObject (IMY_Theme)

static char *IMYInvocation_KEY;

static NSHashTable *invocationHashTable = nil;

+ (void)load
{
    invocationHashTable = [NSHashTable weakObjectsHashTable];
}


- (IMYInvocation *)imyInvocation
{
    IMYInvocation *imyInvocation = [self bk_associatedValueForKey:IMYInvocation_KEY];
    if (!imyInvocation)
    {
        imyInvocation = [[IMYInvocation alloc] init];
        self.imyInvocation = imyInvocation;
        if (![invocationHashTable containsObject:imyInvocation])
        {
            [invocationHashTable addObject:imyInvocation];
        }
    }
    return imyInvocation;
}

- (void)setImyInvocation:(IMYInvocation *)imyInvocation
{
    [self bk_associateValue:imyInvocation withKey:IMYInvocation_KEY];
}


- (void)addInvocationWithBlock:(NSInvocation *(^)(void))block andCMD:(SEL)cmd key:(NSString *)key
{
    [self addInvocationWithBlock:block andCMD:cmd forState:0 key:key];
}

- (void)addInvocationWithBlock:(NSInvocation *(^)(void))block andCMD:(SEL)cmd forState:(NSInteger)state key:(NSString *)key
{
    if (block && [self.imyInvocation shouldAddInvocation:state andCMD:cmd key:key])
    {
        NSInvocation *invocation = block();
        if (invocation)
        {
            [self.imyInvocation addInvocation:invocation cmd:cmd forState:state andKey:key];
        }
    }
}


- (void)_imy_setImageForKey:(NSString *)key forState:(NSInteger)state
{
    [self _imy_setImageForKey:key usingCache:YES forState:state];
}

- (void)_imy_setImageForKey:(NSString *)key usingCache:(BOOL)usingCache forState:(NSInteger)state
{
    [self _imy_setImageForKey:key usingCache:usingCache resizableImageWithCapInsets:UIEdgeInsetsZero forState:state];
}

- (void)_imy_setCenterResizeImageForKey:(NSString *)key forState:(NSInteger)state
{
    [self _imy_setCenterResizeImageForKey:key usingCache:YES forState:state];
}

- (void)_imy_setCenterResizeImageForKey:(NSString *)key usingCache:(BOOL)usingCache forState:(NSInteger)state
{
    UIImage *image = [UIImage imy_imageForKey:key usingCache:usingCache];
    [self imy_setImage:image.imy_resizableImageCenter forState:state];
    IMYBlockWeakToWeakSelf
    [self addInvocationWithBlock:^NSInvocation * {
        return [NSInvocation bk_invocationWithTarget:weakSelf block:^(id target) {
            [target _imy_setCenterResizeImageForKey:key usingCache:usingCache forState:state];
        }];
    } andCMD:_cmd forState:state key:key];
}

- (void)_imy_setImageForKey:(NSString *)key resizableImageWithCapInsets:(UIEdgeInsets)capInsets forState:(NSInteger)state
{
    [self _imy_setImageForKey:key usingCache:YES resizableImageWithCapInsets:capInsets forState:state];
}

- (void)_imy_setImageForKey:(NSString *)key stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight forState:(NSInteger)state
{
    [self _imy_setImageForKey:key usingCache:YES stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight forState:state];
}

- (void)_imy_setImageForKey:(NSString *)key usingCache:(BOOL)usingCache stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight forState:(NSInteger)state
{
    UIImage *image = [[UIImage imy_imageForKey:key usingCache:usingCache] stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    [self imy_setImage:image forState:state];
    IMYBlockWeakToWeakSelf
    [self addInvocationWithBlock:^NSInvocation * {
        return [NSInvocation bk_invocationWithTarget:weakSelf block:^(id target) {
            [target _imy_setImageForKey:key usingCache:usingCache stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight forState:state];
        }];
    } andCMD:_cmd forState:state key:key];
}

- (void)_imy_setImageForKey:(NSString *)key usingCache:(BOOL)usingCache resizableImageWithCapInsets:(UIEdgeInsets)capInsets forState:(NSInteger)state
{
    UIImage *image = [UIImage imy_imageForKey:key usingCache:usingCache];
    if (!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, capInsets))
    {
        image = [image resizableImageWithCapInsets:capInsets];
    }
    [self imy_setImage:image forState:state];
    IMYBlockWeakToWeakSelf
    [self addInvocationWithBlock:^NSInvocation * {
        return [NSInvocation bk_invocationWithTarget:weakSelf block:^(id target) {
            [target _imy_setImageForKey:key usingCache:usingCache resizableImageWithCapInsets:capInsets forState:state];
        }];
    } andCMD:_cmd forState:state key:key];
}

- (void)_imy_setBackgroundImageForKey:(NSString *)key forState:(NSInteger)state
{
    [self _imy_setBackgroundImageForKey:key usingCache:YES forState:state];
}

- (void)_imy_setBackgroundImageForKey:(NSString *)key usingCache:(BOOL)usingCache forState:(NSInteger)state
{
    [self _imy_setBackgroundImageForKey:key usingCache:usingCache resizableImageWithCapInsets:UIEdgeInsetsZero forState:state];
}

- (void)_imy_setCenterResizeBackgroundImageForKey:(NSString *)key forState:(NSInteger)state
{
    [self _imy_setCenterResizeImageForKey:key usingCache:YES forState:state];
}

- (void)_imy_setCenterResizeBackgroundImageForKey:(NSString *)key usingCache:(BOOL)usingCache forState:(NSInteger)state
{
    UIImage *image = [[UIImage imy_imageForKey:key usingCache:usingCache] imy_resizableImageCenter];
    [self imy_setBackgroundImage:image forState:state];
    IMYBlockWeakToWeakSelf
    [self addInvocationWithBlock:^NSInvocation * {
        return [NSInvocation bk_invocationWithTarget:weakSelf block:^(id target) {
            [target _imy_setCenterResizeBackgroundImageForKey:key usingCache:usingCache forState:state];
        }];
    } andCMD:_cmd forState:state key:key];

}

- (void)_imy_setBackgroundImageForKey:(NSString *)key resizableImageWithCapInsets:(UIEdgeInsets)capInsets forState:(NSInteger)state
{
    [self _imy_setBackgroundImageForKey:key usingCache:YES resizableImageWithCapInsets:capInsets forState:state];
}

- (void)_imy_setBackgroundImageForKey:(NSString *)key stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight forState:(NSInteger)state
{
    [self _imy_setBackgroundImageForKey:key usingCache:YES stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight forState:state];
}

- (void)_imy_setBackgroundImageForKey:(NSString *)key usingCache:(BOOL)usingCache stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight forState:(NSInteger)state
{
    UIImage *image = [[UIImage imy_imageForKey:key usingCache:usingCache] stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    [self imy_setBackgroundImage:image forState:state];
    IMYBlockWeakToWeakSelf
    [self addInvocationWithBlock:^NSInvocation * {
        return [NSInvocation bk_invocationWithTarget:weakSelf block:^(id target) {
            [target _imy_setBackgroundImageForKey:key usingCache:usingCache stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight forState:state];
        }];
    } andCMD:_cmd forState:state key:key];
}

- (void)_imy_setBackgroundImageForKey:(NSString *)key usingCache:(BOOL)usingCache resizableImageWithCapInsets:(UIEdgeInsets)capInsets forState:(NSInteger)state
{
    UIImage *image = [UIImage imy_imageForKey:key usingCache:usingCache];
    if (!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, capInsets))
    {
        image = [image resizableImageWithCapInsets:capInsets];
    }
    [self imy_setBackgroundImage:image forState:state];
    IMYBlockWeakToWeakSelf
    [self addInvocationWithBlock:^NSInvocation * {
        return [NSInvocation bk_invocationWithTarget:weakSelf block:^(id target) {
            [target _imy_setBackgroundImageForKey:key usingCache:usingCache resizableImageWithCapInsets:capInsets forState:state];
        }];
    } andCMD:_cmd forState:state key:key];
}


- (void)addToThemeChangeObserver
{
    if ([self respondsToSelector:@selector(imy_themeChanged)])
    {
        [[IMYThemeManager sharedIMYThemeManager] addThemeChangeObserver:self];
        [self performSelector:@selector(imy_themeChanged)];
    }
}

+ (void)imy_invoke
{
    [invocationHashTable.allObjects makeObjectsPerformSelector:@selector(invoke)];
}

- (void)imy_setImage:(UIImage *)image forState:(NSInteger)state
{
    if ([self isKindOfClass:[UIImageView class]])
    {
        UIImageView *imageView = (UIImageView *) self;
        if (state == IMYUIImageViewNormalState)
        {
            imageView.image = image;
        }
        else if (state == IMYUIImageViewHighlightedState)
        {
            imageView.highlightedImage = image;
        }
    }
    else if ([self isKindOfClass:[UIButton class]])
    {
        UIButton *button = (UIButton *) self;
        [button setImage:image forState:(UIControlState) state];
    }
}

- (void)imy_setBackgroundImage:(UIImage *)image forState:(NSInteger)state
{
    if ([self isKindOfClass:[UIButton class]])
    {
        UIButton *button = (UIButton *) self;
        [button setBackgroundImage:image forState:(UIControlState) state];
    }
}

@end


@implementation UIView (IMY_Theme_BackgroundColor)
- (void)imy_setBackgroundColorForKey:(NSString *)key
{
    [self _imy_setColorForKey:key withSel:@selector(setBackgroundColor:)];
}

- (void)imy_setTextColorForKey:(NSString *)key
{
    [self _imy_setColorForKey:key withSel:@selector(setTextColor:)];
}

- (void)imy_setHighlightedTextColorForKey:(NSString *)key
{
    [self _imy_setColorForKey:key withSel:@selector(setHighlightedTextColor:)];
}

- (void)_imy_setColorForKey:(NSString *)key withSel:(SEL)sel
{
    if ([self respondsToSelector:sel])
    {
        UIColor *color = [[IMYThemeManager sharedIMYThemeManager] colorForKey:key];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:sel withObject:color];
#pragma clang diagnostic pop
        IMYBlockWeakToWeakSelf
        [self addInvocationWithBlock:^NSInvocation * {
            return [NSInvocation bk_invocationWithTarget:weakSelf block:^(id target) {
                [target _imy_setColorForKey:key withSel:sel];
            }];
        } andCMD:sel key:key];
    }
}


@end