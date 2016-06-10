//
//  MyReturnViewController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/6/10.
//  Copyright © 2016年 liuliang. All rights reserved.
//
//我的回报
#define GET_MY_RETURN_LIST(openid,pageNo) [NSString stringWithFormat:@"cache=false&openid=%@&self=4&pageNo=%d&status_not=0&pageSize=10",openid,pageNo]

#import "MyReturnViewController.h"
#import "MyReturnTableView.h"
#import "ZCListModel.h"
@interface MyReturnViewController ()
@property (nonatomic, strong) MyReturnTableView *table;
@property (nonatomic, strong) UIButton           *scrollTop;
@property (nonatomic, strong) NSMutableArray     *listArr;
@property (nonatomic, strong) ZCListModel        *listModel;
@property (nonatomic, assign) int                pageNo;

@end

@implementation MyReturnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的回报";
    _listArr=[NSMutableArray array];
    _pageNo=1;
    [self setBackItem];
    [self configUI];
    [self getHttpData];
}

-(void)configUI
{
    //创建table
    _table=[[MyReturnTableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    __weak typeof (&*self)weakSelf=self;
    [self.view addSubview:_table];
    
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
    
//    //添加没数据状态的视图
//    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ZCNoneDataView" owner:nil options:nil];
//    _noneDataView=[nibView objectAtIndex:0];
//    _noneDataView.frame=CGRectMake(KEDGE_DISTANCE, 108+KEDGE_DISTANCE, KSCREEN_W-2*KEDGE_DISTANCE, KSCREEN_H-108-2*KEDGE_DISTANCE);
//    _noneDataView.layer.cornerRadius=KCORNERRADIUS;
//    _noneDataView.layer.masksToBounds=YES;
//    [self.view addSubview:_noneDataView];
//    _noneDataView.hidden=YES;
    
    //添加置顶按钮
    _scrollTop=[UIButton buttonWithType:UIButtonTypeCustom];
    _scrollTop.layer.cornerRadius=KCORNERRADIUS;
    _scrollTop.layer.masksToBounds=YES;
    _scrollTop.frame=CGRectMake(KSCREEN_W-60,KSCREEN_H-60,50,50);
    [_scrollTop setImage:[UIImage imageNamed:@"回到顶部"] forState:UIControlStateNormal];
    [_scrollTop addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    _scrollTop.hidden=YES;
    [self.view addSubview:_scrollTop];
}

#pragma mark --- 置顶
-(void)scrollToTop
{
    [_table setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark --- 获取我的回报众筹列表
-(void)getHttpData
{
    NSString *httpUrl=[NSString stringWithFormat:@"%@%@",LISTMYPRODUCTS,GET_MY_RETURN_LIST([ZYZCTool getUserId],_pageNo)];
    NSLog(@"httpUrl%@",httpUrl);
    [ZYZCHTTPTool getHttpDataByURL:httpUrl withSuccessGetBlock:^(id result, BOOL isSuccess) {
        if (isSuccess) {
            if (_pageNo==1&&_listArr.count) {
                [_listArr removeAllObjects];
            }
            _listModel=[[ZCListModel alloc]mj_setKeyValues:result];
            for(ZCOneModel *oneModel in _listModel.data)
            {
                oneModel.productType=MyReturnProduct;
                [_listArr addObject:oneModel];
            }
            //没有数据，展示数据为空界面提示
            if (!_listArr.count) {
//                _noneDataView.hidden=NO;
//                _noneDataView.myZCType=_myProductType-MyPublishType;
            }
            else
            {
//                _noneDataView.hidden=YES;
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
