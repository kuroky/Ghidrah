//
//  LogViewController.m
//  Ghidrah-iOS
//
//  Created by kuroky on 2019/6/25.
//  Copyright © 2019 Emucoo. All rights reserved.
//

#import "LogViewController.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <Masonry/Masonry.h>

#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = DDLogLevelError;
#endif

@interface LogViewController ()

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Log";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"DDLog";
    
    DDLogDebug(@"success message");
    DDLogError(@"request error");
    DDLogWarn(@"no data");
    DDLogInfo(@"Warming up printer (pre-customization)");
    DDLogVerbose(@"Intializing protcol x26 (pre-customization)");
}

@end
