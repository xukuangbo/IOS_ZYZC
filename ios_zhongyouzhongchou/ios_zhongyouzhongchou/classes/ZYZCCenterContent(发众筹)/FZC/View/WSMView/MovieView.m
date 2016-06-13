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
        NSLog(@"asset:%@",asset.asset);
        
        weakSelf.movImage=image;
        [weakSelf compressVideo:asset.asset];
    }];
//    点击取消
    [_picker setDidCancelPickingBlock:^{
        [weakSelf.viewController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self.viewController presentViewController:_picker animated:YES completion:nil];
}

-(void)compressVideo:(PHAsset*)asset{
    [PromptManager showJPGHUDWithMessage:@"正在获取视屏文件…" inView:_picker.view];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MediaUtils writePHVedio:asset toPath:nil block:^(NSURL *url) {
            if (!url) {
                //写入失败
                dispatch_async(dispatch_get_main_queue(), ^{
                    [PromptManager dismissJPGHUD];
                    [self.viewController dismissViewControllerAnimated:YES completion:^{
                        [MBProgressHUD showError:@"读取数据失败"];
                        self.movImage=nil;
                    }];
                });
            }else{
                //写入成功
                self.originMovUrl=url;
                long long fileSize=[MediaUtils getFileSize:[url path]];
                CGFloat M_Size=fileSize/(1024.0 * 1024.0);
                NSLog(@"+++++文件大小:%fM",M_Size);
                //原文件大于300M,警告提醒，可能压缩后会大于10M导致视频上传失败
                if (M_Size>300.0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [PromptManager dismissJPGHUD];
                        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"视频文件较大，压缩后可能大于10M,是否继续？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                        [alertView show];
                        return ;
                    });
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self compressVideoByUrl:url];
                    });
                }
            }
        }];
    });
}

#pragma mark ---压缩视屏
-(void)compressVideoByUrl:(NSURL *)url
{
    self.movieFileName= [NSString stringWithFormat:@"%@.m4v",KMY_ZC_FILE_PATH(self.contentBelong)];
         [PromptManager dismissJPGHUD];
         [PromptManager showJPGHUDWithMessage:@"视频压缩中…" inView:_picker.view];
    __weak typeof (&*self)weakSelf=self;
    [MediaUtils convertVideoQuailtyWithInputURL:url outputURL:nil completeHandler:^(AVAssetExportSession *exportSession, NSURL* compressedOutputURL) {
        [PromptManager dismissJPGHUD];
        if (exportSession.status == AVAssetExportSessionStatusCompleted) {
            /******* 压缩成功*******/
            [MediaUtils deleteFileByPath:url.path];
            long long fileSize=[MediaUtils getFileSize:compressedOutputURL.path];
            CGFloat M_Size=fileSize/(1024.0 * 1024.0);
            NSLog(@"+++++压缩后文件大小:%fM",M_Size);
            
            /******* 判断压缩后文件大小*******/
            if (fileSize > 1024 * 1024 * 10) {
                /******* 压缩后文件较大，删除文件*******/
                [MediaUtils deleteFileByPath:[compressedOutputURL path]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.viewController dismissViewControllerAnimated:YES completion:^{
                        [MBProgressHUD showError:@"视频过大,获取失败"];
                        weakSelf.movImage=nil;
                    }];
                });
                return ;
            }
            /******* 压缩后文件满足要求*******/
                //复制文件到指定位置
               [MediaUtils deleteFileByPath:weakSelf.movieFileName];
                NSFileManager *fileManager=[NSFileManager defaultManager];
                BOOL copySuccess=
                [fileManager copyItemAtPath:[compressedOutputURL path] toPath:weakSelf.movieFileName error:nil];
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
    }];
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        return;
    }
    else if(buttonIndex==1)
    {
        [self compressVideoByUrl:self.originMovUrl];
    }
}



#pragma mark --- imagePickerController 选择后方法回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.movieFileName= [NSString stringWithFormat:@"%@.mp4",KMY_ZC_FILE_PATH(self.contentBelong)];
        //获取媒体类型
        NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        //判断是不是视频
        if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
//            [MBProgressHUD showHUDAddedTo:picker.view animated:YES];
            
            //获取视频文件的url
            NSURL *mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
            
//            //获取视屏第一帧
            _preMovImg=[self thumbnailImageForVideo:mediaURL atTime:1.0];
            
            //计算文件时长
            int mediaTime=[self getMovieTimeByMovieStr:mediaURL.absoluteString];
            if (mediaTime>3*60) {
                 _preMovImg=nil;
                //选择器消失
                __weak typeof (&*self)weakSelf=self;
                [picker dismissViewControllerAnimated:YES completion:^{
                    if (weakSelf.preMovImg) {
                        weakSelf.movieImg.image=weakSelf.preMovImg;
                    }
                    UIAlertView *alertView= [[UIAlertView alloc]initWithTitle:@"视屏时长超过限制，请重新选择" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                }];
            }
            else
            {
                //如果此处已存在文件删除已保存的文件
                [ZYZCTool removeExistfile:self.movieFileName];
                [ZYZCTool removeExistfile:self.movieImgFileName];
                //赋值图片数据
                self.movieImg.image=self.preMovImg;
                self.turnImageView.hidden=NO;
                //保存图片到本地
                [self saveMovieImg];

                //开启线程将文件转换成MP4格式
                 __weak typeof (&*self)weakSelf=self;
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSURL  *inputURL  = mediaURL;
                    NSURL  *outputURL = [NSURL fileURLWithPath:weakSelf.movieFileName];
                    
                    [weakSelf turntoMP4WithInputURL:inputURL
                                      outputURL:outputURL
                                   blockHandler:^(AVAssetExportSession *hander){
                                       NSFileManager *manager=[NSFileManager defaultManager];
                                       //另起线程移除原mov文件
                                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                           NSError *error=nil;
                                           BOOL isRemoveMovFile=[manager removeItemAtURL:inputURL error:&error];
                                           if (isRemoveMovFile) {
                                               NSLog(@"mov文件已移除");
                                           }
                                           else
                                           {
                                               NSLog(@"mov文件未移出");
                                           }
                                       });
                                       
                                       //将MP4文件和第一帧图片路径保存到单例中
                                       MoreFZCDataManager *dataManager=[MoreFZCDataManager sharedMoreFZCDataManager];
                                       if ([weakSelf.contentBelong isEqualToString:RAISEMONEY_CONTENTBELONG]) {
                                           dataManager.raiseMoney_movieUrl=weakSelf.movieFileName;
                                           dataManager.raiseMoney_movieImg=weakSelf.movieImgFileName;
                                       }
                                       else if ([weakSelf.contentBelong isEqualToString:RETURN_01_CONTENTBELONG])
                                       {
                                            dataManager.return_movieUrl=weakSelf.movieFileName;
                                           dataManager.return_movieImg=weakSelf.movieImgFileName;
                                       }
                                       else if ([weakSelf.contentBelong isEqualToString:RETURN_02_CONTENTBELONG])
                                       {
                                           dataManager.return_movieUrl01=weakSelf.movieFileName;
                                           dataManager.return_movieImg01=weakSelf.movieImgFileName;
                                       }
                                   }];
                });
                
                //选择器消失
                [picker dismissViewControllerAnimated:YES completion:nil];
            }
        }
    
        /*
            //计算文件大小
            NSData *movData= [NSData dataWithContentsOfURL:mediaURL];
            NSUInteger  movLength=movData.length;
            NSLog(@"mov文件大小:%ud",movLength);
            
            //如果是视屏录制另起线程保存视屏到相册中
            if (self.isRecordResoure) {
                NSString *urlStr = [mediaURL path];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
                        
                        UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
                    }
                });
            }

            //转成MP4格式并判断文件大小
            NSURL  *inputURL  = mediaURL;
            NSURL  *outputURL = [NSURL fileURLWithPath:[self pathForMP4File]];
            __weak typeof (&*self)weakSelf=self;
            [self turntoMP4WithInputURL:inputURL
                              outputURL:outputURL
                           blockHandler:^(AVAssetExportSession *hander){
                               NSFileManager *manager=[NSFileManager defaultManager];
                               //另起线程移除原mov文件
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                               NSError *error=nil;
                               BOOL isRemoveMovFile=[manager removeItemAtURL:inputURL error:&error];
                               if (isRemoveMovFile) {
                                   NSLog(@"mov文件已移除");
                               }
                               else
                               {
                                   NSLog(@"mov文件未移出");
                               }
                            });
                               //计算MP4文件大小
                               NSData *data= [NSData dataWithContentsOfURL:outputURL];
                               NSUInteger MP4Lenght=data.length;
                               NSLog(@"mp4文件大小为:%ud",MP4Lenght);
                               //如果文件大于20M，不允许上传
                               if (MP4Lenght>20*1024*1024) {
                                   weakSelf.isBigFile=YES;
                                   weakSelf.preMovImg=nil;
                                   //开启线程删除转换的mp4文件
                                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                       NSError *error02=nil;
                                       BOOL isRemoveMP4File=[manager removeItemAtURL:outputURL error:&error02];
                                       if (isRemoveMP4File) {
                                           NSLog(@"mp4文件已移出");
                                       }
                                       else
                                       {
                                           NSLog(@"mp4文件移出失败");
                                       }
                                   });
                                }
                               //文件小于20M
                               else
                               {
                                   //如果此处已保存文件删除已保存的文件
                                   if (weakSelf.myVideoPath) {
                                       //开启线程删除
                                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                           NSError *error03=nil;
                                           BOOL isRemovePreMP4File=[manager removeItemAtURL:weakSelf.myVideoPath error:&error03];
                                           if (isRemovePreMP4File) {
                                               NSLog(@"pre_mp4文件已移出");
                                           }
                                           else
                                           {
                                               NSLog(@"pre_mp4文件移出失败");
                                           }
  
                                       });
                                   }
                                }
                               //记录文件路径
                               weakSelf.myVideoPath=outputURL;
                               
                               //选择器消失
                               [picker dismissViewControllerAnimated:YES completion:^{
                                   [MBProgressHUD hideHUDForView:picker.view animated:YES];
                                   if (weakSelf.preMovImg) {
                                        weakSelf.movieImg.image=weakSelf.preMovImg;
                                   }
                                   if (weakSelf.isBigFile) {
                                       //提示文件过大
                                       UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"文件过大,无法上传" message:nil delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                       [alertView show];
  
                                   }
                               }];
                            }];
            */
            
}

//#pragma mark --- alertView方法回调
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag==KFZC_MOVIERECORDSAVE_TAG||buttonIndex==1) {
//        //保存视频至相册（异步线程）
//        NSString *urlStr = [self.movieFilePath path];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
//                UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
//            }
//        });
//    }
//}

//#pragma mark 视频保存完毕的回调
//- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf{
//    if (error) {
//        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
//    }else{
//        NSLog(@"视频保存成功.");
//    }
//}

/**
 *  获取视屏第一帧图片
 *
 *  @param videoURL 视屏路径／链接
 *  @param time     时间
 *
 *  @return 图片数据
 */
- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    MPMoviePlayerController *mp = [[MPMoviePlayerController alloc]
                                   initWithContentURL:videoURL];
    mp.shouldAutoplay=NO;
    UIImage *images = [mp thumbnailImageAtTime:0.0
                                    timeOption:MPMovieTimeOptionNearestKeyFrame];
    return images;
    
    /*
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil] ;
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset] ;
    
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    
    CFTimeInterval thumbnailImageTime = time;
    
    NSError *thumbnailImageGenerationError = nil;
    
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 10) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
    {
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    }
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    
    return thumbnailImage;
     */
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

/**
 *  视屏压缩（MP4格式转换）
 */
-(void)turntoMP4WithInputURL:(NSURL*)inputURL
                   outputURL:(NSURL *)outputURL
                blockHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        
        exportSession.outputURL =outputURL;
        
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         
         {
             
             switch (exportSession.status) {
                     
                 case AVAssetExportSessionStatusUnknown:
                     
                     NSLog(@"AVAssetExportSessionStatusUnknown");
                     
                     break;
                     
                 case AVAssetExportSessionStatusWaiting:
                     
                     NSLog(@"AVAssetExportSessionStatusWaiting");
                     
                     break;
                     
                 case AVAssetExportSessionStatusExporting:
                     
                     NSLog(@"AVAssetExportSessionStatusExporting");
                     
                     break;
                     
                 case AVAssetExportSessionStatusCompleted:
                     
                     NSLog(@"AVAssetExportSessionStatusCompleted");
                     
                     handler(exportSession);
                     
                     break;
                     
                 case AVAssetExportSessionStatusFailed:
                     
                     NSLog(@"AVAssetExportSessionStatusFailed");
                     
                     break;
                     
                case AVAssetExportSessionStatusCancelled:
                     
                     NSLog(@"AVAssetExportSessionStatusCancelled");
                     
                     break;
             }
             
         }];
    }
}

-(void)saveMovieImg{
    
    self.movieImgFileName=[NSString stringWithFormat:@"%@.png",KMY_ZC_FILE_PATH(self.contentBelong)];
    //将图片数据转换成png格式文件并存储
    if (self.movieImg.image){
        [UIImagePNGRepresentation(self.movieImg.image) writeToFile:self.movieImgFileName atomically:YES];
    }

}

@end
