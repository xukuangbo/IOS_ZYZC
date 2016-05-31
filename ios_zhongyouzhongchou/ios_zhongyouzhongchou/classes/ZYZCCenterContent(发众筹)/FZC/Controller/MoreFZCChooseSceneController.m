//
//  MoreFZCChooseSceneController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/21.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCChooseSceneController.h"
#import "ZYZCDataBase.h"
#import "ZYZCViewSpotModel.h"
#import "LanguageTool.h"
@interface MoreFZCChooseSceneController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray  *viewSpot;
@end

@implementation MoreFZCChooseSceneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _viewSpot=[NSMutableArray array];
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


-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

#pragma mark ---searchBar代理方法实现
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{

    //监听键盘的出现和收起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    _table.hidden=NO;
    ZYZCDataBase *dataBase=[ZYZCDataBase sharedDBManager];
    [dataBase saveDataWithFinishBlock:^(BOOL saveSuccess) {
        if (saveSuccess) {
            NSArray *dataArr=[dataBase recieveDBData];
            for (NSDictionary *dic in dataArr) {
                OneSpotModel *oneSportModel=[[OneSpotModel alloc]mj_setKeyValues:dic];
                [_viewSpot addObject:oneSportModel];
            }
            [_table reloadData];
        }
    }];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    ZYZCDataBase *dataBase=[ZYZCDataBase sharedDBManager];
    NSArray *arr=[dataBase queryWithStrCondition:searchText];
    if (!arr.count) {
        arr=[dataBase queryWithPinyinCondition:[LanguageTool chineseChangeToPinYin:searchText]];
    }
    [_viewSpot removeAllObjects];
    for (OneSpotModel *oneSpotModel in arr) {
        [_viewSpot addObject:oneSpotModel];
    }
    [_table reloadData];
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
    return _viewSpot.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId=@"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    OneSpotModel *oneSpotModel=_viewSpot[indexPath.row];
    cell.textLabel.text=oneSpotModel.country.length>0?[NSString stringWithFormat:@"%@    %@",oneSpotModel.name,oneSpotModel.country]:oneSpotModel.name;
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.attributedText=[self getAttributeTextByModel:oneSpotModel];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel  *headView=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,_table.width, 40)];
    headView.text=@"热门搜索";
    headView.font=[UIFont boldSystemFontOfSize:14];
    headView.textColor=[UIColor ZYZC_TextGrayColor];
    headView.textAlignment=NSTextAlignmentCenter;
    UIView *lineView=[UIView lineViewWithFrame:CGRectMake(KEDGE_DISTANCE, 35, headView.width-2*KEDGE_DISTANCE, 1) andColor:nil];
    headView.backgroundColor=[UIColor whiteColor];
    [headView addSubview:lineView];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneSpotModel *oneSpotModel=_viewSpot[indexPath.row];
    _searchBar.text=oneSpotModel.name;
}


#pragma mark --- 键盘出现和收起方法
-(void)keyboardWillShow:(NSNotification *)notify
{
    NSDictionary *dic = notify.userInfo;
    NSValue *value = dic[UIKeyboardFrameEndUserInfoKey];
    CGFloat height=value.CGRectValue.size.height;
     _table.height-=height;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

-(void)keyboardWillHidden:(NSNotification *)notify
{
    NSDictionary *dic = notify.userInfo;
    NSValue *value = dic[UIKeyboardFrameEndUserInfoKey];
    CGFloat height=value.CGRectValue.size.height;
    _table.height+=height;
    [[NSNotificationCenter defaultCenter] removeObserver: self name:UIKeyboardWillHideNotification object:nil];
}


-(NSMutableAttributedString *)getAttributeTextByModel:(OneSpotModel *)oneSpotModel
{
    NSString *text=oneSpotModel.country.length>0?[NSString stringWithFormat:@"%@   %@",oneSpotModel.name,oneSpotModel.country]:oneSpotModel.name;
    NSMutableAttributedString *attrStr=[[NSMutableAttributedString alloc]initWithString:text];
    NSRange range=[text rangeOfString:oneSpotModel.name];
    
    if (text.length) {
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, range.length)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, range.length)];
        
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(range.length, text.length-range.length)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor ZYZC_TextGrayColor] range:NSMakeRange(range.length, text.length-range.length)];
    }
    return  attrStr;
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
