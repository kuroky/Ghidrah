//
//  UIButton+EMAdd.m
//  Emucoo
//
//  Created by kuroky on 2018/8/30.
//  Copyright © 2018年 Emucoo. All rights reserved.
//

#import "UIButton+EMAdd.h"
#import <objc/runtime.h>

static NSString *KActionBlockKey;

@implementation UIButton (EMAdd)

- (void)handleControlEvent:(ActionBlock)block {
    [self addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(self, &KActionBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)tapAction:(UIButton *)sender {
    ActionBlock block = objc_getAssociatedObject(self, &KActionBlockKey);
    block ? block(sender) : nil;
}

@end
