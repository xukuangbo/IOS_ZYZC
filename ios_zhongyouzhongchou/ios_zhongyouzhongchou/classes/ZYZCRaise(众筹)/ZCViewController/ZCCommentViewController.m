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
@property (nonatomic, strong) ZCCommentList *commentList;
@property (nonatomic, strong) NSMutableArray *commentArr;
@property (nonatomic, assign) BOOL scrollBottom;
@end

@implementation ZCCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _commentArr=[NSMutableArray array];
    [self setBackItem];
    [self configUI];
    [self getHttpData];
    
}

-(void)getHttpData
{
    NSDictionary *parameters=@{@"openid":[ZYZCTool getUserId],@"productId":_productId};
    [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:GET_COMMENT andParameters:parameters andSuccessGetBlock:^(id result, BOOL isSuccess) {
        NSLog(@"%@",result);
        [_commentArr removeAllObjects];
        if (isSuccess) {
            _commentList=[[ZCCommentList alloc]mj_setKeyValues:result];
            for(ZCCommentModel *commentModel in _commentList.commentList)
            {
                [_commentArr addObject:commentModel];
            }
            [_table.mj_header endRefreshing];
            [_table reloadData];
            if (_scrollBottom) {
                [_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_commentArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
        }
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
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
        [weakSelf getHttpData];
    }];
    
    //添加评论
    AddCommentView *addCommentView=[[AddCommentView alloc]init];
    addCommentView.top=KSCREEN_H-addCommentView.height;
    addCommentView.productId=_productId;
    [self.view addSubview:addCommentView];
    
    addCommentView.commentSuccess=^(NSString *content)
    {
        weakSelf.scrollBottom=YES;
        [weakSelf getHttpData];
//        ZCCommentModel *commentModel=[[ZCCommentModel alloc]init];
//        commentModel.comment.content=content;
//        commentModel.user=weakSelf.user;
    };
    addCommentView.keyBoardChange=^(CGFloat height,BOOL change)
    {
        if (change) {
            weakSelf.table.height-=height;
        }
        else
        {
            weakSelf.table.height+=height;
        }
    };
    
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
