//
//  TacticSingleAttractionsController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/2.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticSingleAttractionsController.h"
#import "TacticSingleFoodModel.h"

#define labelViewFont [UIFont systemFontOfSize:16]
#define titleLabelFont [UIFont systemFontOfSize:18]
#define home_navi_bgcolor(alpha) [[UIColor ZYZC_NavColor] colorWithAlphaComponent:alpha]
#define imageViewHeight (KSCREEN_W / 16 * 9)
@interface TacticSingleAttractionsController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIImageView *mapView;
@property (nonatomic, weak) UILabel *labelView;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation TacticSingleAttractionsController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    scrollView.bounces = YES;
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
     创建容器
     */
    UIImageView *mapView = [[UIImageView alloc] init];
    mapView.userInteractionEnabled = YES;
    mapView.layer.cornerRadius = 5;
    mapView.layer.masksToBounds = YES;
    [scrollView addSubview:mapView];
    self.mapView = mapView;
    //创建绿线
    CGFloat lineHeight = 15;
    [mapView addSubview:[UIView lineViewWithFrame:CGRectMake(KEDGE_DISTANCE , KEDGE_DISTANCE, 2,lineHeight) andColor:[UIColor ZYZC_MainColor]]];
    //创建标题
    CGFloat titleLabelX = KEDGE_DISTANCE * 2;
    CGFloat titleLabelY = KEDGE_DISTANCE;
    CGFloat titleLabelW = 200;
    CGFloat titleLabelH = lineHeight;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
    titleLabel.textColor = [UIColor colorWithRed:84/256.0 green:84/256.0 blue:84/256.0 alpha:1];
    titleLabel.text = @"美食介绍";
    titleLabel.font = titleLabelFont;
    [mapView addSubview:titleLabel];
    /**
     *  创建文字
     */
    UILabel *labelView = [[UILabel alloc] init];
    //    labelView.lineBreakMode = NSLineBreakByCharWrapping;
    labelView.textAlignment = NSTextAlignmentCenter;
    labelView.layer.cornerRadius = 5;
    labelView.layer.masksToBounds = YES;
    labelView.font = labelViewFont;
    //    labelView.backgroundColor = [UIColor whiteColor];
    labelView.textColor = [UIColor ZYZC_TextGrayColor];
    labelView.numberOfLines = 0;
    [mapView addSubview:labelView];
    self.labelView = labelView;
}


//- (void)setTacticSingleFoodModel:(TacticSingleFoodModel *)tacticSingleFoodModel
//{
//    _tacticSingleFoodModel = tacticSingleFoodModel;
//    
//    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
//    //肯定有图片
//    CGFloat mapViewX = KEDGE_DISTANCE;
//    CGFloat mapViewY = self.imageView.height + KEDGE_DISTANCE;
//    CGFloat mapViewW = KSCREEN_W - mapViewX * 2;
//    //先计算文字高度
//    CGFloat labelViewX = KEDGE_DISTANCE;
//    CGFloat labelViewY = 44;
//    CGFloat labelViewW = mapViewW - KEDGE_DISTANCE * 2;
//    CGFloat labelViewH = 0;
//    if (tacticSingleFoodModel.foodText) {
//        CGSize textSize = [ZYZCTool calculateStrLengthByText:tacticSingleFoodModel.foodText andFont:labelViewFont andMaxWidth:labelViewW];
//        labelViewH = textSize.height;
//    }else{
//        labelViewH = 0;
//    }
//    
//    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:KWebImage(tacticSingleFoodModel.foodImg)] placeholderImage:[UIImage imageNamed:@"image_placeholder"] options:options];
//    
//    self.labelView.text = tacticSingleFoodModel.foodText;
//    self.labelView.frame = CGRectMake(labelViewX, labelViewY, labelViewW, labelViewH);
//    
//    CGFloat mapViewH = labelViewH + 44 + KEDGE_DISTANCE * 2;
//    self.mapView.frame = CGRectMake(mapViewX, mapViewY, mapViewW, mapViewH);
//    self.mapView.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
//    
//    CGFloat scrollViewH = self.imageView.height + mapViewH + KEDGE_DISTANCE * 2 + 44;
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, scrollViewH);
//    
//    
//}

//#pragma mark - UISrollViewDelegate
///**
// *  navi背景色渐变的效果
// */
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat offsetY = scrollView.contentOffset.y;
//    
//    
//    if (offsetY <= imageViewHeight) {
//        CGFloat alpha = MAX(0, offsetY/imageViewHeight);
//        
//        [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(alpha)];
//        self.title = @"";
//    } else {
//        [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(1)];
//        if (self.tacticSingleFoodModel) {
//            self.title = self.tacticSingleFoodModel.name;
//        }
//        
//    }
//}
@end
