//
// Created by Ivan on 15/3/30.
//
//


#import "NSString+IMY_Theme.h"


@implementation NSString (IMY_Theme)

static NSString *BundleExecutableName = nil;
static NSString *Home_Prefix = @"Containers/Data/Application/";

+ (instancetype)BundleExecutableName
{
    if (!BundleExecutableName)
    {
        BundleExecutableName = [NSString stringWithFormat:@"%@.app", [[NSBundle mainBundle] infoDictionary][(__bridge id) kCFBundleExecutableKey]];
    }
    return BundleExecutableName;
}

- (NSString *)imy_relativePath;
{
    NSString *relativePath = nil;
    NSRange range = [self rangeOfString:[NSString BundleExecutableName]];
    if (range.location == NSNotFound)
    {
        range = [self rangeOfString:Home_Prefix];
    }
    if (range.location != NSNotFound)
    {
        NSUInteger index = range.length + range.location + 1;
        if (self.length > index - 1)
        {
            relativePath = [self substringFromIndex:index];
        }
    }
    return relativePath;
}

- (NSString *)imy_fullPath
{
    NSString *relativePath = self.imy_relativePath;
    if (!relativePath)
    {
        relativePath = [[NSString alloc] initWithString:self];
    }

    NSString *fullPath = [NSHomeDirectory() stringByAppendingPathComponent:relativePath];
    if (!fullPath.imy_exist)
    {
        fullPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:relativePath];
    }
    return fullPath.imy_exist ? fullPath : nil;
}

- (BOOL)imy_exist
{
    return [[NSFileManager defaultManager] fileExistsAtPath:self];
}


@end