
#import <UIKit/UIKit.h>
#import "ControllerPopByInteractivePopGestureRecognizer.h"


typedef NS_OPTIONS(NSInteger, LRNavigationBarBackgroundImageStyle) {
    LRNavigationBarBackgroundImageStyle_Default = 1,
    LRNavigationBarBackgroundImageStyle_Clear = 1 << 1,
};

/**
 拦截左侧返回按钮
 */
@protocol LRLeftBarrierDelegate <NSObject>

@optional

/**
 返回代理
 */
- (void)goBackListener;

@end


/**
 基类控制器
 */
@interface LRViewController : UIViewController< ControllerPopByInteractivePopGestureRecognizer>

/**
 是否使用滑动返回
 */
@property (nonatomic, assign) BOOL interactivePopGestureRecognizerEnabled;

/**
 默认返回按钮
 */
@property (nonatomic, strong) UIButton *navLeftBtn;

/**
 返回按钮的拦截代理
 */
@property (weak, nonatomic) id<LRLeftBarrierDelegate> baseNavDelegate;

/**
 页面出现时间
 */
@property (nonatomic, assign) int64_t viewAppearTime;

/**
 页面消失时间
 */
@property (nonatomic, assign) int64_t viewDisappearTime;

/**
 子类页面在显示时是否自定义导航栏的显示/隐藏
 */
@property (nonatomic, assign) BOOL customNavigationBarHiddenWhenAppear;

@property (nonatomic, assign) LRNavigationBarBackgroundImageStyle naviBarImageStyle;

#pragma mark - 设置导航条

/**
 生成默认的返回按钮
 */
UIButton *DefaultLeftButton(NSInteger fontSize, UIColor *normalColor, UIColor *highlightColor);

/**
 左侧按钮组设置
 */
- (void)setNavigationBarLeftItems:(NSArray *)leftItems;

/**
 自定义左侧按钮
 */
- (void)createLeftBtnItemWithCustomView:(UIView*)customView;

/**
 创建默认的左侧按钮
 */
- (void)createLeftBtnItem;
/**
 创建默认的左侧按钮
 */
- (void)createLeftWhiteBtnItem;

/**
 清除左侧按钮
 */
- (void)removeNavigationBarLeftItems;

/**
 右侧按钮组设置
 */
- (void)setNavigationBarRightItems:(NSArray *)rightItems;

/**
 创建自定义右侧按钮
 */
- (void)createRightBtnItemWithCustomView:(UIView*)customView;
/**
 清除右侧按钮
 */
- (void)removeNavigationBarRightItems;

/**
 通过文字,字体,颜色设置导航条标题
 */
- (void)setNavigationBarTitle:(NSString*)title font:(UIFont*)font color:(UIColor*)color;

/**
 通过自定义View设置导航条标题
 */
- (void)createTitleView:(UIView*)titleView;

#pragma mark -- 设置导航条背景色

/**
 导航默认色
 */
- (void)setNavigationBarDefaultBackgroundImage;

/**
 重置导航图片
 */
- (void)revertNavigationBarDefaultBackgroundImage;

/**
 导航无色
 */
- (void)setNavigationBarClearBackgroundImage;

/**
 配置默认图片
 */
+ (void)configureDefaultNavigationBarBackgroundImage:(NSString *)imageName;

#pragma mark - 返回检查

/**
 默认的返回按钮操作
 */
- (void)leftAction:(UIButton *)btn;

/**
 滑动返回监听
 */
- (void)controllerPopByInteractivePopGestureRecognizer;

@end
