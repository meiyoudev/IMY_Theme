//
// Created by Ivan on 15/3/24.
//
//


#import <objc/message.h>
#import <BlocksKit/NSInvocation+BlocksKit.h>
#import "UIImageView+IMY_WebImage.h"
#import "ObjcAssociatedObjectHelpers.h"
#import "UIImage+IMY_Theme.h"
#import "UIImageView+WebCache.h"
#import "ReactiveCocoa.h"
#import "View+MASAdditions.h"
#import "GCDQueue.h"
#import "Aspects.h"
#import "NSArray+BlocksKit.h"
#import "UIGestureRecognizer+BlocksKit.h"
#import "GCDMacros.h"

typedef NS_ENUM(NSInteger, IMY_WebImageState)
{
IMY_WebImageDownloading = 0,
        IMY_WebImageDownloadSucceed,
        IMY_WebImageDownloadFailed
};

@interface UIImageView (IMY_WebImage_Private)
@property IMY_WebImageState webImageState;
@property UIViewContentMode displayContentMode;
@property CGFloat imy_downloadProgress;
@property BOOL imy_setup;
@property(strong) UITapGestureRecognizer *originalTap;
@property(strong) UITapGestureRecognizer *failureTap;
@end

@implementation UIImageView (IMY_WebImage)

SYNTHESIZE_ASC_PRIMITIVE(webImageState, setWebImageState, IMY_WebImageState)

SYNTHESIZE_ASC_PRIMITIVE(downloadContentMode, setDownloadContentMode, UIViewContentMode)

SYNTHESIZE_ASC_PRIMITIVE(displayContentMode, setDisplayContentMode, UIViewContentMode)

SYNTHESIZE_ASC_PRIMITIVE(failureContentMode, setFailureContentMode, UIViewContentMode)

SYNTHESIZE_ASC_PRIMITIVE(showProgress, setShowProgress, BOOL)

SYNTHESIZE_ASC_OBJ(placeholderImageName, setPlaceholderImageName)

SYNTHESIZE_ASC_OBJ(failureImageName, setFailureImageName)

SYNTHESIZE_ASC_PRIMITIVE(imy_downloadProgress, setImy_downloadProgress, CGFloat)

SYNTHESIZE_ASC_OBJ(progressView, setProgressView)

SYNTHESIZE_ASC_PRIMITIVE(imy_setup, setImy_setup, BOOL)

SYNTHESIZE_ASC_OBJ(originalTap, setOriginalTap)

SYNTHESIZE_ASC_OBJ(failureTap, setFailureTap)

SYNTHESIZE_ASC_OBJ(backgroundColorKey, setBackgroundColorKey)


- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imy_setup)
    {
        [self imy_setBackgroundColorForKey:self.backgroundColorKey];
        [self imy_themeChanged];
    }
}


+ (void)load
{
    [[UIImageView appearance] setFailureContentMode:UIViewContentModeCenter];
    [[UIImageView appearance] setDownloadContentMode:UIViewContentModeCenter];

    [UIImageView aspect_hookSelector:@selector(setContentMode:) withOptions:AspectPositionAfter usingBlock:^(id <AspectInfo> aspectInfo, UIViewContentMode viewContentMode) {
        UIImageView *imageView = (UIImageView *) aspectInfo.instance;
        imageView.displayContentMode = viewContentMode;
    } error:nil];

    [UIImageView aspect_hookSelector:@selector(addGestureRecognizer:) withOptions:AspectPositionAfter usingBlock:^(id <AspectInfo> aspectInfo, UIGestureRecognizer *gestureRecognizer) {
        UIImageView *imageView = (UIImageView *) aspectInfo.instance;
        if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
        {
            imageView.originalTap = (UITapGestureRecognizer *) gestureRecognizer;
        }
    } error:nil];

    [UIImageView aspect_hookSelector:@selector(setProgressView:) withOptions:AspectPositionAfter usingBlock:^(id <AspectInfo> aspectInfo, UIView *progressView) {
        __weak UIImageView *imageView = (UIImageView *) aspectInfo.instance;
        if (progressView)
        {
            [imageView addSubview:progressView];
            [progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(imageView);
                make.height.mas_equalTo(10);
                make.left.equalTo(imageView).offset(5);
                make.right.equalTo(imageView).offset(-5);
            }];
        }
    } error:nil];
}

- (void)imy_setImageURL:(id)URL
{
    [[GCDQueue mainQueue] queueBlock:^{
        [self prePareDownload];
        self.contentMode = self.imy_contentMode;
        [self sd_setImageWithURL:URL placeholderImage:self.imy_placeholderImage options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            [[GCDQueue mainQueue] queueBlock:^{
                self.imy_downloadProgress = MAX(0, MIN(1, receivedSize / (CGFloat) expectedSize));
            }];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error && image)
            {
                self.webImageState = IMY_WebImageDownloadSucceed;
                self.image = image;
            }
            else
            {
                NSLog(@"error = %@", error);
                self.webImageState = IMY_WebImageDownloadFailed;
            }
            self.contentMode = self.imy_contentMode;
            [self imy_setupTap];
        }];
    }];
}

- (void)imy_setImageURL:(id)URL quality:(NSInteger)quality
{
    [self imy_setImageURL:URL resise:CGSizeZero quality:quality];
}

- (void)imy_setImageURL:(id)URL resise:(CGSize)size
{
    [self imy_setImageURL:URL resise:size quality:0];
}

- (void)imy_setImageURL:(id)URL resise:(CGSize)size quality:(NSInteger)quality
{
    [self imy_setImageURL:URL resise:size quality:quality type:IMY_QiNiu_None];
}

- (void)imy_setImageURL:(id)URL resise:(CGSize)size quality:(NSInteger)quality type:(IMY_QiNiu_ImageType)type
{
    NSString *URLString = [NSString qiniuURL:URL resize:size quality:quality type:type];
    [self imy_setImageURL:URLString];
}


- (UIImage *)imy_placeholderImage
{
    if (self.showProgress)
    {
        return nil;
    }
    return [UIImage imy_imageForKey:self.placeholderImageName];
}

- (UIImage *)imy_failureImage
{
    return [UIImage imy_imageForKey:self.failureImageName];
}

- (void)imy_themeChanged
{
    switch (self.webImageState)
    {
        case IMY_WebImageDownloading:
        {
            if (!self.showProgress)
            {
                self.image = self.imy_placeholderImage;
            }
            break;
        }
        case IMY_WebImageDownloadFailed:
        {
            self.image = self.imy_failureImage;
            break;
        }
        default:
        {

        }
    }
}

- (void)prePareDownload
{
    @synchronized (self)
    {
        @weakify(self)
        [self sd_cancelCurrentImageLoad];
        self.webImageState = IMY_WebImageDownloading;
        self.imy_downloadProgress = 0;
        if (!self.imy_setup)
        {
            self.imy_setup = YES;
            [self addToThemeChangeObserver];
            self.failureTap = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
                @strongify(self)
                if (self.webImageState == IMY_WebImageDownloadFailed)
                {
                    [self imy_setImageURL:self.sd_imageURL];
                }
            }];

            self.displayContentMode = self.contentMode;
            self.originalTap = [self.gestureRecognizers bk_match:^BOOL(UIGestureRecognizer *gestureRecognizer) {
                return [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]];
            }];
            [RACObserve(self, self.imy_downloadProgress) subscribeNext:^(NSNumber *x) {
                @strongify(self)
                __block float progress = x.floatValue;
                static SEL animatedSel = nil;
                static SEL sel = nil;
                GCDExecOnce(^{
                    animatedSel = @selector(setProgress:animated:);
                    sel = @selector(setProgress:);

                })
                if ([self.progressView respondsToSelector:animatedSel])
                {
                    [[NSInvocation bk_invocationWithTarget:self.progressView block:^(id target) {

                        [target setProgress:progress animated:YES];
                    }] invoke];
                }
                else if ([self.progressView respondsToSelector:sel])
                {
                    [[NSInvocation bk_invocationWithTarget:self.progressView block:^(id target) {
                        [target setProgress:progress];
                    }] invoke];
                }
            }];

            [[RACObserve(self, self.webImageState) skip:1] subscribeNext:^(NSNumber *x) {
                @strongify(self)
                self.progressView.hidden = self.webImageState != IMY_WebImageDownloading;
                [self imy_themeChanged];
            }];

            [RACObserve(self, self.showProgress) subscribeNext:^(id x) {
                @strongify(self)
                dispatch_main_async_safe(^{
                    if ([x boolValue])
                    {
                        self.imy_setupProgressView;
                    }
                    else
                    {
                        [self.progressView removeFromSuperview];
                    }
                })
            }];
        }
        [self imy_setupTap];
    }
}

- (UIViewContentMode)imy_contentMode
{
    switch (self.webImageState)
    {
        case IMY_WebImageDownloading:
        {
             return self.downloadContentMode;
        }
        case IMY_WebImageDownloadFailed:
        {
            return self.failureContentMode;
        }
        default:
        {
            return self.displayContentMode;
        }
    }

}

- (id)imy_setupProgressView
{
    if (!self.progressView)
    {
        self.progressView = (id) [[UIProgressView alloc] init];
        [self addSubview:self.progressView];
        @weakify(self)
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.center.equalTo(self);
            make.height.mas_equalTo(10);
            make.left.equalTo(self).offset(5);
            make.right.equalTo(self).offset(-5);
        }];
    }
    return self.progressView;
}

- (void)imy_setupTap
{
    [self removeGestureRecognizer:self.failureTap];
    [self removeGestureRecognizer:self.originalTap];
    if (self.webImageState == IMY_WebImageDownloadSucceed)
    {
        if (self.originalTap)
        {
            [self addGestureRecognizer:self.originalTap];
        }
        else
        {
            self.userInteractionEnabled = NO;
        }
    }
    else if (self.webImageState == IMY_WebImageDownloadFailed)
    {
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:self.failureTap];
    }
    else if (self.webImageState == IMY_WebImageDownloading)
    {
        if (self.showProgress)
        {
            self.userInteractionEnabled = YES;
            [self addGestureRecognizer:self.failureTap];
        }
        else if (self.originalTap)
        {
            self.userInteractionEnabled = YES;
            [self addGestureRecognizer:self.originalTap];
        }
    }
}

@end