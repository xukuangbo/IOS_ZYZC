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
        _travelDetailDays=[NSMutableArray array];
        _goal_TotalTravelDay=@"1";
        _return_supportOneYuanStatus=@"1";
        _return_supportAnyYuanStatus=@"1";
        //第四个界面
    }
    return self;
}


+ (NSDictionary *)objectClassInArray
{
    return @{
             @"travelDetailDays" : [MoreFZCTravelOneDayDetailMdel class],
            };
}

+ (Class)objectClassInArray:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"travelDetailArr"]) {
        return [MoreFZCTravelOneDayDetailMdel class];
    }
    return nil;
}

-(void)initAllProperties
{
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    
    manager.goal_goals=nil;
    manager.goal_startDate=nil;
    manager.goal_backDate=nil;
    manager.goal_TotalTravelDay=nil;
    manager.goal_numberPeople=nil;
    manager.goal_travelTheme=nil;
    manager.goal_travelThemeImgUrl=nil;
    manager.raiseMoney_sightMoney=nil;
    manager.raiseMoney_transMoney=nil;
    manager.raiseMoney_liveMoney=nil;
    manager.raiseMoney_eatMoney=nil;
    manager.goal_TotalTravelDay=nil;
    manager.raiseMoney_wordDes=nil;
    manager.raiseMoney_imgsDes=nil;
    manager.raiseMoney_voiceUrl=nil;
    manager.raiseMoney_movieUrl=nil;
    manager.travelDetailDays=[NSMutableArray array];
    manager.return_supportOneYuanStatus=@"1";
    manager.return_supportAnyYuanStatus=@"1";
    self.return_returnPeopleStatus=nil;
    self.return_returnPeopleMoney=nil;
    self.return_returnPeopleNumber=nil;
    self.return_wordDes=nil;
    self.return_imgsDes=nil;
    self.return_voiceUrl=nil;
    self.return_movieUrl=nil;
    self.return_togetherPeopleStatus=nil;
    self.return_togetherPeopleNumber=nil;
    self.return_togetherMoneyPercent=nil;
    self.return_togetherRateMoney=nil;
}


#pragma mark --- 获取对象所有属性
- (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

@end
