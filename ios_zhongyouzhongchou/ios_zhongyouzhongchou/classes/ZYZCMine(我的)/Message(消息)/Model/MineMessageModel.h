//
//  MineMessageModel.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/11.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineMessageModel : NSObject
/**
 *  头像
 */
@property (nonatomic, copy) NSString *iconString;
/**
 *  新消息数量
 */
@property (nonatomic, assign) NSInteger newMessageCount;
/**
 *  名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  内容描述
 */
@property (nonatomic, copy) NSString *descString;
/**
 *  时间
 */
@property (nonatomic, copy) NSString *time;
@end
