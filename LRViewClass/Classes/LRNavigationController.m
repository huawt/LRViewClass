
#import "LRNavigationController.h"
#import <QuickLook/QuickLook.h>
#import "LRUISize.h"
#import "LRViewController.h"
#import "LRNavigationBar.h"
#import "ControllerPopByInteractivePopGestureRecognizer.h"
#import "LRDefines.h"

@interface LRNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LRNavigationController

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
    return [super initWithNavigationBarClass:[LRNavigationBar class] toolbarClass:[UIToolbar class]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
        self.delegate = weakSelf;
    }
    
    self.delegate = self;
    [self deleteNavigationBarBottomLine];
    
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-bold" size:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationBar.tintColor = UIColor.whiteColor;
}

- (void)deleteNavigationBarBottomLine
{
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}

//#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //禁止滑动返回，感觉直接在baseViewControl中写一个是否允许返回的属性会更灵活一些
     if([viewController isKindOfClass:[QLPreviewController class]]){
        self.interactivePopGestureRecognizer.enabled = NO;
    }else if ([viewController isKindOfClass:[UITabBarController class]]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }else if ([viewController isKindOfClass:[LRViewController class]]) {
        self.interactivePopGestureRecognizer.enabled = ((LRViewController *)viewController).interactivePopGestureRecognizerEnabled;
    }else{
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator=navigationController.topViewController.transitionCoordinator;
    [transitionCoordinator notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        if (!context.isCancelled)
        {
            UIViewController *fromController = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
            if ([fromController respondsToSelector:@selector(controllerPopByInteractivePopGestureRecognizer)])
            {
                [fromController performSelector:@selector(controllerPopByInteractivePopGestureRecognizer) withObject:nil];
            }
        }
    }];

}

#pragma mark - 模仿push pop效果

#pragma mark - 添加 push时打印目标控制器名称
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }else{
        viewController.hidesBottomBarWhenPushed = NO;
    }
    DLog(@"Push viewController:%@", NSStringFromClass([viewController class]));
    [super pushViewController:viewController animated:animated];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //根视图禁止滑动返回
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] )
        {
            return NO;
        }
    }

    //返回动画时禁止返回
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    //手动禁用
    if ([self.visibleViewController isKindOfClass:[LRViewController class]]) {
        BOOL popByGestureEnabled = ((LRViewController *)self.visibleViewController).interactivePopGestureRecognizerEnabled;
        return popByGestureEnabled;
    }
    
    return YES;
}

@end
