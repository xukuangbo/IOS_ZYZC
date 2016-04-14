//
//  ZCMainTableViewCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCMainModel.h"
#import "ZCDetailInfoModel.h"
@interface ZCMainTableViewCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UIImageView  *bgImg;
@property(nonatomic,weak)IBOutlet  UILabel      *titleLab;
@property(nonatomic,weak)IBOutlet  UILabel      *recommendLab;
@property(nonatomic,weak)IBOutlet  UIImageView  *sceneryImg;
@property(nonatomic,weak)IBOutlet  UIImageView  *iconImg;
@property(nonatomic,weak)IBOutlet  UILabel      *preMoneyLab;
@property(nonatomic,weak)IBOutlet  UILabel      *timeLab;
@property(nonatomic,weak)IBOutlet  UILabel      *collectionMoneyLab;
@property(nonatomic,weak)IBOutlet  UILabel      *progressLab;
@property(nonatomic,weak)IBOutlet  UILabel      *leftDayLab;
@property(nonatomic,weak)IBOutlet  UIView       *bgIconView;
@property(nonatomic,weak)IBOutlet  UIImageView  *progressBgImg;
@property(nonatomic,weak)IBOutlet  UIView       *infoView;

@property(nonatomic,strong)ZCMainModel *mainModel;
@property(nonatomic,strong)ZCDetailInfoModel *detailInfoModel;
@end
