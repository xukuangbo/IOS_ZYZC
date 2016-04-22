//
//  TacticSingleHeadView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticSingleHeadView.h"
#import "TacticSingleViewController.h"
@implementation TacticSingleHeadView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
        namelabel.font = [UIFont systemFontOfSize:33];
        namelabel.centerX = self.centerX;
        namelabel.centerY = TacticSingleHeadViewHeight * 0.5;
        [self addSubview:namelabel];
        self.nameLabel = namelabel;
    }
    return self;
}
@end
