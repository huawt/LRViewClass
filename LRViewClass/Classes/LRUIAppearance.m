//
//  LRUIAppearance.m
//  LRViewClass
//
//  Created by WinTer on 2020/12/17.
//

#import "LRUIAppearance.h"

@implementation LRUIAppearance

+ (instancetype)appearance
{
    static dispatch_once_t __singletonToken;
    static id __singleton__;
    dispatch_once( &__singletonToken, ^{ __singleton__ = [[self alloc] initPrivate]; } );
    return __singleton__;
}
- (instancetype)init
{
    NSAssert(NO, @"");
    return nil;
}
- (instancetype)initPrivate
{
    if (self = [super init]) {
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}

@end
