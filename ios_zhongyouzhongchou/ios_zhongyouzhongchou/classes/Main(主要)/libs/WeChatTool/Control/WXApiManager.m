//
//  WXApiManager.m
//  SDKSample
//
//  Created by Jeason on 16/07/2015.
//
//

#import "WXApiManager.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "ZYZCRCManager.h"
#import "ZYZCAccountTool.h"
@implementation WXApiManager

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

- (void)dealloc {
    self.delegate = nil;
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvMessageResponse:)]) {
            SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
            [_delegate managerDidRecvMessageResponse:messageResp];
        }
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAuthResponse:)]) {
            SendAuthResp *authResp = (SendAuthResp *)resp;
            [_delegate managerDidRecvAuthResponse:authResp];
        }
    } else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAddCardResponse:)]) {
            AddCardToWXCardPackageResp *addCardResp = (AddCardToWXCardPackageResp *)resp;
            [_delegate managerDidRecvAddCardResponse:addCardResp];
        }
    }
    
    //支付结果回调
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case WXSuccess: {
                NSNotification *notification = [NSNotification notificationWithName:KORDER_PAY_NOTIFICATION object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
            default: {
                NSNotification *notification = [NSNotification notificationWithName:KORDER_PAY_NOTIFICATION object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
            }
        }
    }
}

- (void)onReq:(BaseReq *)req {
    if ([req isKindOfClass:[GetMessageFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvGetMessageReq:)]) {
            GetMessageFromWXReq *getMessageReq = (GetMessageFromWXReq *)req;
            [_delegate managerDidRecvGetMessageReq:getMessageReq];
        }
    } else if ([req isKindOfClass:[ShowMessageFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvShowMessageReq:)]) {
            ShowMessageFromWXReq *showMessageReq = (ShowMessageFromWXReq *)req;
            [_delegate managerDidRecvShowMessageReq:showMessageReq];
        }
    } else if ([req isKindOfClass:[LaunchFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvLaunchFromWXReq:)]) {
            LaunchFromWXReq *launchReq = (LaunchFromWXReq *)req;
            [_delegate managerDidRecvLaunchFromWXReq:launchReq];
        }
    }
}

//========================================================

#pragma mark --- 微信登录
- (void)loginWeChatWithViewController:(UIViewController *)viewController
{
    UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:@"众游众筹登录" message:@"众游众筹使用微信登陆" preferredStyle:UIAlertControllerStyleAlert];
    [loginAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        SendAuthReq* req = [[SendAuthReq alloc] init];
        req.scope = kWechatAuthScope;// @"post_timeline,sns"
        req.state = kWechatAuthState;//  req.openID = kWechatAuthOpenID;
        [WXApi sendAuthReq:req viewController:viewController delegate:self];
    }]];
    [viewController presentViewController:loginAlert animated:YES completion:nil];
}

/**
 *  获取微信用户的个人信息
 */
- (void)requstPersonalData:(ZYZCAccountModel *)account
{
    if (account) {
//        [MBProgressHUD showMessage:@"正在加载个人数据"];
        NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",account.access_token,account.openid];
        [ZYZCHTTPTool getHttpDataByURL:url withSuccessGetBlock:^(id result, BOOL isSuccess) {
           ZYZCAccountModel  *accountModel=[[ZYZCAccountModel alloc]mj_setKeyValues:result];
//            有微信的数据后可以向我们的服务器发送注册信息
            [self regisPersonalMessageWith:accountModel];
            
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
                                @"openid": weakAccount.unionid,
                                @"nickname": weakAccount.nickname,
                                @"sex": weakAccount.sex,
                                @"language": weakAccount.language,
                                @"city": weakAccount.city,
                                @"province": weakAccount.province,
                                @"country": weakAccount.country,
                                @"headimgurl": weakAccount.headimgurl
                                };
    [ZYZCHTTPTool postHttpDataWithEncrypt:NO andURL:REGISTERWEICHAT andParameters:parameter andSuccessGetBlock:^(id result, BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"%@",result);
            ZYZCAccountModel *accountModel=weakAccount;
            accountModel.openid=result[@"data"][@"openid"];
            accountModel.userId=result[@"data"][@"userId"];
            [ZYZCAccountTool saveAccount:accountModel];
            
             //存储openid,userId到NSUserDefaults中
             NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            [user setObject:accountModel.openid forKey:KUSER_ID];
            [user setObject:accountModel.userId forKey:KUSER_MARK];
            [user synchronize];
            
            //注册成功,获取融云token
            ZYZCRCManager *RCManager=[ZYZCRCManager defaultManager];
            RCManager.hasLogin=NO;
            [RCManager getRCloudToken];
            
        }else{
            [[NSNotificationCenter defaultCenter]postNotificationName:KWX_LOGIN_FAIL object:nil];
        }
    } andFailBlock:^(id failResult) {
        [[NSNotificationCenter defaultCenter]postNotificationName:KWX_LOGIN_FAIL object:nil];
        NSLog(@"__________%@",failResult);
    }];
}


#pragma mark --- 判断用户是否一dengl微信
-(void)judgeAppGetWeChatLoginWithViewController:(UIViewController *)viewController
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *openid=[user objectForKey:KUSER_ID];
//    openid已存在，说明已登录
    if (openid) {
        return;
    }
    else
    {
        [self loginWeChatWithViewController:viewController];
    }
}







//======================================================
#pragma mark --- 微信支付
-(void )payForWeChat:(NSDictionary *)dict
{
    //    post
    //    {
    //    openid: string  // 微信用户openid
    //    ip: string // 用户ip
    //    productId: number   // 众筹项目id
    //    style1: number      // 支持1元 不传为未选择
    //    style2: number      // 支持任意金额的钱数 不传为未选择
    //    style3: number      // 回报支持一钱数   不传为未选择
    //    style4: number       // 一起去支付的钱数   不传为未选择
    //    style5: number       // 回报支持二钱数   不传为未选择
    //    }
    
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:dict];
    [params setObject:[ZYZCTool getUserId] forKey:@"openid"];
    [params setObject:@"127.0.0.1" forKey:@"ip"];// 不知道是干嘛用的
    
    
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES];
    [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:GET_WX_ORDER  andParameters:params andSuccessGetBlock:^(id result, BOOL isSuccess) {
        //        NSLog(@"result:%@",result);
        PayReq *request = [[PayReq alloc] init];
        /** 商家向财付通申请的商家id */
        NSDictionary *data=[ZYZCTool turnJsonStrToDictionary:result[@"data"]];
        request.openID    = data[@"appid"];
        request.partnerId = data[@"partnerid"];
        request.prepayId  = data[@"prepayid"];
        request.package   = data[@"package"];
        request.nonceStr  = data[@"noncestr"];
        request.timeStamp = [data[@"timestamp"] intValue];
        request.sign      = data[@"sign"];
        [WXApi sendReq: request];
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES];
        
    } andFailBlock:^(id failResult) {
        NSLog(@"failResult:%@",failResult);
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES];
    }];
}



@end
