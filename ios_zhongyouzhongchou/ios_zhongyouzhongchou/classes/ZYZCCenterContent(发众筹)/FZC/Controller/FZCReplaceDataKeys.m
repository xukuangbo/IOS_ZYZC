//
//  FZCReplaceDataKeys.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/28.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "FZCReplaceDataKeys.h"
#import "MoreFZCDataManager.h"
#import "NSDate+RMCalendarLogic.h"
@implementation FZCReplaceDataKeys

MJCodingImplementation

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"schedule" : [ScheduleData class],
             @"report"   : [ReportData class],
             };
}

+ (Class)objectClassInArray:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"schedule"]) {
        return [ScheduleData class];
    }
    
    if ([propertyName isEqualToString:@"report"]) {
        return [ReportData class];
    }
    return nil;
}

-(void)replaceDataKeys
{
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
//    self.openid=[ZYZCTool getUserId];
    self.openid=@"o6_bmjrPTlm6_2sgVt7hMZOPfL2M";
    self.status=@1;
    self.title=manager.goal_travelTheme;
    self.spell_buy_price=(NSNumber *)manager.raiseMoney_totalMoney;
    self.dest=manager.goal_goals;
    self.productCountryId=@[@1,@2];//需更改
    self.start_time=manager.goal_startDate;
    self.end_time=manager.goal_backDate;
    NSDate *date=[[NSDate date] dayInTheFollowingMonth:3];
    self.spell_end_time=[NSDate stringFromDate:date];
    self.people=(NSNumber *)manager.goal_numberPeople;
    self.cover=manager.goal_travelThemeImgUrl;
    self.desc=manager.raiseMoney_wordDes;
    self.voice=manager.raiseMoney_voiceUrl;
    self.movie=manager.raiseMoney_movieUrl;
    self.movieImg=manager.raiseMoney_movieImg;
    
    //行程安排
    NSMutableArray *mutArr=[NSMutableArray array];
    for (int i=0; i<manager.travelDetailDays.count-1; i++) {
        MoreFZCTravelOneDayDetailMdel *model=manager.travelDetailDays[i];
        ScheduleData *oneSchedule=[[ScheduleData alloc]init];
        oneSchedule.day=[NSNumber numberWithInt:i+1];
        oneSchedule.spot=model.siteDes;
        oneSchedule.spots=model.sites;
        oneSchedule.trans=model.trafficDes;
        oneSchedule.live=model.liveDes;
        oneSchedule.food=model.foodDes;
        oneSchedule.desc=model.wordDes;
        oneSchedule.voice=model.voiceUrl;
        oneSchedule.movie=model.movieUrl;
        oneSchedule.movieImg=model.movieImg;
        [mutArr addObject:oneSchedule];
    }
    self.schedule=mutArr;
    
    //支持1元
    ReportData *report01=[[ReportData alloc]init];
    report01.style=@1;
    report01.price=@1;
    //支持任意金额
    ReportData *report02=[[ReportData alloc]init];
    report02.style=@2;
    report02.price=@0;
    //回报支持1
    ReportData *report03=[[ReportData alloc]init];
    report03.style=@3;
    report03.price=(NSNumber *)manager.return_returnPeopleMoney;
    report03.people=(NSNumber *)manager.return_returnPeopleNumber;
    report03.desc=manager.return_wordDes;
    report03.voice=manager.return_voiceUrl;
    report03.movie=manager.return_movieUrl;
    //一起游
    ReportData *report04=[[ReportData alloc]init];
    report04.style=@4;
    report04.people=(NSNumber *)manager.goal_numberPeople;
    report04.price=(NSNumber *)manager.return_togetherRateMoney;
    
    //回报支持2
    ReportData *report05=[[ReportData alloc]init];
    report04.style=@5;
    report04.price=(NSNumber *)manager.return_returnPeopleMoney;
    report04.people=(NSNumber *)manager.return_returnPeopleNumber;
    report04.desc=manager.return_wordDes;
    report04.voice=manager.return_voiceUrl;
    report04.movie=manager.return_movieUrl;
    
    //筹旅费景点花费
    ReportData *report06=[[ReportData alloc]init];
    report06.style=@6;
    report06.price=(NSNumber *)manager.raiseMoney_sightMoney;
    //筹旅费交通花费
    ReportData *report07=[[ReportData alloc]init];
    report07.style=@7;
    report07.price=(NSNumber *)manager.raiseMoney_transMoney;
    //筹旅费住宿花费
    ReportData *report08=[[ReportData alloc]init];
    report08.style=@8;
    report08.price=(NSNumber *)manager.raiseMoney_liveMoney;
    //筹旅费餐饮花费
    ReportData *report09=[[ReportData alloc]init];
    report09.style=@9;
    report09.price=(NSNumber *)manager.raiseMoney_eatMoney;
    
    self.report=@[report01,report02,report03,report04,report05,report06,report07,report08];
    
}

@end

@implementation ScheduleData

MJCodingImplementation

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end

@implementation ReportData

MJCodingImplementation

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end


