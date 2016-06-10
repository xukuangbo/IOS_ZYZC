//
//  ZYZCPersonalController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/6/1.
//  Copyright © 2016年 liuliang. All rights reserved.
//

//我的众筹列表
#define GET_MY_LIST(openid,type,pageNo) [NSString stringWithFormat:@"cache=false&openid=%@&self=%ld&pageNo=%d&status_not=0,2&pageSize=10",openid,type,pageNo]

#import "ZYZCPersonalController.h"
#import "PersonHeadView.h"
#import "ZCListModel.h"
#import "ZYZCOneProductCell.h"
#import "ZCProductDetailController.h"
@interface ZYZCPersonalController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView       *table;
@property (nonatomic, strong) PersonHeadView    *headView;
@property (nonatomic, strong) UserModel         *userModel;
@property (nonatomic, strong) NSMutableArray    *productArr;
@property (nonatomic, assign) int               pageNo;
@property (nonatomic, assign) PersonProductType productType;
@property (nonatomic, strong) ZCListModel       *listModel;
@end

@implementation ZYZCPersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _productArr=[NSMutableArray array];
    _pageNo=1;
    _productType=PublishType;
    [self setBackItem];
    [self configUI];
    [self getUserInfoData];
}

-(void)configUI
{
    UIView *navBgView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:navBgView];
    
    _table=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.contentInset=UIEdgeInsetsMake(HEAD_VIEW_HEIGHT, 0, 0, 0);
    _table.dataSource=self;
    _table.delegate=self;
    _table.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    _table.backgroundColor=[UIColor ZYZC_BgGrayColor];
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    
    
    MJRefreshAutoNormalFooter *normalFooter=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _pageNo++;
        [self getProductsData];
    }];
    [normalFooter setTitle:@"" forState:MJRefreshStateIdle];
    
    
    //添加头视图
    _headView=[[PersonHeadView alloc]initWithType:NO];
    [self.view addSubview:_headView];
    
    __weak typeof (&*self )weakSelf=self;
    _headView.changeProduct=^(PersonProductType productType)
    {
        weakSelf.productType=productType;
        weakSelf.pageNo=1;
       [weakSelf getProductsData];
    };
    
}

#pragma mark --- 获取个人信息
-(void)getUserInfoData
{
    NSString *url=[NSString stringWithFormat:@"%@openid=%@&userId=%@",GETUSERDETAIL,[ZYZCTool getUserId],_userId];
    NSLog(@"%@",url);
    [ZYZCHTTPTool getHttpDataByURL:url withSuccessGetBlock:^(id result, BOOL isSuccess)
     {
         NSLog(@"%@",result);
         if (isSuccess) {
             _userModel=[[UserModel alloc]mj_setKeyValues:result[@"data"][@"user"]];
             NSNumber *friendShip=result[@"data"][@"friend"];
             _headView.friendship=[friendShip isEqual:@1]?YES:NO;
             _headView.meGzAll=result[@"data"][@"meGzAll"];
             _headView.gzMeAll=result[@"data"][@"gzMeAll"];
              _headView.userModel=_userModel;
             [self getProductsData];
         }
         
     } andFailBlock:^(id failResult) {
         NSLog(@"%@",failResult);
     }];
}

#pragma mark --- 获取他的众筹
-(void)getProductsData
{
    if (!_userModel.openid) {
        return;
    }
    NSString *url=[NSString stringWithFormat:@"%@%@",LISTMYPRODUCTS,
                   GET_MY_LIST(_userModel.openid,_productType-PublishType+1,_pageNo)];
    NSLog(@"url:%@",url);
    [ZYZCHTTPTool getHttpDataByURL:url withSuccessGetBlock:^(id result, BOOL isSuccess)
    {
        NSLog(@"%@",result);
        if (isSuccess) {
            if (_pageNo==1&&_productArr.count) {
                [_productArr removeAllObjects];
            }
            _listModel=[[ZCListModel alloc]mj_setKeyValues:result];
            
            if (_listModel.data.count) {
                for(ZCOneModel *oneModel in _listModel.data)
                {
                    [_productArr addObject:oneModel];
                }
            }
            else
            {
                _pageNo--;
            }
             [_table reloadData];
        }
        //停止上拉刷新
        [_table.mj_footer endRefreshing];
        
    } andFailBlock:^(id failResult) {
        
        //停止上拉刷新
        [_table.mj_footer endRefreshing];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
     return _productArr.count*2+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2) {
        NSString *cellId=@"productCell";
        ZYZCOneProductCell *productCell=(ZYZCOneProductCell*)[ZYZCOneProductCell customTableView:tableView cellWithIdentifier:cellId andCellClass:[ZYZCOneProductCell class]];
        productCell.oneModel=_productArr[(indexPath.row-1)/2];
        return productCell;
    }
    else{
        UITableViewCell *cell=[ZYZCOneProductCell createNormalCell];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2) {
        return PRODUCT_CELL_HEIGHT;
    }
    else
    {
        return KEDGE_DISTANCE;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2) {
    //推出信息详情页
    ZCProductDetailController *personDetailVC=[[ZCProductDetailController alloc]init];
    personDetailVC.hidesBottomBarWhenPushed=YES;
    ZCOneModel *oneModel=_productArr[(indexPath.row+1)/2-1];
    personDetailVC.oneModel=oneModel;
    personDetailVC.oneModel.productType=ZCDetailProduct;
    personDetailVC.productId=oneModel.product.productId;
    personDetailVC.detailProductType=PersonDetailProduct;
    [self.navigationController pushViewController:personDetailVC animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY=scrollView.contentOffset.y;
//    NSLog(@"%f",offsetY);
    if (offsetY>=-(HEAD_VIEW_HEIGHT)&&offsetY<=-154) {
        _headView.top=-(offsetY+HEAD_VIEW_HEIGHT);
        _headView.tableOffSetY=offsetY;
    }
    
    if (offsetY>-154) {
        self.title=_userModel.userName.length>8?[_userModel.userName substringToIndex:8]:_userModel.userName;
    }
    else
    {
        self.title=nil;
    }
    
    if (offsetY<=-(HEAD_VIEW_HEIGHT)+KEDGE_DISTANCE) {
        _table.bounces=NO;
    }
    else
    {
        _table.bounces=YES;
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
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
