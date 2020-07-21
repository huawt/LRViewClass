
#import <UIKit/UIKit.h>

/**
 导航控制器
 */
@interface LRNavigationController : UINavigationController<UINavigationControllerDelegate>

/// 删除导航栏底部黑线
- (void)deleteNavigationBarBottomLine;

/// 设置导航条标题颜色
- (void)setNavigationBarTitleColor:(UIColor *)titleColor;

/// 设置导航条标题字体
- (void)setNavigationBarTitleFont:(UIFont *)titleFont;

@end
