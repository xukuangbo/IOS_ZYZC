//
//  ZCDetailModel.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/11.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZCDetailProductModel,UserModel,ReportModel;

@interface ZCDetailModel : NSObject

@property (nonatomic, copy   ) NSString *code;
@property (nonatomic, strong )ZCDetailProductModel *detailProductModel;

@end

@interface ZCDetailProductModel : NSObject

@property (nonatomic, copy  ) NSString *cover;
@property (nonatomic, copy  ) NSString *desc;
@property (nonatomic, copy  ) NSString *voice;
@property (nonatomic, copy  ) NSString *video;
@property (nonatomic, copy  ) NSString *videoImg;
@property (nonatomic, copy  ) NSString *dest;
@property (nonatomic, strong) NSNumber *Friend;
@property (nonatomic, strong) NSNumber *friendsCount;
@property (nonatomic, strong) NSNumber *mySelf;
@property (nonatomic, strong) NSNumber *productId;
@property (nonatomic, copy  ) NSString *spell_buy_price;
@property (nonatomic, copy  ) NSString *spell_end_time;
@property (nonatomic, copy  ) NSString *start_time;
@property (nonatomic, copy  ) NSString *end_time;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, strong) UserModel *user;
@property (nonatomic, strong) NSArray  *schedule;

@property (nonatomic, strong) NSArray  *report;

@property (nonatomic, assign) CGFloat introFirstCellHeight;


@end

@interface UserModel : NSObject

@property (nonatomic, copy  ) NSString *faceImg;
@property (nonatomic, copy  ) NSString *sex;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, copy  ) NSString *userName;

@end

@interface ReportModel : NSObject

@property (nonatomic, copy  ) NSString *desc;
@property (nonatomic, strong) NSNumber *people;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *reportId;
@property (nonatomic, strong) NSNumber *style;
@property (nonatomic, strong) NSNumber *sumPeople;
@property (nonatomic, strong) NSNumber *sumPrice;
@property (nonatomic, strong) NSArray  *users;

@end









