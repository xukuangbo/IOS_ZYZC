//
//  ZYZCCusomMovieImage.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/22.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCCusomMovieImage.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@implementation ZYZCCusomMovieImage

//为了保证同一时间只有一个播放器，使用单例模式
+ (AVPlayerViewController *)sharedInstance{
    static AVPlayerViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[AVPlayerViewController alloc] init];
    });
    return vc;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    self.layer.cornerRadius=KCORNERRADIUS;
    self.layer.masksToBounds=YES;
    self.backgroundColor=[UIColor orangeColor];
    
    UIImageView *startImg=[[UIImageView alloc]init];
    startImg.bounds=CGRectMake(0, 0, 60, 60);
    startImg.center=CGPointMake(self.width/2, self.height/2);
    startImg.image=[UIImage imageNamed:@"btn_v_on"];
    [self addSubview:startImg];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playMovie:)];
    [self addGestureRecognizer:tap];
    
}

-(void)playMovie:(UITapGestureRecognizer *)tap
{
    if (_playUrl) {
        NSLog(@"播放视频");
        AVPlayer *player=[AVPlayer playerWithURL:[NSURL URLWithString:self.playUrl]];
        [player play];
        [ZYZCCusomMovieImage sharedInstance].player = player;
        [self addSubview:[ZYZCCusomMovieImage sharedInstance].view];
        [[ZYZCCusomMovieImage sharedInstance].view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
    }
}


@end
