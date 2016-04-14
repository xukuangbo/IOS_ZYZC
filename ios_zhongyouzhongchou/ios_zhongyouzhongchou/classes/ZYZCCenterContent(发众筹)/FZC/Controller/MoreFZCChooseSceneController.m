//
//  MoreFZCChooseSceneController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/21.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCChooseSceneController.h"

@interface MoreFZCChooseSceneController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UITableView *table;
@end

@implementation MoreFZCChooseSceneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"发起众筹";
    [self setBackItem];
    [self configUI];
}

-(void)configUI
{
    //创建搜索框
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE, 10+64, KSCREEN_W-2*KEDGE_DISTANCE, 40)];
    _searchBar.delegate=self;
    _searchBar.layer.cornerRadius=KCORNERRADIUS;
    _searchBar.layer.masksToBounds=YES;
    _searchBar.placeholder=@"输入目的地";
    [self.view addSubview:_searchBar];
    
    //创建tableView
    _table=[[UITableView alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE, _searchBar.bottom, KSCREEN_W-2*KEDGE_DISTANCE, KSCREEN_H-_searchBar.bottom) style:UITableViewStylePlain];
    _table.delegate=self;
    _table.dataSource=self;
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    _table.showsVerticalScrollIndicator=NO;
    _table.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    _table.hidden=YES;
    [self.view addSubview:_table];
}

#pragma mark ---searchBar代理方法实现
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _table.hidden=NO;
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    for (NSString *obj in self.mySceneArr) {
        if ([obj isEqualToString:_searchBar.text]) {
            NSLog(@"该目的地已存在!");
            return;
        }
    }
    
    __weak typeof (&*self)weakSelf=self;
    if (self.getOneScene) {
        weakSelf.getOneScene(_searchBar.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- table代理方法实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headView=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,_table.width, 40)];
    headView.text=@"热门搜索";
    headView.font=[UIFont boldSystemFontOfSize:14];
    headView.textColor=[UIColor ZYZC_TextGrayColor];
    headView.textAlignment=NSTextAlignmentCenter;
    [headView addSubview:[UIView lineViewWithFrame:CGRectMake(10, headView.height-1, headView.width-20, 1) andColor:nil]];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


#pragma mark --- 点击事件

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_searchBar resignFirstResponder];
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
