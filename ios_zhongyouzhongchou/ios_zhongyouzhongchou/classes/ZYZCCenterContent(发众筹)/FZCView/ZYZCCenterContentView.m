//
//  ZYZCCenterContentView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCCenterContentView.h"
#import "CustomItemView.h"
#import "MoreFZCViewController.h"
#import "MoreFZCDataManager.h"
#import "MBProgressHUD+MJ.h"
@interface ZYZCCenterContentView ()
{
    NSArray *btnArr;
    UIButton *preBtn;
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
    btnArr=@[@"btn_xyj",@"btn_fzc",@"btn_lxxj"];
    NSArray *titleArr=@[@"写游记",@"发众筹",@"旅行照片"];
    NSInteger numberItems=btnArr.count;
    CGFloat width=55;
    CGFloat height=95;
    CGFloat distence_x=45;
    CGFloat distence_y=25;
    CGFloat edg_x=(KSCREEN_W-(width*3+distence_x*2))/2;
    CGFloat edg_y=25;
    for (int i=0; i<numberItems; i++) {
        CustomItemView *itemView=[[CustomItemView alloc]initWithFrame:CGRectMake(edg_x+(width+distence_x)*(i%3), edg_y+(height+distence_y)*(i/3), width, height)];
        [itemView.itemBtn setImage:[UIImage imageNamed:btnArr[i]] forState:UIControlStateNormal];
        itemView.tag=itemView.itemBtn.tag=KZYZC_CENTERCONTENT_BTN_TAG+i;
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
    if (self.deleteBlock) {
        self.deleteBlock();
    }
    
    if (sender.tag==KZYZC_CENTERCONTENT_BTN_TAG+1) {
        NSString *openId=[ZYZCTool getUserId];
        if (!openId) {
            [MBProgressHUD showError:@"未登录,请先进行登录!"];
            return;
        }
        
        MoreFZCViewController *fzcVC=[[MoreFZCViewController alloc]init];
        fzcVC.title=@"发起众筹";
        if (self.pushVCBlock) {
             self.pushVCBlock(fzcVC);
        }
    }
}

@end
