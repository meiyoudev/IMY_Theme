//
// Created by Ivan on 15/3/25.
//
//


#import "NSString+IMY_WebImage.h"
#import "ObjcAssociatedObjectHelpers.h"


@implementation NSString (IMY_WebImage)

+ (NSString *)qiniuURL:(id)URL resize:(CGSize)size quality:(int)quality type:(IMY_QiNiu_ImageType)type
{
    NSString *urlString = nil;
    if ([URL isKindOfClass:[NSURL class]])
    {
        NSURL *url = (NSURL *) URL;
        urlString = url.absoluteString;
    }
    else if ([URL isKindOfClass:[NSString class]])
    {
        NSString *string = (NSString *) URL;
        urlString = string;
    }
    else
    {
        return nil;
    }
    NSMutableString *returnMe = [[NSMutableString alloc] initWithString:urlString];
    [returnMe appendString:@"?imageView2/1"];
    if (!CGSizeEqualToSize(CGSizeZero, size))
    {
        [returnMe appendFormat:@"/h/%d/w/%d", (int) size.height, (int) size.width];
    }
    if ((quality > 0 && quality < 100))
    {
        [returnMe appendFormat:@"/q/%d", quality];
    }
    if (type != IMY_QiNiu_None)
    {
        [returnMe appendFormat:@"/format/%@", IMY_QiNiuImageType(type)];
    }
    return returnMe;
}


@end