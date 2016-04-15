//
//  GoalFirstCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/18.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "GoalFirstCell.h"
#import "MoreFZCChooseSceneController.h"
#import "CalendarViewController.h"
#import "GoalScheduleView.h"

#import "MoreFZCDataManager.h"

@interface GoalFirstCell()
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)GoalScheduleView *scheduleView;
@property(nonatomic,assign)CGPoint lastScenePoint;
@property(nonatomic,strong)NSMutableArray *sceneArr;
@property(nonatomic,strong)NSMutableArray *sceneTitleArr;
@property(nonatomic,strong)UIButton *startBtn;
@end

@implementation GoalFirstCell

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
    self.bgImg.height=FIRSTCELLHEIGHT;
    self.titleLab.text=@"旅行目的地";
    _lastScenePoint=CGPointMake(10, 0);
    _sceneArr=[NSMutableArray array];
    _sceneTitleArr=[NSMutableArray array];
    //旅游目的地添加到该_scroll上
    _scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, self.topLineView.bottom, KSCREEN_W-5*KEDGE_DISTANCE-28, 35)];
    _scroll.contentSize=CGSizeMake(_scroll.width, 0);
    _scroll.showsHorizontalScrollIndicator=NO;
    [self.contentView addSubview:_scroll];
    //创建添加目的地按钮
    UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame=CGRectMake(_scroll.right+KEDGE_DISTANCE, CGRectGetMaxY(self.topLineView.frame)+4.5, 26, 26);
    [addBtn setImage:[UIImage imageNamed:@"btn_and"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addScene) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addBtn];
    
    //旅行时间,出游人数标题
    NSArray *titleArr=@[@"旅行时间",@"出游人数"];
    for (int i=0; i<2; i++) {
        UILabel *tavelTimeLab=[self createLabAndUnderlineWithFrame:CGRectMake(2*KEDGE_DISTANCE, _scroll.bottom+10+70*i, self.bgImg.width-2*KEDGE_DISTANCE, 20) andTitle:titleArr[i]];
        [self.contentView addSubview:tavelTimeLab];
    }
    
    //添加初始地址
    _startBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _startBtn.origin=_lastScenePoint;
    _startBtn.size=CGSizeMake(80, 35);
    [_startBtn setTitle:@"出发地" forState:UIControlStateNormal];
    [_startBtn setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
    _startBtn.hidden=YES;
    [_startBtn addSubview:[UIView lineViewWithFrame:CGRectMake(0, _startBtn.height-1, _startBtn.width, 1) andColor:nil]];
    [_scroll addSubview:_startBtn];
    
    //添加第一个地址
    [self addSceneByTitle:@"杭州"];
    [_sceneTitleArr addObject:@"杭州"];
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    manager.goal_goals=_sceneTitleArr;//单例纪录目的地
    
    //添加旅行日程显示视图
    _scheduleView=[[GoalScheduleView alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE*2, _scroll.bottom+40, KSCREEN_W-40, 40)];
    [self.contentView addSubview:_scheduleView];
    
    //添加点击手势在日程显示视图上
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getTap:)];
    [_scheduleView addGestureRecognizer:tap];
    
    //添加人数选择视图
    _peoplePickerView=[[GoalPeoplePickerView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, _scroll.bottom+110, 0, 0)];
    _peoplePickerView.numberPeople=4;
    [self.contentView addSubview:_peoplePickerView];
}

#pragma mark --- 选择行程日期
-(void)getTap:(UITapGestureRecognizer *)tap
{
    CalendarViewController *calendarVC=[CalendarViewController calendarWithDays:365 showType:CalendarShowTypeMultiple];
    __weak typeof (&*self)weakSelf=self;
    calendarVC.confirmBlock=^()
    {
        MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
        if (manager.goal_startDate.length) {
            weakSelf.scheduleView.startLab.text=manager.goal_startDate;
            weakSelf.scheduleView.startLab.textColor=[UIColor ZYZC_TextBlackColor];
        }
        if (manager.goal_backDate.length) {
            weakSelf.scheduleView.backLab.text=manager.goal_backDate;
            weakSelf.scheduleView.backLab.textColor=[UIColor ZYZC_TextBlackColor];
        }
    };
    [self.viewController.navigationController pushViewController:calendarVC animated:YES];
}

#pragma mark --- 添加目的地
-(void)addScene
{
    MoreFZCChooseSceneController *chooseScenceVC=[[MoreFZCChooseSceneController  alloc]init];
    __weak typeof (&*self)weakSelf=self;
    chooseScenceVC.getOneScene=^(NSString *scene)
    {
        [weakSelf.sceneTitleArr addObject:scene];//将目的地名称保存在数组中
        MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
        manager.goal_goals=weakSelf.sceneTitleArr;//单例纪录目的地
        [weakSelf addSceneByTitle:scene];
    };
    chooseScenceVC.mySceneArr=_sceneTitleArr;
    [self.viewController.navigationController pushViewController:chooseScenceVC animated:YES];
}

#pragma mark --- 通过目的地名称添加目的地视图
-(void)addSceneByTitle:(NSString *)title
{
    UIView *oneScenceView=[self createOneSceneWithOrigin:_lastScenePoint andTitle:title];
    [_sceneArr addObject:oneScenceView];//添加到数组中
    [_scroll addSubview:oneScenceView];//添加到scroll中
    //记录最后一个目的地在scroll 的位置
    _lastScenePoint=CGPointMake(oneScenceView.right, oneScenceView.top);
    //改变scroll的画布大小
    _scroll.contentSize=CGSizeMake(oneScenceView.right, 0);
    //设置scroll的偏移量来显示最新添加的目的地
    CGFloat offSet_x=_scroll.contentSize.width-_scroll.width;
    if (_scroll.contentSize.width-_scroll.width>0) {
        _scroll.contentOffset=CGPointMake(offSet_x, 0) ;
    }
}

#pragma mark --- 添加某个目的地
-(UIView *)createOneSceneWithOrigin:(CGPoint )origin andTitle:(NSString *)title
{
    _startBtn.hidden=YES;
    CGFloat titleWidth=[ZYZCTool calculateStrLengthByText:title andFont:[UIFont systemFontOfSize:17] andMaxWidth:KSCREEN_W].width;
    //view为底部视图
    UIView *view=[[UIView alloc]init];
    view.size=CGSizeMake(titleWidth+30, 35);
    view.origin=origin;
    
    CGFloat btnOrginX=10;
    if (_sceneArr.count) {//当有地址时，继续添加地址会有箭头
        view.size=CGSizeMake(titleWidth+60, 35);
        //添加箭头到view上
        UIImageView *arrowImg=[[UIImageView alloc]init];
        arrowImg.frame=CGRectMake(10, view.height/2-2.5, 16, 5);
        arrowImg.image=[UIImage imageNamed:@"icn_des_jt"];
        [view addSubview:arrowImg];
        //改变btn位置
        btnOrginX=arrowImg.right+10;
    }
    //添加按钮在view上
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(btnOrginX, 0, titleWidth+20, 35);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [btn setTitleColor:[UIColor ZYZC_TextBlackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(deleteScene:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    //添加下划线在按钮上
    [btn addSubview:[UIView lineViewWithFrame:CGRectMake(0, btn.bottom-1, btn.width, 1) andColor:nil]];
    //添加删除键在按钮上
    UIImageView *deleteImg=[[UIImageView alloc]initWithFrame:CGRectMake(btn.width-10, 0, 15, 15)];
    deleteImg.image=[UIImage imageNamed:@"icn_xxcc"];
    [btn addSubview:deleteImg];
    return view;
}

#pragma mark --- 删除某个目的地
-(void)deleteScene:(UIButton *)sender
{
    //删除目的地
    UIView *sceneView=sender.superview;
    //视图从数组中删除
    [_sceneArr removeObject:sceneView];
    //目的地从数组中删除
    [_sceneTitleArr removeObject:sender.titleLabel.text];
    //单例纪录目的地
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    manager.goal_goals=_sceneTitleArr;
    //视图从父视图上删除
    [sceneView removeFromSuperview];
     _lastScenePoint=CGPointMake(10, 0);

    if (_sceneArr.count) {
        //删除所有目的地视图和视图数组中的内容
        for (NSInteger i=_sceneArr.count-1; i>=0; i--) {
            UIView *subView=(UIView *)_sceneArr[i];
            [_sceneArr removeObject:subView];
            [subView removeFromSuperview];
        }
        //重新添加所有目的地视图
        for (int i=0; i<_sceneTitleArr.count; i++) {
            [self addSceneByTitle:_sceneTitleArr[i]];
        }
    }
    else
    {
        _startBtn.hidden=NO;
         manager.goal_goals=@[@"出发地"];
    }
}

#pragma mark --- 刷新数据
-(void)reloadViews
{
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    if (manager.goal_numberPeople) {
        _peoplePickerView.numberPeople=[manager.goal_numberPeople integerValue];
    }
    else
    {
        _peoplePickerView.numberPeople=4;
    }
}

@end
