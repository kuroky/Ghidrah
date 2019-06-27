//
//  ViewController.m
//  Ghidrah-iOS
//
//  Created by kuroky on 2019/6/20.
//  Copyright © 2019 Emucoo. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

#import "WeatherViewController.h"
#import "HUDViewController.h"
#import "ModelViewController.h"
#import "LogViewController.h"
#import "CacheViewController.h"
#import "ImageViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    
    self.dataList = @[@"Network", @"Model", @"Cache", @"Image", @"HUD", @"Log"];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.dataList[indexPath.row];
    if ([title isEqualToString:@"Network"]) {
        WeatherViewController *weather = [WeatherViewController new];
        [self.navigationController pushViewController:weather animated:YES];
    }
    else if ([title isEqualToString:@"HUD"]) {
        HUDViewController *hud = [HUDViewController new];
        [self.navigationController pushViewController:hud animated:YES];
    }
    else if ([title isEqualToString:@"Model"]) {
        ModelViewController *model = [ModelViewController new];
        [self.navigationController pushViewController:model animated:YES];
    }
    else if ([title isEqualToString:@"Log"]) {
        LogViewController *log = [LogViewController new];
        [self.navigationController pushViewController:log animated:YES];
    }
    else if ([title isEqualToString:@"Cache"]) {
        CacheViewController *cache = [CacheViewController new];
        [self.navigationController pushViewController:cache animated:YES];
    }
    else if ([title isEqualToString:@"Image"]) {
        ImageViewController *image = [ImageViewController new];
        [self.navigationController pushViewController:image animated:YES];
    }
}


@end
