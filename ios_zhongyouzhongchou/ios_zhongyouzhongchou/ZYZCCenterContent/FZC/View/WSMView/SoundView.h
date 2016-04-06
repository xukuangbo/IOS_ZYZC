//
//  SounceView.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "WSMBaseView.h"
#import "DrawCircleView.h"
@interface SoundView : WSMBaseView
@property (nonatomic, strong)  UILabel *secLab;
@property (nonatomic, strong)  UILabel *milliSecLab;
@property (nonatomic, strong)  UIButton *soundBtn;
@property (nonatomic, strong)  UIButton *playerBtn;
@property (nonatomic, strong)  DrawCircleView *circleView;
@end
