
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __has_include(<LRViewClass/LRViewClass.h>)

FOUNDATION_EXPORT double LRViewClassVersionNumber;
FOUNDATION_EXPORT const unsigned char LRViewClassVersionString[];

#import <LRViewClass/LRDefines.h>
#import <LRViewClass/LRUIAppearance.h>
#import <LRViewClass/LRUISize.h>
#import <LRViewClass/LRNavigationBar.h>
#import <LRViewClass/LRNavigationController.h>
#import <LRViewClass/LRViewController.h>
#import <LRViewClass/LRTabBarViewController.h>
#import <LRViewClass/ControllerPopByInteractivePopGestureRecognizer.h>

#else

#import "LRDefines.h"
#import "LRUIAppearance.h"
#import "LRUISize.h"
#import "LRNavigationBar.h"
#import "LRNavigationController.h"
#import "LRTabBarViewController.h"
#import "LRViewController.h"
#import "ControllerPopByInteractivePopGestureRecognizer.h"

#endif
