//
//  CalendarViewController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/14.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "CalendarViewController.h"
#import "WeekDayView.h"
#import "RMCalendarCollectionViewLayout.h"
#import "RMCollectionCell.h"
#import "RMCalendarMonthHeaderView.h"

#import "MoreFZCDataManager.h"
typedef NS_ENUM(NSInteger, ChooseState) {
    ChooseNone,
    ChooseStart,
    ChooseStartAndBack
};

@interface CalendarViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic,strong)UISegmentedControl *segmentedControl;
@property(nonatomic,strong)NSArray *occupyDays;
@property(nonatomic,strong)RMCalendarModel *keepStartDateMdel;
@property(nonatomic,assign)ChooseState chooseState;
@end


@implementation CalendarViewController

static NSString *MonthHeader = @"MonthHeaderView";

static NSString *DayCell = @"DayCell";

/**
 *  初始化模型数组对象
 */
- (NSMutableArray *)calendarMonth {
    if (!_calendarMonth) {
        _calendarMonth = [NSMutableArray array];
    }
    return _calendarMonth;
}

- (RMCalendarLogic *)calendarLogic {
    if (!_calendarLogic) {
        _calendarLogic = [[RMCalendarLogic alloc] init];
    }
    return _calendarLogic;
}

- (instancetype)initWithDays:(int)days showType:(CalendarShowType)type modelArrar:(NSMutableArray *)modelArr {
    self = [super init];
    if (!self) return nil;
    self.days = days;
    self.type = type;
    self.modelArr = modelArr;
    return self;
}

- (instancetype)initWithDays:(int)days showType:(CalendarShowType)type {
    self = [super init];
    if (!self) return nil;
    self.days = days;
    self.type = type;
    return self;
}

+ (instancetype)calendarWithDays:(int)days showType:(CalendarShowType)type modelArrar:(NSMutableArray *)modelArr {
    return [[self alloc] initWithDays:days showType:type modelArrar:modelArr];
}

+ (instancetype)calendarWithDays:(int)days showType:(CalendarShowType)type {
    return [[self alloc] initWithDays:days showType:type];
}

- (void)setModelArr:(NSMutableArray *)modelArr {
#if __has_feature(objc_arc)
    _modelArr = modelArr;
#else
    if (_modelArr != modelArr) {
        [_modelArr release];
        _modelArr = [modelArr retain];
    }
#endif
}

-(void)setIsEnable:(BOOL)isEnable {
    _isEnable = isEnable;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"发起众筹";
    _chooseState=ChooseNone;
    [self setBackItem];
    [self configUI];
}
-(void)configUI
{
    [self createChooseView];
    [self createShowTimeView];
    [self createCollectionView];
    [self createBottomView];
}
-(void)createChooseView
{
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"出发时间",@"返回时间",nil];
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    _segmentedControl.frame = CGRectMake(KSCREEN_W/2-110, 64+10, 220, 30);
    _segmentedControl.selectedSegmentIndex =0;
    _segmentedControl.backgroundColor=[UIColor ZYZC_MainColor];
    _segmentedControl.tintColor = [UIColor whiteColor];
    _segmentedControl.layer.cornerRadius=KCORNERRADIUS;
    _segmentedControl.layer.masksToBounds=YES;
    [_segmentedControl addTarget:self action:@selector(changeSegmented:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
}

-(void)changeSegmented:(UISegmentedControl *)segemented
{
    if (segemented.selectedSegmentIndex==0) {
         self.calendarMonth = [self getMonthArrayOfDays:self.days showType:self.type isEnable:self.isEnable modelArr:self.modelArr];
        _keepStartDateMdel=nil;
        _chooseState=ChooseNone;
        [self.collectionView reloadData];
    }
}

-(void)createShowTimeView
{
    _scheduleView=[[GoalScheduleView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_segmentedControl.frame)+10, KSCREEN_W-20, 30)];
    _scheduleView.backgroundColor=[UIColor whiteColor];
    _scheduleView.layer.cornerRadius=5;
    _scheduleView.layer.masksToBounds=YES;
    [self.view addSubview:_scheduleView];
}

-(void)createCollectionView
{
    UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, _scheduleView.bottom+10, KSCREEN_W-20, KSCREEN_H-_scheduleView.bottom-10)];
    bgImg.image=KPULLIMG(@"tab_bg_boss0", 10, 0, 10, 0);
    bgImg.userInteractionEnabled=YES;
    [self.view addSubview:bgImg];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WeekDayView" owner:self options:nil];
    WeekDayView *weekDayView=[nib objectAtIndex:0];
    weekDayView.frame=CGRectMake(10, 2.5, bgImg.frame.size.width-20, 40);
    [bgImg addSubview:weekDayView];

    // 定义Layout对象
    RMCalendarCollectionViewLayout *layout = [[RMCalendarCollectionViewLayout alloc] init];
    
    // 初始化CollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake((bgImg.frame.size.width-COLLECTION_WIDTH)/2, CGRectGetMaxY(weekDayView.frame), COLLECTION_WIDTH, KSCREEN_H-bgImg.frame.origin.y-42.5-54) collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator=NO;
    
#if !__has_feature(objc_arc)
    [layout release];
#endif
    
    // 注册CollectionView的Cell
    [self.collectionView registerClass:[RMCollectionCell class] forCellWithReuseIdentifier:DayCell];
    
    [self.collectionView registerClass:[RMCalendarMonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];
    
    //   self.collectionView.bounces = NO;//将网格视图的下拉效果关闭
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;//实现网格视图的dataSource
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [bgImg addSubview:self.collectionView];
    
    self.calendarMonth = [self getMonthArrayOfDays:self.days showType:self.type isEnable:self.isEnable modelArr:self.modelArr];
}

/**
 *  获取Days天数内的数组
 *
 *  @param days 天数
 *  @param type 显示类型
 *  @param arr  模型数组
 *  @return 数组
 */
- (NSMutableArray *)getMonthArrayOfDays:(int)days showType:(CalendarShowType)type isEnable:(BOOL)isEnable modelArr:(NSArray *)arr
{
    NSDate *date = [NSDate date];
    
    NSDate *selectdate  = [NSDate date];
    //返回数据模型数组
    
    NSString *dateStr01=@"2016-04-15 +0000";
    NSString *dateStr02=@"2016-04-16 +0000";
    NSString *dateStr03=@"2016-04-17 +0000";
    NSString *dateStr04=@"2016-04-18 +0000";
    NSDateFormatter *dateForma=[[NSDateFormatter alloc]init];
    dateForma.dateFormat=@"yyyy-MM-dd Z";
    NSDate *date01=[dateForma dateFromString:dateStr01];
    NSDate *date02=[dateForma dateFromString:dateStr02];
    NSDate *date03=[dateForma dateFromString:dateStr03];
    NSDate *date04=[dateForma dateFromString:dateStr04];
    _occupyDays=@[date01,date02,date03,date04];
    return [self.calendarLogic reloadCalendarView:date selectDate:selectdate occupyDates:_occupyDays needDays:days showType:type isEnable:isEnable priceModelArr:arr];
}

#pragma mark - CollectionView 数据源

// 返回组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.calendarMonth.count;
}
// 返回每组行数
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *arrary = [self.calendarMonth objectAtIndex:section];
    return arrary.count;
}

#pragma mark - CollectionView 代理

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RMCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DayCell forIndexPath:indexPath];
    NSArray *months = [self.calendarMonth objectAtIndex:indexPath.section];
    RMCalendarModel *model =[months objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
        RMCalendarModel *model = [month_Array objectAtIndex:15];
        
        RMCalendarMonthHeaderView *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader forIndexPath:indexPath];
        monthHeader.masterLabel.text = [NSString stringWithFormat:@"%lu年 %lu月",(unsigned long)model.year,(unsigned long)model.month];//@"日期";
        monthHeader.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        reusableview = monthHeader;
    }
    return reusableview;
}

- (void)collectionView:(nonnull UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

    NSArray *months = [self.calendarMonth objectAtIndex:indexPath.section];
    RMCalendarModel *model = [months objectAtIndex:indexPath.row];
    /**
     *  选择出发时间与返回时间
     *
     */
    if (_chooseState==ChooseNone) {//选择开始时间
        _keepStartDateMdel=model;
        _segmentedControl.selectedSegmentIndex=1;
        if (model.style == CellDayTypeClick || model.style == CellDayTypeFutur || model.style == CellDayTypeWeek) {
            [self.calendarLogic selectLogic:model];
        }
        //将开始日期显示到界面上
        _scheduleView.startLab.text=[ZYZCTool turnDateToCustomDate:model.date];
        _scheduleView.startLab.textColor=[UIColor ZYZC_TextBlackColor];
        //记录已选出发时间状态
        _chooseState=ChooseStart;
    }
    else if(_chooseState==ChooseStart)//选择返回时间
    {
        //返回时间小于等于出发时间时
        if ([NSDate compareDate:_keepStartDateMdel.date withDate:model.date]<=0) {
            return;
        }
        //返回时间大于出发时间，判断时间段内是否存在已安排时间
        for (NSDate *obj in _occupyDays) {
            if ([NSDate compareDate:_keepStartDateMdel.date withDate:obj]==1){
                if ([NSDate compareDate:obj withDate:model.date]==1) {
                    NSLog(@"选择有冲突！请重新选择选择返回时间");
                    return;
                }
            }
        }
        if (model.style == CellDayTypeClick || model.style == CellDayTypeFutur || model.style == CellDayTypeWeek) {
            //更改选中状态
            [self.calendarLogic changeStateToCellDayTypeClick:model];
            //将返回日期显示到界面上
            _scheduleView.backLab.text=[ZYZCTool turnDateToCustomDate:model.date];
            _scheduleView.backLab.textColor=[UIColor ZYZC_TextBlackColor];
            
            _travelTotalDays=[NSDate getDayNumbertoDay:_keepStartDateMdel.date beforDay:model.date];
            
            self.sureBtn.enabled=YES;//确定按钮可点击
        }
        _chooseState=ChooseStartAndBack;
    }
     [self.collectionView reloadData];
}

- (BOOL)collectionView:(nonnull UICollectionView *)collectionView shouldSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return YES;
}

#pragma mark --- 复写父类点击方法
-(void)clickBtn
{
    //单例纪录开始时间
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    manager.goalViewStartDate=_scheduleView.startLab.text;
    //单例纪录返回时间
    manager.goalViewBackDate=_scheduleView.backLab.text;
    //单例纪录旅行总天数
    manager.goalViewTotalDays=_travelTotalDays;
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc {
#if !__has_feature(objc_arc)
    [self.collectionView release];
    [super dealloc];
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
