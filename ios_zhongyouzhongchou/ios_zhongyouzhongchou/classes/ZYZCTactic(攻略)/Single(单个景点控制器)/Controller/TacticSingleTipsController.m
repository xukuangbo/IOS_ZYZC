//
//  TacticSingleTipsController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/2.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticSingleTipsController.h"
#import "TacticSingleTipsModel.h"
#define home_navi_bgcolor(alpha) [[UIColor ZYZC_NavColor] colorWithAlphaComponent:alpha]
#define imageViewHeight (KSCREEN_W / 16 * 9)
@interface TacticSingleTipsController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *labelView;
@property (nonatomic, weak) UIImageView *mapView;
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation TacticSingleTipsController

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
    scrollView.bounces = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    /**
     创建白色背景
     */
    UIImageView *mapView = [[UIImageView alloc] init];
    mapView.userInteractionEnabled = YES;
    [self.scrollView addSubview:mapView];
    self.mapView = mapView;
    /**
     *  创建图片
     */
    CGFloat imageViewX = 0;
    CGFloat imageViewY = 0;
    CGFloat imageViewW = KSCREEN_W;
    CGFloat imageViewH = imageViewHeight;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)];
    [self.scrollView addSubview:imageView];
    imageView.backgroundColor = [UIColor redColor];
    self.imageView = imageView;
    
    /**
     *  创建文字
     */
    UILabel *labelView = [[UILabel alloc] init];
    labelView.layer.cornerRadius = 5;
    labelView.layer.masksToBounds = YES;
    labelView.font = labelViewFont;
    labelView.textColor = [UIColor ZYZC_TextGrayColor];
    labelView.numberOfLines = 0;
    [mapView addSubview:labelView];
    self.labelView = labelView;
    
}

- (void)setTacticSingleTipsModel:(TacticSingleTipsModel *)tacticSingleTipsModel
{
    _tacticSingleTipsModel = tacticSingleTipsModel;
    
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
    if (tacticSingleTipsModel.tipsText) {
//        NSString *str = [NSString string];
//        NSLog(@"%@",tacticSingleTipsModel.tipsText);
//        NSArray *tempArray = [tacticSingleTipsModel.tipsText componentsSeparatedByString:@"\r\n"];
//        NSLog(@"%@",tempArray);
        
        CGSize textSize = [ZYZCTool calculateStrLengthByText:tacticSingleTipsModel.tipsText andFont:labelViewFont andMaxWidth:labelViewW];
        labelViewH = textSize.height;
    }else{
        labelViewH = 0;
    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:KWebImage(tacticSingleTipsModel.tipsImg)] placeholderImage:[UIImage imageNamed:@"image_placeholder"] options:options];
    
    self.labelView.frame = CGRectMake(labelViewX, labelViewY, labelViewW, labelViewH);
    self.labelView.text = tacticSingleTipsModel.tipsText;
    
    CGFloat mapViewH = labelViewH + KEDGE_DISTANCE * 2;
    self.mapView.frame = CGRectMake(mapViewX, mapViewY, mapViewW, mapViewH);
    self.mapView.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    
    CGFloat scrollViewH = self.imageView.height + mapViewH + KEDGE_DISTANCE * 2;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, scrollViewH);
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
        if (self.tacticSingleTipsModel) {
            self.title = self.tacticSingleTipsModel.name;
        }
        
    }
}
@end
