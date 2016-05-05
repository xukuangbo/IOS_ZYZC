//
//  MovieView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define TEXT_01 @"点击上传视屏文件"
#define TEXT_02 @"提示:视屏不能长于3分钟"
#import "MovieView.h"
#import "MBProgressHUD.h"
#import "ZYZCTool+getLocalTime.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVTime.h>

#import <AssetsLibrary/AssetsLibrary.h>


#import <MediaPlayer/MediaPlayer.h>


@interface MovieView ()
@property (nonatomic, strong) MPMoviePlayerController *player;
@property (nonatomic, strong) UIImagePickerController *mediaPickerController;
@property (nonatomic, strong) UIImagePickerController *mediaRecordController;
@property (nonatomic, assign) BOOL isRecordResoure;
@property (nonatomic, strong) UIImage *preMovImg;
@property (nonatomic, assign) BOOL isBigFile;
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
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
//    __weak typeof (&*self)weakSelf=self;
#pragma mark --- 选择本地视屏
//    UIAlertAction *localMediaAction = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action)
//    {
        //相册是否允许访问
        ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied)
        {
            //不允许
            UIAlertView *alertView01=[[UIAlertView alloc]initWithTitle:@"您屏蔽了选择相册的权限，开启请去系统设置->隐私->我的App来打开权限" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView01 show];
            return;
        }
        
        //创建图像选取控制器
        self.mediaPickerController=[[UIImagePickerController alloc]init];
        //设置图像选取控制器的类型
        self.mediaPickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        //允许用户进行编辑
        self.mediaPickerController.allowsEditing = NO;
        //设置委托对象
        self.mediaPickerController.delegate = self;
        //视频上传质量
        self.mediaPickerController.videoQuality=UIImagePickerControllerQualityTypeHigh;
        //设置图像选取控制器的来源模式为相册模式
          self.mediaPickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
       //视屏时长限制
         self.mediaPickerController.videoMaximumDuration=3;
        //以模视图控制器的形式显示
          [self.viewController presentViewController:self.mediaPickerController animated:YES completion:nil];
//    }];
/*
#pragma mark --- 视屏录制
    UIAlertAction *recordMdiaAction = [UIAlertAction actionWithTitle:@"视屏录制" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        _isRecordResoure=YES;
        //相机是否允许访问
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            //无权限
            UIAlertView *alertView02=[[UIAlertView alloc]initWithTitle:@"您屏蔽了使用相机的权限，开启请去系统设置->隐私->我的App来打开权限" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView02 show];
            return;
        }
        //创建图像选取控制器
        weakSelf.mediaRecordController=[[UIImagePickerController alloc]init];
        //设置图像选取控制器的类型
        weakSelf.mediaRecordController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        //允许用户进行编辑
        weakSelf.mediaRecordController.allowsEditing = NO;
        //设置委托对象
        weakSelf.mediaRecordController.delegate = self;
        //视频上传质量
        weakSelf.mediaRecordController.videoQuality=UIImagePickerControllerQualityTypeHigh;
        //设置图像选取控制器的来源模式为相册模式
        //设置图像选取控制器的来源模式为相机模式
          weakSelf.mediaRecordController.sourceType = UIImagePickerControllerSourceTypeCamera;
        //设置摄像头模式（拍照，录制视频）为录像模式
          weakSelf.mediaRecordController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        //摄像头设置
        weakSelf.mediaRecordController.cameraDevice=UIImagePickerControllerCameraDeviceRear|UIImagePickerControllerCameraDeviceFront;
        //闪光灯设置
        weakSelf.mediaRecordController.cameraFlashMode=UIImagePickerControllerCameraFlashModeOff|UIImagePickerControllerCameraFlashModeOn;
        weakSelf.mediaRecordController.videoMaximumDuration=5;
        if([[[UIDevice   currentDevice] systemVersion] floatValue]>=8.0) {
            weakSelf.mediaRecordController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        }
        [weakSelf.viewController presentViewController:weakSelf.mediaRecordController animated:YES completion:nil];
    }];

    [alertController addAction:cancelAction];
    [alertController addAction:localMediaAction];
    [alertController addAction:recordMdiaAction];
    
    [self.viewController presentViewController:alertController animated:YES completion:nil];
    */
}

#pragma mark --- imagePickerController 选择后方法回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
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
//                    [MBProgressHUD hideHUDForView:picker.view animated:YES];
                    if (weakSelf.preMovImg) {
                        weakSelf.movieImg.image=weakSelf.preMovImg;
                    }
                    UIAlertView *alertView= [[UIAlertView alloc]initWithTitle:@"视屏时长超过限制，请重新选择" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                }];
            }
            else
            {
                //赋值图片数据
                self.movieImg.image=_preMovImg;
                _turnImageView.hidden=NO;
                //保存图片
                [self saveMovieImg];
                
                
                //如果此处已存在文件删除已保存的文件
                if (self.movieFileName) {
                    //开启线程删除
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        NSError *error03=nil;
                        //移除mp4视屏文件
                        NSFileManager *manager=[NSFileManager defaultManager];
                        [manager removeItemAtURL:[NSURL fileURLWithPath:KMY_ZHONGCHOU_DOCUMENT_PATH(self.movieFileName)]  error:&error03];
                        
                        //同时移除视屏图片文件
                        [manager removeItemAtURL:[NSURL fileURLWithPath:KMY_ZHONGCHOU_DOCUMENT_PATH(self.movieImgFileName)]  error:nil];
                        
                    });
                }
                //开启线程将文件转换成MP4格式
                 __weak typeof (&*self)weakSelf=self;
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSURL  *inputURL  = mediaURL;
                    
                    NSString *outPutFileName=[NSString stringWithFormat:@"%@/%@/%@.mp4",KDOCUMENT_FILE,KMY_ZHONGCHOU_TMP,[ZYZCTool getLocalTime]];
                    NSString *outPutURLStr=KMY_ZHONGCHOU_DOCUMENT_PATH(outPutFileName);
                    NSURL  *outputURL = [NSURL fileURLWithPath:outPutURLStr];
                    
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
                                       //记录mp4文件名
                                       weakSelf.movieFileName=outPutFileName;
                                       
                                       //将MP4文件和第一帧图片路径保存到单例中
                                       MoreFZCDataManager *dataManager=[MoreFZCDataManager sharedMoreFZCDataManager];
                                       if ([self.contentBelong isEqualToString:RAISEMONEY_CONTENTBELONG]) {
                                           dataManager.raiseMoney_movieUrl=outPutFileName;
                                           dataManager.raiseMoney_movieImg=weakSelf.movieImgFileName;
                                       }
                                       else if ([self.contentBelong isEqualToString:RETURN_01_CONTENTBELONG])
                                       {
                                            dataManager.return_movieUrl=outPutFileName;
                                           dataManager.return_movieImg=weakSelf.movieImgFileName;
                                       }
                                       else if ([self.contentBelong isEqualToString:RETURN_02_CONTENTBELONG])
                                       {
                                           dataManager.return_movieUrl01=outPutFileName;
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
//    
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
    
    self.movieImgFileName=[NSString stringWithFormat:@"%@/%@/%@.png",KDOCUMENT_FILE,KMY_ZHONGCHOU_TMP,[ZYZCTool getLocalTime]];
    //将图片数据转换成png格式文件并存储
    if (self.movieImg.image){
        [UIImagePNGRepresentation(self.movieImg.image) writeToFile:KMY_ZHONGCHOU_DOCUMENT_PATH(self.movieImgFileName) atomically:YES];
    }

}

//#pragma mark --- 视屏文件转换为MP4格式后的存储路径

//-(NSString *)pathForMP4File
//{
//
//    NSString *documentsPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
//    NSString * filePath=[NSString stringWithFormat:@"%@/%@/%@/%@.mp4",documentsPath,KDOCUMENT_FILE,KMY_ZHONGCHOU_TMP,[ZYZCTool getLocalTime]];
//    return filePath;
//}

//#pragma mark --- 获取图片存储在tmp的路径下
//-(NSString *)getImagePath
//{
//    NSString *documentsPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
//    NSString * pngPath=[NSString stringWithFormat:@"%@/%@/%@/%@.png",documentsPath,KDOCUMENT_FILE,KMY_ZHONGCHOU_TMP,[ZYZCTool getLocalTime]];
//    
//    //将图片数据转换成png格式文件到tmp中
//    if (self.movieImg.image){
//        [UIImagePNGRepresentation(self.movieImg.image) writeToFile:pngPath atomically:YES];
//    }
//    return pngPath;
//}

@end
