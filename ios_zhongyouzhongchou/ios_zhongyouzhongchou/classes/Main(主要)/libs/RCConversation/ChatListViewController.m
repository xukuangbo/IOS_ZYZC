//
//  ChatListViewController.m
//  RongCloudDemo
//
//  Created by 杜立召 on 15/4/18.
//  Copyright (c) 2015年 dlz. All rights reserved.
//

#import "ChatListViewController.h"
#import "ZYZCConversationController.h"
@interface ChatListViewController ()

@end

@implementation ChatListViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"聊天列表";
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION)]];
    //自定义导航左右按钮
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"单聊" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
////    [rightButton setTintColor:[UIColor whiteColor]];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 6, 67, 23);
//    UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigator_btn_back"]];
//    backImg.frame = CGRectMake(-10, 0, 22, 22);
//    [backBtn addSubview:backImg];
//    UILabel *backText = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 65, 22)];
//    backText.text = @"退出";
//    backText.font = [UIFont systemFontOfSize:15];
//    [backText setBackgroundColor:[UIColor clearColor]];
//    [backText setTextColor:[UIColor whiteColor]];
//    [backBtn addSubview:backText];
//    [backBtn addTarget:self action:@selector(leftBarButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    [self.navigationItem setLeftBarButtonItem:leftButton];
//    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_new"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressBack)];
    
    UIView *emptyView=[[UIView alloc]initWithFrame:self.view.bounds];
//    emptyView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"abc"]];
    self.emptyConversationView=emptyView;
    
    self.conversationListTableView.tableFooterView = [UIView new];
}

-(void)pressBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *重写RCConversationListViewController的onSelectedTableRow事件
 *
 *  @param conversationModelType 数据模型类型
 *  @param model                 数据模型
 *  @param indexPath             索引
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    ZYZCConversationController *conversationVC = [[ZYZCConversationController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
    [self.navigationController pushViewController:conversationVC animated:YES];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"会话";    
}

/**
 *  退出登录
 *
 *  @param sender <#sender description#>
 */
- (void)leftBarButtonItemPressed:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    [alertView show];
}

/**
 *  重载右边导航按钮的事件
 *
 *  @param sender <#sender description#>
 */
-(void)rightBarButtonItemPressed:(id)sender
{
    ZYZCConversationController *conversationVC = [[ZYZCConversationController alloc]init];
    conversationVC.conversationType =ConversationType_PRIVATE;
    conversationVC.targetId = @"oulbuvolvV8uHEyZwU7gAn8icJFw"; //这里模拟自己给自己发消息，您可以替换成其他登录的用户的UserId
    conversationVC.title = @"聊天";
    [self.navigationController pushViewController:conversationVC animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[RCIM sharedRCIM]disconnect];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end