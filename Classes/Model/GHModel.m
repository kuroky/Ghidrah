//
//  GHModel.m
//  Emucoo
//
//  Created by kuroky on 2017/6/19.
//  Copyright © 2017年 Emucoo. All rights reserved.
//

#import "GHModel.h"
#import "YYModel.h"

@interface GHModel () <NSCopying, NSCoding>

@end

@implementation GHModel

#pragma mark - json字典转换成Model
+ (id)gh_convertModelWithJsonDic:(NSDictionary *)jsonDic {
    return [self yy_modelWithDictionary:jsonDic];
}

#pragma mark - json字符串转换成Model
+ (id)gh_convertModelWithJsonStr:(NSString *)jsonStr {
    return [self yy_modelWithJSON:jsonStr];
}

#pragma mark - json数组model化
+ (NSArray *)gh_convertModelWithJsonArr:(NSArray *)jsonArr {
    return [NSArray yy_modelArrayWithClass:self json:jsonArr];
}

#pragma mark - Coding/Copying/hash/equal
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

- (NSUInteger)hash {
    return [self yy_modelHash];
}

- (BOOL)isEqual:(id)object {
    return [self yy_modelIsEqual:object];
}

- (NSString *)description {
    return [self yy_modelDescription];
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return nil;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return nil;
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    return YES;
}

@end

@implementation NSObject (EMBaseModel)

#pragma mark - model转成json对象
- (id)gh_modelToJsonDictionary {
    id obj = [self yy_modelToJSONObject];
    return obj;
}

- (NSString *)gh_modelToJsonString {
    return [self yy_modelToJSONString];
}

- (id)gh_copy {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    GHModel *item = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return item;
}

@end
