//
//  GHProgressHUD.m
//  Emucoo
//
//  Created by kuroky on 2017/6/19.
//  Copyright © 2017年 Emucoo. All rights reserved.
//

#import "GHProgressHUD.h"
#import "MBProgressHUD.h"
#import "UIButton+EMAdd.h"

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }
#endif

static CGFloat const kDefaultToastOffSetY       =   200;    // 默认y轴: >0中心点以下, <0中心点以上
static CGFloat const kDefaultToastHideDelay     =   2.0;    //  默认2s后消失

@interface GHProgressHUD () <MBProgressHUDDelegate> {
    
    MBProgressHUD *_mbProgressHUD;
    MBProgressHUD *_toastHUD;
    
    BOOL _keyboardIsVisible; // 当前键盘显示状态
}

@end

@implementation GHProgressHUD

+ (instancetype)sharedHUD {
    static GHProgressHUD *hud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [GHProgressHUD new];
    });
    
    return hud;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - KeyBoadr NSNotification
- (void)setup {
    NSNotificationCenter *notifiationCenter = [NSNotificationCenter defaultCenter];
    [notifiationCenter addObserver:self
                          selector:@selector(keyboardDidShow)
                              name:UIKeyboardDidShowNotification
                            object:nil];
    [notifiationCenter addObserver:self
                          selector:@selector(keyboardDidHide)
                              name:UIKeyboardWillHideNotification
                            object:nil];
    _keyboardIsVisible = NO;
}

- (void)keyboardDidShow {
    _keyboardIsVisible = YES;
}

- (void)keyboardDidHide {
    _keyboardIsVisible = NO;
}

//MARK:- 显示简单的HUD (阻断UI操作)
- (void)showHUDWithTitle:(NSString *)title
            cancelAction:(void (^)(UIButton *sender))completion {
    if (_mbProgressHUD) {
        [self hideHUD];
    }
    
    dispatch_main_async_safe(^{
        UIView *pView = [self em_rootWindow];
        _mbProgressHUD = [MBProgressHUD showHUDAddedTo:pView
                                              animated:YES];
        _mbProgressHUD.contentColor = [UIColor whiteColor];
        _mbProgressHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        _mbProgressHUD.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
        _mbProgressHUD.label.text = title;
        if (completion) {
            [_mbProgressHUD.button setTitle:@"取消" forState:UIControlStateNormal];
            [_mbProgressHUD.button addTarget:self action:@selector(hideHUD) forControlEvents:UIControlEventTouchUpInside];
            [_mbProgressHUD.button handleControlEvent:completion];
        }
        _mbProgressHUD.userInteractionEnabled = YES;
    });
}

#pragma mark - 隐藏HUD
- (void)hideHUD {
    dispatch_main_async_safe(^{
        [_mbProgressHUD hideAnimated:YES];
        _mbProgressHUD = nil;
    });
}

#pragma mark - 显示有title的HUD
- (void)toastTitle:(NSString *)title {
    if (!title.length) {
        return;
    }
    
    [self hideHUD];
    
    if (_toastHUD) {
        dispatch_main_async_safe(^{
            [_toastHUD hideAnimated:YES];
            _toastHUD = nil;
        });
    }
    
    dispatch_main_async_safe(^{
        UIView *pView = [self em_rootWindow];
        _toastHUD = [self createToastHUD:pView hideDelay:kDefaultToastHideDelay];
        if (!_keyboardIsVisible) {
            _toastHUD.offset = CGPointMake(0.f, kDefaultToastOffSetY);
        }
        _toastHUD.detailsLabel.text = title;
    });
}

- (UIWindow *)em_rootWindow {
    return [UIApplication sharedApplication].windows.firstObject;
}

- (MBProgressHUD *)createToastHUD:(UIView *)pView
                        hideDelay:(CGFloat)delay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:pView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    hud.userInteractionEnabled = NO;
    hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [hud hideAnimated:YES afterDelay:delay];
    return hud;
}

#pragma mark - 返回一个带标题的alertController
- (void)alertTitle:(NSString *)title
        withButton:(NSString *)buttonTitle {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:@""
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    if (!buttonTitle || !buttonTitle.length) {
        buttonTitle = @"好的";
    }
    UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitle
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    [alertController addAction:action];
    [self presentAlertViewController:alertController];
}

#pragma mark - 带有相应事件的alertController
- (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle
      otherButtonTitle:(NSString *)otherButtonTitle
         actionHandler:(void(^)(UIAlertAction *action))handler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelButtonTitle && cancelButtonTitle.length) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           handler ? handler(action) : nil;
                                                       }];
        [alertController addAction:action];
    }
    
    if (otherButtonTitle && otherButtonTitle.length) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:otherButtonTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           handler ? handler(action) : nil;
                                                       }];
        [alertController addAction:action];
    }
    [self presentAlertViewController:alertController];
}

#pragma mark - 带有相应事件的ActionSheet
- (void)actionSheetWithTitle:(NSString *)title
                     message:(NSString *)message
           cancelButtonTitle:(NSString *)cancelButtonTitle
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
               actionHandler:(void(^)(UIAlertAction *action))handler
           otherButtonTitles:(NSString *)otherButtonTitles, ... {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (cancelButtonTitle && cancelButtonTitle.length) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           handler ? handler(action) : nil;
                                                       }];
        [alertController addAction:action];
    }
    
    if (destructiveButtonTitle && destructiveButtonTitle.length) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:destructiveButtonTitle
                                                         style:UIAlertActionStyleDestructive
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           handler ? handler(action) : nil;
                                                       }];
        [alertController addAction:action];
    }
    
    va_list args;
    va_start(args, otherButtonTitles);
    for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:arg
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           handler ? handler(action) : nil;
                                                       }];
        [alertController addAction:action];
    }
    va_end(args);
    
    [self presentAlertViewController:alertController];
}

- (void)presentAlertViewController:(UIAlertController *)alertController {
    UIViewController *rootVC = [self currentViewController];
    dispatch_main_async_safe(^{
        [rootVC presentViewController:alertController
                             animated:YES
                           completion:nil];
    });
}

- (UIViewController *)currentViewController {
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *)vc visibleViewController];
        } else if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    return vc;
}

@end
