//
//  GHProgressHUD.h
//  Emucoo
//
//  Created by kuroky on 2017/6/19.
//  Copyright © 2017年 Emucoo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 基于'MBProgressHUD'的提示框
 */
@interface GHProgressHUD : NSObject

/**
 提示框

 @return EMProgressHUD
 */
+ (GHProgressHUD *)sharedHUD;

/**
 *  显示简单的HUD
 *
 *  @param title 提示的title
 *  @param hold @YES, 停止UI操作; @NO, 允许用户其他UI操作
 */
- (void)showHUDWithTitle:(NSString *)title
            cancelAction:(void (^)(UIButton *sender))completion;

/**
 *  隐藏HUD
 */
- (void)hideHUD;

/**
 *  显示有title的toast (默认在view底部,键盘弹出时在中间)
 *
 *  @param title 提示的title
 */
- (void)toastTitle:(NSString *)title;

/**
 *  alertController, 无响应事件
 *
 *  @param title       标题
 *  @param buttonTitle 按钮
 *
 */
- (void)alertTitle:(NSString *)title
        withButton:(NSString *)buttonTitle;

/**
 *  带有响应事件的alertController
 *
 *  @param title             标题
 *  @param message           提示信息
 *  @param cancelButtonTitle 取消按钮
 *  @param otherButtonTitle  确定按钮
 *  @param handler           事件handler
 *
 */
- (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle
      otherButtonTitle:(NSString *)otherButtonTitle
         actionHandler:(void(^)(UIAlertAction *action))handler;

/**
 *  带有响应事件的ActionSheet
 *
 *  @param title                  标题
 *  @param message                提示信息
 *  @param cancelButtonTitle      取消按钮
 *  @param destructiveButtonTitle 相消按钮
 *  @param handler                事件handler
 *  @param otherButtonTitles      其他按钮
 *
 */
- (void)actionSheetWithTitle:(NSString *)title
                     message:(NSString *)message
           cancelButtonTitle:(NSString *)cancelButtonTitle
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
               actionHandler:(void(^)(UIAlertAction *action))handler
           otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
