//
//  GHLaunchConfig.m
//  AFNetworking
//
//  Created by kuroky on 2019/6/20.
//

#import "GHLaunchConfig.h"

#if __has_include(<GHNetwork/GHNetwork.h>)
#import <GHNetwork/GHNetworkManager.h>
#import <GHNetwork/GHNetworkConfig.h>
#else
#import "GHNetworkConfig.h"
#import "GHNetworkManager.h"
#endif

#if __has_include(<IQKeyboardManager/IQKeyboardManager.h>)
#import <IQKeyboardManager/IQKeyboardManager.h>
#else
#import "IQKeyboardManager.h"
#endif

#import "GHLogFormatter.h"
#if __has_include(<CocoaLumberjack/CocoaLumberjack.h>)
#import <CocoaLumberjack/CocoaLumberjack.h>
#else
#import "CocoaLumberjack.h"
#endif

@implementation GHLaunchConfig

+ (void)gh_launch {
    [[DDTTYLogger sharedInstance] setLogFormatter:[GHLogFormatter new]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
}

+ (void)gh_setupNetwork:(NSString *)url
               security:(nullable AFSecurityPolicy *)securityPolicy
               delegate:(id <GHNetworkHandleDelegate>)delegate {
    GHNetworkConfig *config = [GHNetworkConfig new];
    config.baseUrl = url;
    config.securityPolicy = securityPolicy;
    [[GHNetworkManager sharedManager] addConfig:config];
    [[GHNetworkManager sharedManager] configHandleDelegate:delegate];
}

@end
