//
//  MineWalletModel.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/10.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineWalletModel : NSObject


/**
 *  项目图片
 */
@property (nonatomic, copy) NSString *projectImg;
/**
 *  名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  总金额
 */
@property (nonatomic, copy) NSString *totalMoney;
/**
 *  提现时间
 */
@property (nonatomic, copy) NSString *drawMoneyTime;
/**
 *  项目名称
 */
@property (nonatomic, copy) NSString *projectName;

@end
