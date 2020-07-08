
#import "LRUISize.h"
#import <UIKit/UIKit.h>

CGFloat kStatusBarHeight = 20.0f;
CGFloat kNavigationBarHeight = 44.0f;
CGFloat kTabBarOffset = 0;
CGFloat kTabBarHeight = 49;
CGFloat kStatusBarOffset = 0;
CGFloat kFinalTopHeight = (20.0f + 44.0f);
CGFloat kUIWidth = 0.0f;
CGFloat kUIHeight = 0.0f;
BOOL kIsIPhoneX = NO;

@implementation LRUISize

+ (void)load
{
    kIsIPhoneX = [self judgeIsIPhoneX];
    if (kIsIPhoneX) {
        kStatusBarHeight = 44.0f;
        kNavigationBarHeight = 44.0f;
        kTabBarOffset = 34.0f;
        kTabBarHeight = 49.0 + 34.0f;
        kStatusBarOffset = 24.0f;
        kFinalTopHeight = (kStatusBarHeight + kNavigationBarHeight);
    }else{
        kStatusBarHeight = 20.0f;
        kNavigationBarHeight = 44.0f;
        kTabBarOffset = 0;
        kTabBarHeight = 49.0;
        kStatusBarOffset = 0;
        kFinalTopHeight = (kStatusBarHeight + kNavigationBarHeight);
    }
    kUIWidth = [UIScreen mainScreen].bounds.size.width;
    kUIHeight = [UIScreen mainScreen].bounds.size.height;
}

+ (BOOL)judgeIsIPhoneX
{
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        if (window.safeAreaInsets.left > 0 || window.safeAreaInsets.bottom > 0) {
            return YES;
        }
    }
    return NO;
}

BOOL kIsiPhone(void){
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return YES;
    }
    return NO;
}
BOOL kIsiPad(void){
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return NO;
}

BOOL IsIPhoneX(void){
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        if (window.safeAreaInsets.left > 0 || window.safeAreaInsets.bottom > 0) {
            return YES;
        }
    }
    return NO;
}

UIImage *RefactorImage(UIImage *image, CGSize size)
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);//防止模糊化
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
