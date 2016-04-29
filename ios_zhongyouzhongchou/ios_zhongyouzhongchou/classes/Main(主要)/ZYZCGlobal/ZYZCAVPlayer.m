//
//  ZYZCAVPlayer.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/29.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCAVPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
static ZYZCAVPlayer *sharedInstance = nil;

@interface ZYZCAVPlayer(){
    AVAudioPlayer *audioPlayer;
    AVPlayerViewController *vc;
}
@end
@implementation ZYZCAVPlayer

+ (instancetype)sharedZYZCAVPlayer
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
        
    });
    
    return sharedInstance;
}

@end
