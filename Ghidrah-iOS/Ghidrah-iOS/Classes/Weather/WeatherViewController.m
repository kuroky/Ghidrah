//
//  WeatherViewController.m
//  Ghidrah-iOS
//
//  Created by kuroky on 2019/6/21.
//  Copyright © 2019 Emucoo. All rights reserved.
//

#import "WeatherViewController.h"
#import <Masonry/Masonry.h>
#import "NetworkRequest.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NetworkRequest *request = [NetworkRequest new];
    request.key = @"S1zv0pRPYRYv20pI7";
    request.location = @"shanghai";
    request.language = @"zh-Hans";
    request.unit = @"c";
    [request gh_requestWithCompletion:^(GHNetworkResponse *response) {
        if (response.isSuccess) {
            NSLog(@"%@", response.respData);
        }
    }];
}

@end
