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
    PersonHeadView *personHeadView=[[PersonHeadView alloc]init];
    personHeadView.isMineView=YES;
    personHeadView.userModel=[self getUser];
    [self.view addSubview:personHeadView];
    
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
//    btn_set

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
