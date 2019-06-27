//
//  CacheViewController.m
//  Ghidrah-iOS
//
//  Created by kuroky on 2019/6/25.
//  Copyright © 2019 Emucoo. All rights reserved.
//

#import "CacheViewController.h"
#import "CacheModel.h"
#import <Masonry/Masonry.h>
#import <MXCache.h>

static NSString *const kCellId = @"cell";

@interface CacheViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) CacheModel *model;
@property (copy, nonatomic) NSString *cachekey;

@end

@implementation CacheViewController

- (void)viewDidLoad {
    self.navigationItem.title = @"缓存";
    [super viewDidLoad];
    self.model = [CacheModel new];
    NSLog(@"%@", self.model);
    self.cachekey = @"model";
    
    [[MXCache sharedCache] mx_removeCacheForKey:self.cachekey]; // 清除缓存
    self.dataList = @[@"save model to memory",
                      @"get model from memory",
                      @"remove model of memory",
                      @"save model to disk",
                      @"get model from disk",
                      @"remove model of disk",
                      @"save model to memory and disk",
                      @"get model from memory or disk",
                      @"remove model of memory and disk"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellId];
}

//MARK:- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [[MXCache sharedCache] mx_setObjectMemory:self.model
                                           forKey:self.cachekey];
    }
    else if (indexPath.row == 1) {
        CacheModel *model = [[MXCache sharedCache] mx_memoryCacheForKey:self.cachekey];
        NSLog(@"%@", model);
    }
    else if (indexPath.row == 2) {
        [[MXCache sharedCache] mx_removeMemoryCacheForKey:self.cachekey];
        CacheModel *model = [[MXCache sharedCache] mx_memoryCacheForKey:self.cachekey];
        NSLog(@"%@", model);
    }
    else if (indexPath.row == 3) {
        [[MXCache sharedCache] mx_setObjectDisk:self.model
                                         forKey:self.cachekey];
    }
    else if (indexPath.row == 4) {
        CacheModel *model = [[MXCache sharedCache] mx_diskCacheForKey:self.cachekey];
        NSLog(@"%@", model);
    }
    else if (indexPath.row == 5) {
        [[MXCache sharedCache] mx_removeDiskCacheForKey:self.cachekey];
    }
    else if (indexPath.row == 6) {
        [[MXCache sharedCache] mx_setObject:self.model
                                     forKey:self.cachekey];
    }
    else if (indexPath.row == 7) {
        CacheModel *model = [[MXCache sharedCache] mx_diskCacheForKey:self.cachekey];
        NSLog(@"disk %@", model);
        
        model = [[MXCache sharedCache] mx_memoryCacheForKey:self.cachekey];
        NSLog(@"memory: %@", model);
    }
    else if (indexPath.row == 8) {
        [[MXCache sharedCache] mx_removeCacheForKey:self.cachekey];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
