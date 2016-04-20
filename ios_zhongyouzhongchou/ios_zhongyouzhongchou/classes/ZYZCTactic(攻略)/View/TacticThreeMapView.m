
//
//  TacticThreeMapView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticThreeMapView.h"
#import "TacticVideoModel.h"
#import "TacticImageView.h"
@interface TacticThreeMapView()
@property (nonatomic, weak) TacticImageView *firstView;
@property (nonatomic, weak) TacticImageView *secondView;
@property (nonatomic, weak) TacticImageView *thirdView;
@end
@implementation TacticThreeMapView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat buttonWH = 90;
        CGFloat leftRightMargin = 10;
        CGFloat centenMargin = (frame.size.width - leftRightMargin * 2 - buttonWH * 3) * 0.5;
        for (int i = 0; i < 3; i++) {
            CGFloat buttonX = leftRightMargin + i * (centenMargin + buttonWH);
            CGFloat buttonY = 0;
            TacticImageView *button = [[TacticImageView alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonWH, buttonWH)];
            button.frame = CGRectMake(buttonX, buttonY, buttonWH, buttonWH);
            [self addSubview:button];
            
            if (i == 0) {
                self.firstView = button;
            }else if(i == 1) {
                self.secondView = button;
            }else if(i == 2) {
                self.thirdView = button;
            }
        }
        
    }
    return self;
}


- (void)setVideos:(NSArray *)videos
{
    if (_videos != videos) {
        _videos = videos;
        if (videos.count >= 3) {
            for (int i = 0; i < videos.count; i++) {
            
                TacticVideoModel *videoModel = (TacticVideoModel *)videos[i];
                if (i == 0) {
                    [self.firstView sd_setImageWithURL:[NSURL URLWithString:videoModel.viewImg]];
                    self.firstView.nameLabel.text = videoModel.name;
                }
                if (i == 1) {
                    [self.secondView sd_setImageWithURL:[NSURL URLWithString:videoModel.viewImg]];
                    self.secondView.nameLabel.text = videoModel.name;
                }
                if (i == 2) {
                    [self.thirdView sd_setImageWithURL:[NSURL URLWithString:videoModel.viewImg]];
                    self.thirdView.nameLabel.text = videoModel.name;
                }
                
            }//如果大于三，以后再说
        }
    }
}
@end
