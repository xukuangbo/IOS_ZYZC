//
//  ZCDetailBottomView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/23.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailBottomView.h"
#import "MBProgressHUD+MJ.h"
#import "WXApiManager.h"
@implementation ZCDetailBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.size=CGSizeMake(KSCREEN_W, 49);
        self.left=0;
        self.top=KSCREEN_H-self.height;
        self.backgroundColor=[UIColor ZYZC_TabBarGrayColor];
        [self addSubview:[UIView lineViewWithFrame:CGRectMake(0, 0, KSCREEN_W, 0.5) andColor:[UIColor lightGrayColor]]];
    }
    return self;
}


-(void)setDetailProductType:(DetailProductType)detailProductType
{
    _detailProductType=detailProductType;
     NSArray *titleArr=nil;
    if (detailProductType==PersonDetailProduct) {
        titleArr=@[@"评论",@"支持",@"推荐"];
    }
    else if(detailProductType==MineDetailProduct)
    {
        titleArr=@[@"补充说明",@"支持自己"];
    }
    if (!titleArr.count) {
        return;
    }
    CGFloat btn_width=KSCREEN_W/titleArr.count;
    for (int i=0; i<titleArr.count; i++) {
        UIButton *sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame=CGRectMake(btn_width*i, self.height/2-20, btn_width, 40);
        [sureBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font=[UIFont systemFontOfSize:20];
        sureBtn.layer.cornerRadius=KCORNERRADIUS;
        sureBtn.layer.masksToBounds=YES;
        [sureBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.tag=CommentType+i;
        [self addSubview:sureBtn];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSupportButton:) name:KCAN_SUPPORT_MONEY object:nil];
}


#pragma mark --- 底部按钮点击事件
-(void)clickBtn:(UIButton *)sender
{
    if (_buttonClick) {
        _buttonClick(sender.tag);
    }
}

#pragma mark --- 如果可以支持，支持按钮变为支付
-(void)changeSupportButton:(NSNotification *)notify
{
    NSString *str=notify.object;
    
    _payMoneyBlock=^(NSNumber *productId){
        NSMutableDictionary *mutDic=[NSMutableDictionary dictionaryWithDictionary:[ZYZCTool turnJsonStrToDictionary:notify.object]];
        [mutDic setObject:productId forKey:@"productId"];
        NSNumber *style2=mutDic[@"style2"];
        if ( style2&&[style2 isEqual:@0]) {
            [MBProgressHUD showError:@"请添加支持任意金额数"];
            return ;
        }
        NSLog(@"mutDic:%@",mutDic);
        WXApiManager *wxManager=[WXApiManager sharedManager];
        [wxManager payForWeChat:mutDic];
    };
    
    UIButton *supportBtn=(UIButton *)[self viewWithTag:SupportType];
     if([str isEqualToString:@"hidden"])
    {
        _surePay=NO;
        [supportBtn setTitle:@"支持" forState:UIControlStateNormal];
        [supportBtn setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
        supportBtn.backgroundColor=[UIColor clearColor];
    }
     else {
         _surePay=YES;
         [supportBtn setTitle:@"支付" forState:UIControlStateNormal];
         [supportBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         supportBtn.backgroundColor=[UIColor ZYZC_MainColor];
     }

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:KCAN_SUPPORT_MONEY object:nil];
}


@end
