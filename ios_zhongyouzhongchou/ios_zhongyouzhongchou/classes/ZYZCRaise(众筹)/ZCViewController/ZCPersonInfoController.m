//
//  ZCPersonInfoController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/17.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCPersonInfoController.h"
#import "ZCMainTableViewCell.h"
@interface ZCPersonInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIImageView *topImgView;
@property(nonatomic,strong)UIColor *navColor;
@end
@implementation ZCPersonInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _navColor=[UIColor ZYZC_NavColor];
     [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:0]];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [self setBackItem];
    [self configUI];
}

-(void)configUI
{
    _table=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _table.dataSource=self;
    _table.delegate=self;
    _table.contentInset=UIEdgeInsetsMake(143.5*KCOFFICIEMNT-64, 0, 0, 0);
    _table.tableFooterView=[[UIView alloc]init];
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    UINib *nib=[UINib nibWithNibName:@"ZCMainTableViewCell" bundle:nil];
    [_table registerNib:nib forCellReuseIdentifier:@"ZCMainTableViewCell"];
    [self.view addSubview:_table];
    
    _topImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, -143.5*KCOFFICIEMNT,KSCREEN_W, 143.5*KCOFFICIEMNT)];
    _topImgView.contentMode=UIViewContentModeScaleAspectFill;
    _topImgView.image=[UIImage imageNamed:@"abc"];
    [_table addSubview:_topImgView];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCMainTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ZCMainTableViewCell"];
    ZCDetailInfoModel *model=[[ZCDetailInfoModel alloc]init];
    cell.detailInfoModel=model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==self.table) {
        CGFloat y = scrollView.contentOffset.y;
        if (y <= -143.5*KCOFFICIEMNT)
        {
            CGRect frame = _topImgView.frame;
            frame.origin.y = y;
            frame.size.height = -y;
            _topImgView.frame = frame;
        }
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat height=143.5*KCOFFICIEMNT;
        if (offsetY >= -height) {
            CGFloat alpha = MIN(1, (height + offsetY)/height);
            [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:alpha]];

        } else {
            [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:0]];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor ZYZC_NavColor]];
    [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:1]];
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
