//
//  TacticImageView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticImageView.h"

@implementation TacticImageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        //添加圆角
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        //给button添加一个底部的label
        CGFloat labelW = frame.size.width;
        CGFloat labelH = 20;
        CGFloat labelX = 0;
        CGFloat labelY = frame.size.height - labelH;
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        nameLabel.backgroundColor = [UIColor ZYZC_MainColor];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.alpha = 0.8;
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
        //添加点击手势
        UIGestureRecognizer *gesture = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
        [self addGestureRecognizer:gesture];
    }
    return self;
}


- (void)clickAction
{
    NSLog(@"点击了！！！");
}
@end
