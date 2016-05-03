//
//  TacticImageView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticImageView.h"
#import "TacticSingleViewController.h"
#import "TacticSingleFoodController.h"
@implementation TacticImageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.userInteractionEnabled = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
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
        
        [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
//这里写个跳转到单个景点
- (void)clickAction:(UIButton *)button
{
    if (self.viewType == 3) {
        NSLog(@"这是一个景点的描述！！！！！");
        
        
    }else if (self.viewType == 1 || self.viewType == 2){
        TacticSingleViewController *singleVC = [[TacticSingleViewController alloc] initWithViewId:self.viewId];
        [self.viewController.navigationController pushViewController:singleVC animated:YES];
    }else if (self.viewType == 0){
        //说明他不是一个国家那种东西，而是一个景点
        
        TacticSingleFoodController *foodVC = [[TacticSingleFoodController alloc] init];
        foodVC.tacticSingleFoodModel = self.tacticSingleFoodModel;
        
        [self.viewController.navigationController pushViewController:foodVC animated:YES];
    }
    
    
    
}
@end
