//
//  SounceView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "SoundView.h"
#import "RecordSoundObj.h"
@interface SoundView ()
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)BOOL    isRecord;
@property (nonatomic, assign)NSInteger secRecord;
@property (nonatomic, assign)NSInteger millisecRecord;
@property (nonatomic, strong)RecordSoundObj *soundObj;
@end

@implementation SoundView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)configUI
{
    //计时显示lab
    _secLab=[[UILabel alloc]initWithFrame:CGRectMake(self.width/2-50, 0, 30, 20)];
    _secLab.font=[UIFont systemFontOfSize:16];
    _secLab.textColor=[UIColor ZYZC_MainColor];
    _secLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:_secLab];
    
    _milliSecLab=[[UILabel alloc]initWithFrame:CGRectMake(self.width/2-20, 0, 20, 20)];
    _milliSecLab.font=[UIFont systemFontOfSize:16];
    _milliSecLab.textColor=[UIColor ZYZC_MainColor];
    [self addSubview:_milliSecLab];
    
    [self changeTimeRecordLab];
    
    UILabel *timeRightLab=[[UILabel alloc]initWithFrame:CGRectMake(self.width/2, 0, self.width/2, 20)];
    timeRightLab.font=[UIFont systemFontOfSize:16];
    timeRightLab.textColor=[UIColor ZYZC_TextGrayColor03];
    timeRightLab.attributedText=[self changeTextFontAndColorByString:@"/60.00"];
    [self addSubview:timeRightLab];
    
    //语音录制按钮
    _soundBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _soundBtn.frame=CGRectMake((self.width-90)/2, _secLab.bottom+10, 90, 90);
    [_soundBtn setBackgroundImage:[UIImage imageNamed:@"btn_yylr_p"] forState:UIControlStateNormal];
    [_soundBtn addTarget:self action:@selector(recordSound) forControlEvents:UIControlEventTouchDown];
    [_soundBtn addTarget:self action:@selector(stopRecordSound) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_soundBtn];
    
    //语音播放按钮
    _playerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _playerBtn.frame=CGRectMake((self.width-90)/2, _secLab.bottom+10, 90, 90);
    [_playerBtn setBackgroundImage:[UIImage imageNamed:@"btn_pzd"] forState:UIControlStateNormal];
    [_playerBtn addTarget:self action:@selector(playerSound) forControlEvents:UIControlEventTouchUpInside];
    _playerBtn.hidden=YES;
    [self addSubview:_playerBtn];
    
    //删除按钮
    UIButton *deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame=CGRectMake((self.width-40)/2, _soundBtn.bottom+10, 40, 20) ;
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [deleteBtn setTitleColor:[UIColor ZYZC_TextBlackColor] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteSound) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
    
    [deleteBtn addSubview:[UIView lineViewWithFrame:CGRectMake(0, deleteBtn.height-1, deleteBtn.width, 1) andColor:[UIColor ZYZC_TextBlackColor]]];
    
    //圆环进度条
    [self createDrawCircle];
    
    //创建语音录制对象
    _soundObj=[[RecordSoundObj alloc]init];
    
}

#pragma mark --- 创建圆环进度条
-(void)createDrawCircle
{
    UIView *view=[[UIView alloc]init];
    view.center=_soundBtn.center;
    view.bounds=CGRectMake(0, 0, 80, 80);
    [self addSubview:view];
    _circleView=[[DrawCircleView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    _circleView.progressColor = [UIColor ZYZC_MainColor];
    _circleView.progressStrokeWidth = 3.f;
    _circleView.progressTrackColor = [UIColor whiteColor];
    [view addSubview:_circleView];
    [self insertSubview:_soundBtn aboveSubview:view];
}

#pragma mark --- 语音录制
-(void)recordSound
{
    
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(changeProgressValue) userInfo:nil repeats:YES];
    }
    
    [_soundObj recordMySound];
}

#pragma mark --- 停止语音录制
-(void)stopRecordSound
{
    [_timer invalidate];
    _timer=nil;
    if (!(_secRecord==0&&_millisecRecord==0)) {
        _playerBtn.hidden=NO;
        _soundBtn.hidden=YES;
        [self insertSubview:_playerBtn aboveSubview:_soundBtn];
        [_soundObj stopRecordSound];
    }
}

#pragma mark --- 播放语音
-(void)playerSound
{
    [_soundObj playSound];
}

#pragma mark --- 删除语音
-(void)deleteSound
{
    _soundBtn.hidden=NO;
    _playerBtn.hidden=YES;
    _circleView.progressValue=0;
    _millisecRecord=0;
    _secRecord=0;
    [self changeTimeRecordLab];
    
    [_soundObj deleteMySound];
}

#pragma mark --- 进度条改变
- (void)changeProgressValue
{
    _circleView.progressValue += 0.01/60;
    if (_circleView.progressValue>=1.f) {
        [_timer invalidate];
        _timer=nil;
    }
    else{
        _millisecRecord+=1;
        if (_millisecRecord==100) {
            _millisecRecord=0;
            _secRecord+=1;
        }
        [self changeTimeRecordLab];
    }
}

#pragma mark ---计时显示改变
-(void)changeTimeRecordLab
{
    _secLab.text=[NSString stringWithFormat:@"%.2zd.",_secRecord];
    _milliSecLab.text=[NSString stringWithFormat:@"%.2zd",_millisecRecord];
    
}

#pragma mark --- 字符串的字体更改
-(NSMutableAttributedString *)changeTextFontAndColorByString:(NSString *)str
{
    NSMutableAttributedString *attrStr=[[NSMutableAttributedString alloc]initWithString:str];
    if (str.length>1) {
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor ZYZC_MainColor] range:NSMakeRange(0, 1)];
    }
   
    return  attrStr;
}


@end
