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
#import <MediaPlayer/MediaPlayer.h>
#import "ZYZCAVPlayer.h"
#import "ZCWebViewController.h"
@interface ZYZCCusomMovieImage ()
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;//视频播放控制器
@end

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
        //如果是本地视屏
        NSRange range=[_playUrl rangeOfString:KMY_ZHONGCHOU_FILE];
        if (range.length){
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
            if (!_moviePlayer) {
                NSURL *url=[NSURL fileURLWithPath:self.playUrl];
                _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
                _moviePlayer.view.frame=CGRectMake(0, KSCREEN_H, KSCREEN_W, KSCREEN_H);
                 _moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
                _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
                [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_moviePlayer.view];
            }
            __weak typeof (&*self)weakSelf=self;
            [UIView animateWithDuration:0.1 animations:^{
                weakSelf.moviePlayer.view.top=0;
            } completion:^(BOOL finished) {
                [_moviePlayer play];
            }];
        }
        //网络视屏
        else{
            NSRange range=[_playUrl rangeOfString:@".html"];
            if (range.length) {
                ZCWebViewController *webController=[[ZCWebViewController alloc]init];
                webController.requestUrl=_playUrl;
                webController.myTitle=@"视频播放";
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:webController animated:YES completion:nil];
                return;
            }
            if (IOS8) {
                ZYZCPlayViewController *playVC = [[ZYZCPlayViewController alloc] init];
                playVC.urlString = self.playUrl;
                [self.viewController presentViewController:playVC animated:YES completion:nil];
            }
        }
        
    }
}

-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    __weak typeof (&*self)weakSelf=self;
    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.moviePlayer.view.top=KSCREEN_H ;
    } completion:^(BOOL finished) {
    }];
}

-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
