//
//  ZYZCAVPlayer.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/29.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCAVPlayer.h"

@interface ZYZCAVPlayer()
@end
@implementation ZYZCAVPlayer

//为了保证同一时间只有一个播放器，使用单例模式
+ (AVPlayerViewController *)sharedZYZCAVPlayer{
    static AVPlayerViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[AVPlayerViewController alloc] init];
    });
    return vc;
}

+ (void)playInView:(UIView *)view url:(NSURL *)url
{
    [ZYZCAVPlayer sharedZYZCAVPlayer].view.frame = view.frame;
    AVPlayer *player=[AVPlayer playerWithURL:url];
    [player play];
    [view addSubview:[ZYZCAVPlayer sharedZYZCAVPlayer].view];
    
}

+ (void)playInNewController
{
    
}
@end
