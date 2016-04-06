//
//  RecordSoundObj.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/6.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "RecordSoundObj.h"

@implementation RecordSoundObj


/**
 *  设置音频会话
 */
//-(void)setAudioSession{
//    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
//    //设置为播放和录音状态，以便可以在录制完之后播放录音
//    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
//    [audioSession setActive:YES error:nil];
//}
/**
 *  取得录音文件保存路径
 *
 *  @return 录音文件路径
 */
-(NSURL *)getSavePath{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:kRecordAudioFile];
    NSLog(@"file path:%@",urlStr);
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting{
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dicM;
}

/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL *url=[self getSavePath];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

/**
 *  创建播放器
 *
 *  @return 播放器
 */
-(AVAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        NSURL *url=[self getSavePath];
        NSError *error=nil;
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops=0;
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}

#pragma mark --- 语音录制
-(void)recordMySound
{
    [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
}

#pragma mark --- 停止录制
-(void)stopRecordSound
{
    [self.audioRecorder stop];
}

#pragma mark --- 语音播放
-(void)playSound
{
    [self.audioPlayer play];
}

#pragma mark --- 删除语音
-(void)deleteMySound
{
    _audioRecorder=nil;
    _audioPlayer=nil;
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:kRecordAudioFile];
    NSLog(@"urlStr:%@",urlStr);
    NSError *error=nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:urlStr]) {
        [[NSFileManager defaultManager] removeItemAtPath:urlStr error:&error];
    }
    
}


#pragma mark - 录音机代理方法
/**
 *  录音完成，录音完成后播放录音
 *
 *  @param recorder 录音机对象
 *  @param flag     是否成功
 */
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
        NSLog(@"录音完成!");
}

#pragma mark --- 将音频转换为MP3格式
-(void)turnSoundToMP3
{
//    NSString *mp3AudioPath = [[NSString stringWithFormat:@"%@/%@.mp3", DOCUMENTS_FOLDER, @"temp"] retain]; //新转换mp3文件路径
//    
//    //进入转换
//    int read, write;
//    
//    FILE *pcm = fopen([recorderFilePath cStringUsingEncoding:1], "rb");//被转换的文件
//    FILE *mp3 = fopen([mp3AudioPath cStringUsingEncoding:1], "wb");//转换后文件的存放位置
//    
//    const int PCM_SIZE = 8192;
//    
//    const int MP3_SIZE = 8192;
//    
//    short int pcm_buffer[PCM_SIZE*2];
//    
//    unsigned char mp3_buffer[MP3_SIZE];
//    
//    lame_t lame = lame_init();
//    
//    lame_set_in_samplerate(lame, 44100);
//    
//    lame_set_VBR(lame, vbr_default);
//    
//    lame_init_params(lame);
//    
//    do {
//        
//        read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
//        
//        if (read == 0)
//            
//            write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
//        
//        else
//            
//            write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
//        
//        fwrite(mp3_buffer, write, 1, mp3);
//        
//    } while (read != 0);
//    
//    lame_close(lame);
//    
//    fclose(mp3);
//    
//    fclose(pcm);
}

@end
