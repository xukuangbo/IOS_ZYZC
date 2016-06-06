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
@interface ZYZCMineVIewController ()
@property (nonatomic, strong) PersonHeadView *personHeadView;
@property (nonatomic, strong) UserModel      *userModel;
@property (nonatomic, strong) NSNumber  *meGzAll;
@property (nonatomic, strong) NSNumber  *gzMeAll;
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
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_pas_ld"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
}

-(void)configUI
{
    _personHeadView=[[PersonHeadView alloc]init];
    _personHeadView.isMineView=YES;
    _personHeadView.userModel=[self getUser];
    [self.view addSubview:_personHeadView];
    
}

-(UserModel *)getUser
{
    UserModel *user=nil;
    ZYZCAccountModel *accountModel=[ZYZCAccountTool account];
    if (accountModel) {
        user=[[UserModel alloc]init];
        user.userName=accountModel.nickname;
        user.faceImg=accountModel.headimgurl;
        user.sex= [NSString stringWithFormat:@"%@",accountModel.sex];
    }
    return user;
}


-(void)leftButtonClick
{
    
}

-(void)rightButtonClick
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
     } andFailBlock:^(id failResult) {
         NSLog(@"%@",failResult);
     }];
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
