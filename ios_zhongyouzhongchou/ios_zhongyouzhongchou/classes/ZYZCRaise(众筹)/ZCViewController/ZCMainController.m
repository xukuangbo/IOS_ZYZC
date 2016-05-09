//
//  ZCMainController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define GET_ALL_LIST(pageNo) [NSString stringWithFormat:@"cache=false&orderType=1&pageNo=%d&pageSize=10",pageNo]

#import "ZCMainController.h"
#import "ZCMainTableViewCell.h"
#import "ZCFilterTableViewCell.h"
#import "ZCPersonInfoController.h"
#import "ZCListModel.h"
@interface ZCMainController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedView;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIImageView *fitersView;
@property (nonatomic, strong) NSMutableArray *filterArr;
@property (nonatomic, assign) BOOL isOpenFiters;
@property (nonatomic, assign) int pageNo;
@property (nonatomic, strong) ZCListModel *listModel;
@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation ZCMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self setNavBar];
    _listArr=[NSMutableArray array];
    _pageNo=1;
    self.title=@"众筹列表";
    [self getHttpData];
    [self configUI];
}
#pragma mark --- 创建NavBar
-(void)setNavBar
{
    //nav左右两边按钮创建
    [self customNavWithLeftBtnImgName:@"nav_s"
                      andRightImgName:@"nav_r"
                        andLeftAction:@selector(clickLeftNavBtn)
                       andRightAction:@selector(clickRightNavBtn)];
    //nav中间视图创建
    NSArray *titleArr=@[@"热门",@"附近"];
    _segmentedView = [[UISegmentedControl alloc]initWithItems:titleArr];
    _segmentedView.frame = CGRectMake(KSCREEN_W/2-110, KNAV_HEIGHT/2-14.5, 220, 29);
    _segmentedView.selectedSegmentIndex =0;
    _segmentedView.backgroundColor=[UIColor ZYZC_MainColor];
    _segmentedView.tintColor = [UIColor whiteColor];
    _segmentedView.layer.cornerRadius=4;
    _segmentedView.layer.masksToBounds=YES;
    [_segmentedView addTarget:self action:@selector(changeSegmented:) forControlEvents:UIControlEventValueChanged];
}
#pragma mark --- 切换热门和附近
-(void)changeSegmented:(UISegmentedControl *)segemented
{
    if (segemented.selectedSegmentIndex==0) {
        //只看热门内容
        NSLog(@"热门");
    }
    else
    {
        //只看附近内容
        NSLog(@"附近");
    }
}

#pragma mark --- 点击左侧导航栏按钮
-(void)clickLeftNavBtn
{
    NSLog(@"点击左导航栏按钮");
}

#pragma mark --- 点击右侧导航栏按钮
-(void)clickRightNavBtn
{
    _isOpenFiters=!_isOpenFiters;
    if (_isOpenFiters==YES) {
        _fitersView.hidden=NO;
    }
    else
    {
        _fitersView.hidden=YES;
    }
}

#pragma mark --- 获取众筹列表
-(void)getHttpData
{
    [ZYZCHTTPTool getHttpDataByURL:[NSString stringWithFormat:@"%@%@",LISTALLPRODUCTS,GET_ALL_LIST(_pageNo)] withSuccessGetBlock:^(id result, BOOL isSuccess) {
        if (isSuccess) {
            _listModel=[[ZCListModel alloc]mj_setKeyValues:result];
            for(ZCOneModel *oneModel in _listModel.data)
            {
                [_listArr addObject:oneModel];
            }
            [_table reloadData];
            //停止下拉刷新
            [_table.mj_header endRefreshing];
            //停止上拉刷新
            [_table.mj_footer endRefreshing];
        }

    } andFailBlock:^(id failResult) {
        NSLog(@"网络已断开");
        //停止下拉刷新
        [_table.mj_header endRefreshing];
        //停止上拉刷新
        [_table.mj_footer endRefreshing];
    }];
}

#pragma mark --- 创建控件
-(void)configUI
{
    [self createTableView];
    [self createFitersView];
}
#pragma mark --- 创建tableView
-(void)createTableView
{
    _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W, KSCREEN_H-KTABBAR_HEIGHT) style:UITableViewStyleGrouped];
    _table.dataSource=self;
    _table.delegate=self;
    _table.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    _table.backgroundColor=[UIColor ZYZC_BgGrayColor];
    [self.view addSubview:_table];
    UINib *nib=[UINib nibWithNibName:@"ZCMainTableViewCell" bundle:nil];
    [_table registerNib:nib forCellReuseIdentifier:@"ZCMainTableViewCell"];
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //添加下拉刷新动画效果
    MJRefreshGifHeader *gifHeader=[MJRefreshGifHeader headerWithRefreshingBlock:^{
        _pageNo=1;
        [_listArr removeAllObjects];
        [self getHttpData];
    }];
    UIImage *img01=[UIImage imageNamed:@"btn_dy_pre"];
    UIImage *img02=[UIImage imageNamed:@"btn_fzc_pre"];
    UIImage *img03=[UIImage imageNamed:@"btn_ht_pre"];
    UIImage *img04=[UIImage imageNamed:@"btn_lxxj_pre"];
    
    [gifHeader setImages:@[img01,img02,img03,img04] duration:0.4 forState:MJRefreshStatePulling];
     gifHeader.lastUpdatedTimeLabel.hidden= YES;
    _table.mj_header=gifHeader;
    
    //添加上拉刷新
    _table.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _pageNo++;
        [self getHttpData];
    }];

}
#pragma mark --- 创建过滤选择项视图
-(void)createFitersView
{
    _filterArr=[NSMutableArray array];
    NSArray *titleArr=@[@"只看女",@"只看男"];
    NSArray *imgNameArr=@[@"btn_sex_fem",@"btn_sex_mal"];
    for (int i=0; i<2; i++) {
        ZCFilterModel *filterModel=[[ZCFilterModel alloc]init];
        filterModel.title=titleArr[i];
        filterModel.imgName=imgNameArr[i];
        [_filterArr addObject:filterModel];
    }

    _fitersView=[[UIImageView alloc]initWithFrame:CGRectMake(KSCREEN_W-5-125,2.5+KNAV_HEIGHT+20, 125, 175.5)];
    _fitersView.hidden=YES;
    UIImage * image = [UIImage imageNamed:@"bg_sx"] ;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(15, 0, 15, 0) resizingMode:UIImageResizingModeStretch];
    _fitersView.image=image;
    _fitersView.userInteractionEnabled=YES;
    [self.view addSubview:_fitersView];
    
    UITableView *filterTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 12.5, _fitersView.frame.size.width, _fitersView.frame.size.height-17.5) style:UITableViewStylePlain];
    filterTable.dataSource=self;
    filterTable.delegate=self;
    filterTable.backgroundColor=[UIColor clearColor];
    filterTable.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    filterTable.scrollEnabled=NO;
    filterTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_fitersView addSubview:filterTable];
}

#pragma mark --- table代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==_table) {
        return _listArr.count;
    }
    return 1;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_table) {
        return 1;
    }
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //tableView为主视图的table
    if (tableView==_table) {
        ZCMainTableViewCell *mainCell=[tableView dequeueReusableCellWithIdentifier:@"ZCMainTableViewCell"];
        mainCell.oneModel=_listArr[indexPath.row];
        return mainCell;
    }
    //tableView为过滤视图中的table
    NSArray *titleArr=@[@"看成功",@"看全部"];
    ZCFilterTableViewCell *filterCell=[[ZCFilterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil andRowAtIndexPath:indexPath];
    if (indexPath.row<2) {
        filterCell.model=_filterArr[indexPath.row];
    }
    else
    {
        filterCell.textLabel.text=titleArr[indexPath.row-2];
    }
    return filterCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_table) {
        return 186.5+150*KCOFFICIEMNT;
    }
    return 39.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==_table) {
        return KEDGE_DISTANCE;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView==_table) {
        if (section==9) {
             return KEDGE_DISTANCE;
        }
        return 0.001;
       
    }
    return 0;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_table) {
        //推出信息详情页
        ZCPersonInfoController *personInfoVC=[[ZCPersonInfoController alloc]init];
        personInfoVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:personInfoVC animated:YES];
    }
    else
    {
        
    }
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_segmentedView removeFromSuperview];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_segmentedView];

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
