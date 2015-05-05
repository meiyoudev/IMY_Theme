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
@property(nonatomic, strong) NSMutableArray* configFileNames;
@end

@implementation IMYThemeManager

@synthesize themePath = _themePath;

static IMYThemeManager *_sharedIMYThemeManager = nil;

+ (IMYThemeManager *)sharedIMYThemeManager
{
    if(_sharedIMYThemeManager == nil)
    {
        static dispatch_once_t singleton;
        dispatch_once(&singleton, ^{
            _sharedIMYThemeManager = [self alloc];
            _sharedIMYThemeManager = [_sharedIMYThemeManager init];
        });
    }
    return _sharedIMYThemeManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.colorDict = [[NSMutableDictionary alloc] init];
        self.configFileNames = [NSMutableArray array];
        
        self.observers = [NSHashTable weakObjectsHashTable];
        Home_Path = NSHomeDirectory();
        Main_Bundle_Path = [[NSBundle mainBundle] resourcePath];
        
        self.themePath = [[[NSUserDefaults standardUserDefaults] stringForKey:IMY_ThemePath_Key] imy_fullPath];
        self.defaultThemeColorDict = [[NSMutableDictionary alloc] init];
        
        [self addConfigFileName:@"config.json"];
    }

    return self;
}
-(void)addConfigFileName:(NSString *)configName
{
    if([configName isKindOfClass:[NSString class]] && configName.length)
    {
        [_configFileNames addObject:configName];
        
        NSString *themeConfigFilePath = [[NSBundle mainBundle] pathForResource:configName ofType:nil];
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:themeConfigFilePath];
        if (jsonData)
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            NSDictionary *colors = dict[@"color"];
            [colors enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                _defaultThemeColorDict[key] = [UIColor imy_colorWithHexString:obj];
            }];
        }
        
        [self resetThemeValues];
    }
}
- (NSString *)imageResourcePathForKey:(NSString *)key
{
    return [self resourcePathForKey:key loadMain:YES];
}

///如果主题路径没找到 是否去 主路径上找
- (NSString *)resourcePathForKey:(NSString *)key loadMain:(BOOL)loadMain
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *resourcePath = [_themePath stringByAppendingPathComponent:key];
    BOOL fileExist = [fileManager fileExistsAtPath:resourcePath];
    if (!fileExist && loadMain)
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
    [[NSUserDefaults standardUserDefaults] synchronize];
   
    [self resetThemeValues];
}


- (void)resetThemeValues
{
    [self.colorDict removeAllObjects];
    
    for (NSString* configName in _configFileNames)
    {
        NSString *themeConfigFilePath = [self resourcePathForKey:configName loadMain:NO];
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:themeConfigFilePath];
        if (!jsonData)
        {
            break;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        NSDictionary *colors = dict[@"color"];
        [colors enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            _colorDict[key] = [UIColor imy_colorWithHexString:obj];
        }];
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(themeDidChanged) object:nil];
    [self performSelectorOnMainThread:@selector(themeDidChanged) withObject:nil waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
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
    
    SEL sel = @selector(themeDidChanged);
    [_observers.allObjects bk_each:^(id obj) {
        if ([obj respondsToSelector:sel])
        {
            [obj themeDidChanged];
        }
    }];
}

@end