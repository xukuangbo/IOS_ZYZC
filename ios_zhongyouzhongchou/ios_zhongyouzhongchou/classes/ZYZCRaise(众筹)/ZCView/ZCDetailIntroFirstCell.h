//
//  ZCDetailIntroFirstCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCBaseTableViewCell.h"
#import "ZCDetailIntroFirstCellVoiceShowView.h"
#import "ZCDetailIntroFirstCellModel.h"
#import "ZCDetailModel.h"
#import "ZYZCCusomMovieImage.h"
@interface ZCDetailIntroFirstCell : MoreFZCBaseTableViewCell

@property (nonatomic, strong) ZYZCCusomMovieImage *movieImg;
@property (nonatomic, strong) UILabel             *textLab;
@property (nonatomic, strong) ZCDetailIntroFirstCellVoiceShowView *voiceShow;
@property (nonatomic, strong) ZCDetailProductModel *cellModel;
@property (nonatomic, assign) BOOL hasMovie;
@property (nonatomic, assign) BOOL hasVoice;
@property (nonatomic, assign) BOOL hasWord;
-(void)configUI;
-(void)reloadDataByModel;
@end
