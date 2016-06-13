//
//  MineTravelTagsCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineTravelTagsCell.h"
#import "MineTravelTagsModel.h"
@implementation MineTravelTagsCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tagsLabel = [[UILabel alloc]initWithFrame:frame];
        _tagsLabel.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1.0];
        _tagsLabel.layer.cornerRadius = 5;
        _tagsLabel.layer.masksToBounds = YES;
        _tagsLabel.layer.borderColor = [UIColor ZYZC_TextGrayColor].CGColor;
        _tagsLabel.layer.borderWidth = 1;
        _tagsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tagsLabel];
    }
    return self;
}
@end
