//
//  ZCMainController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

//所有众筹列表
#define GET_ALL_LIST(pageNo) [NSString stringWithFormat:@"cache=false&orderType=4&pageNo=%d&pageSize=10",pageNo]

//我的众筹列表
#define GET_MY_LIST(openid,type,pageNo) [NSString stringWithFormat:@"cache=false&openid=%@&self=%ld&pageNo=%d&pageSize=10",openid,type,pageNo]

#import "ZCMainController.h"
#import "ZCOneProductCell.h"
#import "ZCFilterTableViewCell.h"
#import "ZCPersonInfoController.h"
#import "ZCNoneDataView.h"
@interface ZCMainController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedView;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIImageView *fitersView;
@property (nonatomic, strong) NSMutableArray *filterArr;
@property (nonatomic, assign) BOOL isOpenFiters;
@property (nonatomic, assign) int pageNo;
@property (nonatomic, strong) ZCListModel *listModel;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, weak  ) ZCNoneDataView *noneDataView;

@end

@implementation ZCMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self setNavBar];
    self.automaticallyAdjustsScrollViewInsets=YES;
    _listArr=[NSMutableArray array];
    _pageNo=1;
    _myZCType=MyPublish;
    self.title=@"众筹";
    [self getHttpData];
    [self configUI];
    if (self.zcType==Mylist) {
        self.title=@"我的行程";
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
        [self setBackItem];
        [self setMYZCListHeadView];
    }
}

#pragma mark --- 创建我的众筹列表中的头视图
-(void)setMYZCListHeadView
{
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, KNAV_STATUS_HEIGHT, KSCREEN_W, 44)];
    headView.backgroundColor=[UIColor ZYZC_NavColor];
    [self.view addSubview:headView];
    
    NSArray *titleArr=@[@"我发起",@"我报名",@"我推荐"];
    _segmentedView = [[UISegmentedControl alloc]initWithItems:titleArr];
    _segmentedView.frame = CGRectMake(KEDGE_DISTANCE, 0, headView.width-2*KEDGE_DISTANCE, headView.height-KEDGE_DISTANCE);
    _segmentedView.selectedSegmentIndex =0;
    _segmentedView.backgroundColor=[UIColor ZYZC_MainColor];
    _segmentedView.tintColor = [UIColor whiteColor];
    _segmentedView.layer.cornerRadius=4;
    _segmentedView.layer.masksToBounds=YES;
    [_segmentedView addTarget:self action:@selector(changeSegmented:) forControlEvents:UIControlEventValueChanged];
    [headView addSubview:_segmentedView];
}

#pragma mark --- 创建所有众筹列表的NavBar
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
#pragma mark --- 切换我的行程内容
-(void)changeSegmented:(UISegmentedControl *)segemented
{
    if (segemented.selectedSegmentIndex==0) {
        //我发起
        self.myZCType=MyPublish;
    }
    else if(segemented.selectedSegmentIndex==1){
        //我报名
        self.myZCType=MyJoin;
    }
    else if (segemented.selectedSegmentIndex==2)
    {
        //我推荐
        self.myZCType=MyRecommend;
    }
    _pageNo=1;
    [self getHttpData];
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
    NSString *httpUrl=nil;
    //获取所有众筹详情
    if (self.zcType==AllList) {
        httpUrl=[NSString stringWithFormat:@"%@%@",LISTALLPRODUCTS,GET_ALL_LIST(_pageNo)];
    }
    //获取我的众筹详情
    else if (self.zcType==Mylist)
    {
//        @"o6_bmjrPTlm6_2sgVt7hMZOPfL2M"
        httpUrl=[NSString stringWithFormat:@"%@%@",LISTMYPRODUCTS,
        GET_MY_LIST([ZYZCTool getUserId],_myZCType,_pageNo)];
    }
    
    NSLog(@"httpUrl:%@",httpUrl);
    
    [ZYZCHTTPTool getHttpDataByURL:httpUrl withSuccessGetBlock:^(id result, BOOL isSuccess) {
        NSLog(@"%@",result);
        if (isSuccess) {
            if (_pageNo==1&&_listArr.count) {
                    [_listArr removeAllObjects];
            }
            _listModel=[[ZCListModel alloc]mj_setKeyValues:result];
            for(ZCOneModel *oneModel in _listModel.data)
            {
                oneModel.zcType=_zcType;
                [_listArr addObject:oneModel];
            }
            
            if (_zcType==Mylist&&!_listArr.count) {
            NSArray *iconArr=@[@"icon_mxc_cy",@"icon_mxc_fq",@"icon_mxc_tj"];
            NSArray *title01Arr=@[ZYLocalizedString(@"none_my_publish_01"),
                                  ZYLocalizedString(@"none_my_join_01"),
                                  ZYLocalizedString(@"none_my_recommend_01")];
            NSArray *title02Arr=@[ZYLocalizedString(@"none_my_publish_02"),
                                  ZYLocalizedString(@"none_my_join_02"),
                                  ZYLocalizedString(@"none_my_recommend_02")];
                _noneDataView.hidden=NO;
                _table.hidden=YES;
                _noneDataView.iconView.image=[UIImage imageNamed:iconArr[_myZCType-1]];
                _noneDataView.lab01.text=title01Arr[_myZCType-1];
                _noneDataView.lab02.text=title02Arr[_myZCType-1];
            }
            else
            {
                _noneDataView.hidden=YES;
                _table.hidden=NO;
            }
            
            [_table reloadData];
        }
        //停止下拉刷新
        [_table.mj_header endRefreshing];
        //停止上拉刷新
        [_table.mj_footer endRefreshing];

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
    if (_zcType==Mylist) {
        //添加我的行程中没数据状态的视图
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ZCNoneDataView" owner:nil options:nil];
        _noneDataView=[nibView objectAtIndex:0];
        _noneDataView.frame=CGRectMake(KEDGE_DISTANCE, 108+KEDGE_DISTANCE, KSCREEN_W-2*KEDGE_DISTANCE, KSCREEN_H-108-2*KEDGE_DISTANCE);
        _noneDataView.layer.cornerRadius=KCORNERRADIUS;
        _noneDataView.layer.masksToBounds=YES;
        [self.view addSubview:_noneDataView];
        _noneDataView.hidden=YES;
    }
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
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //如果是我的众筹列表改变table的初始位置
    if (self.zcType==Mylist) {
        _table.contentInset=UIEdgeInsetsMake(44, 0, 0, 0) ;
        _table.frame=CGRectMake(0, 0, KSCREEN_W, KSCREEN_H);
    }
    //添加下拉刷新动画效果
    MJRefreshGifHeader *gifHeader=[MJRefreshGifHeader headerWithRefreshingBlock:^{
        _pageNo=1;
        [self getHttpData];
    }];
    UIImage *img01=[UIImage imageNamed:@"btn_dy_pre"];
    UIImage *img02=[UIImage imageNamed:@"btn_fzc_pre"];
    UIImage *img03=[UIImage imageNamed:@"btn_ht_pre"];
    UIImage *img04=[UIImage imageNamed:@"btn_lxxj_pre"];
    
    [gifHeader setImages:@[img01,img02,img03,img04]  forState:MJRefreshStatePulling];
     gifHeader.lastUpdatedTimeLabel.hidden=YES;
//    gifHeader.gifView.contentMode=
     gifHeader.stateLabel.textColor=[UIColor ZYZC_TextGrayColor04];
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
        NSString *cellId=@"productCell";
        ZCOneProductCell *productCell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!productCell) {
            productCell=[[ZCOneProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        productCell.oneModel=_listArr[indexPath.section];
        return productCell;
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
        if (_zcType==Mylist) {
            return MY_ZC_CELL_HEIGHT;
        }
        return PRODUCT_CELL_HEIGHT;
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
        ZCOneModel *oneModel=_listArr[indexPath.section];
        personInfoVC.oneModel=oneModel;
        personInfoVC.productId=oneModel.product.productId;
        personInfoVC.zcType=self.zcType;
        [self.navigationController pushViewController:personInfoVC animated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [_segmentedView removeFromSuperview];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor ZYZC_NavColor]];
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
