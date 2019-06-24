//
//  GHLaunchConfig.m
//  AFNetworking
//
//  Created by kuroky on 2019/6/20.
//

#import "GHLaunchConfig.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "GHNetworkConfig.h"
#import "GHNetworkManager.h"
//#import "GHLogFormatter.h"
//#import <CocoaLumberjack/DDTTYLogger.h>

@implementation GHLaunchConfig

+ (void)gh_launch {
    
    //[[DDTTYLogger sharedInstance] setLogFormatter:[GHLogFormatter new]];
    

    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    //[[IQKeyboardManager sharedManager] ];
    
    
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
