//
//  MoreFZCDataManager.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCDataManager.h"

@implementation MoreFZCDataManager
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
        self.returnCellHeights = @[@20, @150, @20, @150, @20];
        _goalViewTotalDays=1;
        _travelDetailArr=[NSMutableArray array];
        
        //第四个界面
    }
    return self;
}

#pragma mark - 第四个cell

@end
