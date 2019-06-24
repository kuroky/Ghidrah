//
//  UserModel.h
//  Ghidrah-iOS
//
//  Created by kuroky on 2019/6/21.
//  Copyright © 2019 Emucoo. All rights reserved.
//

#import <Ghidrah/Ghidrah.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : GHModel

@property (nonatomic, copy) NSString *departmentID;

@property (nonatomic, copy) NSString *departmentName;

@property (nonatomic, copy) NSString *departmentType;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *headImgUrl;

@property (nonatomic, assign) BOOL isRepairMan;

@property (nonatomic, assign) BOOL isShopManager;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *orgId;

@property (nonatomic, strong) NSArray *shopNameArr;

@property (nonatomic, assign) NSInteger usePlan;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userToken;

@property (nonatomic, copy) NSString *userType;

@end

NS_ASSUME_NONNULL_END
