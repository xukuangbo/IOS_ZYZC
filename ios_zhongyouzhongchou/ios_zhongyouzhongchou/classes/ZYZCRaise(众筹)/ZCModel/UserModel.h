//
//  UserModel.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/16.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, strong) NSNumber *usedPoints;
@property (nonatomic, copy  ) NSString *school;
@property (nonatomic, copy  ) NSString *sex;//0未知，1.女，2.男
@property (nonatomic, strong) NSNumber *usedBalance;
@property (nonatomic, copy  ) NSString *tags;//兴趣标签
@property (nonatomic, copy  ) NSString *company;
@property (nonatomic, strong) NSNumber *maritalStatus;//0:单身, 1:已婚, 2:离异
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
@property (nonatomic, strong) NSNumber *weight;
@property (nonatomic, strong) NSNumber *height;

@end
