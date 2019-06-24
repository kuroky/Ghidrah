//
//  HUDViewController.m
//  Ghidrah-iOS
//
//  Created by kuroky on 2019/6/21.
//  Copyright © 2019 Emucoo. All rights reserved.
//

#import "HUDViewController.h"
#import <Masonry/Masonry.h>
#import <Ghidrah/GHProgressHUD.h>

@interface HUDViewController ()

@end

@implementation HUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"HUD";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft).offset(40);;
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight).offset(-40);;
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(100);
        make.height.mas_equalTo(40);
    }];
    [button setTitle:@"HUD1" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft).offset(40);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight).offset(-40);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(200);
        make.height.mas_equalTo(40);
    }];
    [button setTitle:@"HUD1" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickBtn2) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickBtn1 {
    [[GHProgressHUD sharedHUD] showHUDWithTitle:@"hud1" cancelAction:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[GHProgressHUD sharedHUD] hideHUD];
    });
}

- (void)clickBtn2 {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[GHProgressHUD sharedHUD] showHUDWithTitle:@"hud2" cancelAction:^(UIButton *sender) {
            [[GHProgressHUD sharedHUD] toastTitle:@"hide"];
        }];
    });
    
}

@end
