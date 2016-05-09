//
//  ZCListModel.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/8.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZCOneModel,ZCProductModel,ZCSpellbuyproductModel,ZCUserModel;

@interface ZCListModel : NSObject

@property (nonatomic, copy  ) NSString *code;
@property (nonatomic, strong) NSArray  *data;

@end


@interface ZCOneModel : NSObject

@property (nonatomic, strong) NSDictionary    *country;
@property (nonatomic, strong) ZCProductModel  *product;
@property (nonatomic, strong) ZCSpellbuyproductModel *spellbuyproduct;
@property (nonatomic, strong) ZCUserModel     *user;

@end

@interface ZCProductModel : NSObject

@property (nonatomic, strong) NSNumber *down;
@property (nonatomic, strong) NSNumber *productId;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy  ) NSString *headImage;
@property (nonatomic, copy  ) NSString *productDest;
@property (nonatomic, copy  ) NSString *productEndTime;
@property (nonatomic, copy  ) NSString *productName;
@property (nonatomic, copy  ) NSString *productPrice;
@property (nonatomic, copy  ) NSString *productStartTime;
@property (nonatomic, copy  ) NSString *travelstartTime;
@property (nonatomic, copy  ) NSString *travelendTime;
@property (nonatomic, strong) NSNumber *up;

@end


@interface ZCSpellbuyproductModel : NSObject

@property (nonatomic, strong) NSNumber *spellRealBuyCount;
@property (nonatomic, strong) NSNumber *buyable;
@property (nonatomic, strong) NSNumber *spellbuyProductId;
@property (nonatomic, strong) NSNumber *fkProductId;
@property (nonatomic, strong) NSNumber *lotteryable;
@property (nonatomic, strong) NSNumber *annable;
@property (nonatomic, strong) NSNumber *spellRealBuyPrice;

@end

@interface ZCUserModel : NSObject

@property (nonatomic, strong) NSNumber *usedPoints;
@property (nonatomic, copy  ) NSString *school;
@property (nonatomic, copy  ) NSString *sex;//0未知，1.女，2.男
@property (nonatomic, strong) NSNumber *usedBalance;
@property (nonatomic, copy  ) NSString *tags;//兴趣标签
@property (nonatomic, copy  ) NSString *company;
@property (nonatomic, copy  ) NSString *maritalStatus;//0:单身, 1:已婚, 2:离异
@property (nonatomic, copy  ) NSString *title;//职位
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, copy  ) NSString *birthday;
@property (nonatomic, copy  ) NSString *userName;
@property (nonatomic, copy  ) NSString *department;
@property (nonatomic, copy  ) NSString *faceImg;
@property (nonatomic, copy  ) NSString *province;
@property (nonatomic, copy  ) NSString *city;
@property (nonatomic, copy  ) NSString *district;
@property (nonatomic, copy  ) NSString *constellation;//星座
@property (nonatomic, copy  ) NSString *phone;

@end




