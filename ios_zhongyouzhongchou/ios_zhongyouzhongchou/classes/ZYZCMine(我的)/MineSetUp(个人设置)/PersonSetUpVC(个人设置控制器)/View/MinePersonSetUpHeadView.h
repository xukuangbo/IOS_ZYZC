//
//  MinePersonSetUpHeadView.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBlurView.h"
#define imageHeadHeight (KSCREEN_W / 16 * 9)
@interface MinePersonSetUpHeadView : UIImageView
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, strong) FXBlurView *blurView;

- (void)addFXBlurView;
@end
