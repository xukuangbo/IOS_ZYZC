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

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cellHeight=1.0;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@", _date,_siteDes,_trafficDes,_liveDes,_foodDes,_sites,_wordDes,_imgsDes,_voiceUrl,_movieUrl];
}
@end
