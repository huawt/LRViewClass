
#import "LRNavigationBar.h"
#import "LRUISize.h"

@implementation LRNavigationBar

- (void)layoutSubviews {
    [super layoutSubviews];
    if (@available(iOS 11.0, *)) {
        UIView *backgroundView = nil;
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                backgroundView = view;
                break;
            }
        }
        if (backgroundView) {
            backgroundView.frame = CGRectMake(0, -kStatusBarHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) + kStatusBarHeight);
        }
    }
}

@end
