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
    self.goal_goals=nil;
    self.goal_numberPeople=nil;
    self.raiseMoney_liveMoney=nil;
    self.goal_startDate=nil;
    self.goal_backDate=nil;
    self.goal_TotalTravelDay=@"1";
    self.goal_numberPeople=nil;
    self.goal_travelTheme=nil;
    self.goal_travelThemeImgUrl=nil;
    self.raiseMoney_sightMoney=nil;
    self.raiseMoney_transMoney=nil;
    self.raiseMoney_liveMoney=nil;
    self.raiseMoney_eatMoney=nil;
    self.raiseMoney_totalMoney=nil;
    self.raiseMoney_wordDes=nil;
    self.raiseMoney_imgsDes=nil;
    self.raiseMoney_voiceUrl=nil;
    self.raiseMoney_movieUrl=nil;
    self.raiseMoney_movieImg=nil;
    self.travelDetailDays=[NSMutableArray array];
    self.return_supportOneYuanStatus=@"1";
    self.return_supportAnyYuanStatus=@"1";
    self.return_returnPeopleStatus=nil;
    self.return_returnPeopleMoney=nil;
    self.return_returnPeopleNumber=nil;
    self.return_wordDes=nil;
    self.return_imgsDes=nil;
    self.return_voiceUrl=nil;
    self.return_movieUrl=nil;
    self.return_movieImg=nil;
    self.return_wordDes=nil;
    self.return_imgsDes=nil;
    self.return_voiceUrl=nil;
    self.return_movieUrl=nil;
    self.return_movieImg=nil;
    self.return_returnPeopleStatus01=nil;
    self.return_returnPeopleMoney01=nil;
    self.return_returnPeopleNumber01=nil;
    self.return_wordDes01=nil;
    self.return_imgsDes01=nil;
    self.return_voiceUrl01=nil;
    self.return_movieUrl01=nil;
    self.return_movieImg01=nil;
    self.return_togetherPeopleStatus=nil;
    self.return_togetherPeopleNumber=nil;
    self.return_togetherMoneyPercent=nil;
    self.return_togetherRateMoney=nil;
}

@end
