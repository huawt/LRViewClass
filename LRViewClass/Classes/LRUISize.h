
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

extern CGFloat kStatusBarHeight;
extern CGFloat kNavigationBarHeight;
extern CGFloat kTabBarOffset;
extern CGFloat kTabBarHeight;
extern CGFloat kStatusBarOffset;
extern CGFloat kFinalTopHeight;
extern CGFloat kUIWidth;
extern CGFloat kUIHeight;
extern BOOL kIsIPhoneX;

NS_ASSUME_NONNULL_BEGIN

@interface LRUISize : NSObject

/**
是否是 刘海屏
*/
+ (BOOL)judgeIsIPhoneX;
/**
 是否是 iPhone
 */
BOOL kIsiPhone(void);
/**
 是否是 iPad
 */
BOOL kIsiPad(void);
/**
是否是 刘海屏
*/
BOOL IsIPhoneX(void);

UIImage *RefactorImage(UIImage *image, CGSize size);

@end

NS_ASSUME_NONNULL_END
