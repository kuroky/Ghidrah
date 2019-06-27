//
//  CacheModel.m
//  Ghidrah-iOS
//
//  Created by kuroky on 2019/6/25.
//  Copyright © 2019 Emucoo. All rights reserved.
//

#import "CacheModel.h"

@implementation CacheModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self createRandomValue];
}

- (void)createRandomValue {
    self.name = @"jack";
    self.age = @(20);
    self.address = @"上海";
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeObjectForKey:@"age"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.age forKey:@"age"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.address forKey:@"address"];
}

- (id)copyWithZone:(NSZone *)zone {
    CacheModel *model = [[self class] allocWithZone:zone];
    model.name = [self.name copy];
    model.age = [self.age copy];
    model.address = [self.address copy];
    return model;
}

- (NSString *)description {
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setValue:_name forKey:@"name"];
    [data setValue:_age forKey:@"age"];
    [data setValue:_address forKey:@"address"];
    return [NSString stringWithFormat:@"<%@:%p>:%@",[self class], &self, data];
}

- (NSString *)debugDescription {
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setValue:_name forKey:@"name"];
    [data setValue:_age forKey:@"age"];
    [data setValue:_address forKey:@"address"];
    return [NSString stringWithFormat:@"<%@:%p>:%@",[self class], &self, data];
}

@end
