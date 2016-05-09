//
//  ZCOneProductCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CELL_HEIGHT 186.5+150*KCOFFICIEMNT
@interface ZCOneProductCell : UITableViewCell
@property (nonatomic, strong) UILabel      *titleLab;
@property (nonatomic, strong) UILabel      *recommendLab;
@property (nonatomic, strong) UIImageView  *headImage;
@property (nonatomic, strong) UILabel      *destLab;
@property (nonatomic, strong) UIImageView  *destLayerImg;
@property (nonatomic, strong) UIImageView  *iconImage;
@end
