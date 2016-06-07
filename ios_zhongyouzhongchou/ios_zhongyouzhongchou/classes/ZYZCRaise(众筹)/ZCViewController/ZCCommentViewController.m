//
//  ZCCommitViewController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/14.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCCommentViewController.h"
#import "ZCCommentCell.h"
#import "ZCCommentModel.h"
#import "AddCommentView.h"
@interface ZCCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) AddCommentView *addCommentView;
@property (nonatomic, strong) ZCCommentList *commentList;
@property (nonatomic, strong) NSMutableArray *commentArr;
@property (nonatomic, assign) int  pageNo;
@property (nonatomic, assign) int pageSize;
@end

@implementation ZCCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _commentArr=[NSMutableArray array];
    _pageNo=1;
    _pageSize=10;
    [self setBackItem];
    [self configUI];
    [self getHttpData];
    
}

-(void)getHttpData
{
    if (!_needGetData) {
        _commentArr=[NSMutableArray arrayWithArray:_comments];
        [_table reloadData];
        _needGetData=YES;
        return;
    }
    NSDictionary *parameters=@{@"openid":[ZYZCTool getUserId],
                               @"productId":_productId,
                               @"pageNo":[NSNumber numberWithInt:_pageNo],
                               @"pageSize":[NSNumber numberWithInt:_pageSize],
                               };
    [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:GET_COMMENT andParameters:parameters andSuccessGetBlock:^(id result, BOOL isSuccess) {
        NSLog(@"%@",result);
        if (_pageNo==1) {
            [_commentArr removeAllObjects];
        }
        if (isSuccess) {
            _commentList=[[ZCCommentList alloc]mj_setKeyValues:result];
            for(ZCCommentModel *commentModel in _commentList.commentList)
            {
                [_commentArr addObject:commentModel];
            }
            [_table reloadData];
            [_table.mj_header endRefreshing];
            [_table.mj_footer endRefreshing];
        }
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
        [_table.mj_header endRefreshing];
        [_table.mj_footer endRefreshing];
    }];
}

-(void)configUI
{
    _table =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.height=KSCREEN_H-49;
    _table.dataSource=self;
    _table.delegate=self;
    _table.showsVerticalScrollIndicator=NO;
    _table.tableFooterView=[[UIView alloc]init];
    _table.backgroundColor=[UIColor ZYZC_BgGrayColor];
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    
    __weak typeof (&*self )weakSelf=self;
    _table.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNo=1;
        [weakSelf getHttpData];
    }];
    
    MJRefreshAutoNormalFooter *autoFooter=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _pageNo++;
        [self getHttpData];
    }];
    [autoFooter setTitle:@"" forState:MJRefreshStateIdle];
    _table.mj_footer=autoFooter;
    
    //添加评论
    _addCommentView=[[AddCommentView alloc]init];
    _addCommentView.top=KSCREEN_H-_addCommentView.height;
    _addCommentView.productId=_productId;
    [self.view addSubview:_addCommentView];
    
    _addCommentView.commentSuccess=^(NSString *content)
    {
        weakSelf.pageNo=1;
        [weakSelf getHttpData];
    };
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(scrollView==_table)
    {
        [_addCommentView.editFieldView resignFirstResponder];
    }
}

    

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId=@"commentCell";
    ZCCommentCell *commentCell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!commentCell) {
        commentCell=[[ZCCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    commentCell.commentModel=_commentArr[indexPath.row];
    return commentCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCCommentModel *commentModel=_commentArr[indexPath.row];
    return commentModel.cellHeight;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor ZYZC_NavColor]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_addCommentView.editFieldView resignFirstResponder];
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
