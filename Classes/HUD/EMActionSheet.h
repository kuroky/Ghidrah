//
//  EMActionSheet.h
//  Emucoo
//
//  Created by kuroky on 2017/7/20.
//  Copyright © 2017年 Emucoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PopSheetActionHandler)(NSString *title, NSInteger idx);
extern NSInteger const EMPopSheetCancel;

@interface EMActionSheet : UIView

/**
 *  选择sheet
 *
 *  @param view         parentView
 *  @param buttonTitles button titles
 *
 *  @return EMActionSheet
 */
+ (EMActionSheet *)showPopSheet:(UIView *)view
                   buttonTitles:(NSArray *)buttonTitles;

/**
 sheet 回调
 
 @param handler 回调handler
 */
- (void)showPopSheetWithAction:(PopSheetActionHandler)handler;

@end
