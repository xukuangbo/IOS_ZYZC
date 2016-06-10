//
//  FZCSaveDraftData.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/25.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "FZCSaveDraftData.h"
#import "MoreFZCDataManager.h"
#import "NSDate+RMCalendarLogic.h"
@implementation FZCSaveDraftData

+ (void)saveDraftDataInOneModel:(ZCOneModel *)oneModel andDetailProductModel:(ZCDetailProductModel *)detailProductModel andDoBlock:(DoBlock )doBlock
{
    MoreFZCDataManager *dataManager= [MoreFZCDataManager sharedMoreFZCDataManager];
    
    oneModel.productType=ZCDetailProduct;
    ZCProductModel *productModel=[[ZCProductModel alloc]init];
    productModel.productPrice= [NSNumber numberWithFloat:[dataManager.raiseMoney_totalMoney floatValue]*100.0] ;
    productModel.travelstartTime=dataManager.goal_startDate;
    productModel.productEndTime=dataManager.goal_backDate;
    productModel.productName=dataManager.goal_travelTheme;
    if (dataManager.goal_goals.count>=2) {
        NSMutableArray *arr=[NSMutableArray arrayWithArray:dataManager.goal_goals];
        [arr removeObjectAtIndex:0];
        productModel.productDest=[self turnJson:arr];
    }
    NSDate *date=[[NSDate dateFromString:dataManager.goal_startDate] dayInTheFollowingDay:-15];
    productModel.productEndTime=[NSDate stringFromDate:date];
    productModel.headImage=dataManager.goal_travelThemeImgUrl;
    oneModel.product=productModel;
    
    detailProductModel.cover=dataManager.goal_travelThemeImgUrl;
    detailProductModel.title=dataManager.goal_travelTheme;
    detailProductModel.desc=dataManager.raiseMoney_wordDes;
    detailProductModel.productVoice=dataManager.raiseMoney_voiceUrl;
    detailProductModel.productVideo=dataManager.raiseMoney_movieUrl;
    detailProductModel.productVideoImg=dataManager.raiseMoney_movieImg;
    
    
    NSMutableArray *reportArr=[NSMutableArray array];
    ReportModel *reportModel01=[[ReportModel alloc]init];
    reportModel01.people = 0;
    reportModel01.style = @1;
    reportModel01.sumPeople = 0;
    reportModel01.sumPrice = 0;
    [reportArr addObject:reportModel01];
    
    ReportModel *reportModel02=[[ReportModel alloc]init];
    reportModel02.people = 0;
    reportModel02.style = @2;
    reportModel02.sumPeople = 0;
    reportModel02.sumPrice = 0;
    [reportArr addObject:reportModel02];
    
    if (dataManager.return_returnPeopleStatus) {
        ReportModel *reportModel03=[[ReportModel alloc]init];
        reportModel03.desc = dataManager.return_wordDes;
        reportModel03.spellVideo = dataManager.return_movieUrl;
        reportModel03.spellVoice = dataManager.return_voiceUrl;
        reportModel03.spellVideoImg=dataManager.return_movieImg;
        reportModel03.people =(NSNumber *)dataManager.return_returnPeopleNumber;
        reportModel03.price =[NSNumber numberWithFloat:[dataManager.return_returnPeopleMoney floatValue]*100.0] ;
        reportModel03.style = @3;
        reportModel03.sumPeople = 0;
        reportModel03.sumPrice =0;
        [reportArr addObject: reportModel03];
    }
    
    ReportModel *reportModel04=[[ReportModel alloc]init];
    reportModel04.people = (NSNumber *)dataManager.goal_numberPeople;
    reportModel04.style = @4;
    reportModel04.sumPeople = (NSNumber *)dataManager.goal_numberPeople;
    reportModel04.sumPrice = 0;
    reportModel04.price=(NSNumber *)dataManager.return_togetherRateMoney;
    [reportArr addObject:reportModel04];
    
    if (dataManager.return_returnPeopleMoney01) {
        ReportModel *reportModel05=[[ReportModel alloc]init];
        reportModel05.desc = dataManager.return_wordDes;
        reportModel05.spellVideo = dataManager.return_movieUrl01;
        reportModel05.spellVoice = dataManager.return_voiceUrl01;
        reportModel05.spellVideoImg=dataManager.return_movieImg01;
        reportModel05.people =(NSNumber *)dataManager.return_returnPeopleNumber01;
        reportModel05.price =[NSNumber numberWithFloat:[dataManager.return_returnPeopleMoney01 floatValue]*100.0] ;
        reportModel05.style = @5;
        reportModel05.sumPeople = 0;
        reportModel05.sumPrice =0;
        [reportArr addObject:reportModel05];
    }
    
    detailProductModel.report=reportArr;
    
    detailProductModel.schedule=dataManager.travelDetailDays;
    
    [ZYZCHTTPTool getHttpDataByURL:[NSString stringWithFormat:@"%@openid=%@",GETUSERINFO,[ZYZCTool getUserId]] withSuccessGetBlock:^(id result, BOOL isSuccess)
     {
         UserModel *user=[[UserModel alloc]mj_setKeyValues:result[@"data"][@"user"]];
         oneModel.user=user;
         detailProductModel.user=user;
         if (doBlock) {
             doBlock();
         }
     }
      andFailBlock:^(id failResult)
     {
         
     }];
}

+(NSString *)turnJson:(id )dic
{
    //    转换成json
    NSData *data = [NSJSONSerialization dataWithJSONObject :dic options : NSJSONWritingPrettyPrinted error:NULL];
    
    NSString *jsonStr = [[ NSString alloc ] initWithData :data encoding : NSUTF8StringEncoding];
    
    return jsonStr;
}


@end
