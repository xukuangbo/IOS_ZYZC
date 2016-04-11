//
//  MovieView.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "WSMBaseView.h"

@interface MovieView : WSMBaseView<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImageView *movieImg;
@property (nonatomic, strong) NSData      *fileData;
@end