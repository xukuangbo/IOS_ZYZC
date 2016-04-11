//
//  MovieView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define TEXT_01 @"点击上传视屏文件"
#define TEXT_02 @"提示:视屏不能大于20M"
#import "MovieView.h"
#import "MBProgressHUD.h"

#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVTime.h>

#import <AssetsLibrary/AssetsLibrary.h>


#import <MediaPlayer/MediaPlayer.h>


@interface MovieView ()
@property (nonatomic, strong) MPMoviePlayerController *player;
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
    
}

-(void)addMyMovie:(UIGestureRecognizer *)tap
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    __weak typeof (&*self)weakSelf=self;
    //选择手机相册中的视屏
    UIAlertAction *localMediaAction = [UIAlertAction actionWithTitle:@"从手机相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        
        //创建图像选取控制器
        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
        //设置图像选取控制器的来源模式为相机模式
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //设置图像选取控制器的类型
        imagePickerController.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        //允许用户进行编辑
        imagePickerController.allowsEditing = NO;
        
        imagePickerController.videoQuality=UIImagePickerControllerQualityTypeHigh;
        //设置委托对象
        imagePickerController.delegate = self;
        //以模视图控制器的形式显示
        [weakSelf.viewController presentViewController:imagePickerController animated:YES completion:nil];
       
    }];
    //选择视屏拍照
    UIAlertAction *recordMdiaAction = [UIAlertAction actionWithTitle:@"视屏录制" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    [alertController addAction:cancelAction];
    [alertController addAction:localMediaAction];
    [alertController addAction:recordMdiaAction];
    
    [self.viewController presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark --- imagePickerController方法回调

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获取媒体类型
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断是不是视频
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        [MBProgressHUD showHUDAddedTo:picker.view animated:YES];
            //获取视频文件的url
            NSURL *mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"mediaURL:%@",mediaURL);
            //获取视屏第一帧
            UIImage *mediaImg = [self thumbnailImageForVideo:mediaURL atTime:1.0];
            //将第一帧图像赋值给_movieImg
            _movieImg.image=mediaImg;
            //计算文件大小
            NSData *movData= [NSData dataWithContentsOfURL:mediaURL];
            NSUInteger  movLength=movData.length;
            NSLog(@"mov文件大小:%ud",movLength);
        
        //转成MP4格式并判断文件大小
        NSURL  *inputURL  = mediaURL;
        NSURL  *outputURL = [NSURL fileURLWithPath:[self pathForMP4File]];
        
        __weak typeof (&*self)weakSelf=self;
        [self turntoMP4WithInputURL:inputURL
                          outputURL:outputURL
                       blockHandler:^(AVAssetExportSession *hander){
                           //文件转成MP4后移出原mov文件
                           NSFileManager *manager=[NSFileManager defaultManager];
                           NSError *error;
                           BOOL isRemoveFile=[manager removeItemAtURL:inputURL error:&error];
                           if (isRemoveFile) {
                               NSLog(@"mov文件已移除");
                           }
                           else
                           {
                               NSLog(@"mov文件未移出");
                           }
                           //计算MP4文件大小
                           NSData *data= [NSData dataWithContentsOfURL:outputURL];
                           NSUInteger MP4Lenght=data.length;
                           NSLog(@"mp4文件大小为:%ud",MP4Lenght);
                           //如果文件大于20M，不允许上传
                           if (MP4Lenght>20*1024*1024) {
                               NSLog(@"文件过大，上传失败");
                               weakSelf.movieImg=nil;
                           }
            
                           [picker dismissViewControllerAnimated:YES completion:^{
                               [MBProgressHUD hideHUDForView:picker.view animated:YES];
                           }];
                       }];

    }
    
}


/**
 *  获取视屏第一帧图片
 *
 *  @param videoURL 视屏路径／链接
 *  @param time     时间
 *
 *  @return 图片数据
 */
- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
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

/**
 *  视屏文件转换为MP4格式后的存储路径
 */
-(NSString *)pathForMP4File
{
    //用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * filePath = [documentDir stringByAppendingPathComponent:[NSString stringWithFormat:@"output-%@.mp4",[formater stringFromDate:[NSDate date]]]];
    return filePath;
}


@end
