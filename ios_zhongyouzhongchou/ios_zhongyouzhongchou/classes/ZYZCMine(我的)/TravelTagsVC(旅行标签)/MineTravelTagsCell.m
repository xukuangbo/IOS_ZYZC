//
//  MineTravelTagsCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineTravelTagsCell.h"

@implementation MineTravelTagsCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *tagLabel = [[UILabel alloc]initWithFrame:frame];
        tagLabel.layer.cornerRadius = 5;
        tagLabel.layer.masksToBounds = YES;
        tagLabel.layer.borderColor = [UIColor ZYZC_TextGrayColor].CGColor;
        tagLabel.layer.borderWidth = 1;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:tagLabel];
        self.tagsLabel = tagLabel;
    }
    return self;
}
@end
