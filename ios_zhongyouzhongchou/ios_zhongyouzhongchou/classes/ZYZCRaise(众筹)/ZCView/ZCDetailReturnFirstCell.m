//
//  ZCDetailReturnFirstCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/25.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define HASSUPPORTPEOPLE(numberPeople) [NSString stringWithFormat:@"已支持:%d位",numberPeople]
#define RETURNSUPPORT01(money) [NSString stringWithFormat:@"回报支持一:%.2f元",money]
#define RETURNSUPPORT02(money) [NSString stringWithFormat:@"回报支持二:%.2f元",money]

#define TOGETHERSUPPORT(rate,money) [NSString stringWithFormat:@"一起去:支持%d％旅费(%.2f)元",rate,money]

#import "ZCDetailReturnFirstCell.h"

@interface ZCDetailReturnFirstCell ()
@property (nonatomic, strong) NSMutableArray *mySubViews;
@property(nonatomic,  strong) NSNumber *supportOneMoney;
@property(nonatomic,  strong) NSNumber *supportAnyMoney;
@property (nonatomic, strong) NSNumber *returnMoney01;
@property (nonatomic, strong) NSNumber *returnMoney02;
@property (nonatomic, strong) NSNumber *togetherMoney;
@end

@implementation ZCDetailReturnFirstCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)configUI{
    [super configUI];
    [self.topLineView removeFromSuperview];
    [self.titleLab  removeFromSuperview];
    
    NSString *text01=ZYLocalizedString(@"support_one_yuan");
    NSString *text02=ZYLocalizedString(@"supoort_any_yuan");
    NSString *text03=ZYLocalizedString(@"support_return");
    NSString *text04=ZYLocalizedString(@"support_together");;
    
    _mySubViews=[NSMutableArray array];
    _supportOneYuanView =[[ZCSupportOneYuanView alloc]initSupportViewByTop:0 andTitle:@"支持1元" andText:text01 ];
    [self.contentView addSubview:_supportOneYuanView];
    [_mySubViews addObject:_supportOneYuanView];
    
    _supportAnyYuanView =[[ZCSupportAnyYuanView alloc]initSupportViewByTop:_supportOneYuanView.bottom andTitle:@"支持任意金额:" andText:text02];
    [self.contentView addSubview:_supportAnyYuanView];
    [_mySubViews addObject:_supportAnyYuanView];
    _supportAnyYuanView.chooseSupport=NO;
    
    _returnSupportView01 =[[ZCSupportReturnView alloc]initSupportViewByTop:_supportAnyYuanView.bottom andTitle:RETURNSUPPORT01(0.00) andText:text03];
    [self.contentView addSubview:_returnSupportView01];
    [_mySubViews addObject:_returnSupportView01];
    
    _returnSupportView02 =[[ZCSupportReturnView alloc]initSupportViewByTop:_returnSupportView01.bottom andTitle:RETURNSUPPORT02(0.00) andText:text03];
    [self.contentView addSubview:_returnSupportView02];
    [_mySubViews addObject:_returnSupportView02];
    
    _togetherView =[[ZCSupportTogetherView alloc]initSupportViewByTop:_returnSupportView02.bottom andTitle:TOGETHERSUPPORT(0,0.00) andText:text04 ];
    [self.contentView addSubview:_togetherView];
    [_mySubViews addObject:_togetherView];
    
     [self supportCode];
    
}

-(void)setCellModel:(ZCDetailProductModel *)cellModel
{
    _cellModel=cellModel;
    NSArray *report=cellModel.report;
    BOOL hasReturn01=NO,hasReturn02=NO;
    CGFloat totalMoney=0.0;
    for (ReportModel *reportModel in report) {
        if ([reportModel.style intValue]==0) {
            if (reportModel.price) {
                 totalMoney=[reportModel.price floatValue];
            }
        }
        else if ([reportModel.style intValue]==1) {
            //获取我的userId，判断是否已支持过该项目一元
            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            NSString *myUserId=[user objectForKey:KUSER_MARK];
            _supportOneYuanView.users=reportModel.users;
            BOOL hasSupportOneYuan=NO;
            for (UserModel *user in _supportOneYuanView.users) {
                if ([myUserId isEqual:user.userId]) {
                    hasSupportOneYuan=YES;
                }
            }
            if (hasSupportOneYuan) {
                _supportOneYuanView.chooseSupport=NO;
            }
        }
        else if ([reportModel.style intValue]==2)
        {
            _supportAnyYuanView.users=reportModel.users;
        }
        else if ([reportModel.style intValue]==3)
        {
            hasReturn01=YES;
            _returnSupportView01.limitNumber=[reportModel.sumPeople intValue];
            if ([reportModel.sumPeople integerValue]<=reportModel.users.count||[_cellModel.mySelf isEqual:@1]) {
                _returnSupportView01.chooseSupport=NO;
            }
            CGFloat money=[reportModel.price floatValue]/100;
            _returnMoney01=[NSNumber numberWithFloat:money];
            _returnSupportView01.titleLab.text=RETURNSUPPORT01(money);
            _returnSupportView01.titleLab.width=[ZYZCTool calculateStrLengthByText:RETURNSUPPORT01(money) andFont:[UIFont systemFontOfSize:15] andMaxWidth:KSCREEN_W].width;
            
            [_returnSupportView01 reloadDataByVideoImgUrl:reportModel.spellVideoImg andPlayUrl:reportModel.spellVideo andVoiceUrl:reportModel.spellVoice andFaceImg:cellModel.user.faceImg andDesc:reportModel.desc];
            _returnSupportView01.users=reportModel.users;
            }
        else if ([reportModel.style intValue]==4)
        {
            if ([_cellModel.mySelf isEqual:@1]) {
                _togetherView.chooseSupport=NO;
            }
            _togetherView.limitNumber=[reportModel.sumPeople intValue];
            _togetherView.users=reportModel.users;
            CGFloat money=[reportModel.price floatValue]/100;
            _togetherMoney=[NSNumber numberWithFloat:money];
            int  rate=0;
            if (totalMoney) {
                rate=(int)[reportModel.price floatValue]/totalMoney*100;
            }
            _togetherView.titleLab.text=TOGETHERSUPPORT(rate,money);
             _togetherView.titleLab.width=[ZYZCTool calculateStrLengthByText:TOGETHERSUPPORT(rate,money) andFont:[UIFont systemFontOfSize:15] andMaxWidth:KSCREEN_W].width;
        }
        else if ([reportModel.style intValue]==5)
        {
            hasReturn02=YES;
            _returnSupportView02.limitNumber=[reportModel.sumPeople intValue];
            if ([reportModel.sumPeople integerValue]<=reportModel.users.count||[_cellModel.mySelf isEqual:@1]) {
                _returnSupportView02.supportBtn.enabled=NO;
            }
            CGFloat money=[reportModel.price floatValue]/100;
            _returnMoney02=[NSNumber numberWithFloat:money];
            _returnSupportView02.titleLab.text=RETURNSUPPORT02(money);
            _returnSupportView02.titleLab.width=[ZYZCTool calculateStrLengthByText:RETURNSUPPORT02(money) andFont:[UIFont systemFontOfSize:15] andMaxWidth:KSCREEN_W].width;
             [_returnSupportView02 reloadDataByVideoImgUrl:reportModel.spellVideoImg andPlayUrl:reportModel.spellVideo andVoiceUrl:reportModel.spellVoice andFaceImg:cellModel.user.faceImg andDesc:reportModel.desc];
             _returnSupportView02.users=reportModel.users;
        }
    }
    
    _supportAnyYuanView.top=_supportOneYuanView.bottom;
    hasReturn01? _returnSupportView01.top =_supportAnyYuanView.bottom:[_returnSupportView01 removeFromSuperview];
    hasReturn02?_returnSupportView02.top =_supportAnyYuanView.bottom+_returnSupportView01.height*hasReturn01:[_returnSupportView02 removeFromSuperview];
    _togetherView.top =_supportAnyYuanView.bottom+_returnSupportView01.height*hasReturn01+_returnSupportView02.height*hasReturn02;
    self.bgImg.height=_togetherView.bottom;
    cellModel.returnFirtCellHeight=self.bgImg.height;
}


#pragma ark --- 支持
-(void)supportCode
{
    
    __weak typeof (&*self)weakSelf=self;
    _supportOneYuanView.supportBlock=_supportAnyYuanView.supportBlock=_returnSupportView01.supportBlock=_returnSupportView02.supportBlock=_togetherView.supportBlock=^()
    {
        BOOL showSupport=NO;
        for (ZCSupportBaseView *view in weakSelf.mySubViews) {
            if (view.sureSupport) {
                
                showSupport=YES;
            }
        }
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        if (weakSelf.supportOneYuanView.sureSupport) {
            [dic setObject:@1 forKey:@"style1"];
        }
        if (weakSelf.supportAnyYuanView.sureSupport) {
            NSNumber *anyMoney=nil;
            if (!weakSelf.supportAnyYuanView.textField.text.length) {
                anyMoney=@0;
            }
            else
            {
                CGFloat money=[weakSelf.supportAnyYuanView.textField.text floatValue];
                anyMoney=[NSNumber numberWithFloat:money];
            }
            [dic setObject:anyMoney forKey:@"style2"];
        }
        if (weakSelf.returnSupportView01.sureSupport) {
            [dic setObject:weakSelf.returnMoney01 forKey:@"style3"];
        }
        if (weakSelf.returnSupportView02.sureSupport) {
            [dic setObject:weakSelf.returnMoney02 forKey:@"style5"];
        }
        if (weakSelf.togetherView.sureSupport) {
            [dic setObject:weakSelf.togetherMoney forKey:@"style4"];
        }
        NSData *data = [NSJSONSerialization dataWithJSONObject :dic options : NSJSONWritingPrettyPrinted error:NULL];
        NSString *jsonStr = [[ NSString alloc ] initWithData :data encoding : NSUTF8StringEncoding];
        if (showSupport) {
            [[NSNotificationCenter defaultCenter] postNotificationName:KCAN_SUPPORT_MONEY object:jsonStr];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:KCAN_SUPPORT_MONEY object:@"hidden"];
        }
    };

}

@end








