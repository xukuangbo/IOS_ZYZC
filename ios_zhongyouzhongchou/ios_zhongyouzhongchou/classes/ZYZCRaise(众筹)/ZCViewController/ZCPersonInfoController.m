//
//  ZCPersonInfoController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/17.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define BGIMAGEHEIGHT  200*KCOFFICIEMNT
#define BLURHEIGHT     40
#import "ZCPersonInfoController.h"
#import "ZCMainTableViewCell.h"
#import "ZCDetailFirstCell.h"
#import "ZCDetailSecondCell.h"
#import "FXBlurView.h"
@interface ZCPersonInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong) UIColor *navColor;
@property (nonatomic, strong) FXBlurView *blurView;
@property (nonatomic, strong) UILabel *travelThemeLab;
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
    [self createBottomView];
}

#pragma mark --- 创建控件
-(void)configUI
{
    _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W, KSCREEN_H-KTABBAR_HEIGHT) style:UITableViewStylePlain];
    _table.dataSource=self;
    _table.delegate=self;
    _table.contentInset=UIEdgeInsetsMake(BGIMAGEHEIGHT-64, 0, 0, 0);
    _table.tableFooterView=[[UIView alloc]init];
    _table.backgroundColor=[UIColor ZYZC_BgGrayColor];
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    UINib *nib=[UINib nibWithNibName:@"ZCMainTableViewCell" bundle:nil];
    [_table registerNib:nib forCellReuseIdentifier:@"ZCMainTableViewCell"];
    [self.view addSubview:_table];
    
    _topImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, -BGIMAGEHEIGHT,KSCREEN_W, BGIMAGEHEIGHT)];
    _topImgView.contentMode=UIViewContentModeScaleAspectFill;
    _topImgView.image=[UIImage imageNamed:@"abc"];
    [_table addSubview:_topImgView];
    
    //创建毛玻璃添加到顶部图片上
    _blurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, BGIMAGEHEIGHT-BLURHEIGHT, KSCREEN_W, BLURHEIGHT)];
    [_blurView setDynamic:YES];
    [_topImgView addSubview:_blurView];
    //给毛玻璃润色
    UIView *blackView=[[UIView alloc]initWithFrame:_blurView.bounds];
    blackView.backgroundColor=[UIColor blackColor];
    blackView.alpha=0.2;
    [_blurView addSubview:blackView];
    
    //创建旅行主题标签
    _travelThemeLab=[[UILabel alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, 5, KSCREEN_W, 30)];
    _travelThemeLab.font=[UIFont boldSystemFontOfSize:20];
    _travelThemeLab.text=@"暖冬海岛 遇见烂漫";
    _travelThemeLab.textColor=[UIColor whiteColor];
    [_blurView addSubview:_travelThemeLab];
    
    
}

#pragma mark --- tableView代理方法
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==1)
    {
       NSString *cellId=@"ZCMainTableViewCell";
        ZCMainTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        ZCDetailInfoModel *model=[[ZCDetailInfoModel alloc]init];
        cell.detailInfoModel=model;
        return cell;
    }
    else if (indexPath.row==3)
    {
        NSString *cellId=@"detailFirstCell";
        ZCDetailFirstCell *detailFirstCell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!detailFirstCell) {
            detailFirstCell=[[ZCDetailFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
         return detailFirstCell;
        
    }
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=[UIColor ZYZC_BgGrayColor];
        return cell;
    }
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 1:
            return 210;
            break;
        case 3:
            return ZCDETAIL_FIRSTCELL_HEIGHT;
            break;
        default:
            return KEDGE_DISTANCE;
            break;
    }
}
#pragma mark --- tableView的滑动效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==self.table) {
        CGFloat y = scrollView.contentOffset.y;
        if (y <= -BGIMAGEHEIGHT)
        {
            CGRect frame = _topImgView.frame;
            frame.origin.y = y;
            frame.size.height = -y;
            _topImgView.frame = frame;
            _blurView.top=_topImgView.height-BLURHEIGHT;
        }
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat height=BGIMAGEHEIGHT;
        if (offsetY >= -height) {
            CGFloat alpha = MIN(1, (height + offsetY)/height);
            [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:alpha]];

        } else {
            [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:0]];
        }
    }
}

#pragma mark --- 创建底部点击按钮
-(void)createBottomView
{
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, KSCREEN_H-KTABBAR_HEIGHT , KSCREEN_W, KTABBAR_HEIGHT)];
    bottomView.backgroundColor=[UIColor ZYZC_TabBarGrayColor];
    [self.view addSubview:bottomView];
    
    [bottomView addSubview:[UIView lineViewWithFrame:CGRectMake(0, 0, KSCREEN_W, 0.5) andColor:[UIColor lightGrayColor]]];
    
    NSArray *titleArr=@[@"想去",@"支持",@"分享"];
    CGFloat btn_width=KSCREEN_W/3;
    for (int i=0; i<3; i++) {
        UIButton *sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame=CGRectMake(btn_width*i, KTABBAR_HEIGHT/2-20, btn_width, 40);
        [sureBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font=[UIFont systemFontOfSize:20];
        sureBtn.layer.cornerRadius=KCORNERRADIUS;
        sureBtn.layer.masksToBounds=YES;
        [sureBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.tag=KZCDETAIL_ATTITUDETYPE+i;
        [sureBtn addSubview:[UIView lineViewWithFrame:CGRectMake(0, 7, 1, sureBtn.height-2*7) andColor:[UIColor ZYZC_TextGrayColor]]];
        [bottomView addSubview:sureBtn];
    }
}

#pragma mark --- 底部按钮点击事件
-(void)clickBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case WantToType:
            //想去
            break;
        case SupportType:
            //支持
            break;
        case ShareType:
            //分享
            break;
        default:
            break;
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
