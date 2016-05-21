//
//  ZCWSMView.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/19.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYZCCusomMovieImage.h"
#import "ZYZCCustomVoiceView.h"
@interface ZCWSMView : UIView
@property (nonatomic, copy  ) NSString *videoImgUrl;
@property (nonatomic, copy  ) NSString *playUrl;
@property (nonatomic, copy  ) NSString *voiceUrl;
@property (nonatomic, copy  ) NSString *faceImg;
@property (nonatomic, copy  ) NSString *desc;

-(void)reloadDataByVideoImgUrl:(NSString *)videoImgUrl andPlayUrl:(NSString *)playUrl andVoiceUrl:(NSString *)voiceUrl andFaceImg:(NSString *)faceImg andDesc:(NSString *)desc;

@end
