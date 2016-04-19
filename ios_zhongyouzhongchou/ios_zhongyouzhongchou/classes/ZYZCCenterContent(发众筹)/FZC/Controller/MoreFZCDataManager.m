//
//  MoreFZCDataManager.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCDataManager.h"

@implementation MoreFZCDataManager

MJCodingImplementation

// 用来保存唯一的单例对象
static id _instace;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+ (instancetype)sharedMoreFZCDataManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        //这里写要初始化的东西！！！
        _goal_TotalTravelDay=@"1";
        _travelDetailArr=[NSMutableArray array];
        _return_supportOneYuanStatus=@"1";
        _return_supportAnyYuanStatus=@"1";
        //第四个界面
    }
    return self;
}

@end
