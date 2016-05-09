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
#define home_navi_bgcolor(alpha) [[UIColor ZYZC_NavColor] colorWithAlphaComponent:alpha]

#define imageViewHeight (KSCREEN_W / 16 * 9)

#define labelViewFont [UIFont systemFontOfSize:16]

@interface TacticSingleFoodVC ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UIImageView *mapView;
@property (nonatomic, weak) UILabel *labelView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, weak) UIScrollView *scrollView;
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
     *  创建Scrollview
     */
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_W, KSCREEN_H - 49)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    /**
     *  创建图片
     */
    CGFloat imageViewX = 0;
    CGFloat imageViewY = 0;
    CGFloat imageViewW = KSCREEN_W;
    CGFloat imageViewH = imageViewHeight;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)];
    [scrollView addSubview:imageView];
    imageView.backgroundColor = [UIColor redColor];
    self.imageView = imageView;
    /**
     图片上的文字
     */
    UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageViewW, 60)];
    namelabel.font = [UIFont systemFontOfSize:33];
    namelabel.textAlignment = NSTextAlignmentCenter;
    namelabel.textColor = [UIColor whiteColor];
    namelabel.centerX = KSCREEN_W * 0.5;
    namelabel.centerY = imageViewH * 0.5;
    [imageView addSubview:namelabel];
    self.nameLabel = namelabel;
    
    /**
     创建白色背景
     */
    UIImageView *mapView = [[UIImageView alloc] init];
    mapView.userInteractionEnabled = YES;
    [self.scrollView addSubview:mapView];
    self.mapView = mapView;
    /**
     *  创建文字
     */
    UILabel *labelView = [[UILabel alloc] init];
    labelView.layer.cornerRadius = 5;
    labelView.layer.masksToBounds = YES;
    labelView.font = [UIFont systemFontOfSize:16];
    labelView.backgroundColor = [UIColor whiteColor];
    labelView.textColor = [UIColor ZYZC_TextGrayColor];
    labelView.numberOfLines = 0;
    [mapView addSubview:labelView];
    self.labelView = labelView;
    
    //创造3个imageView的数组
    self.imageArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.imageArray addObject:imageView];
    }
}

- (void)setTacticSingleFoodModel:(TacticSingleFoodModel *)tacticSingleFoodModel
{
    _tacticSingleFoodModel = tacticSingleFoodModel;
    
    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
    //肯定有图片
    CGFloat mapViewX = KEDGE_DISTANCE;
    CGFloat mapViewY = imageViewHeight + KEDGE_DISTANCE;
    CGFloat mapViewW = KSCREEN_W - mapViewX * 2;
    //先计算文字高度
    CGFloat labelViewX = KEDGE_DISTANCE;
    CGFloat labelViewY = KEDGE_DISTANCE;
    CGFloat labelViewW = mapViewW - KEDGE_DISTANCE * 2;
    CGFloat labelViewH = 0;
    CGSize textSize = [ZYZCTool calculateStrLengthByText:tacticSingleFoodModel.foodText andFont:labelViewFont andMaxWidth:labelViewW];
    labelViewH = textSize.height;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:KWebImage(tacticSingleFoodModel.foodImg)] placeholderImage:[UIImage imageNamed:@"image_placeholder"] options:options];
    self.nameLabel.text = tacticSingleFoodModel.name;
    
    self.labelView.text = tacticSingleFoodModel.foodText;
    self.labelView.frame = CGRectMake(labelViewX, labelViewY, labelViewW, labelViewH);
    
    CGFloat mapViewH = labelViewH + KEDGE_DISTANCE * 2;
    
    self.mapView.frame = CGRectMake(mapViewX, mapViewY, mapViewW, mapViewH);
    self.mapView.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, self.mapView.height + KEDGE_DISTANCE * 2 + imageViewHeight);
}


- (void)setTacticVideoModel:(TacticVideoModel *)tacticVideoModel
{
    _tacticVideoModel = tacticVideoModel;
    
    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
    //肯定有图片
    CGFloat mapViewX = KEDGE_DISTANCE;
    CGFloat mapViewY = imageViewHeight + KEDGE_DISTANCE;
    CGFloat mapViewW = KSCREEN_W - mapViewX * 2;
    //先计算文字高度
    CGFloat labelViewX = KEDGE_DISTANCE;
    CGFloat labelViewY = KEDGE_DISTANCE;
    CGFloat labelViewW = mapViewW - labelViewX * 2;
    CGFloat labelViewH = 0;
    CGSize textSize = [ZYZCTool calculateStrLengthByText:tacticVideoModel.viewText andFont:labelViewFont andMaxWidth:labelViewW];
    labelViewH = textSize.height;
    
    self.nameLabel.text = tacticVideoModel.name;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:KWebImage(tacticVideoModel.viewImg)] placeholderImage:[UIImage imageNamed:@"image_placeholder"] options:options];
    
    self.labelView.text = tacticVideoModel.viewText;
    self.labelView.frame = CGRectMake(labelViewX, labelViewY, labelViewW, labelViewH);
    
    CGFloat mapViewH = labelViewH + KEDGE_DISTANCE * 2;
    
    if (tacticVideoModel.pics) {
        
        CGFloat imageX = KEDGE_DISTANCE;
        CGFloat imageW = mapViewW - imageX * 2;
        CGFloat imageH = imageW / 16 * 9;
        NSArray *detailImageArray = [tacticVideoModel.pics componentsSeparatedByString:@","];
        for (int i = 0; i < detailImageArray.count; i++) {
            CGFloat imageY = CGRectGetMaxY(self.labelView.frame) + i * (imageH + KEDGE_DISTANCE) + KEDGE_DISTANCE;
            UIImageView *imageView = self.imageArray[i];
            [self.mapView addSubview:imageView];
            imageView.backgroundColor = [UIColor redColor];
            imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            [imageView sd_setImageWithURL:[NSURL URLWithString:KWebImage(detailImageArray[i])] placeholderImage:[UIImage imageNamed:@"image_placeholder"] options:options];
        }
        mapViewH = mapViewH + detailImageArray.count * (imageH + KEDGE_DISTANCE);
    }
    self.mapView.frame = CGRectMake(mapViewX, mapViewY, mapViewW, mapViewH);
    self.mapView.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, CGRectGetMaxY(self.mapView.frame) + KEDGE_DISTANCE);
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
        if (self.tacticVideoModel) {
            self.title = self.tacticVideoModel.name;
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

@end
