//
// Created by Ivan Chua on 15/3/25.
// Copyright (c) 2015 MeiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IMY_QiNiu_ImageType)
{
    IMY_QiNiu_None = 0,
    IMY_QiNiu_JPG,
    IMY_QiNiu_PNG,
    IMY_QiNiu_WEBP,
    IMY_QiNiu_GIF
};

static inline NSString *IMY_QiNiuImageType(IMY_QiNiu_ImageType type) {
    switch (type)
    {
        case IMY_QiNiu_PNG:
        {
            return @"png";
        }
        case IMY_QiNiu_WEBP:
        {
            return @"webp";
        }
        case IMY_QiNiu_GIF:
        {
            return @"gif";
        }
        case IMY_QiNiu_JPG:
        {
            return @"jpg";
        }
        default:
        {
            return @"";
        }
    }
}


@interface NSString (IMY_WebImage)
+ (NSString *)qiniuURL:(id)URL resize:(CGSize)size quality:(NSInteger)quality type:(IMY_QiNiu_ImageType)type;
@end