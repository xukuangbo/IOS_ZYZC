//
//  ZYZCPersonalController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/6/1.
//  Copyright © 2016年 liuliang. All rights reserved.
//


#import "ZYZCPersonalController.h"
#import "PersonHeadView.h"
@interface ZYZCPersonalController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) PersonHeadView *headView;
@property (nonatomic, strong) UserModel *userModel;
@property (nonatomic, strong) NSMutableArray *productArr;
@end

@implementation ZYZCPersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackItem];
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
    _productArr=[NSMutableArray array];
//    NSLog(@"_userId:%@",_userId);
//    NSLog(@"%f",HEAD_VIEW_HEIGHT);
    [self configUI];
    [self getUserInfoData];
}

-(void)configUI
{
    UIImageView *navBgView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:navBgView];
    
    _table=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.contentInset=UIEdgeInsetsMake(HEAD_VIEW_HEIGHT, 0, 0, 0);
    _table.dataSource=self;
    _table.delegate=self;
    _table.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    _table.backgroundColor=[UIColor ZYZC_BgGrayColor];
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    
    _headView=[[PersonHeadView alloc]init];
    [self.view addSubview:_headView];
    
}

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
         }
         
     } andFailBlock:^(id failResult) {
         NSLog(@"%@",failResult);
     }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.row==0) {
        cell.contentView.backgroundColor=[UIColor orangeColor];
    }
    else if (indexPath.row==1)
    {
        cell.contentView.backgroundColor=[UIColor greenColor];

    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
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
