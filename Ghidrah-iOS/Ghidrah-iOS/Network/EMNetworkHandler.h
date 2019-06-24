//
//  EMNetworkHandler.h
//  Emucoo
//
//  Created by kuroky on 2019/5/10.
//  Copyright © 2019 Emucoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GHNetworkHandleDelegate.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Http请求代理, 业务处理
 */
@interface EMNetworkHandler : NSObject <GHNetworkHandleDelegate>

+ (instancetype)handler;

@end

NS_ASSUME_NONNULL_END
