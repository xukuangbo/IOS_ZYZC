//
//  TravelSecondCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/25.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCBaseTableViewCell.h"
#import "FZCContentEntryView.h"
#import "AddDetailView.h"
#import "MoreFZCTravelOneDayDetailMdel.h"
#define TRAVELSECONDCELLHEIGHT 260
#define TRAVELOPENHEIGHT  200
typedef void(^ReloadTableBlock)(BOOL isChangeHeight);
@interface TravelSecondCell : MoreFZCBaseTableViewCell
@property (nonatomic, strong) FZCContentEntryView *contentEntryView;
@property (nonatomic, strong) AddDetailView       *addView;
@property (nonatomic, copy  ) ReloadTableBlock    reloadTableBlock;
@property (nonatomic, assign) BOOL                isOpenView;
@property (nonatomic, strong) MoreFZCTravelOneDayDetailMdel *oneDetailModel;
@property (nonatomic, copy  ) NSString            *soundFileName;
/**
 *  存储数据到模型中
 */
-(void)saveTravelOneDayDetailData;

@end
