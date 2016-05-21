//
//  ZYZCCusomMovieImage.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/22.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define IOS8 [[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0
#import "ZYZCCusomMovieImage.h"
#import "ZYZCPlayViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "ZYZCAVPlayer.h"
@implementation ZYZCCusomMovieImage

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode=UIViewContentModeScaleAspectFill;
        self.layer.masksToBounds=YES;
        self.userInteractionEnabled=YES;
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    self.layer.cornerRadius=KCORNERRADIUS;
    self.layer.masksToBounds=YES;
    self.backgroundColor=[UIColor ZYZC_BgGrayColor];
    
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
//        AVPlayer *player=[AVPlayer playerWithURL:[NSURL URLWithString:self.playUrl]];
//        [player play];
//        [ZYZCAVPlayer sharedZYZCAVPlayer].player = player;
//        [self addSubview:[ZYZCAVPlayer sharedZYZCAVPlayer].view];
//        [[ZYZCAVPlayer sharedZYZCAVPlayer].view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(0);
//        }];
        //这里尝试推送到一个新的控制器
        if (IOS8) {
            ZYZCPlayViewController *playVC = [[ZYZCPlayViewController alloc] init];
            playVC.urlString = self.playUrl;
            [self.viewController presentViewController:playVC animated:YES completion:nil];
        }
        
    }
}




@end
