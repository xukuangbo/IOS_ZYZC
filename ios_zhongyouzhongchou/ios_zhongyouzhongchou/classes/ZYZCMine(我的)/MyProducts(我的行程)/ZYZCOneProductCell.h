//
//  ZYZCOneProductCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/6/8.
//  Copyright © 2016年 liuliang. All rights reserved.
//


#define PRODUCT_CELL_HEIGHT 195+135*KCOFFICIEMNT  

#define PRODUCT_DETAIL_CELL_HEIGHT 210

#define MY_ZC_CELL_HEIGHT   195+45+135*KCOFFICIEMNT

#import "ZYZCBaseTableViewCell.h"
#import "ZCListModel.h"
#import "ZCInfoView.h"
#import "ZCDetailCustomButton.h"

@interface ZYZCOneProductCell : ZYZCBaseTableViewCell

@property (nonatomic, strong) ZCOneModel   *oneModel;

@property (nonatomic, assign) ProductType  productType;

@end
