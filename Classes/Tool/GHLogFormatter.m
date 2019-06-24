//
//  GHLogFormatter.m
//  Emucoo
//
//  Created by kuroky on 2017/6/19.
//  Copyright © 2017年 Emucoo. All rights reserved.
//

#import "GHLogFormatter.h"
#import <CocoaLumberjack/DDTTYLogger.h>

@implementation GHLogFormatter

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *logLevel = nil;
    switch (logMessage->_flag) {
        case DDLogFlagError:
            logLevel = @"[❌] >  "; // Error (接口报错/或其他错误信息...)
            break;
        case DDLogFlagWarning:
            logLevel = @"[⚠️]  >  "; // Waring
            break;
        case DDLogFlagInfo:
            logLevel = @"[💧]  >  ";
            break;
        case DDLogFlagDebug:
            logLevel = @"[✅] >  "; // Normal info
            break;
        default:
            logLevel = @"[🔤] >  ";
            break;
    }
    
    static NSDateFormatter *dateFormatter;
    
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    }
    
    NSString *strDate = [dateFormatter stringFromDate:logMessage.timestamp];
    NSString *formatStr = [NSString stringWithFormat:@"%@--%@%@[line %zd] %@",
                           strDate,logLevel, logMessage.function,
                           logMessage.line, logMessage.message];
    return formatStr;
}

@end
