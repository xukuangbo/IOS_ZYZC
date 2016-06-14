//
//  ZYZCMineVIewController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/6/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCMineVIewController.h"
#import "PersonHeadView.h"
#import "UserModel.h"
#import "ZYZCAccountTool.h"
#import "ZYZCAccountModel.h"
#import "MineTableViewCell.h"
#import "MineSetUpViewController.h"
@interface ZYZCMineVIewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PersonHeadView *personHeadView;
@property (nonatomic, strong) UITableView    *table;
@property (nonatomic, strong) UILabel        *titleLab;
@property (nonatomic, strong) UserModel      *userModel;
@property (nonatomic, strong) NSNumber       *meGzAll;
@property (nonatomic, strong) NSNumber       *gzMeAll;
@end

@implementation ZYZCMineVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavItems];
    [self configUI];
}

-(void)setNavItems
{
    
    _titleLab =[[UILabel alloc]initWithFrame:CGRectMake((self.view.width-200)/2, 0, 200, 44)];
    _titleLab.textColor=[UIColor whiteColor];
    _titleLab.font=[UIFont boldSystemFontOfSize:20];
    _titleLab.textAlignment=NSTextAlignmentCenter;
    [self.navigationController.navigationBar addSubview:_titleLab];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
    
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_pas_ld"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
}

-(void)configUI
{
    UIView *navBgView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:navBgView];
    
    _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W,KSCREEN_H-49) style:UITableViewStylePlain];
    _table.dataSource=self;
    _table.delegate=self;
    _table.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    _table.backgroundColor=[UIColor ZYZC_BgGrayColor];
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    _table.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_table];
    
    _personHeadView=[[PersonHeadView alloc]initWithType:YES];
    _table.tableHeaderView=_personHeadView;
    MJRefreshHeader *refreshHeader=[MJRefreshHeader headerWithRefreshingBlock:^{
        [self getUserInfoData];
    }];
    _table.mj_header=refreshHeader;
    
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        MineTableViewCell *minecCell=[[MineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        return minecCell;
    }
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=[UIColor ZYZC_BgGrayColor];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
         return MINE_CELL_HEIGHT;
    }
    else
    {
        return KEDGE_DISTANCE;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY=scrollView.contentOffset.y;
//        NSLog(@"%f",offsetY);
        _personHeadView.tableOffSetY=offsetY;
  
    if (offsetY>=74) {
        _titleLab.text=_userModel.userName.length>8?[_userModel.userName substringToIndex:8]:_userModel.userName;
    }
    else
    {
        _titleLab.text=nil;
    }
}

#pragma mark --- 设置
-(void)leftButtonClick
{
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"MineSetUpVC" bundle:nil];
    MineSetUpViewController *mineSetUpViewController = [board instantiateViewControllerWithIdentifier:@"MineSetUpViewController"];
    mineSetUpViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mineSetUpViewController animated:YES];
}

#pragma mark --- 消息
-(void)rightButtonClick
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _titleLab.hidden=NO;
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];

    [self getUserInfoData];
    
}

#pragma mark --- 获取个人信息
-(void)getUserInfoData
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *userId=[user objectForKey:KUSER_MARK];
    if (!userId) {
        return;
    }
    NSString *url=[NSString stringWithFormat:@"%@openid=%@&userId=%@",GETUSERDETAIL,[ZYZCTool getUserId],userId];
    NSLog(@"%@",url);
    [ZYZCHTTPTool getHttpDataByURL:url withSuccessGetBlock:^(id result, BOOL isSuccess)
     {
         NSLog(@"%@",result);
         if (isSuccess) {
             _userModel=[[UserModel alloc]mj_setKeyValues:result[@"data"][@"user"]];
             _personHeadView.meGzAll=result[@"data"][@"meGzAll"];
             _personHeadView.gzMeAll=result[@"data"][@"gzMeAll"];
             _personHeadView.userModel=_userModel;
         }
          [_table.mj_header endRefreshing];
     } andFailBlock:^(id failResult) {
         [_table.mj_header endRefreshing];
         NSLog(@"%@",failResult);
     }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    _titleLab.hidden=YES;
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
