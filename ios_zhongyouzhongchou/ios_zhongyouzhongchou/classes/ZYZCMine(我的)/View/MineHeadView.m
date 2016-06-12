//
//  MineHeadView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineHeadView.h"
#import "MineUserModel.h"
#import "ZYZCAccountModel.h"
#import "ZYZCAccountTool.h"
#import "WXApiManager.h"
#import "WXApiObject.h"
#import "MineSetUpViewController.h"

#import "MBProgressHUD+MJ.h"
#import "ZYZCRCManager.h"
#define mineCornerRadius 5

#define shadowIconViewWH 76
#define nameLabelH 20
#define professionLabelH 15
#define descLabelH 15
#define centerAndFootMapViewH 25

@interface MineHeadView ()<WXApiManagerDelegate>
@property (nonatomic, strong)ZYZCAccountModel *accountModel;
@end
@implementation MineHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        
        CGFloat mineHeadMargin = (self.height - shadowIconViewWH - nameLabelH - professionLabelH - descLabelH - centerAndFootMapViewH)/5;
        
        mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
//        NSLog(@"%@",mgr.responseSerializer.acceptableContentTypes);
        self.userInteractionEnabled = YES;
        [WXApiManager sharedManager].delegate = self;
        //0头像遮盖
//        CGFloat shadowIconViewWH = 76;
        UIView *shadowIconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, shadowIconViewWH, shadowIconViewWH)];
        shadowIconView.centerX = self.centerX;
        shadowIconView.top = mineHeadMargin;
        shadowIconView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        shadowIconView.layer.cornerRadius = mineCornerRadius;
        shadowIconView.layer.masksToBounds = YES;
        [self addSubview:shadowIconView];
        
        //5创建一个登陆按钮
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButton.size = CGSizeMake(shadowIconViewWH * 0.5, shadowIconViewWH * 0.5);
        
        [loginButton setImage:[UIImage imageNamed:@"wechat_icon"] forState:UIControlStateNormal];
//        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
//        loginButton.backgroundColor = [UIColor redColor];
        loginButton.origin = CGPointMake(self.width - loginButton.width, 20);
        [loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:loginButton];
        self.loginButton = loginButton;
        //5.1创建一个设置按钮
        UIButton *setUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        setUpButton.size = CGSizeMake(shadowIconViewWH * 0.5, shadowIconViewWH * 0.5);
        
        [setUpButton setImage:[UIImage imageNamed:@"btn_set"] forState:UIControlStateNormal];
        setUpButton.origin = CGPointMake(30, 30);
        [setUpButton addTarget:self action:@selector(setUpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:setUpButton];
        self.setUpButton = setUpButton;
        
        //1.头像
        UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        iconButton.size = CGSizeMake(shadowIconViewWH - 10, shadowIconViewWH - 10);
        iconButton.center = shadowIconView.center;
        [self addSubview:iconButton];
        self.iconButton = iconButton;
        [self.iconButton setBackgroundImage:[UIImage imageNamed:@"minicon.jpg"] forState:UIControlStateNormal];
        self.iconButton.layer.cornerRadius = mineCornerRadius;
        self.iconButton.layer.masksToBounds = YES;
        
        //2.名字
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.size = CGSizeMake(60, nameLabelH);
        nameLabel.centerX = iconButton.centerX;
        nameLabel.top = shadowIconView.bottom + mineHeadMargin;
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:18];
        nameLabel.shadowColor = [UIColor colorWithWhite:0.1f alpha:0.8f];    //设置文本的阴影色彩和透明度。
        nameLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);     //设置阴影的倾斜角度。
        nameLabel.text = @"李晓雅";
        //在赋值完名字后应该计算一下，调用一下方法吧
//        nameLabel.backgroundColor = [UIColor redColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        //3.性别
        UIImageView *sexView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_sex_fem"]];
        sexView.origin = CGPointMake(nameLabel.right, nameLabel.top);
        sexView.centerY = nameLabel.centerY;
        [self addSubview:sexView];
        self.sexView = sexView;
        
        //4.加V用户
        UIImageView *vipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_renzheng"]];
        vipView.origin = CGPointMake(sexView.right, nameLabel.top);
        vipView.centerY = nameLabel.centerY;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        //5.职业
        UILabel *professionLabel = [[UILabel alloc] init];
        professionLabel.text = @"暂无职业";
        professionLabel.font = [UIFont systemFontOfSize:13];
        professionLabel.top = nameLabel.bottom + mineHeadMargin;
        professionLabel.left = 0;
//        professionLabel.backgroundColor = [UIColor redColor];
        professionLabel.size = CGSizeMake(self.width, professionLabelH);
        professionLabel.textColor = [UIColor whiteColor];
        professionLabel.shadowColor = [UIColor colorWithWhite:0.1f alpha:0.8f];    //设置文本的阴影色彩和透明度。
        professionLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);     //设置阴影的倾斜角度。
        professionLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:professionLabel];
        self.professionLabel = professionLabel;
        
        //6.描述
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.text = @"点击设置添加个人描述";
        descLabel.font = [UIFont systemFontOfSize:13];
        descLabel.top = professionLabel.bottom + mineHeadMargin;
        descLabel.left = 0;
        descLabel.size = CGSizeMake(self.width, descLabelH);
        descLabel.textColor = [UIColor whiteColor];
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.shadowColor = [UIColor colorWithWhite:0.1f alpha:0.8f];    //设置文本的阴影色彩和透明度。
        descLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);     //设置阴影的倾斜角度。
        [self addSubview:descLabel];
        self.descLabel = descLabel;
        
        //7.两个切换按钮的容器
        UIView *centerAndFootMapView = [[UIView alloc] init];
        centerAndFootMapView.left = 10;
        centerAndFootMapView.width = self.width - centerAndFootMapView.left * 2;
        centerAndFootMapView.bottom = mineHeadViewHeight;
        centerAndFootMapView.height = centerAndFootMapViewH;
        centerAndFootMapView.layer.cornerRadius = 5;
        centerAndFootMapView.layer.masksToBounds = YES;
        [self addSubview:centerAndFootMapView];

        //8.我的中心
        UIButton *myCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        myCenterButton.size = CGSizeMake(centerAndFootMapView.width * 0.5, centerAndFootMapView.height);
        myCenterButton.origin = CGPointMake(0, 0);
        myCenterButton.tag = KMineHeadViewChangeType;
        [myCenterButton setTitle:@"我的中心" forState:UIControlStateNormal];
        [myCenterButton addTarget:self action:@selector(centerAndFootAction:) forControlEvents:UIControlEventTouchUpInside];
        [centerAndFootMapView addSubview:myCenterButton];
        self.myCenterButton = myCenterButton;
        myCenterButton.backgroundColor = [UIColor whiteColor];
        [myCenterButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        //9.我的足迹
        UIButton *myFootButton = [UIButton buttonWithType:UIButtonTypeCustom];
        myFootButton.size = CGSizeMake(centerAndFootMapView.width * 0.5, centerAndFootMapView.height);
        myFootButton.origin = CGPointMake(myCenterButton.right, 0);
        myFootButton.tag = KMineHeadViewChangeType + 1;
        [myFootButton addTarget:self action:@selector(centerAndFootAction:) forControlEvents:UIControlEventTouchUpInside];
        [myFootButton setTitle:@"我的足迹" forState:UIControlStateNormal];
        [centerAndFootMapView addSubview:myFootButton];
        self.myFootButton = myFootButton;
        myFootButton.backgroundColor = kMineChangeButtonNormalColor;
        [myFootButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)centerAndFootAction:(UIButton *)button
{
    //让两个tableView的隐藏相反一下
    self.headChangeBlock(button);
}
/**
 *  model的赋值，数据的赋值
 */
- (void)setUserModel:(MineUserModel *)userModel
{
    if (_userModel != userModel) {
        _userModel = userModel;
        
        //icon头像
        SDWebImageOptions sdWebImageOptions = SDWebImageRetryFailed | SDWebImageLowPriority;
        [self.iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:userModel.faceImg] forState:UIControlStateNormal placeholderImage:nil options:sdWebImageOptions];
         
    }
}
/**
 *  设置按钮
 *
 */
- (void)setUpButtonAction:(UIButton *)button
{
    //成功应该跳转到个人设置的界面
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"MineSetUpVC" bundle:nil];
    MineSetUpViewController *mineSetUpViewController = [board instantiateViewControllerWithIdentifier:@"MineSetUpViewController"];
    mineSetUpViewController.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:mineSetUpViewController animated:YES];
}

/**
 *  登陆按钮
 *
 */
- (void)loginButtonAction:(UIButton *)button
{
    
    UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:@"众游众筹登录" message:@"众游众筹使用微信登陆" preferredStyle:UIAlertControllerStyleAlert];
    [loginAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [loginAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //从这里开始，我将进行登陆操作
        SendAuthReq* req = [[SendAuthReq alloc] init];
        req.scope = kWechatAuthScope; // @"post_timeline,sns"
        req.state = kWechatAuthState;
//        req.openID = kWechatAuthOpenID;
        [WXApi sendAuthReq:req viewController:self.viewController delegate:[WXApiManager sharedManager]];
    }]];
    
    [self.viewController presentViewController:loginAlert animated:YES completion:nil];
    
}

#pragma mark - 刷新数据
/**
 *  刷新微信用户数据（头像等）
 */
- (void)requstPersonData:(ZYZCAccountModel *)account
{
    if (account) {
        [MBProgressHUD showMessage:@"正在加载个人数据"];
        NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",account.access_token,account.openid];
        
        [ZYZCHTTPTool getHttpDataByURL:url withSuccessGetBlock:^(id result, BOOL isSuccess) {
            NSLog(@"result:%@",result);
            //这里可以请求到数据，然后加载给account,注册并加载数据

            //记录到账号模型
            _accountModel=[[ZYZCAccountModel alloc]mj_setKeyValues:result];
//           _accountModel = [ZYZCAccountModel accountWithPersonalMessage:result];
            
//            [ZYZCAccountTool saveAccount:_accountModel];
            
            //有微信的数据后可以向我们的服务器发送注册信息
//            [self regisPersonalMessageWith:weakAccount];
            
        } andFailBlock:^(id failResult) {
            NSLog(@"%@",failResult);
        }];
        

    }
    
    
    
    
}
#pragma mark - 注册个人资料
- (void)regisPersonalMessageWith:(ZYZCAccountModel *)weakAccount
{
//    {
//        "openid": "o6_bmjrPTlm6_2sgVt7hMZOPfL2M",
//        "nickname": "Band",
//        "sex": 1,
//        "language": "zh_CN",
//        "city": "广州",
//        "province": "广东",
//        "country": "中国",
//        "headimgurl":    "http://wx.qlogo.cn/mmopen/g3MonUZtNHkdmzicIlibx6iaFqAc56vxLSUfpb6n5WKSYVY0ChQKkiaJSgQ1dZuTOgvLLrhJbERQQ4eMsv84eavHiaiceqxibJxCfHe/0"
//    }
    NSDictionary *parameter = @{
                                @"openid": weakAccount.openid,
                                @"nickname": weakAccount.nickname,
                                @"sex": weakAccount.sex,
                                @"language": weakAccount.language,
                                @"city": weakAccount.city,
                                @"province": weakAccount.province,
                                @"country": weakAccount.country,
                                @"headimgurl": weakAccount.headimgurl
                                };
    __weak typeof(&*self) weakSelf = self;
    [ZYZCHTTPTool postHttpDataWithEncrypt:NO andURL:@"http://121.40.225.119:8080/register/saveWeixinInfo.action" andParameters:parameter andSuccessGetBlock:^(id result, BOOL isSuccess) {
        if (isSuccess) {
//            ZYZCAccountModel *model = [ZYZCAccountTool account];
            weakAccount.userId = result[@"data"][@"userId"];
            [ZYZCAccountTool saveAccount:weakAccount];
            [NSThread sleepForTimeInterval:2];
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"注册成功"];
            
            //注册成功,获取融云token
            ZYZCRCManager *RCManager=[ZYZCRCManager defaultManager];
            RCManager.hasLogin=NO;
            [RCManager getRCloudToken];
            
            //存储userId到NSUserDefaults中
            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            [user setObject:result[@"data"][@"userId"] forKey:KUSER_MARK];
            [user synchronize];
        
            //展示数据
            weakSelf.nameLabel.text = weakAccount.nickname;
            [weakSelf.iconButton sd_setImageWithURL:[NSURL URLWithString:weakAccount.headimgurl] forState:UIControlStateNormal];
            
        }else{
            [MBProgressHUD hideHUD];
            [NSThread sleepForTimeInterval:2];
            [MBProgressHUD showError:@"注册失败"];
           
        }
    } andFailBlock:^(id failResult) {
        NSLog(@"__________%@",failResult);
    }];
    

}
#pragma mark - 展示注册完成后的信息
- (void)showRegisMessage:(NSDictionary *)responseObject
{
    //作请求成功与否的判断
    if ([responseObject[@"code"] isEqual:@0]) {//注册成功,显示信息
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"注册成功，正在加载个人数据"];
        ZYZCAccountModel *account = [ZYZCAccountTool account];
        self.nameLabel.text = account.nickname;
        SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
        [self.iconButton sd_setImageWithURL:[NSURL URLWithString:account.headimgurl] forState:UIControlStateNormal placeholderImage:nil options:options completed:nil];
        
        [MBProgressHUD hideHUD];
    }else if([responseObject[@"code"] isEqual:@1]){
        [MBProgressHUD showError:@"注册失败"];
    }
}

#pragma mark - WXApiManagerDelegate
- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)request
{
    NSLog(@"_____接受到啦1");
}

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)request
{
    NSLog(@"_____接受到啦1111111");
}

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)request
{
    NSLog(@"_____接受到啦2222222");
}

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response
{
    NSLog(@"_____接受到啦13333333");
}

/**
 *  获取微信登录的token
 */
- (void)managerDidRecvAuthResponse:(SendAuthResp *)response
{
    NSString *url = GET_WX_TOKEN(response.code);
   [ZYZCHTTPTool getHttpDataByURL:url withSuccessGetBlock:^(id result, BOOL isSuccess) {
       //获取失败
       if (result[@"errcode"]) {
           [MBProgressHUD showError:ZYLocalizedString(@"fail_login_weixin")];
           return ;
       }
       //获取成功
       ZYZCAccountModel *accountModel = [[ZYZCAccountModel alloc]mj_setKeyValues:result[@"data"]];
    [self requstPersonData:accountModel];

    } andFailBlock:^(id failResult) {
       NSLog(@"%@",failResult);
   }];
//    [mgr GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
//        NSLog(@"%@",responseObject);
        //这里还需要去请求个人信息，然后保存到本地
    
//        ZYZCAccountModel *accountModel = [ZYZCAccountModel accountWithDict:responseObject];
//        [ZYZCAccountTool saveAccount:accountModel];
        
        //这里可以让headview刷新一下数据
//        [self reloadAccountData];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
    
}

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response
{
    NSLog(@"_____接受到啦555555555");
}
@end
