//
//  ZYZCPlayViewController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/2.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCPlayViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ZYZCPlayViewController ()

@end

@implementation ZYZCPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
////    self.navigationController.navigationBar.hidden = YES;
//    self.tabBarController.tabBar.hidden = YES;
//    
//    NSLog(@"%@",NSStringFromCGRect(self.videoBounds));
//}
//
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    
////    self.navigationController.navigationBar.hidden = NO;
//    self.tabBarController.tabBar.hidden = NO;
//}

- (void)setUrlString:(NSString *)urlString
{
    if (_urlString != urlString) {
        _urlString  = urlString;
        
        //urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//url只支持英文和少数其它字符，因此对url中非标准字符需要进行编码，这个编码方*****能不完善，因此使用下面的方法编码。
        NSString *newUrlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *netUrl = [NSURL URLWithString:newUrlString];
        AVPlayer *player = [AVPlayer playerWithURL:netUrl];
        self.player = player;
        [player play];
    }
    
}

@end
