//
//  UINavigationController+EMAdd.m
//  Emucoo
//
//  Created by kuroky on 2018/4/18.
//  Copyright © 2018年 Emucoo. All rights reserved.
//

#import "UINavigationController+EMAdd.h"

@implementation UINavigationController (EMAdd)

- (void)em_setNeedsNavigationBackground:(CGFloat)alpha {
    // 导航栏背景透明度设置
    UIView *barBackgroundView = [self.navigationBar subviews].firstObject;// _UIBarBackground
    UIImageView *backgroundImageView = [barBackgroundView subviews].firstObject;// UIImageView
    if (self.navigationBar.isTranslucent && [backgroundImageView isKindOfClass:[UIImageView class]]) {
        if (backgroundImageView != nil && backgroundImageView.image != nil) {
            barBackgroundView.alpha = alpha;
        } else {
            UIView *backgroundEffectView = barBackgroundView.subviews.count > 1 ? barBackgroundView.subviews[1] : nil;// UIVisualEffectView
            if (backgroundEffectView != nil) {
                backgroundEffectView.alpha = alpha;
            }
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
    
    self.navigationBar.clipsToBounds = alpha == 0.0;
}

@end
