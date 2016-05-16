//
//  ZCCommentModel.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/16.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCCommentModel.h"

@implementation ZCCommentList
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"commentList":@"data"};
}

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"commentList":@"ZCCommentModel"};
}

@end

@implementation ZCCommentModel

@end

@implementation ZCCommentInfoModel

@end
