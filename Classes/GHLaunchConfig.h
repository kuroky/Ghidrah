//
//  GHLaunchConfig.h
//  AFNetworking
//
//  Created by kuroky on 2019/6/20.
//

#import <Foundation/Foundation.h>
#import "GHNetworkHandleDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class AFSecurityPolicy;

@interface GHLaunchConfig : NSObject

+ (void)gh_launch;

/**
 网络层配置

 @param url 请求url
 @param securityPolicy https
 @param delegate 业务delegate
 */
+ (void)gh_setupNetwork:(NSString *)url
               security:(nullable AFSecurityPolicy *)securityPolicy
               delegate:(id <GHNetworkHandleDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
