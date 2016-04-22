//
//  TacticImageView.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TacticImageView : UIButton
/**
 *  view类型
 */
@property (nonatomic, assign) NSInteger viewType;
/**
 *  城市的编号
 */
@property (nonatomic, assign) NSInteger viewId;
/**
 *  地名
 */
@property (nonatomic, weak) UILabel *nameLabel;



@end
