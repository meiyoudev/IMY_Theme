//
// Created by Ivan on 15/3/23.
//
//


#import "IMYInvocation.h"
#import "NSArray+BlocksKit.h"
#import "ObjcAssociatedObjectHelpers.h"

@implementation NSInvocation(IMYTheme)
SYNTHESIZE_ASC_OBJ(key, setKey)
@end

@interface IMYInvocation ()
@property(nonatomic, strong) NSMutableDictionary *selDict;
@end

@implementation IMYInvocation

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _selDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (BOOL)shouldAddInvocation:(NSInteger)state andCMD:(SEL)cmd key:(NSString *)key
{
    NSString *selString = NSStringFromSelector(cmd);
    NSMutableDictionary *dict = _selDict[selString];
    NSInvocation *invocation = dict[@(state)];
    if (!invocation)
    {
        return YES;
    }
    else
    {
        return ![invocation.key isEqualToString:key];
    }
}

-(void)removeAddInvocationForState:(NSInteger)state andCMD:(SEL)cmd
{
    NSString *selString = NSStringFromSelector(cmd);
    NSMutableDictionary *dict = _selDict[selString];
    dict[@(state)] = nil;
}

- (void)addInvocation:(NSInvocation *)invocation cmd:(SEL)cmd forState:(NSInteger)state andKey:(NSString *)key
{
    NSMutableDictionary *mapTable = [self dictOfSEL:cmd];
    invocation.key = key;
    mapTable[@(state)] = invocation;
}


- (NSMutableDictionary *)dictOfSEL:(SEL)sel
{
    NSString *selString = NSStringFromSelector(sel);
    NSMutableDictionary *dict = _selDict[selString];
    if (!dict)
    {
        dict = [[NSMutableDictionary alloc] init];
        _selDict[selString] = dict;
    }
    return dict;
}


- (void)invoke
{
    [_selDict.allValues bk_each:^(NSDictionary *dictionary) {
        [dictionary.allValues makeObjectsPerformSelector:@selector(invoke)];
    }];
}

- (void)dealloc
{
    NSLog(@"MYI");
}

@end