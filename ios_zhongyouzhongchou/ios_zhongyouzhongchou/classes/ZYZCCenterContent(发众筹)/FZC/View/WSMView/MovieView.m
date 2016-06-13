//
//  MovieView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define TEXT_01 @"点击上传视屏文件"
#define TEXT_02 @"提示:视屏不能长于10M"
#import "MovieView.h"
#import "MBProgressHUD.h"
#import "ZYZCTool+getLocalTime.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVTime.h>

#import <AssetsLibrary/AssetsLibrary.h>


#import <MediaPlayer/MediaPlayer.h>


#import "XMNPhotoPickerFramework/XMNPhotoPickerFramework.h"
#import "MediaUtils.h"
#import "PromptController.h"
#import "MBProgressHUD+MJ.h"

@interface MovieView ()
@property (nonatomic, strong) MPMoviePlayerController *player;
@property (nonatomic, strong) UIImagePickerController *mediaPickerController;
@property (nonatomic, strong) UIImagePickerController *mediaRecordController;
@property (nonatomic, assign) BOOL isRecordResoure;
@property (nonatomic, strong) UIImage *preMovImg;
@property (nonatomic, assign) BOOL isBigFile;

@property (nonatomic, strong) XMNPhotoPickerController* picker;
@property (nonatomic, strong) UIImage *movImage;
@property (nonatomic, strong) NSURL *originMovUrl;

@property (nonatomic, strong) NSMutableArray<XMNAssetModel*>* models;

@end

@implementation MovieView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)configUI{
    
    UIButton *addMovieBtn=[UIButton buttonWithType:UIButtonTypeCustom ];
    addMovieBtn.frame=CGRectMake((self.width-58)/2, 20, 58, 38);
    [addMovieBtn setImage:[UIImage imageNamed:@"ico_scspi"] forState:UIControlStateNormal];
    addMovieBtn.userInteractionEnabled=NO;
    [self addSubview:addMovieBtn];
    
    UILabel *alertLab01=[[UILabel alloc]initWithFrame:CGRectMake(0, addMovieBtn.bottom+10, self.width, 20)];
    alertLab01.text=TEXT_01;
    alertLab01.textAlignment=NSTextAlignmentCenter;
    alertLab01.font=[UIFont systemFontOfSize:17];
    alertLab01.textColor=[UIColor ZYZC_TextGrayColor01];
    [self addSubview:alertLab01];
    
    UILabel *alertLab02=[[UILabel alloc]initWithFrame:CGRectMake(0, alertLab01.bottom+10, self.width, 20)];
    alertLab02.text=TEXT_02;
    alertLab02.textColor=[UIColor ZYZC_MainColor];
    alertLab02.textAlignment=NSTextAlignmentCenter;
    alertLab02.font=[UIFont systemFontOfSize:15];
    [self addSubview:alertLab02];
    
    _movieImg=[[UIImageView alloc]initWithFrame:self.bounds];
    _movieImg.contentMode=UIViewContentModeScaleAspectFill;
    [self addSubview:_movieImg];
        
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addMyMovie:)];
    [self addGestureRecognizer:tap];
    
    _turnImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_movieImg.width-50, _movieImg.height-50, 40, 40)];
    _turnImageView.image=[UIImage imageNamed:@"icon_change_video"];
    _turnImageView.hidden=YES;
    _turnImageView.userInteractionEnabled=NO;
    [_movieImg addSubview:_turnImageView];
}

-(void)addMyMovie:(UIGestureRecognizer *)tap
{
    _isRecordResoure=NO;
    _isBigFile=NO;
#pragma mark --- 选择本地视屏
    //相册是否允许访问
    ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied)
    {
        //不允许
        UIAlertView *alertView01=[[UIAlertView alloc]initWithTitle:@"您屏蔽了选择相册的权限，开启请去系统设置->隐私->我的App来打开权限" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView01 show];
        return;
    }
    
    _picker = [[XMNPhotoPickerController alloc] initWithMaxCount:9 delegate:nil];
    _picker.autoPushToPhotoCollection=NO;
    _picker.autoPushToVideoCollection=YES;
    __weak typeof(self) weakSelf = self;
//    选择视频后回调
    [_picker setDidFinishPickingVideoBlock:^(UIImage * _Nullable image, XMNAssetModel * _Nullable asset) {
        weakSelf.movImage=image;
        [weakSelf compressVideo:asset.asset];
    }];
//    点击取消
    [_picker setDidCancelPickingBlock:^{
        [weakSelf.viewController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self.viewController presentViewController:_picker animated:YES completion:nil];
}

-(void)compressVideo:(PHAsset *)asset
{
     __weak typeof (&*self)weakSelf=self;
     weakSelf.movieFileName= [NSString stringWithFormat:@"%@.mp4",KMY_ZC_FILE_PATH(weakSelf.contentBelong)];
     [PromptManager showJPGHUDWithMessage:@"视频压缩中…" inView:weakSelf.picker.view];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MediaUtils compressVideo:asset completeHandler:^(AVAssetExportSession *exportSession, NSURL *compressedOutputURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [PromptManager dismissJPGHUD];
                if (exportSession.status == AVAssetExportSessionStatusCompleted) {
                    /******* 压缩成功*******/
                    long long fileSize=[MediaUtils getFileSize:compressedOutputURL.path];
                    CGFloat M_Size=fileSize/(1024.0 * 1024.0);
                    NSLog(@"+++++压缩后文件大小:%fM",M_Size);
                    /******* 判断压缩后文件大小*******/
                    if (fileSize > 1024 * 1024 * 10) {
                        /******* 压缩后文件较大，删除文件*******/
                        [MediaUtils deleteFileByPath:[compressedOutputURL path]];
                        [weakSelf.viewController dismissViewControllerAnimated:YES completion:^{
                            [MBProgressHUD showError:@"视频过大,获取失败"];
                            weakSelf.movImage=nil;
                        }];
                        return ;
                    }
                    /******* 压缩后文件满足要求*******/
                    //复制文件到指定位置
                    [MediaUtils deleteFileByPath:weakSelf.movieFileName];
                    NSFileManager *fileManager=[NSFileManager defaultManager];
                    BOOL copySuccess=
                    [fileManager copyItemAtPath:[compressedOutputURL path]  toPath:weakSelf.movieFileName error:nil];
                    if (copySuccess) {
                        //删除源视频
                        [MediaUtils deleteFileByPath:[compressedOutputURL path]];
                        //将图片数据转换成png格式文件并存储
                        weakSelf.movieImgFileName=[NSString stringWithFormat:@"%@.png",KMY_ZC_FILE_PATH(weakSelf.contentBelong)];
                        [MediaUtils deleteFileByPath:weakSelf.movieImgFileName];
                        if (weakSelf.movImage){
                            [UIImagePNGRepresentation(weakSelf.movImage) writeToFile:weakSelf.movieImgFileName atomically:YES];
                        }
                        [weakSelf.viewController dismissViewControllerAnimated:YES completion:^{
                            weakSelf.movieImg.image=weakSelf.movImage;
                            weakSelf.turnImageView.hidden=NO;
                            [PromptManager showSuccessJPGHUDWithMessage:@"压缩成功" intView: weakSelf.viewController.view time:1];
                            [weakSelf saveDataInDataManager];
                        }];
                    }
                }
                else{
                    /******* 压缩失败*******/
                    [MBProgressHUD showError:@"数据异常,压缩失败"];
                    weakSelf.movImage=nil;
                    [weakSelf.viewController dismissViewControllerAnimated:YES completion:nil];
                }
            });
        }];
    });
}

#pragma mark  --- 保存数据到单例中
-(void)saveDataInDataManager
{
    //将video文件和第一帧图片路径保存到单例中
    MoreFZCDataManager *dataManager=[MoreFZCDataManager sharedMoreFZCDataManager];
    if ([self.contentBelong isEqualToString:RAISEMONEY_CONTENTBELONG]) {
        dataManager.raiseMoney_movieUrl=self.movieFileName;
        dataManager.raiseMoney_movieImg=self.movieImgFileName;
    }
    else if ([self.contentBelong isEqualToString:RETURN_01_CONTENTBELONG])
    {
        dataManager.return_movieUrl=self.movieFileName;
        dataManager.return_movieImg=self.movieImgFileName;
    }
    else if ([self.contentBelong isEqualToString:RETURN_02_CONTENTBELONG])
    {
        dataManager.return_movieUrl01=self.movieFileName;
        dataManager.return_movieImg01=self.movieImgFileName;
    }
}

/**
 *  获取视屏时长
 */
-(int )getMovieTimeByMovieStr:(NSString *)movieStr
{
    NSURL    *movieURL = [NSURL URLWithString:movieStr];
    NSDictionary *opts = [NSDictionary dictionaryWithObject:
                          [NSNumber numberWithBool:NO]
                                                     forKey:
                          AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:movieURL options:opts];  // 初始化视频媒体文件
    int second = 0;
    second = (int)urlAsset.duration.value / urlAsset.duration.timescale; // 获取视频总时长,单位秒
    return second;
}



@end
