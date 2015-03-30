//
// Created by Ivan on 15/3/23.
//
//


#import "IMYInvocation.h"
#import "NSArray+BlocksKit.h"

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

- (BOOL)hasAddInvocationForState:(NSInteger)state andCMD:(SEL)cmd
{
    NSString *selString = NSStringFromSelector(cmd);
    NSMutableDictionary *dict = _selDict[selString];
    return dict[@(state)] != nil;
}


- (void)addInvocation:(NSInvocation *)invocation cmd:(SEL)cmd forState:(NSInteger)state
{
    NSMutableDictionary *mapTable = [self dictOfSEL:cmd];
    if (!mapTable[@(state)])
    {
        mapTable[@(state)] = invocation;
    }
}

- (void)forceAddInvocation:(NSInvocation *)invocation cmd:(SEL)cmd forState:(NSInteger)state
{
    NSMutableDictionary *mapTable = [self dictOfSEL:cmd];
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


@end