//
// Created by Ivan on 15/3/24.
//
//


#import "UITabBarItem+IMY_Theme.h"
#import "UIImage+IMY_Theme.h"
#import "NSObject+IMY_Theme.h"
#import "NSInvocation+BlocksKit.h"


@implementation UITabBarItem (IMY_Theme)
- (void)imy_setFinishedSelectedImageName:(NSString *)selectedImageName withFinishedUnselectedImageName:(NSString *)unselectedImageName
{
    UIImage *selectedImage = [UIImage imy_imageForKey:selectedImageName];
    UIImage *unSelectedImage = [UIImage imy_imageForKey:unselectedImageName];
    if ([selectedImage respondsToSelector:@selector(imageWithRenderingMode:)])
    {
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        unSelectedImage = [unSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [self setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unSelectedImage];
#pragma clang diagnostic pop
    IMYBlockWeakToWeakSelf
    [self addInvocationWithBlock:^NSInvocation * {
        return [NSInvocation bk_invocationWithTarget:weakSelf block:^(id target) {
            [target imy_setFinishedSelectedImageName:selectedImageName withFinishedUnselectedImageName:unselectedImageName];
        }];
    } andCMD:_cmd key:[selectedImageName stringByAppendingString:unselectedImageName]];
}
@end