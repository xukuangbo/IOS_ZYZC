//
//  TacticSingleModel.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticSingleModel.h"
#import "TacticSingleFoodModel.h"
#import "TacticSingleTipsModel.h"
@implementation TacticSingleModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"foods" : [TacticSingleFoodModel class],
             };
}



@end
