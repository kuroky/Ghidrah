//
//  CacheModel.h
//  Ghidrah-iOS
//
//  Created by kuroky on 2019/6/25.
//  Copyright © 2019 Emucoo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacheModel : NSObject <NSCoding, NSCopying>

@property (copy, nonatomic) NSString *name;

@property (strong, nonatomic) NSNumber *age;

@property (copy, nonatomic) NSString *address;

@end

NS_ASSUME_NONNULL_END
