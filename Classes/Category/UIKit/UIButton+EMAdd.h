//
//  UIButton+EMAdd.h
//  Emucoo
//
//  Created by kuroky on 2018/8/30.
//  Copyright © 2018年 Emucoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(UIButton *sender);

@interface UIButton (EMAdd)

- (void)handleControlEvent:(ActionBlock)block;

@end
