//
// Created by Ivan on 15/4/3.
//
//


#import "Test.h"


@implementation Test
- (void)dealloc
{
    NSLog(@"%s", sel_getName(_cmd));
}
@end