//
//  TravelFirstCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/24.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TravelFirstCell.h"
#import "MoreFZCDataManager.h"
@interface TravelFirstCell ()
@property(nonatomic,assign)CGPoint lastScenePoint;
@end

@implementation TravelFirstCell

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
    self.bgImg.height=TRAVELFIRSTCELLHEIGHT;
    self.titleLab.text=@"行程安排";
    //推荐行程按钮
    UIButton *recommendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    recommendBtn.frame=CGRectMake(KSCREEN_W-2*KEDGE_DISTANCE-80, 15, 80, 25);
    recommendBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [recommendBtn setTitle:@"推荐行程" forState:UIControlStateNormal];
    [recommendBtn setTitleColor:[UIColor ZYZC_TextBlackColor] forState:UIControlStateNormal];
    recommendBtn.layer.cornerRadius=KCORNERRADIUS;
    recommendBtn.layer.masksToBounds=YES;
    recommendBtn.layer.borderWidth=1;
    recommendBtn.layer.borderColor=[UIColor ZYZC_MainColor].CGColor;
    [self.contentView addSubview:recommendBtn];
    
    //创建日程视图
    _scheduleView=[[GoalScheduleView alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE*2, self.topLineView.bottom+10, KSCREEN_W-40, 30)];
    [self.contentView addSubview:_scheduleView];
       //已选目的地视图
    _scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, _scheduleView.bottom+10, KSCREEN_W-4*KEDGE_DISTANCE, 30)];
    _scroll.contentSize=CGSizeMake(_scroll.width, 0 );
    _scroll.showsHorizontalScrollIndicator=NO;
    [self.contentView addSubview:_scroll];
    [self reloadTravelData];
}

#pragma mark --- 添加某个目的地
-(UIView *)createOneScene:(NSInteger)number  WithOrigin:(CGPoint )origin andTitle:(NSString *)title
{
    CGFloat titleWidth=[ZYZCTool calculateStrLengthByText:title andFont:[UIFont systemFontOfSize:17] andMaxWidth:KSCREEN_W].width;
    //view为底部视图
    UIView *view=[[UIView alloc]init];
    view.size=CGSizeMake(titleWidth+10, 35);
    view.origin=origin;
    
    CGFloat labOrginX=0;
    if (number>0) {//当有地址时，继续添加地址会有箭头
        view.size=CGSizeMake(titleWidth+40, 35);
        //添加箭头到view上
        UIImageView *arrowImg=[[UIImageView alloc]init];
        arrowImg.frame=CGRectMake(10, view.height/2-2.5, 16, 5);
        arrowImg.image=[UIImage imageNamed:@"icn_des_jt"];
        [view addSubview:arrowImg];
        //改变btn位置
        labOrginX=arrowImg.right+10;
    }
    //添加按钮在view上
    UILabel *lab=[[UILabel alloc]init];
    lab.frame=CGRectMake(labOrginX, 0, titleWidth+10, 35);
    lab.text=title;
    lab.textAlignment=NSTextAlignmentCenter;
    [view addSubview:lab];
    return view;
}

-(void)reloadTravelData
{
    _lastScenePoint=CGPointMake(0, 0);
    
    //将已确定日程显示到界面上
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    if (manager.goalViewStartDate.length) {
        _scheduleView.startLab.text=manager.goalViewStartDate;
        _scheduleView.startLab.textColor=[UIColor ZYZC_TextBlackColor];
    }
    if (manager.goalViewBackDate.length) {
        _scheduleView.backLab.text=manager.goalViewBackDate;
        _scheduleView.backLab.textColor=[UIColor ZYZC_TextBlackColor];
    }
    //将目的地显示到scroll上
    NSMutableArray *scenesArr=[NSMutableArray arrayWithArray:manager.goalViewScenesArr];
    if (scenesArr.count==1) {
        [scenesArr addObject:@"目的地"];
    }
    
    NSArray *viewArr=[_scroll subviews];
    for (UIView *obj in viewArr) {
        if ([obj isKindOfClass:[UIView class]]) {
            [obj removeFromSuperview];
        }
    }
    
    for (int i=0; i<scenesArr.count; i++) {
        UIView *oneScenceView=[self createOneScene:i WithOrigin:_lastScenePoint andTitle:scenesArr[i]];
        [_scroll addSubview:oneScenceView];
        _lastScenePoint=CGPointMake(oneScenceView.right, oneScenceView.top);
        _scroll.contentSize=CGSizeMake(oneScenceView.right+10, 0);
    }
    if (_lastScenePoint.x<_scroll.width) {
        _scroll.left=2*KEDGE_DISTANCE+(_scroll.width-_lastScenePoint.x)/2;
    }
}

@end










