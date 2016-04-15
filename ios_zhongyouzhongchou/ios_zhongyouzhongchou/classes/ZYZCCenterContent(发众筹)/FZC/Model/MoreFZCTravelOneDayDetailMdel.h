//
//  MoreFZCTravelOneDayDetailMdel.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/29.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreFZCTravelOneDayDetailMdel : NSObject
/**
 *  日期
 */
@property (nonatomic, strong) NSDate   *date;
/**
 *  景点描述
 */
@property (nonatomic, copy  ) NSString *siteDes;
/**
 *  交通描述
 */
@property (nonatomic, copy  ) NSString *trafficDes;
/**
 *  住宿描述
 */
@property (nonatomic, copy  ) NSString *accommodateDes;
/**
 *  餐饮描述
 */
@property (nonatomic, copy  ) NSString *foodDes;
/**
 *  当天旅游景点
 */
@property (nonatomic, strong) NSArray  *sitesArr;
/**
 *  当天旅游的文字描述
 */
@property (nonatomic, strong) NSString *travelDes;
/**
 *  当天旅游图片描述
 */
@property (nonatomic, strong) NSArray *travelImgArr;
/**
 *  当天旅游的语音录入
 */
@property (nonatomic, strong) NSData *voiceData;
/**
 *  当天旅游视屏录入
 */
@property (nonatomic, strong) NSData *movieData;

@end
