//
//  ZCPersonInfoController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/17.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define BGIMAGEHEIGHT  200*KCOFFICIEMNT
#define BLURHEIGHT     44

#define ZCDETAIL_CONTENTSHOW_HEIGHT KSCREEN_H-64-49-53

#import "ZCPersonInfoController.h"
#import "ZCMainTableViewCell.h"
#import "ZCDetailFirstCell.h"
//#import "ZCDetailIntroShowCell.h"
#import "ZCDetailArrangeShowCell.h"
#import "ZCDetailReturnShowCell.h"
#import "ZCDetailTableHeadView.h"
//介绍部分cells
#import "ZCDetailIntroFirstCell.h"
#import "ZCDetailIntroSecondCell.h"
#import "ZCDetailIntroThirdCell.h"

#import "FXBlurView.h"

@interface ZCPersonInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong) UIColor *navColor;
@property (nonatomic, strong) FXBlurView *blurView;
@property (nonatomic, strong) UILabel *travelThemeLab;
@property (nonatomic, strong) ZCDetailTableHeadView *headView;
@property (nonatomic, assign) ZCDetailContentType contentType;
@property (nonatomic, assign) BOOL cellTableShow;
@end
@implementation ZCPersonInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor ZYZC_BgGrayColor];
    _navColor=[UIColor ZYZC_NavColor];
     [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:0]];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    _isAddCosponsor = YES;//添加联和发起人项
    self.contentType= IntroType;
     _firstCellMdel = [[ZCDetailIntroFirstCellModel alloc]init];
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
    _table.showsVerticalScrollIndicator=NO;
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
    blackView.alpha=0.1;
    [_blurView addSubview:blackView];
    
    //创建旅行主题标签
    _travelThemeLab=[[UILabel alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, 5, KSCREEN_W, 30)];
    _travelThemeLab.font=[UIFont boldSystemFontOfSize:20];
    _travelThemeLab.text=@"暖冬海岛 遇见烂漫";
    _travelThemeLab.shadowOffset=CGSizeMake(1 , 1);
    _travelThemeLab.shadowColor=[UIColor ZYZC_TextBlackColor];
    _travelThemeLab.textColor=[UIColor whiteColor];
    [_blurView addSubview:_travelThemeLab];
}


#pragma mark --- tableView代理方法
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int days=5;
    //第二组的cell数量
    NSInteger secondSectionCellNumber=6*(self.contentType==IntroType?1:0) +
    2*days*(self.contentType==ArrangeType?1:0)+3*(self.contentType==ReturnType?1:0);
    
    if (section==0) {
        return 2 + 2*_isAddCosponsor;
    }
    else
    {
        return  secondSectionCellNumber ;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        if(indexPath.row==1)
        {
           NSString *cellId01=@"ZCMainTableViewCell";
            ZCMainTableViewCell *mainCell=[tableView dequeueReusableCellWithIdentifier:cellId01];
            ZCDetailInfoModel *model=[[ZCDetailInfoModel alloc]init];
            mainCell.detailInfoModel=model;
            return mainCell;
        }
        else if (indexPath.row == 1+_isAddCosponsor*2&&indexPath.row!=1)
        {
            NSString *cellId02=@"detailFirstCell";
            ZCDetailFirstCell *detailFirstCell=[tableView dequeueReusableCellWithIdentifier:cellId02];
            if (!detailFirstCell) {
                detailFirstCell=[[ZCDetailFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId02];
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
    }
    //第二组内容 indexPath.section==1
    else
    {
        ////查看介绍内容
        if (self.contentType==IntroType) {
            if(indexPath.row==0)
            {
                NSString *introCellId01=@"introFirstCell";
                ZCDetailIntroFirstCell *introFirstCell=[tableView dequeueReusableCellWithIdentifier:introCellId01];
                if (!introFirstCell) {
                    introFirstCell= [[ZCDetailIntroFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:introCellId01];
                }
                introFirstCell.layer.cornerRadius=KCORNERRADIUS;
                
                introFirstCell.cellModel=_firstCellMdel;
                return introFirstCell;
            }
            else if (indexPath.row == 2)
            {
                NSString *introCellId02=@"introSecondCell";
                ZCDetailIntroSecondCell *introSecondCell=[tableView dequeueReusableCellWithIdentifier:introCellId02];
                if (!introSecondCell) {
                    introSecondCell= [[ZCDetailIntroSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:introCellId02];
                }
                return introSecondCell;
            }
            else if (indexPath.row == 4)
            {
                NSString *introCellId03=@"introThirdCell";
                ZCDetailIntroThirdCell *introThirdCell=[tableView dequeueReusableCellWithIdentifier:introCellId03];
                if (!introThirdCell) {
                    introThirdCell= [[ZCDetailIntroThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:introCellId03];
                }
                return introThirdCell;
                
            }
            else
            {
                UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor=[UIColor ZYZC_BgGrayColor];
                return cell;
            }
        }
        //查看行程内容
        else if (self.contentType == ArrangeType)
        {
            UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor=[UIColor orangeColor];
            return cell;
        }
        //查看回报内容
        else
        {
            UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor=[UIColor greenColor];
            return cell;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
    
        if (indexPath.row ==1)
        {
         return 210;
        }
        else if (indexPath.row==1+_isAddCosponsor*2&&indexPath.row!=1)
        {
           return ZCDETAIL_FIRSTCELL_HEIGHT;
        }
        else
        {
           return KEDGE_DISTANCE;
        }
    }
    else
    {
        //介绍部分cells高度
        if (self.contentType == IntroType) {
            if (indexPath.row==0) {
                return _firstCellMdel.cellHeight;
            }
            else if (indexPath.row == 2)
            {
                return ZCDETAILINTRO_SECONDCELL_HEIGHT;
            }
            else if (indexPath.row == 4)
            {
                return ZCDETAILINTRO_THIRDCELL_HEIGHT;
            }
            else
            {
                return KEDGE_DISTANCE;
            }
        }
        //行程部分cells高度
        else if (self.contentType == ArrangeType)
        {
            return ZCDETAIL_CONTENTSHOW_HEIGHT;
        }
        //回报部分cells高度
        else
        {
            return ZCDETAIL_CONTENTSHOW_HEIGHT;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        if(!_headView){
             _headView=[[ZCDetailTableHeadView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W,ZCDETAIL_SECONDSECTION_HEIGHT)];
        };
        __weak typeof (&*self)weakSelf=self;
        _headView.clickChangeContent=^(ZCDetailContentType contentType)
        {
            if (weakSelf.contentType!=contentType) {
                weakSelf.contentType=contentType;
                [weakSelf.table reloadData];
            }
        };
        
        return _headView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return ZCDETAIL_SECONDSECTION_HEIGHT;
    }
    return 0.0;
}

#pragma mark --- tableView的滑动效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //图片拉伸效果
    if (scrollView==self.table) {
        CGFloat offsetY = scrollView.contentOffset.y;
        
        if (offsetY <= -BGIMAGEHEIGHT)
        {
            CGRect frame = _topImgView.frame;
            frame.origin.y = offsetY;
            frame.size.height = -offsetY;
            _topImgView.frame = frame;
            _blurView.top=_topImgView.height-BLURHEIGHT;
        }
        
        //导航栏颜色渐变
        CGFloat height=BGIMAGEHEIGHT;
        if (offsetY >= -height) {
            CGFloat alpha = MIN(1, (height + offsetY)/height);
            [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:alpha]];
        } else {
            [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:0]];
        }
        
        //设置导航栏title
        if ((height + offsetY)/height>=1) {
            scrollView.contentInset=UIEdgeInsetsMake(64, 0, 0, 0);
            self.title= _travelThemeLab.text;
        }
        else
        {
            self.title=nil;
            scrollView.contentInset=UIEdgeInsetsMake(BGIMAGEHEIGHT, 0, 0, 0);
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
        if (sureBtn.tag!=KZCDETAIL_ATTITUDETYPE) {
             [sureBtn addSubview:[UIView lineViewWithFrame:CGRectMake(0, 7, 1, sureBtn.height-2*7) andColor:[UIColor ZYZC_TextGrayColor]]];
        }
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
