//
//  ZCCommitViewController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/14.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCCommentViewController.h"
#import "ZCCommentModel.h"
@interface ZCCommentViewController ()
@property (nonatomic, strong) ZCCommentList *commentList;
@property (nonatomic, strong) NSMutableArray *commentArr;
@end

@implementation ZCCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _commentArr=[NSMutableArray array];
    [self setBackItem];
    [self getHttpData];
}

-(void)getHttpData
{
    NSDictionary *parameters=@{@"openid":[ZYZCTool getUserId],@"productId":@1};
    [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:GET_COMMENT andParameters:parameters andSuccessGetBlock:^(id result, BOOL isSuccess) {
        NSLog(@"%@",result);
        if (isSuccess) {
            _commentList=[[ZCCommentList alloc]mj_setKeyValues:result];
            for(ZCCommentModel *commentModel in _commentList.commentList)
            {
                [_commentArr addObject:commentModel];
            }
        }
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
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
