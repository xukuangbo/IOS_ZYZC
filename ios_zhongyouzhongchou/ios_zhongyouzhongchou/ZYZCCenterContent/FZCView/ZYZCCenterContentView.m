//
//  ZYZCCenterContentView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCCenterContentView.h"
#import "CustomItemView.h"
//#import "FZCViewController.h"
#import "MoreFZCViewController.h"
@interface ZYZCCenterContentView ()
{
    NSArray *btnArr;
}
@end
@implementation ZYZCCenterContentView
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
    btnArr=@[@"btn_xyj",@"btn_fzc",@"btn_lxxj",@"btn_ht",@"btn_xx",@"btn_dy"];
    NSArray *titleArr=@[@"写游记",@"发众筹",@"旅行照片",@"话题",@"消息",@"订阅"];
    NSInteger numberItems=6;
    CGFloat width=55;
    CGFloat height=95;
    CGFloat distence_x=45;
    CGFloat distence_y=25;
    CGFloat edg_x=(KSCREEN_W-(width*3+distence_x*2))/2;
    CGFloat edg_y=25;
    for (int i=0; i<numberItems; i++) {
        CustomItemView *itemView=[[CustomItemView alloc]initWithFrame:CGRectMake(edg_x+(width+distence_x)*(i%3), edg_y+(height+distence_y)*(i/3), width, height)];
        [itemView.itemBtn setImage:[UIImage imageNamed:btnArr[i]] forState:UIControlStateNormal];
        itemView.tag=KZYZC_CENTERCONTENT_BTN_TAG+i;
        [itemView.itemBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        itemView.itemLab.text=titleArr[i];
        [self addSubview:itemView];
    }
    
    _deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame=CGRectMake((KSCREEN_W-25)/2, self.frame.size.height-37.5, 25, 25);
    [_deleteBtn setImage:[UIImage imageNamed:@"btn_jc"] forState:UIControlStateNormal];
    [self addSubview:_deleteBtn];
}

-(void)clickBtn:(UIButton *)sender
{
    CustomItemView *myItemView=(CustomItemView *)sender.superview;
    for (int i=0; i<6; i++) {
        CustomItemView *itemView=(CustomItemView *)[self viewWithTag:KZYZC_CENTERCONTENT_BTN_TAG+i];
        if ([myItemView isEqual:itemView]) {
            [itemView.itemBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_pre",btnArr[itemView.tag-KZYZC_CENTERCONTENT_BTN_TAG]]] forState:UIControlStateNormal];
            itemView.itemLab.textColor=[UIColor ZYZC_CenterContentTextColor];
        }
        else{
            [itemView.itemBtn setImage:[UIImage imageNamed:btnArr[itemView.tag-KZYZC_CENTERCONTENT_BTN_TAG]] forState:UIControlStateNormal];
            itemView.itemLab.textColor=[UIColor whiteColor];
        }
    }
    
    if (self.deleteBlock) {
        self.deleteBlock();
    }
    
    if (myItemView.tag==KZYZC_CENTERCONTENT_BTN_TAG+1) {
        MoreFZCViewController *fzcVC=[[MoreFZCViewController alloc]init];
        fzcVC.title=@"发起众筹";
        if (self.pushVCBlock) {
             self.pushVCBlock(fzcVC);
        }
    }
}

@end