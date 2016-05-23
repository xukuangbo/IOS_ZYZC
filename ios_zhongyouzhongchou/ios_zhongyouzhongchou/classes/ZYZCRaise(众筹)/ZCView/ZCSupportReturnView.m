//
//  ZCSupportReturnView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCSupportReturnView.h"

@implementation ZCSupportReturnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)configUI
{
    [super configUI];
    
    _wsmView=[[ZCWSMView alloc]initWithFrame:CGRectMake(0, 0, self.width, 0)];
    [self.otherViews addSubview:_wsmView];
    [self changViewFrame];
}

-(void)reloadDataByVideoImgUrl:(NSString *)videoImgUrl andPlayUrl:(NSString *)playUrl andVoiceUrl:(NSString *)voiceUrl andFaceImg:(NSString *)faceImg andDesc:(NSString *)desc
{
    [_wsmView reloadDataByVideoImgUrl:videoImgUrl andPlayUrl:playUrl andVoiceUrl:voiceUrl andFaceImg:faceImg andDesc:desc];
    [self changViewFrame];
}

-(void)changViewFrame
{
    self.limitLab.frame=CGRectMake(0, _wsmView.bottom+KEDGE_DISTANCE, 80, 20);
    self.hasSupportLab.frame=CGRectMake(self.limitLab.right+30, self.limitLab.top, 80, 20) ;
    self.morePeopleBtn.frame=CGRectMake(self.width-50, self.hasSupportLab.top, 50, 20) ;
    self.otherViews.height=self.hasSupportLab.bottom;
    self.height=self.otherViews.bottom+KEDGE_DISTANCE;

}

@end
