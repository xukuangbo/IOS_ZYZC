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
        _report=[NSMutableArray array];
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
    self.openid=[ZYZCTool getUserId];
    self.status=@1;
    self.title=manager.goal_travelTheme;
    self.spell_buy_price=(NSNumber *)manager.raiseMoney_totalMoney;
    self.dest=manager.goal_goals;
    self.start_time=manager.goal_startDate;
    self.end_time=manager.goal_backDate;
    NSDate *date=[[NSDate dateFromString:self.start_time] dayInTheFollowingDay:-15];
    self.spell_end_time=[NSDate stringFromDate:date];
    self.cover=manager.goal_travelThemeImgUrl;
    self.desc=manager.raiseMoney_wordDes;
    self.voice=manager.raiseMoney_voiceUrl;
    self.video=manager.raiseMoney_movieUrl;
    self.videoImg=manager.raiseMoney_movieImg;
    
    //行程安排
    NSMutableArray *mutArr=[NSMutableArray array];
    for (int i=0; i<manager.travelDetailDays.count; i++) {
        MoreFZCTravelOneDayDetailMdel *model=manager.travelDetailDays[i];
        ScheduleData *oneSchedule=[[ScheduleData alloc]init];
        oneSchedule.day=[NSString stringWithFormat:@"%@",model.day];
        oneSchedule.spot=model.siteDes;
        oneSchedule.spots=model.sites;
        oneSchedule.trans=model.trafficDes;
        oneSchedule.live=model.liveDes;
        oneSchedule.food=model.foodDes;
        oneSchedule.desc=model.wordDes;
        oneSchedule.voice=model.voiceUrl;
        oneSchedule.video=model.movieUrl;
        oneSchedule.videoImg=model.movieImg;
        [mutArr addObject:oneSchedule];
    }
    self.schedule=mutArr;
    
    //支持1元
    ReportData *report01=[[ReportData alloc]init];
    report01.style=@1;
    report01.price=@1;
    [_report addObject:report01];
    //支持任意金额
    ReportData *report02=[[ReportData alloc]init];
    report02.style=@2;
    report02.price=@0;
    [_report addObject:report02];
    //回报支持1
    if([manager.return_returnPeopleStatus isEqualToString:@"1"]){
        ReportData *report03=[[ReportData alloc]init];
        report03.style=@3;
        report03.price=(NSNumber *)manager.return_returnPeopleMoney;
        report03.people=(NSNumber *)manager.return_returnPeopleNumber;
        report03.desc=manager.return_wordDes;
        report03.voice=manager.return_voiceUrl;
        report03.video=manager.return_movieUrl;
        report03.videoImg=manager.return_movieImg;
        [_report addObject:report03];
    }
    //一起游
    ReportData *report04=[[ReportData alloc]init];
    report04.style=@4;
    report04.people=(NSNumber *)manager.goal_numberPeople;
    report04.price=(NSNumber *)manager.return_togetherRateMoney;
    [_report addObject:report04];
    
    //回报支持2
    if ([manager.return_returnPeopleStatus01 isEqualToString:@"1"]) {
        ReportData *report05=[[ReportData alloc]init];
        report05.style=@5;
        report05.price=(NSNumber *)manager.return_returnPeopleMoney01;
        report05.people=(NSNumber *)manager.return_returnPeopleNumber01;
        report05.desc=manager.return_wordDes01;
        report05.voice=manager.return_voiceUrl01;
        report05.video=manager.return_movieUrl01;
        report05.videoImg=manager.return_movieImg01;
        [_report addObject:report05];
    }
    if (manager.raiseMoney_sightMoney.floatValue>0) {
        //筹旅费景点花费
        ReportData *report06=[[ReportData alloc]init];
        report06.style=@6;
        report06.price=(NSNumber *)manager.raiseMoney_sightMoney;
        [_report addObject:report06];
    }
    
    if (manager.raiseMoney_transMoney.floatValue>0) {
        //筹旅费交通花费
        ReportData *report07=[[ReportData alloc]init];
        report07.style=@7;
        report07.price=(NSNumber *)manager.raiseMoney_transMoney;
        [_report addObject:report07];
    }
    
    if (manager.raiseMoney_liveMoney.floatValue>0) {
        //筹旅费住宿花费
        ReportData *report08=[[ReportData alloc]init];
        report08.style=@8;
        report08.price=(NSNumber *)manager.raiseMoney_liveMoney;
        [_report addObject:report08];
    }
    if (manager.raiseMoney_eatMoney.floatValue>0) {
        //筹旅费餐饮花费
        ReportData *report09=[[ReportData alloc]init];
        report09.style=@9;
        report09.price=(NSNumber *)manager.raiseMoney_eatMoney;
        [_report addObject:report09];
    }
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


