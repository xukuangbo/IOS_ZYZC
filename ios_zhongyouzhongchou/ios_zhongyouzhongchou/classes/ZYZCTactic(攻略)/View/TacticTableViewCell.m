

#import "TacticTableViewCell.h"
#import "TacticModel.h"
#import "TacticVideoModel.h"
#import "TacticThreeMapView.h"
#import "ZYZCTool.h"
@interface TacticTableViewCell()
/**
 *  视频view
 */
@property (nonatomic, weak) UIView *videoView;
/**
 *  video的容器view
 */
@property (nonatomic, weak) TacticThreeMapView *videoThreeMapView;
/**
 *  热门目的地view
 */
@property (nonatomic, weak) UIView *hotDestView;
/**
 *  热门目的地容器view
 */
@property (nonatomic, weak) TacticThreeMapView *hotDestMapView;


@end


@implementation TacticTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor ZYZC_BgGrayColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        /**
         *  创建视频view
         */
        [self createVideoView];
        
        /**
         *  创建目的地view
         */
        [self createDestView];
    }
    return self;
}
/**
 *  创建视频view
 */
- (void)createVideoView
{
    CGFloat videoViewX = TacticTableViewCellMargin;
    CGFloat videoViewY = TacticTableViewCellMargin;
    CGFloat videoViewW = KSCREEN_W - videoViewX * 2;
    CGFloat videoViewH = videoViewHeight;
    UIView *videoView = [self viewWithIndex:1 frame:CGRectMake(videoViewX, videoViewY, videoViewW, videoViewH) Title:@"视频攻略" desc:@"3分钟看懂旅行目的地核心攻略"];
    [self.contentView addSubview:videoView];
    self.videoView = videoView;
    //创建3个view放到视频view里面
    
}

/**
 *  创建目的地view
 */
- (void)createDestView
{
    CGFloat hotDestViewX = TacticTableViewCellMargin;
    CGFloat hotDestViewY = self.videoView.bottom + TacticTableViewCellMargin;
    CGFloat hotDestViewW = KSCREEN_W - hotDestViewX * 2;
    CGFloat hotDestViewH = videoViewHeight;
    UIView *hotDestView = [self viewWithIndex:2 frame:CGRectMake(hotDestViewX, hotDestViewY, hotDestViewW, hotDestViewH) Title:@"热门目的地" desc:@"根据兴趣标签精准匹配更靠谱"];
    [self.contentView addSubview:hotDestView];
    self.hotDestView = hotDestView;
}

- (UIView *)viewWithIndex:(NSInteger)index frame:(CGRect)rect Title:(NSString *)title desc:(NSString *)desc
{
    CGFloat margin = 10;
    UIView *mapView = [[UIView alloc ] initWithFrame:rect];
//    mapView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1.0];
    mapView.backgroundColor = [UIColor whiteColor];
    mapView.layer.cornerRadius = 5;
    mapView.layer.masksToBounds = YES;
    //创建绿线
    CGFloat lineHeight = 15;
   [mapView addSubview:[UIView lineViewWithFrame:CGRectMake(margin , margin, 2, lineHeight) andColor:[UIColor ZYZC_MainColor]]];
    //创建标题
    CGFloat titleLabelX = margin * 2;
    CGFloat titleLabelY = margin;
    CGFloat titleLabelW = 100;
    CGFloat titleLabelH = lineHeight;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithRed:84/256.0 green:84/256.0 blue:84/256.0 alpha:1];
    titleLabel.font = titleFont;
    [mapView addSubview:titleLabel];
    
    //创建向右的箭头
    CGFloat rightButtonW = 60;
    CGFloat rightButtonH = 15;
    CGFloat rightButtonX = mapView.width - margin - rightButtonW;
    CGFloat rightButtonY = margin;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(rightButtonX, rightButtonY, rightButtonW, rightButtonH);
    [rightButton setImage:[UIImage imageNamed:@"btn_rig_mor"] forState:UIControlStateNormal];
    [rightButton setTitle:@"更多" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = descFont;
    
    //得出文字的宽度,交换两个的位置
    CGSize rightButtonTitleSize = [ZYZCTool calculateStrLengthByText:@"更多" andFont:descFont andMaxWidth:MAXFLOAT];
    CGFloat labelWidth = rightButtonTitleSize.width + 2;
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    CGFloat imageWith = rightButton.currentImage.size.width + 2;
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, imageWith);
    
    [mapView addSubview:rightButton];
    //创建描述
    CGFloat descLabelX = margin * 2;
    CGFloat descLabelY = titleLabel.bottom + 4;
    CGFloat descLabelW = 250;
    CGFloat descLabelH = lineHeight;
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(descLabelX, descLabelY, descLabelW, descLabelH)];
    descLabel.text = desc;
    descLabel.font = descFont;
    descLabel.textColor = [UIColor ZYZC_TextGrayColor];
    [mapView addSubview:descLabel];
    
    //创建3个图片的容器
    TacticThreeMapView *threeMapView = [[TacticThreeMapView alloc] initWithFrame:CGRectMake(0, descLabel.bottom + 4, mapView.width, 90)];
    [mapView addSubview:threeMapView];
    
    if (index == 1) {//是第一个框框
        self.videoThreeMapView = threeMapView;
    }else if (index == 2){//是第二个框框
        self.hotDestMapView = threeMapView;
    }
    
    return mapView;
}

- (void)setTacticModel:(TacticModel *)tacticModel
{
    if (_tacticModel != tacticModel) {
        _tacticModel = tacticModel;
        //如果视频内容大于等于3，就可以显示
        if (tacticModel.videos.count >= 3) {
            self.videoView.hidden = NO;
            self.videoThreeMapView.videos = tacticModel.videos;
            
        }else{
//            self.videoMapView.hidden = YES;
        }
        
        //目的地内容显示
        if (tacticModel.mgViews.count >= 3) {
            self.hotDestView.hidden = NO;
            self.hotDestMapView.videos = tacticModel.mgViews;
        }
    }
}
@end
