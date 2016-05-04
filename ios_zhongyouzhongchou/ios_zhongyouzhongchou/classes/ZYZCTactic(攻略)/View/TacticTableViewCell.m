

#import "TacticTableViewCell.h"
#import "TacticModel.h"
#import "TacticVideoModel.h"
#import "TacticThreeMapView.h"
#import "TacticCustomMapView.h"
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
    CGFloat videoViewH = threeViewMapHeight;
//    UIView *videoView = [UIView viewWithIndex:1 frame:CGRectMake(videoViewX, videoViewY, videoViewW, videoViewH) Title:@"视频攻略" desc:@"3分钟看懂旅行目的地核心攻略"];
    TacticCustomMapView *videoView = [[TacticCustomMapView alloc] initWithFrame:CGRectMake(videoViewX, videoViewY, videoViewW, videoViewH)];
    videoView.titleLabel.text = @"视频攻略";
    videoView.descLabel.text = @"三分钟看懂旅行目的地核心攻略";
    self.videoView = videoView;
    //添加点击手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotDestViewAction:)];
    [videoView addGestureRecognizer:gesture];
    [self.contentView addSubview:videoView];
    
    //    descLabel.bottom == 44
    CGFloat threeMapViewX = 0;
    CGFloat threeMapViewY = 44 + 4;
    CGFloat threeMapViewW = videoViewW - TacticTableViewCellMargin * 2;
    CGFloat threeMapViewH = threeViewHeight;
    TacticThreeMapView *threeMapView = [[TacticThreeMapView alloc] initWithFrame:CGRectMake(threeMapViewX, threeMapViewY, threeMapViewW, threeMapViewH)];
    threeMapView.threeMapViewType = threeMapViewTypeVideo;
    [videoView addSubview:threeMapView];
    self.videoThreeMapView = threeMapView;
    
}

- (void)hotDestViewAction:(UITapGestureRecognizer *)gesture
{
    NSLog(@"555555555");
}

/**
 *  创建目的地view
 */
- (void)createDestView
{
    CGFloat hotDestViewX = TacticTableViewCellMargin;
    CGFloat hotDestViewY = self.videoView.bottom + TacticTableViewCellMargin;
    CGFloat hotDestViewW = KSCREEN_W - hotDestViewX * 2;
    CGFloat hotDestViewH = threeViewMapHeight;
    TacticCustomMapView *hotDestView = [[TacticCustomMapView alloc] initWithFrame:CGRectMake(hotDestViewX, hotDestViewY, hotDestViewW, hotDestViewH)];
    hotDestView.titleLabel.text = @"热门目的地";
    hotDestView.descLabel.text = @"根据兴趣标签精准匹配更靠谱";
    //创建3个图片的容器
//    descLabel.bottom == 44
    CGFloat threeMapViewX = 0;
    CGFloat threeMapViewY = 44 + 4;
    CGFloat threeMapViewW = hotDestViewW - TacticTableViewCellMargin * 2;
    CGFloat threeMapViewH = threeViewHeight;
    TacticThreeMapView *threeMapView = [[TacticThreeMapView alloc] initWithFrame:CGRectMake(threeMapViewX, threeMapViewY, threeMapViewW, threeMapViewH)];
    threeMapView.threeMapViewType = threeMapViewTypeSingleView;
    [hotDestView addSubview:threeMapView];
    self.hotDestMapView = threeMapView;
    
    [self.contentView addSubview:hotDestView];
    self.hotDestView = hotDestView;
}



- (void)setTacticModel:(TacticModel *)tacticModel
{
    if (_tacticModel != tacticModel) {
        _tacticModel = tacticModel;
        self.videoThreeMapView.videos = tacticModel.videos;
        self.hotDestMapView.videos = tacticModel.videos;
//        //如果视频内容大于等于3，就可以显示
//        if (tacticModel.videos.count >= 3) {
//            self.videoView.hidden = NO;
//            self.videoThreeMapView.videos = tacticModel.videos;
//            
//        }else{
////            self.videoMapView.hidden = YES;
//        }
//        //目的地内容显示
//        if (tacticModel.mgViews.count >= 3) {
//            self.hotDestView.hidden = NO;
//           self.videoThreeMapView.videos = tacticModel.videos;
//        }
    }
}
@end
