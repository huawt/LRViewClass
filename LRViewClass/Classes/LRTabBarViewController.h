
#import <UIKit/UIKit.h>

@protocol LRTabBarViewControllerDelegate <NSObject>

- (BOOL)LRTabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;

@end

@interface LRTabBarViewController : UITabBarController<UITabBarControllerDelegate>

@property (nonatomic, weak) id<LRTabBarViewControllerDelegate>baseDelegate;

@end
