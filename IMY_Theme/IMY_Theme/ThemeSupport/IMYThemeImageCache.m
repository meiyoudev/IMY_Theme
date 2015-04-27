//
// Created by Ivan on 15/3/20.
//
//


#import "IMYThemeImageCache.h"


@implementation IMYThemeImageCache

static IMYThemeImageCache *_sharedIMYThemeImageCache = nil;

+ (IMYThemeImageCache *)sharedIMYThemeImageCache
{
    static dispatch_once_t singleton;
    dispatch_once(&singleton, ^{
        _sharedIMYThemeImageCache = [[self alloc] init];
    });
    return _sharedIMYThemeImageCache;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clear) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }

    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)setObject:(id)obj forKey:(id)key
{
    if (key)
    {
        if (!obj)
        {
            [self removeObjectForKey:key];
        }
        else
        {
            [super setObject:obj forKey:key];
        }
    }
}

- (void)clear
{
    [self removeAllObjects];
}

@end