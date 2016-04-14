//
//  CustomItemView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "CustomItemView.h"

@implementation CustomItemView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
-(void)configUI
{
    _itemBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _itemBtn.frame=CGRectMake(0, 0, 55, 55);
    [self addSubview:_itemBtn];
    
    _itemLab=[[UILabel alloc]initWithFrame:CGRectMake(-20, 65, 95, 30)];
    _itemLab.font=[UIFont systemFontOfSize:20];
    _itemLab.textColor=[UIColor whiteColor];
    _itemLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_itemLab];
    
}
@end
