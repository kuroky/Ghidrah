//
//  UIViewController+EMAdd.m
//  Emucoo
//
//  Created by kuroky on 2017/7/18.
//  Copyright © 2017年 Emucoo. All rights reserved.
//

#import "UIViewController+EMAdd.h"
#import <objc/runtime.h>

@implementation UIViewController (EMAdd)

- (BOOL)em_interactivePopDisabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setEm_interactivePopDisabled:(BOOL)disabled {
    objc_setAssociatedObject(self, @selector(em_interactivePopDisabled), @(disabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)em_pushViewController:(UIViewController *)targetViewContrller
           fromViewController:(UIViewController *)fromViewController
        ignoreViewControllers:(NSArray <NSString *> *)ignoreNames; {
    if (!fromViewController) {
        fromViewController = self;
    }
    [fromViewController.navigationController pushViewController:targetViewContrller animated:YES];
    NSArray *arr = fromViewController.navigationController.viewControllers;
    NSMutableArray *viewControllers = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *className = NSStringFromClass([obj class]);
        if (![ignoreNames containsObject:className]) {
            [viewControllers addObject:obj];
        }
    }];
    [fromViewController.navigationController setViewControllers:viewControllers animated:NO];
}

+ (UIViewController *)em_currentViewController {
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
        return vc;
    }
    return vc;
}

@end
