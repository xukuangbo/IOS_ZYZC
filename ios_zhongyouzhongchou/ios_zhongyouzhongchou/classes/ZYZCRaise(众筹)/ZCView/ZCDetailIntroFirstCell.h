//
//  ZCDetailIntroFirstCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define ZCDETAILINTRO_FIRSTCELL_HEIGHT  354
#import "MoreFZCBaseTableViewCell.h"
#import "ZCDetailIntroFirstCellVoiceShowView.h"
#import "ZCDetailIntroFirstCellModel.h"
#import <MediaPlayer/MediaPlayer.h>
@interface ZCDetailIntroFirstCell : MoreFZCBaseTableViewCell

@property (nonatomic, strong) UIImageView *movieImg;
@property (nonatomic, strong) UILabel     *textLab;
@property (nonatomic, strong) ZCDetailIntroFirstCellVoiceShowView *voiceShow;
@property (nonatomic, strong) ZCDetailIntroFirstCellModel *cellModel;
@property (nonatomic, assign) BOOL hasMovie;
@property (nonatomic, assign) BOOL hasVoice;
@property (nonatomic, assign) BOOL hasWord;

@end
