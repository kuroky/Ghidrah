//
//  EMNetworkHandler.m
//  Emucoo
//
//  Created by kuroky on 2019/5/10.
//  Copyright © 2019 Emucoo. All rights reserved.
//

#import "EMNetworkHandler.h"
#import <GHNetworkResponse.h>
#import <GHNetworkRequest.h>

@implementation EMNetworkHandler

+ (instancetype)handler {
    static EMNetworkHandler *handle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [EMNetworkHandler new];
    });
    return handle;
}

//MARK:- EMNetworkHandleDelegate
- (NSDictionary <NSString *, NSString *> *)requireHeaders {
    NSString *token = @"";
    if (!token) {
        token = @"1"; // 不存在时 默认传1 业务需求
    }
    
    return @{@"ApiType": @"IOS",
             @"Version": @"1.0.0",
             @"userToken": token};
}

- (GHNetworkResponse *)handleRequest:(GHNetworkRequest *)request {
    GHNetworkResponse *reponse = [self parseResponse:request.responseData];
#if DEBUG
    [self printLog:request reponse:reponse];
#endif
    return reponse;
}

- (GHNetworkResponse *)parseResponse:(NSData *)responseData {
    NSDictionary *dic = @{};
    if (responseData) {
        dic = [NSJSONSerialization JSONObjectWithData:responseData
                                              options:NSJSONReadingAllowFragments
                                                error:nil];
    }
    else {
        dic = @{@"respMsg": @"请求失败,请稍后再试",
                @"respCode": @(408)};
    }
    GHNetworkResponse *reponse = [GHNetworkResponse new];
    reponse.errMsg = dic[@"respMsg"];
    reponse.respData = dic[@"data"];
    id code = dic[@"respCode"];
    NSInteger errCode = 408;
    if ([code isKindOfClass:[NSNumber class]]) {
        errCode = [(NSNumber *)code integerValue];
    }
    else if ([code isKindOfClass:[NSString class]]) {
        errCode = [(NSString *)code integerValue];
    }
    reponse.errCode = errCode;
    reponse.isSuccess = errCode == 0 ? YES : NO;
    return reponse;
}

- (void)printLog:(GHNetworkRequest *)request
         reponse:(GHNetworkResponse *)response {
    NSString *url = [request.baseUrl stringByAppendingString:request.requestUrl];
    id para = request.requestArgument;
    if (!para) {
        para = @{};
    }
    
    double requestTimer = (request.endInterval - request.startInterval) * 1000;
    NSString *interval = [NSString stringWithFormat:@"Http请求: %.fms", requestTimer];
    
    if (response.isSuccess) {
        NSLog(@"requestUrl: %@\n %@ \n parameters: %@\n response: %@ header: %@", url, interval, para, response, request.requestHeaderFieldValueDictionary);
    }
    else {
        NSLog(@"requestUrl: %@\n %@ \n parameters: %@\n response: %@ header: %@", url, interval, para, response, request.requestHeaderFieldValueDictionary);
    }
}

@end
