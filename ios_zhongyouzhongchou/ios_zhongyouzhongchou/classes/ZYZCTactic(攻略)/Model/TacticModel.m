//
//  TacticModel.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticModel.h"
#import "MJExtension.h"
#import "TacticVideoModel.h"
@implementation TacticModel


+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"videos" : [TacticVideoModel class],
             @"mgViews" : [TacticVideoModel class]
             };
}
@end
