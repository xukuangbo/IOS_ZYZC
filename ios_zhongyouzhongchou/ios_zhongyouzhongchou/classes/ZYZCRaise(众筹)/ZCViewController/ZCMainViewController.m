//
//  ZCMainViewController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/6/8.
//  Copyright © 2016年 liuliang. All rights reserved.
//
//所有众筹列表
#define GET_ALL_LIST(pageNo) [NSString stringWithFormat:@"cache=false&orderType=4&pageNo=%d&status_not=0,2&pageSize=10",pageNo]


#import "ZCMainViewController.h"
#import "ZCFilterTableViewCell.h"
#import "ZCListModel.h"
#import "ZCMainTableView.h"
#import "WXApiManager.h"
#import "MBProgressHUD+MJ.h"
#import "ZYZCAccountModel.h"
@interface ZCMainViewController ()<WXApiManagerDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedView;
@property (nonatomic, strong) ZCMainTableView    *table;
//@property (nonatomic, strong) UIImageView        *fitersView;
//@property (nonatomic, assign) BOOL               isOpenFiters;
//@property (nonatomic, strong) NSMutableArray     *filterArr;
@property (nonatomic, strong) ZCListModel        *listModel;
@property (nonatomic, strong) NSMutableArray     *listArr;
@property (nonatomic, strong) UIButton           *scrollTop;
@property (nonatomic, assign) int pageNo;

@end

@implementation ZCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.automaticallyAdjustsScrollViewInsets=YES;
    _listArr=[NSMutableArray array];
    _pageNo=1;
    self.title=@"众筹";
    [self configUI];
    [self getHttpData];
}

/*
#pragma mark --- 创建众筹列表的NavBar
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
 */


/*
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
 */

#pragma mark --- 创建控件
-(void)configUI
{
//    [self createFitersView];
    
    //创建table
    _table=[[ZCMainTableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_table];
    __weak typeof (&*self)weakSelf=self;
    _table.headerRefreshingBlock=^()
    {
        weakSelf.pageNo=1;
        [weakSelf getHttpData];
    };
    _table.footerRefreshingBlock=^()
    {
        weakSelf.pageNo++;
        [weakSelf getHttpData];
    };
    _table.scrollDidScrollBlock=^(CGFloat offSetY)
    {
        if (offSetY>=1000.0) {
            weakSelf.scrollTop.hidden=NO;
        }
        else
        {
            weakSelf.scrollTop.hidden=YES;
        }
    };

    //创建置顶按钮
    _scrollTop=[UIButton buttonWithType:UIButtonTypeCustom];
    _scrollTop.layer.cornerRadius=KCORNERRADIUS;
    _scrollTop.layer.masksToBounds=YES;
    _scrollTop.frame=CGRectMake(KSCREEN_W-60,KSCREEN_H-59-55,50,50);
    [_scrollTop setImage:[UIImage imageNamed:@"回到顶部"] forState:UIControlStateNormal];
    
    [_scrollTop addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    _scrollTop.hidden=YES;
    [self.view addSubview:_scrollTop];
}

#pragma mark --- 获取众筹列表
-(void)getHttpData
{
    //获取所有众筹详情
    NSString *httpUrl=[NSString stringWithFormat:@"%@%@",LISTALLPRODUCTS,GET_ALL_LIST(_pageNo)];
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
                oneModel.productType=ZCListProduct;
                [_listArr addObject:oneModel];
            }
            _table.dataArr=_listArr;
            [_table reloadData];
        }
        [_table.mj_header endRefreshing];
        [_table.mj_footer endRefreshing];
        
    } andFailBlock:^(id failResult) {
        [_table.mj_header endRefreshing];
        [_table.mj_footer endRefreshing];
    }];
}

#pragma mark --- 置顶
-(void)scrollToTop
{
    [_table setContentOffset:CGPointMake(0, -64) animated:YES];
    
}

#pragma mark --- 置顶按钮状态变化
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==_table) {
        CGFloat offSetY=scrollView.contentOffset.y;
        if (offSetY>=1000.0) {
            _scrollTop.hidden=NO;
        }
        else
        {
            _scrollTop.hidden=YES;
        }
    }
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [_segmentedView removeFromSuperview];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
