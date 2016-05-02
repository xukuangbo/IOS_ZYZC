//
//  ZYZCAVPlayer.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/29.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface ZYZCAVPlayer : AVPlayerViewController
+ (AVPlayerViewController *)sharedZYZCAVPlayer;

+ (void)playInView:(UIView *)view url:(NSURL *)url;

+ (void)playInNewController;

@end
