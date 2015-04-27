//
// Created by Ivan on 15/3/20.
//
//


#import "UIImage+IMY_Theme.h"
#import "IMYThemeManager.h"
#import "IMYThemeImageCache.h"


@implementation UIImage (IMY_Theme)

+ (instancetype)imy_imageForKey:(NSString *)key
{
    return [self imy_imageForKey:key usingCache:YES];
}

+ (instancetype)imy_imageForKey:(NSString *)key usingCache:(BOOL)usingCache
{
    //获取后缀，如果没有后缀，就拼接上png，也就是说，除了png可以不写，其他的都要写。
    NSString *ext = key.pathExtension;
    if (ext.length == 0 || !ext)
    {
        key = [key stringByAppendingPathExtension:@"png"];
    }
    //获取资源的路径，如果皮肤包内没有的话，就用mainBundle里面的
    NSString *imagePath = [[IMYThemeManager sharedIMYThemeManager] imageResourcePathForKey:key];
    //从缓存里面先拿，拿不到再去读
    UIImage *image = [[IMYThemeImageCache sharedIMYThemeImageCache] objectForKey:key];
    if (!image)
    {
        image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    }
    if (usingCache)
    {
//        [[IMYThemeImageCache sharedIMYThemeImageCache] setObject:image forKey:key];
    }
    return image;
}

- (instancetype)imy_resizableImageCenter
{
    CGSize imageSize = self.size;
    CGFloat centerX = imageSize.width / 2;
    CGFloat centerY = imageSize.height / 2;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(centerY - 0.5f, centerX - 0.5f, centerY + 0.5f, centerX + 0.5f);
    return [self resizableImageWithCapInsets:edgeInsets];
}

@end