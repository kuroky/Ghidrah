//
//  ModelViewController.m
//  Ghidrah-iOS
//
//  Created by kuroky on 2019/6/21.
//  Copyright © 2019 Emucoo. All rights reserved.
//

#import "ModelViewController.h"
#import "NetworkRequest.h"
#import <Masonry/Masonry.h>
#import <Ghidrah/GHProgressHUD.h>
#import "UserModel.h"

@interface ModelViewController ()

@property (nonatomic, strong) UITextView *textView1;
@property (nonatomic, strong) UITextView *textView2;

@end

@implementation ModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textView1 = [[UITextView alloc] initWithFrame:CGRectZero];
    self.textView1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.textView1];
    [self.textView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft).offset(40);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight).offset(-40);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(100);
        make.height.mas_equalTo(120);
    }];
    
    self.textView2 = [[UITextView alloc] initWithFrame:CGRectZero];
    self.textView2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.textView2];
    [self.textView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft).offset(40);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight).offset(-40);
        make.top.equalTo(self.textView1.mas_bottom).offset(40);
        make.height.mas_equalTo(120);
    }];
    
    self.navigationItem.title = @"Json->Model";
    
    [[GHProgressHUD sharedHUD] showHUDWithTitle:@"" cancelAction:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self request];
    });
}

- (void)request {
    NetworkRequest *request = [NetworkRequest new];
    //request.mobile = @"shida1";
    //request.password = @"123456";
    [request gh_requestWithCompletion:^(GHNetworkResponse *response) {
        [[GHProgressHUD sharedHUD] hideHUD];
        if (response.isSuccess) {
            self.textView1.text = [response.respData gh_modelToJsonString];
            UserModel *model = [UserModel gh_convertModelWithJsonDic:response.respData];
            self.textView2.text = [model gh_modelToJsonString];
        }
        else {
            [[GHProgressHUD sharedHUD] toastTitle:response.errMsg];
        }
    }];
}

@end
