//
//  MoreFZCTravelOneDayDetailMdel.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/29.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCTravelOneDayDetailMdel.h"

@implementation MoreFZCTravelOneDayDetailMdel

MJCodingImplementation

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@", _date,_siteDes,_trafficDes,_accommodateDes,_foodDes,_sitesArr,_travelDes,_travelImgArr,_voiceUrl,_movieUrl];
}
@end
