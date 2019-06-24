//
//  NetworkRequest.h
//  Ghidrah-iOS
//
//  Created by kuroky on 2019/6/21.
//  Copyright © 2019 Emucoo. All rights reserved.
//

#import <GHNetwork/GHNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkRequest : GHNetworkRequest

@property (nonatomic, copy) NSString *key;

@property (nonatomic, copy) NSString *location;

@property (copy, nonatomic) NSString *language;

@property (nonatomic, copy) NSString *unit;

@end

NS_ASSUME_NONNULL_END
