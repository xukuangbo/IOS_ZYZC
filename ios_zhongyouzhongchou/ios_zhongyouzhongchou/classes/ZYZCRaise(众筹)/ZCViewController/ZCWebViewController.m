//
//  ZCWebViewController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/30.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCWebViewController.h"

@interface ZCWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *web;
@end

@implementation ZCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

-(void)configUI
{
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_requestUrl]];
    _web=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    [self.view addSubview:_web];
    _web.delegate=self;
    [_web loadRequest:request];
    
    UIView *navView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    navView.backgroundColor=[UIColor ZYZC_NavColor];
    [self.view addSubview:navView];
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 20, 50, 44);
    [backBtn setImage:[UIImage imageNamed:@"btn_back_new"] forState:UIControlStateNormal];
    [backBtn addTarget: self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, navView.width, 44)];
    titleLab.text=_myTitle;
    titleLab.font=[UIFont boldSystemFontOfSize:20];
    titleLab.textAlignment=NSTextAlignmentCenter;
    titleLab.textColor=[UIColor whiteColor];
    [navView addSubview:titleLab];
}
//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSString *touchStr = [[request URL] absoluteString];
//    NSLog(@"touchStr:%@",touchStr);
//    return YES;
//}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
