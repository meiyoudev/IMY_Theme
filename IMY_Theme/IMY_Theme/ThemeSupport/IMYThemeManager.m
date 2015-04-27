//
// Created by Ivan on 15/3/20.
//
//


#import "IMYThemeManager.h"
#import "IMYThemeImageCache.h"
#import "NSObject+IMY_Theme.h"
#import "NSArray+BlocksKit.h"
#import "UIColor+IMY_Theme.h"
#import "NSString+IMY_Theme.h"
#import "IMYThemeConfig.h"

#define IMY_ThemePath_Key @"IMY_ThemePath_Key"

static NSString *Home_Path = nil;
static NSString *Main_Bundle_Path = nil;

@interface IMYThemeManager ()
@property(nonatomic, strong) NSMutableDictionary *defaultThemeColorDict;
@property(nonatomic, strong) NSMutableDictionary *colorDict;
@property(nonatomic, strong) NSHashTable *observers;
@end

@implementation IMYThemeManager

@synthesize themePath = _themePath;

static IMYThemeManager *_sharedIMYThemeManager = nil;

+ (IMYThemeManager *)sharedIMYThemeManager
{
    static dispatch_once_t singleton;
    dispatch_once(&singleton, ^{
        _sharedIMYThemeManager = [[self alloc] init];
    });
    return _sharedIMYThemeManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.colorDict = [[NSMutableDictionary alloc] init];
        self.observers = [NSHashTable weakObjectsHashTable];
        Home_Path = NSHomeDirectory();
        Main_Bundle_Path = [[NSBundle mainBundle] resourcePath];
        self.themePath = [[[NSUserDefaults standardUserDefaults] stringForKey:IMY_ThemePath_Key] imy_fullPath];
        self.defaultThemeColorDict = [[NSMutableDictionary alloc] init];
        NSString *themeConfigFilePath = [[NSBundle mainBundle] pathForResource:IMY_CONFIG_NAME ofType:nil];
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:themeConfigFilePath];
        if (jsonData)
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            NSDictionary *colors = dict[@"color"];
            [colors enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                _defaultThemeColorDict[key] = [UIColor imy_colorWithHexString:obj];
            }];
        }
    }

    return self;
}


- (NSString *)imageResourcePathForKey:(NSString *)key
{
    return [self resourcePathForKey:key];
}

- (NSString *)resourcePathForKey:(NSString *)key
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *resourcePath = [_themePath stringByAppendingPathComponent:key];
    BOOL fileExist = [fileManager fileExistsAtPath:resourcePath];
    if (!fileExist)
    {
        resourcePath = [Main_Bundle_Path stringByAppendingPathComponent:key];
    }
    return resourcePath;
}


- (UIColor *)colorForKey:(NSString *)key
{
    UIColor *color = _colorDict[key];
    if (!color)
    {
        color = _defaultThemeColorDict[key];
    }
    return color ?: [UIColor blackColor];
}


- (void)setThemePath:(NSString *)themePath
{
    _themePath = themePath;
    [[IMYThemeImageCache sharedIMYThemeImageCache] clear];
    [[NSUserDefaults standardUserDefaults] setObject:themePath forKey:IMY_ThemePath_Key];
    [self resetThemeValues];
    [self themeDidChanged];
}


- (void)resetThemeValues
{
    [self.colorDict removeAllObjects];
    NSString *themeConfigFilePath = [self resourcePathForKey:IMY_CONFIG_NAME];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:themeConfigFilePath];
    if (!jsonData)
    {
        return;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSDictionary *colors = dict[@"color"];
    [colors enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        _colorDict[key] = [UIColor imy_colorWithHexString:obj];
    }];
}

- (void)addThemeChangeObserver:(id)object
{
    if (![_observers containsObject:object])
    {
        [_observers addObject:object];
    }
}


- (void)themeDidChanged
{
    [NSObject imy_invoke];
    SEL sel = NSSelectorFromString(@"imy_themeChanged");
    [_observers.allObjects bk_each:^(id obj) {
        if ([obj respondsToSelector:sel])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [obj performSelector:sel];
#pragma clang diagnostic pop
        }
    }];
}

@end