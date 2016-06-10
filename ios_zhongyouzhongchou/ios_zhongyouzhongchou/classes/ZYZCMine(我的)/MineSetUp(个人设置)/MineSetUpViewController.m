//
//  MineSetUpViewController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineSetUpViewController.h"
#import "MinePersonSetUpController.h"
#import "ZYZCAccountTool.h"
#import "ZYZCAccountModel.h"
#import "MBProgressHUD+MJ.h"
#import "MineSaveContactInfoVC.h"
#import "MineTravelTagsVC.h"
@interface MineSetUpViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MineSetUpViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_new"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressBack)];
    self.title = @"设置";
}

-(void)pressBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当选中的时候就会调用
    ZYZCAccountModel *model = [ZYZCAccountTool account];
    if (model) {//登录了
        
    }else//没登录
    {
        [MBProgressHUD setAnimationDuration:2];
        [MBProgressHUD showError:@"请先登录后设置"];
        
        return;
    }
    
    //在这里实现各种方法
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0://个人信息
                NSLog(@"个人信息");
                [self.navigationController pushViewController:[[MinePersonSetUpController alloc] init] animated:YES];
                break;
            case 1://旅行标签
                NSLog(@"旅行标签");
                [self.navigationController pushViewController:[[MineTravelTagsVC alloc] init] animated:YES];
                break;
            case 2://收货地址
                NSLog(@"收货地址");
                [self.navigationController pushViewController:[[MineSaveContactInfoVC alloc] init] animated:YES];
                break;
            default:
                break;
        }
    }else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0://清空缓存
                //这个是清空缓存的方法，弹出一个alert
                NSLog(@"清空缓存");
                break;
            case 1:
                //打开众游链接
                NSLog(@"众游链接");
                
                break;
            case 2://帮助反馈
                NSLog(@"帮助反馈");
                
                break;
            default:
                break;
        }
        
        
    }else{
        
    }
}
@end
