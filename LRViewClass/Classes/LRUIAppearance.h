//
//  LRUIAppearance.h
//  LRViewClass
//
//  Created by WinTer on 2020/12/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRUIAppearance : NSObject

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle ;

+ (instancetype)appearance;

@end

NS_ASSUME_NONNULL_END
