//
//  RecordSoundObj.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/6.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "lame.h"
@interface RecordSoundObj : NSObject<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;//音频录音机
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;//音频播放器，用于播放录音文件
@property (nonatomic, copy  ) NSString *soundFileName;
/**
 *  语音录制
 */
-(void)recordMySound;
/**
 *  停止语音录制
 */
-(void)stopRecordSound;
/**
 *  语音播放
 */
-(void)playSound;
/**
 *  删除语音
 */
-(void)deleteMySound;

@end
