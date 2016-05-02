//
//  MoreFZCDataManager.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MJCoding.h"
#import "MoreFZCTravelOneDayDetailMdel.h"
#import <UIKit/UIKit.h>
@interface MoreFZCDataManager : NSObject<NSCopying,MJCoding>
//第一界面
//目的地中涉及到参数
/**
 *  目的地数组
 */
@property (nonatomic, strong) NSArray *goal_goals;
/**
 *  出发日期
 */
@property (nonatomic, copy  ) NSString *goal_startDate;
/**
 *  返回日期
 */
@property (nonatomic, copy  ) NSString *goal_backDate;
/**
 *  旅游总时间
 */
@property (nonatomic, copy  ) NSString *goal_TotalTravelDay;
/**
 *  一起游人数
 */
@property (nonatomic, copy  ) NSString *goal_numberPeople;
/**
 *  旅行主题名
 */
@property (nonatomic, copy  ) NSString  *goal_travelTheme;
/**
 *  旅行主题图片路径
 */
@property (nonatomic, copy  ) NSString  *goal_travelThemeImgUrl;

//第二界面
/**
 *  景点金额
 */
@property (nonatomic, copy  ) NSString *raiseMoney_sightMoney;
/**
 *  行程金额
 */
@property (nonatomic, copy  ) NSString *raiseMoney_transMoney;
/**
 *  居住金额
 */
@property (nonatomic, copy  ) NSString *raiseMoney_liveMoney;
/**
 *  餐饮金额
 */
@property (nonatomic, copy  ) NSString *raiseMoney_eatMoney;

/**
 *  总金额数目
 */
@property (nonatomic, copy  ) NSString *raiseMoney_totalMoney;
/**
 *  筹路费文字描述
 */
@property (nonatomic, copy  ) NSString *raiseMoney_wordDes;
/**
 *  筹路费图片描述
 */
@property (nonatomic, copy  ) NSArray  *raiseMoney_imgsDes;
/**
 *  筹路费语音描述
 */
@property (nonatomic, copy  ) NSString *raiseMoney_voiceUrl;
/**
 *  筹路费视屏描述
 */
@property (nonatomic, copy  ) NSString *raiseMoney_movieUrl;
/**
 *  筹路费视屏第一帧
 */
@property (nonatomic, copy  ) NSString *raiseMoney_movieImg;

//第三界面属性
/**
 *  旅游行程安排
 */
@property (nonatomic, strong) NSMutableArray *travelDetailDays;


//第四界面属性

/**
 *  return第三个cell是否选中
 */
//return_people_status
@property (nonatomic, copy  ) NSString *return_supportOneYuanStatus;

@property (nonatomic, copy  ) NSString *return_supportAnyYuanStatus;

@property (nonatomic, copy  ) NSString *return_returnPeopleStatus;
/**
 *  return第三个cell的金钱
 */
@property (nonatomic, copy  ) NSString *return_returnPeopleMoney;
/**
 *  return第三个cell的人数
 */
@property (nonatomic, copy  ) NSString *return_returnPeopleNumber;

//再次添加一个回报众筹的一些参数
@property (nonatomic, copy  ) NSString *return_returnPeopleStatus01;
/**
 *  return第三个cell01的金钱
 */
@property (nonatomic, copy  ) NSString *return_returnPeopleMoney01;
/**
 *  return第三个cell01的人数
 */
@property (nonatomic, copy  ) NSString *return_returnPeopleNumber01;

@property (nonatomic, copy  ) NSString *return_wordDes;

@property (nonatomic, copy  ) NSString *return_imgsDes;

@property (nonatomic, copy  ) NSString *return_voiceUrl;

@property (nonatomic, copy  ) NSString *return_movieUrl;

@property (nonatomic, copy  ) NSString *return_movieImg;

@property (nonatomic, copy  ) NSString *return_togetherPeopleStatus;

@property (nonatomic, copy  ) NSString *return_togetherPeopleNumber;

@property (nonatomic, copy  ) NSString *return_togetherMoneyPercent;

@property (nonatomic, copy  ) NSString *return_togetherRateMoney;


+ (instancetype)sharedMoreFZCDataManager;

/**
 *  初始化参数
 */
-(void)initAllProperties;

@end
