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
#import "ZCPersonInfoController.h"

@interface ZCDetailReturnFirstCell ()

@property (nonatomic, strong) UIButton  *preClickBtn;

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
    
   _supportOneYuanView =[[ZCSupportOneYuanView alloc]initSupportViewByTop:0 andTitle:@"支持1元" andText:text01 ];
    [self.contentView addSubview:_supportOneYuanView];
    
    _supportAnyYuanView =[[ZCSupportAnyYuanView alloc]initSupportViewByTop:_supportOneYuanView.bottom andTitle:@"支持任意金额:" andText:text02];
    [self.contentView addSubview:_supportAnyYuanView];
    
    _returnSupportView01 =[[ZCSupportReturnView alloc]initSupportViewByTop:_supportAnyYuanView.bottom andTitle:RETURNSUPPORT01(0.00) andText:text03];
    [self.contentView addSubview:_returnSupportView01];
    
    _returnSupportView02 =[[ZCSupportReturnView alloc]initSupportViewByTop:_returnSupportView01.bottom andTitle:RETURNSUPPORT02(0.00) andText:text03];
    [self.contentView addSubview:_returnSupportView02];
    
    _togetherView =[[ZCSupportTogetherView alloc]initSupportViewByTop:_returnSupportView02.bottom andTitle:TOGETHERSUPPORT(5,0.00) andText:text04 ];
    [self.contentView addSubview:_togetherView];
    
//    __weak typeof (&*self)weakSelf=self;
//    _supportOneYuanView.clickSupport=_supportAnyYuanView.clickSupport=_returnSupportView01.clickSupport=_returnSupportView02.clickSupport=_togetherView.clickSupport=^(UIButton *clickBtn)
//    {
//        if (weakSelf.preClickBtn&&weakSelf.preClickBtn!=clickBtn) {
//            [weakSelf.preClickBtn setImage:[UIImage imageNamed:@"Butttn_support"] forState:UIControlStateNormal];
//        }
//        weakSelf.preClickBtn=clickBtn;
//        ZCPersonInfoController *VC=(ZCPersonInfoController *)weakSelf.viewController;
//        VC.paySupportMoney=YES;
//        UIButton *supportBtn=[(UIButton *)VC.view viewWithTag:KZCDETAIL_ATTITUDETYPE+1];
//        supportBtn.backgroundColor=[UIColor ZYZC_MainColor];
//        [supportBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    };
    
}

-(void)setCellModel:(ZCDetailProductModel *)cellModel
{
    _cellModel=cellModel;
    NSArray *report=cellModel.report;
    BOOL hasReturn01=NO,hasReturn02=NO;
    CGFloat totalMoney=0.0;
    for (ReportModel *reportModel in report) {
        //临时数据
        reportModel.users=@[cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user,cellModel.user];
        //==============
        
        if ([reportModel.style intValue]==0) {
            if (reportModel.price) {
                 totalMoney=[reportModel.price floatValue];
            }
        }
        else if ([reportModel.style intValue]==1) {
            _supportOneYuanView.users=reportModel.users;
        }
        else if ([reportModel.style intValue]==2)
        {
            _supportAnyYuanView.users=reportModel.users;
        }
        else if ([reportModel.style intValue]==3)
        {
            hasReturn01=YES;
            _returnSupportView01.limitNumber=[reportModel.sumPeople intValue];
            if ([reportModel.sumPeople integerValue]<=reportModel.users.count) {
                _returnSupportView01.supportBtn.enabled=NO;
            }
            CGFloat money=[reportModel.price floatValue]/100;
            _returnSupportView01.titleLab.text=RETURNSUPPORT01(money);
            _returnSupportView01.titleLab.width=[ZYZCTool calculateStrLengthByText:RETURNSUPPORT01(money) andFont:[UIFont systemFontOfSize:15] andMaxWidth:KSCREEN_W].width;
            
            [_returnSupportView01 reloadDataByVideoImgUrl:reportModel.spellVideoImg andPlayUrl:reportModel.spellVideo andVoiceUrl:reportModel.spellVoice andFaceImg:cellModel.user.faceImg andDesc:reportModel.desc];
            _returnSupportView01.users=reportModel.users;
            }
        else if ([reportModel.style intValue]==4)
        {
            _togetherView.limitNumber=[reportModel.sumPeople intValue];
            _togetherView.users=reportModel.users;
            CGFloat money=[reportModel.price floatValue]/100;
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
            if ([reportModel.sumPeople integerValue]<=reportModel.users.count) {
                _returnSupportView02.supportBtn.enabled=NO;
            }
            CGFloat money=[reportModel.price floatValue]/100;
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

@end








