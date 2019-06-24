//
//  NetworkRequest.m
//  Ghidrah-iOS
//
//  Created by kuroky on 2019/6/21.
//  Copyright © 2019 Emucoo. All rights reserved.
//

#import "NetworkRequest.h"

@implementation NetworkRequest

- (NSString *)requestUrl {
    NSString *url = [NSString stringWithFormat:@"weather/now.json?key=%@&location=%@&language=%@&unit=%@", self.key, self.location, self.language, self.unit];
    return url;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return nil;
}

@end
