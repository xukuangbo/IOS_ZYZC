//
//  TacticSingleFoodVC.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticSingleFoodVC.h"
#import "TacticSingleFoodModel.h"
#import "TacticVideoModel.h"
#import "TacticFoodPicCell.h"
#import "TacticFoodTextCell.h"
#define home_navi_bgcolor(alpha) [[UIColor ZYZC_NavColor] colorWithAlphaComponent:alpha]
#define imageViewHeight (KSCREEN_W / 16 * 9)
@interface TacticSingleFoodVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIImageView *mapView;
@property (nonatomic, weak) UILabel *labelView;
@property (nonatomic, weak) UITableView *tableView;

@end

static NSString *textCellID = @"TacticFoodTextCell";
static NSString *picCellID = @"TacticFoodPicCell";

@implementation TacticSingleFoodVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpUI];
        [self setBackItem];
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.view.backgroundColor = [UIColor ZYZC_BgGrayColor];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(0)];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}
/**
 *  创建界面
 */
- (void)setUpUI
{
    /**
     *  创建UITableView
     */
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_W, KSCREEN_H - 49) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.bounces = YES;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

- (void)setTacticSingleFoodModel:(TacticSingleFoodModel *)tacticSingleFoodModel
{
    _tacticSingleFoodModel = tacticSingleFoodModel;
    
    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
    //肯定有图片
    CGFloat mapViewX = KEDGE_DISTANCE;
    CGFloat mapViewY = self.imageView.height + KEDGE_DISTANCE;
    CGFloat mapViewW = KSCREEN_W - mapViewX * 2;
    //先计算文字高度
    CGFloat labelViewX = KEDGE_DISTANCE;
    CGFloat labelViewY = 44;
    CGFloat labelViewW = mapViewW - KEDGE_DISTANCE * 2;
    CGFloat labelViewH = 0;
    if (tacticSingleFoodModel.foodText) {
        CGSize textSize = [ZYZCTool calculateStrLengthByText:tacticSingleFoodModel.foodText andFont:labelViewFont andMaxWidth:labelViewW];
        labelViewH = textSize.height;
    }else{
        labelViewH = 0;
    }
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:KWebImage(tacticSingleFoodModel.foodImg)] placeholderImage:[UIImage imageNamed:@"image_placeholder"] options:options];
    
    self.labelView.text = tacticSingleFoodModel.foodText;
    self.labelView.frame = CGRectMake(labelViewX, labelViewY, labelViewW, labelViewH);
    
    CGFloat mapViewH = labelViewH + 44 + KEDGE_DISTANCE * 2;
    self.mapView.frame = CGRectMake(mapViewX, mapViewY, mapViewW, mapViewH);
    self.mapView.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    
    
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TacticFoodPicCell *cell = [tableView dequeueReusableCellWithIdentifier:picCellID];
        if (!cell) {
            cell = [[TacticFoodPicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:picCellID];
        }
        
        
        
        return cell;
    }else if(indexPath.row == 1) {
        TacticFoodTextCell *cell = [tableView dequeueReusableCellWithIdentifier:textCellID];
        if (!cell) {
            cell = [[TacticFoodTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textCellID];
        }
        
        
        return cell;
    }else{
        TacticFoodPicCell *cell = [tableView dequeueReusableCellWithIdentifier:picCellID];
        if (!cell) {
            cell = [[TacticFoodPicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:picCellID];
        }
        
        return cell;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

#pragma mark - UISrollViewDelegate
/**
 *  navi背景色渐变的效果
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    
    if (offsetY <= imageViewHeight) {
        CGFloat alpha = MAX(0, offsetY/imageViewHeight);
        
        [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(alpha)];
        self.title = @"";
    } else {
        [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(1)];
        if (self.tacticSingleFoodModel) {
            self.title = self.tacticSingleFoodModel.name;
        }
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
