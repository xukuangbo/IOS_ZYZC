//
//  ZCDetailIntroSecondCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define HTTP_URL(viewId)   [NSString stringWithFormat:@"http://www.sosona.com:8080/viewSpot/getViewSpot.action?viewId=%@",viewId]

#import "ZCDetailIntroSecondCell.h"

#import "ZYZCViewSpotModel.h"

#import "TacticSingleViewController.h"

#define FIRSTBTN_TAG  3
#define LINEVIEW_TAG  110
@interface ZCDetailIntroSecondCell ()
@property (nonatomic, strong) UILabel *destLab;
@property (nonatomic, strong) UIScrollView *goalsView;
@property (nonatomic, strong) UIButton *preClickBtn;
@property (nonatomic, assign) CGFloat preBtnX;
@property (nonatomic, assign) BOOL firstGetGoals;

@end

@implementation ZCDetailIntroSecondCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)configUI
{
    [super configUI];
    self.bgImg.height=ZCDETAILINTRO_SECONDCELL_HEIGHT;
    self.titleLab.text=@"目的地介绍";
    self.titleLab.font=[UIFont boldSystemFontOfSize:17];
    
    _goalsView=[[UIScrollView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, self.topLineView.bottom+KEDGE_DISTANCE, KSCREEN_W-4*KEDGE_DISTANCE, 30)];
    _goalsView.showsHorizontalScrollIndicator=NO;
    [self.contentView addSubview:_goalsView];
    _firstGetGoals=YES;
    
    _oneGoalImg=[[UIImageView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, _goalsView.bottom+KEDGE_DISTANCE, KSCREEN_W-4*KEDGE_DISTANCE,(KSCREEN_W-4*KEDGE_DISTANCE)*5/8)];
    _oneGoalImg.image =[UIImage imageNamed:@"image_placeholder"];
    _oneGoalImg.contentMode=UIViewContentModeScaleAspectFill;
    _oneGoalImg.layer.cornerRadius=KCORNERRADIUS;
    _oneGoalImg.layer.masksToBounds=YES;
    [self.contentView addSubview:_oneGoalImg];
    
    _destLab=[[UILabel alloc]initWithFrame:CGRectMake(0, _oneGoalImg.height/4, _oneGoalImg.width, _oneGoalImg.height/2)];
    _destLab.font=[UIFont boldSystemFontOfSize:30];
    _destLab.textAlignment=NSTextAlignmentCenter;
    _destLab.textColor=[UIColor whiteColor];
    _destLab.shadowOffset=CGSizeMake(1, 1);
    _destLab.shadowColor=[UIColor blackColor];
    [_oneGoalImg addSubview:_destLab];
    
    UIView *view01=[UIView lineViewWithFrame:CGRectMake(2*KEDGE_DISTANCE, _oneGoalImg.bottom+KEDGE_DISTANCE, 2, 20) andColor:[UIColor ZYZC_MainColor]];
    [self.contentView addSubview:view01];
    
    UILabel *generalTitleLab=[[UILabel alloc]initWithFrame:CGRectMake(view01.right+KEDGE_DISTANCE, _oneGoalImg.bottom+KEDGE_DISTANCE, 120, 20)];
    generalTitleLab.text=@"目的地概况";
    generalTitleLab.textColor=[UIColor ZYZC_TextBlackColor];
    [self.contentView addSubview:generalTitleLab];
    
    UIButton *moreBtn=[ZYZCTool getCustomBtnByTilte:@"更多" andImageName:@"btn_rig_mor" andtitleFont:[UIFont systemFontOfSize:15]];
    moreBtn.frame=CGRectMake(KSCREEN_W-2*KEDGE_DISTANCE-50, _oneGoalImg.bottom+KEDGE_DISTANCE, 50, 20) ;
    [moreBtn setTitleColor:[UIColor ZYZC_TextGrayColor04] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(gotoViewSpot) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:moreBtn];
    
    //目的地概况内容
    _generalLab=[[UILabel alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, generalTitleLab.bottom+KEDGE_DISTANCE, KSCREEN_W-4*KEDGE_DISTANCE, 80)];
    _generalLab.font=[UIFont systemFontOfSize:15];
    _generalLab.numberOfLines=3;
    _generalLab.textColor=[UIColor ZYZC_TextGrayColor04];
    [self.contentView addSubview:_generalLab];
    
    _generalLab.text=@"        三大纪律开始打架了扩大啊发哈肌肤恢复噶大是大非合适的接口发生地方就开始地方上独领风骚的护发素可点击发货速度快结束发生地方 i 松而我的大三大的发生地方首都发生地方是谁的冯绍峰发生地方是非得失";
    _generalLab.attributedText=[ZYZCTool setLineDistenceInText:_generalLab.text];
    
    //给cell添加点击事件
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoViewSpot)];
    [self addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeViewFrame) name:@"viewControllerShow" object:nil];
    
}

-(void)changeViewFrame
{
     _goalsView.contentOffset=CGPointMake(-(_goalsView.width-_preBtnX+16)/2, 0);
}

#pragma mark --- 目的地set方法
-(void)setGoals:(NSArray *)goals
{
    _goals=goals;
    if (_firstGetGoals) {
        _preBtnX=0;
        //添加目的地试图到_goalsView
        for (int i=0; i<goals.count; i++) {
            OneSpotModel *oneSpotModel=goals[i];
            UIButton *btn = [self setButton:i withTitle:oneSpotModel.name];
            [_goalsView addSubview:btn];
            _preBtnX=btn.right+16;
        }
        if (_preBtnX-16>_goalsView.width) {
            _goalsView.contentSize=CGSizeMake(_preBtnX-16, 0);
        }
        else
        {
            _goalsView.contentOffset=CGPointMake(-(_goalsView.width-_preBtnX+16)/2, 0);
        }
    }
    
    //初始化后点击第一个目的地
    if (!_preClickBtn) {
        UIButton *btn=(UIButton *)[_goalsView viewWithTag:FIRSTBTN_TAG];
        [self changeGoal:btn];
    }
    
    _firstGetGoals=NO;
}

#pragma mark --- 创建目的地btn
- (UIButton *)setButton:(NSInteger)index withTitle:(NSString *)title
{
    UIFont *font=[UIFont  systemFontOfSize:15];
    
    CGFloat titleWidth=[ZYZCTool calculateStrLengthByText:title andFont:font andMaxWidth:KSCREEN_W].width;
    
    CGFloat buttonW = titleWidth+20;
    CGFloat buttonH = _goalsView.height;
    CGFloat buttonX = _preBtnX;
    CGFloat buttonY = 0;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:15];
    button.tag = index+FIRSTBTN_TAG;
    [button addTarget:self action:@selector(changeGoal:) forControlEvents:UIControlEventTouchUpInside];
    
    //给btn添加下划线
    UIView *lineView=[UIView lineViewWithFrame:CGRectMake(0, button.height-1, button.width, 1) andColor:[UIColor ZYZC_MainColor]];
    lineView.tag=LINEVIEW_TAG;
    lineView.hidden=YES;
    [button addSubview:lineView];
    
    if (index!=0) {
        //从第二个目的地开始，添加箭头
        UIImageView *arrowImg=[[UIImageView alloc]initWithFrame:CGRectMake(-16, (button.height-5)/2, 16, 5)];
        arrowImg.image=[UIImage imageNamed:@"icn_des_jt"];
        [button addSubview:arrowImg];
    }
    
    [self getButtonNormalState:button];
    
    return button;
}

#pragma mark --- button点击事件
-(void)changeGoal:(UIButton *)button
{
    [self getButtonHeightState:button];
    
    if (_preClickBtn&&_preClickBtn!=button) {
        
        [self getButtonNormalState:_preClickBtn];
        
    }
    _preClickBtn=button;
    
    OneSpotModel *oneSpotModel=_goals[button.tag-FIRSTBTN_TAG];
    //获取数据
    [self getHttpDataByViewId:oneSpotModel.ID];
    
}

#pragma mark --- 获取单个目的地数据
-(void)getHttpDataByViewId:(NSNumber *)viewId
{
    [ZYZCHTTPTool getHttpDataByURL:HTTP_URL(viewId) withSuccessGetBlock:^(id result, BOOL isSuccess) {
        _tacticSingleModel = [TacticSingleModel mj_objectWithKeyValues:result[@"data"]];
        [self reloadData];
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
}

#pragma mark --- 刷新数据
-(void)reloadData
{
    [_oneGoalImg sd_setImageWithURL:[NSURL URLWithString:KWebImage(_tacticSingleModel.viewImg)] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
    _generalLab.text=_tacticSingleModel.viewText ;
    _destLab.text=_tacticSingleModel.name;
    _generalLab.attributedText=[ZYZCTool setLineDistenceInText:_generalLab.text];
}

#pragma mark --- 景点详情
-(void)gotoViewSpot
{
    TacticSingleViewController *singleViewVC=[[TacticSingleViewController alloc]init];
    singleViewVC.tacticSingleModel=_tacticSingleModel;
    singleViewVC.viewId=_tacticSingleModel.ID;
    [self.viewController.navigationController pushViewController:singleViewVC animated:YES];
}


#pragma mark --- buttonNormalState
-(void)getButtonNormalState:(UIButton *)button
{
    [button setTitleColor:[UIColor ZYZC_TextGrayColor04] forState:UIControlStateNormal];
    button.backgroundColor=[UIColor whiteColor];
    
    UIView *lineView=[button viewWithTag:LINEVIEW_TAG];
    lineView.hidden=YES;
}

#pragma mark --- buttonHeightState
-(void)getButtonHeightState:(UIButton *)button
{
    [button setTitleColor:[UIColor ZYZC_TextBlackColor] forState:UIControlStateNormal];
    button.backgroundColor=[UIColor whiteColor];
    
    UIView *lineView=[button viewWithTag:LINEVIEW_TAG];
    lineView.hidden=NO;
    
}

-(void)dealloc
{
     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"viewControllerShow" object:nil];
}


@end
