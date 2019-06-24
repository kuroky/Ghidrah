//
//  UIViewController+EMAdd.h
//  Emucoo
//
//  Created by kuroky on 2017/7/18.
//  Copyright © 2017年 Emucoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (EMAdd)

/**
 是否禁止侧滑返回 YES:禁止 NO:不禁止
 */
@property (nonatomic, assign) BOOL em_interactivePopDisabled;

/**
 A->B->C->D, A为rootController
 
 fromViewController->targetViewContrller 转为 rootController->targetViewContrller
 
 @param targetViewContrller 目标vc
 @param fromViewController 跳转vc nil时表示当前viewcontroller
 @param ignoreNames 忽略的VC classname
 */
- (void)em_pushViewController:(UIViewController *)targetViewContrller
           fromViewController:(UIViewController *)fromViewController
        ignoreViewControllers:(NSArray <NSString *> *)ignoreNames;

/**
 当前屏幕显示的ViewController

 @return UIViewController
 */
+ (UIViewController *)em_currentViewController;

@end
