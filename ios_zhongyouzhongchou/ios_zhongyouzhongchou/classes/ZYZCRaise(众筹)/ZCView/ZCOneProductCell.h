//
//  ZCOneProductCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCInfoView.h"
#import "ZCListModel.h"
#define PRODUCT_CELL_HEIGHT 195+135*KCOFFICIEMNT
@interface ZCOneProductCell : UITableViewCell
@property (nonatomic, strong) UILabel      *titleLab;
@property (nonatomic, strong) UILabel      *recommendLab;
@property (nonatomic, strong) UIImageView  *headImage;
@property (nonatomic, strong) UILabel      *destLab;
@property (nonatomic, strong) UIImageView  *destLayerImg;
@property (nonatomic, strong) UIImageView  *iconImage;
@property (nonatomic, strong) UILabel      *nameLab;
@property (nonatomic, strong) UIImageView  *sexImg;
@property (nonatomic, strong) UIImageView  *vipImg;
@property (nonatomic, strong) UILabel      *destenceLab;
@property (nonatomic, strong) UILabel      *jobLab;
@property (nonatomic, strong) UILabel      *infoLab;
@property (nonatomic, strong) UILabel      *moneyLab;
@property (nonatomic, strong) UILabel      *startLab;
@property (nonatomic, strong) UIImageView  *emptyProgress;
@property (nonatomic, strong) UIImageView  *fillProgress;
@property (nonatomic, weak  ) ZCInfoView   *zcInfoView;

@property (nonatomic, strong) ZCOneModel *oneModel;

@end
