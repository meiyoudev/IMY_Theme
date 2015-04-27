# IMY_Theme
	Q:为什么要写这个东西?
	A:因为我们产品上线一年多了,产品那边忽然来了一个换肤的需求,所以不得考虑一个比较廉价的换肤方式.
	
	Q:有用到第三方库吗?
	A:当然有,用到的库详见Podfile或IMY_Theme.podspec.json 当然你可以修改代码来解除对这些库的依赖.
	
<hr />	
#我们来看看效果
![](Untitled.gif)
#使用方法
	UINavigationBar+IMY_Theme.h
	- (void)imy_setBackgroundImageWithKey:(NSString *)key forBarMetrics:(UIBarMetrics)barMetrics;
	
	UITabBarItem+IMY_Theme
	- (void)imy_setFinishedSelectedImageName:(NSString *)selectedImageName withFinishedUnselectedImageName:(NSString *)unselectedImageName;

	UIButton+IMY_Theme
	- (void)imy_setImageForKey:(NSString *)key andState:(UIControlState)state;

	- (void)imy_setImageForKey:(NSString *)key andState:(UIControlState)state stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

	- (void)imy_setCenterResizeImageForKey:(NSString *)key andState:(UIControlState)state;

	- (void)imy_setBackgroundImageForKey:(NSString *)key andState:(UIControlState)state;

	- (void)imy_setCenterResiseBackgroudImageForKey:(NSString *)key andState:(UIControlState)state;

	- (void)imy_setBackgroudImageForKey:(NSString *)key stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight forState:(UIControlState)state;

	- (void)imy_setTitleColorForKey:(NSString *)key andState:(UIControlState)state;

	UIImageView+IMY_Theme
	- (void)imy_setImageForKey:(NSString *)key;

	- (void)imy_setHighlightedImageForKey:(NSString *)key;

	- (void)imy_setImageForKey:(NSString *)key stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

	- (void)imy_setHighlightedImageForKey:(NSString *)key stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

	- (void)imy_setCenterResizeImageForKey:(NSString *)key;

	- (void)imy_setCenterResizeHighlightedImageForKey:(NSString *)key;

	背景颜色和文字相关的
	@interface UIView (IMY_Theme_BackgroundColor)//请忽略这个category的名字
	- (void)imy_setBackgroundColorForKey:(NSString *)key;

	- (void)imy_setTextColorForKey:(NSString *)key;

	- (void)imy_setHighlightedTextColorForKey:(NSString *)key;
	@end
	
	还有另外一种方式,详见Demo,适用于所有的NSObject