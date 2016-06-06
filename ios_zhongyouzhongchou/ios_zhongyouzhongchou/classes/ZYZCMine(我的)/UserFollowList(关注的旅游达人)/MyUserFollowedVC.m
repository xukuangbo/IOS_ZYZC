//
//  MyUserFollowedVC.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MyUserFollowedVC.h"
#import "ZYZCAccountModel.h"
#import "ZYZCAccountTool.h"
#import "MyUserFollowedModel.h"
#import "MyUserFollowedCell.h"
@interface MyUserFollowedVC()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *userFollowedArray;

@property (nonatomic, weak) UITableView *tableView;

@end


@implementation MyUserFollowedVC
#pragma mark - system方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        [self configUI];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
    
}

#pragma mark - setUI方法
- (void)configUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = MyUserFollowedCellHeight;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor ZYZC_BgGrayColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
#pragma mark - requsetData方法
- (void)requestData
{
    
    ZYZCAccountModel *accountModel = [ZYZCAccountTool account];
    NSString *url = Get_UserFollowed_List(accountModel.openid);
    NSLog(@"%@",url);
    //访问网络
    __weak typeof(&*self) weakSelf = self;
    [ZYZCHTTPTool getHttpDataByURL:url withSuccessGetBlock:^(id result, BOOL isSuccess) {
        if (isSuccess) {
            //请求成功，转化为数组
            weakSelf.userFollowedArray = [MyUserFollowedModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [weakSelf.tableView reloadData];
        }
        
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
}
#pragma mark - set方法

#pragma mark - delegate方法
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userFollowedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"MineMessageCell";
    MyUserFollowedCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MyUserFollowedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.userFollowModel = self.userFollowedArray[indexPath.row];
    return cell;
}
@end
