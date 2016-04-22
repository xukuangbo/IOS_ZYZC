//
//  ZYZCCusomMovieImage.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/22.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCCusomMovieImage.h"

@implementation ZYZCCusomMovieImage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    self.layer.cornerRadius=KCORNERRADIUS;
    self.layer.masksToBounds=YES;
    self.backgroundColor=[UIColor orangeColor];
    
    UIImageView *startImg=[[UIImageView alloc]init];
    startImg.center=CGPointMake(self.width/2, self.height/2);
    startImg.bounds=CGRectMake(0, 0, 60, 60);
    startImg.image=[UIImage imageNamed:@"btn_v_on"];
    [self addSubview:startImg];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playMovie:)];
    [self addGestureRecognizer:tap];
    
}

-(void)playMovie:(UITapGestureRecognizer *)tap
{
    if (_playUrl) {
        NSLog(@"播放视频");
    }
}


@end
