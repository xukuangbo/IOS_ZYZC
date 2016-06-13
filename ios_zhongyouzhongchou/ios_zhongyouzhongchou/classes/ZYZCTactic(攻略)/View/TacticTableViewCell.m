

#import "TacticTableViewCell.h"
#import "TacticModel.h"
#import "TacticVideoModel.h"
#import "TacticThreeMapView.h"
#import "TacticCustomMapView.h"
#import "ZYZCTool.h"
#import "TacticMoreVideosController.h"
#import "TacticMoreCitiesVC.h"
#import "TacticMoreVideosVC.h"

@interface TacticTableViewCell()<TacticCustomMapViewDelegate>
/**
 *  视频view
 */
@property (nonatomic, weak) UIView *videoView;
/**
 *  video的容器view
 */
@property (nonatomic, weak) TacticThreeMapView *videoThreeMapView;

/**
 *  国家view
 */
@property (nonatomic, strong) TacticCustomMapView *countryView;
/**
 *  国家的容器view1
 */
@property (nonatomic, strong) TacticThreeMapView *countryViewOne;
/**
 *  国家的容器view2
 */
@property (nonatomic, strong) TacticThreeMapView *countryViewTwo;
/**
 *  热门目的地view
 */
@property (nonatomic, strong) TacticCustomMapView *hotDestView;
/**
 *  热门目的地容器view
 */
@property (nonatomic, strong) TacticThreeMapView *hotDestViewOne;
/**
 *  热门目的地容器view
 */
@property (nonatomic, strong) TacticThreeMapView *hotDestViewTwo;


@end

#pragma mark - system方法

@implementation TacticTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        /**
         *  创建视频view
         */
        [self createVideoView];
        
        
        /**
         *  创建国家
         */
        [self createCountryView];
        
        /**
         *  创建目的地view
         */
        [self createDestView];
        
        
    }
    return self;
}
#pragma mark - setUI方法
/**
 *  创建视频view
 */
- (void)createVideoView
{
    CGFloat videoViewX = KEDGE_DISTANCE;
    CGFloat videoViewY = KEDGE_DISTANCE;
    CGFloat videoViewW = KSCREEN_W - videoViewX * 2;
    CGFloat videoViewH = threeViewMapHeight;
//    UIView *videoView = [UIView viewWithIndex:1 frame:CGRectMake(videoViewX, videoViewY, videoViewW, videoViewH) Title:@"视频攻略" desc:@"3分钟看懂旅行目的地核心攻略"];
    TacticCustomMapView *videoView = [[TacticCustomMapView alloc] initWithFrame:CGRectMake(videoViewX, videoViewY, videoViewW, videoViewH)];
    videoView.titleLabel.text = ZYLocalizedString(@"tactic_video_title");
    videoView.moreButton.tag = MoreVCTypeTypeVideo;
    videoView.delegate = self;
    videoView.moreButton.hidden = NO;
    videoView.descLabel.text = ZYLocalizedString(@"tactic_video_detailTitle");
    self.videoView = videoView;
    //添加点击手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotDestViewAction:)];
    [videoView addGestureRecognizer:gesture];
    [self.contentView addSubview:videoView];
    
    //    descLabel.bottom == 44
    CGFloat threeMapViewX = KEDGE_DISTANCE;
    CGFloat threeMapViewY = 44 + 4;
    CGFloat threeMapViewW = videoViewW - KEDGE_DISTANCE * 2;
    CGFloat threeMapViewH = threeViewHeight;
    TacticThreeMapView *threeMapView = [[TacticThreeMapView alloc] initWithFrame:CGRectMake(threeMapViewX, threeMapViewY, threeMapViewW, threeMapViewH)];
    threeMapView.threeMapViewType = threeMapViewTypeVideo;
    [videoView addSubview:threeMapView];
    self.videoThreeMapView = threeMapView;
    
}

- (void)createCountryView
{
    CGFloat hotDestViewX = KEDGE_DISTANCE;
    CGFloat hotDestViewY = self.videoView.bottom + KEDGE_DISTANCE;
    CGFloat hotDestViewW = KSCREEN_W - hotDestViewX * 2;
    CGFloat hotDestViewH = sixViewMapHeight;
    _countryView = [[TacticCustomMapView alloc] initWithFrame:CGRectMake(hotDestViewX, hotDestViewY, hotDestViewW, hotDestViewH)];
    _countryView.moreButton.tag = MoreVCTypeTypeCountryView;
    _countryView.moreButton.hidden = NO;
    _countryView.delegate = self;
    _countryView.titleLabel.text = ZYLocalizedString(@"tactic_country_title");
    _countryView.descLabel.text = ZYLocalizedString(@"country_detail_title");
    [self.contentView addSubview:_countryView];
    //创建3个图片的容器
    
    //    descLabel.bottom == 44
    CGFloat countryViewOneX = KEDGE_DISTANCE;
    CGFloat countryViewOneY = 44 + 4;
    CGFloat countryViewOneW = hotDestViewW - KEDGE_DISTANCE * 2;
    CGFloat countryViewOneH = threeViewHeight;
    _countryViewOne = [[TacticThreeMapView alloc] initWithFrame:CGRectMake(countryViewOneX, countryViewOneY, countryViewOneW, countryViewOneH)];
    [_countryView addSubview:_countryViewOne];
    
    
    //    descLabel.bottom == 44
    CGFloat countryViewTwoX = KEDGE_DISTANCE;
    CGFloat countryViewTwoY = _countryViewOne.bottom + KEDGE_DISTANCE;
    CGFloat countryViewTwoW = _countryView.width - KEDGE_DISTANCE * 2;
    CGFloat countryViewTwoH = threeViewHeight;
    _countryViewTwo = [[TacticThreeMapView alloc] initWithFrame:CGRectMake(countryViewTwoX, countryViewTwoY, countryViewTwoW, countryViewTwoH)];
    [_countryView addSubview:_countryViewTwo];
}


/**
 *  创建目的地view
 */
- (void)createDestView
{
    CGFloat hotDestViewX = KEDGE_DISTANCE;
    CGFloat hotDestViewY = _countryView.bottom + KEDGE_DISTANCE;
    CGFloat hotDestViewW = KSCREEN_W - hotDestViewX * 2;
    CGFloat hotDestViewH = sixViewMapHeight;
    _hotDestView = [[TacticCustomMapView alloc] initWithFrame:CGRectMake(hotDestViewX, hotDestViewY, hotDestViewW, hotDestViewH)];
    _hotDestView.moreButton.tag = MoreVCTypeTypeCityView;
    _hotDestView.moreButton.hidden = NO;
    _hotDestView.delegate = self;
    _hotDestView.titleLabel.text = ZYLocalizedString(@"tactic_dest_title");
    _hotDestView.descLabel.text = ZYLocalizedString(@"country_detail_title");
    
    [self.contentView addSubview:_hotDestView];
    //创建3个图片的容器
    //    descLabel.bottom == 44
    CGFloat hotDestViewOneX = KEDGE_DISTANCE;
    CGFloat hotDestViewOneY = 44 + 4;
    CGFloat hotDestViewOneW = hotDestViewW - KEDGE_DISTANCE * 2;
    CGFloat hotDestViewOneH = threeViewHeight;
    _hotDestViewOne = [[TacticThreeMapView alloc] initWithFrame:CGRectMake(hotDestViewOneX, hotDestViewOneY, hotDestViewOneW, hotDestViewOneH)];
    [_hotDestView addSubview:_hotDestViewOne];
    
    //    descLabel.bottom == 44
    CGFloat hotDestViewTwoX = KEDGE_DISTANCE;
    CGFloat hotDestViewTwoY = _hotDestViewOne.bottom + KEDGE_DISTANCE;
    CGFloat hotDestViewTwoW = _hotDestView.width - KEDGE_DISTANCE * 2;
    CGFloat hotDestViewTwoH = threeViewHeight;
    _hotDestViewTwo = [[TacticThreeMapView alloc] initWithFrame:CGRectMake(hotDestViewTwoX, hotDestViewTwoY, hotDestViewTwoW, hotDestViewTwoH)];
    [_hotDestView addSubview:_hotDestViewTwo];
}

#pragma mark - requsetData方法

#pragma mark - set方法
- (void)setTacticModel:(TacticModel *)tacticModel
{
    if (_tacticModel != tacticModel) {
        _tacticModel = tacticModel;
        
        self.videoThreeMapView.videos = tacticModel.videos;
        
        if (tacticModel.countryViews.count>3) {
            _countryViewOne.singleViews = tacticModel.countryViews;
            
            NSMutableArray *tempArray = [NSMutableArray array];
            for (int i = 3; i < tacticModel.countryViews.count; i++) {
                [tempArray addObject:tacticModel.countryViews[i]];
            }
            _countryViewTwo.singleViews = tempArray;
        }
        
        if (tacticModel.mgViews.count > 3) {//有两排的情况下
            _hotDestViewOne.singleViews = tacticModel.mgViews;
            
            NSMutableArray *tempArrayTwo = [NSMutableArray array];
            for (int i = 3; i < tacticModel.mgViews.count; i++) {
                [tempArrayTwo addObject:tacticModel.mgViews[i]];
            }
            _hotDestViewTwo.singleViews = tempArrayTwo;
        }
        
        
    }
}

#pragma mark - button点击方法

- (void)hotDestViewAction:(UITapGestureRecognizer *)gesture
{
    NSLog(@"555555555");
}

#pragma mark - TacticCustomMapViewDelegate
- (void)pushToMoreVC:(UIButton *)button
{
    if (button.tag == MoreVCTypeTypeVideo) {
        NSLog(@"我是更多视频");
        TacticMoreVideosVC *moreVC = [[TacticMoreVideosVC alloc] init];
//        moreVC.moreArray = self.tacticModel.videos;
        [self.viewController.navigationController pushViewController:moreVC animated:YES];
    }else if (button.tag == MoreVCTypeTypeCountryView){
        NSLog(@"我是更多国家");
        TacticMoreCitiesVC *moreVC = [[TacticMoreCitiesVC alloc] initWithViewType:1];
//        moreVC.moreArray = self.tacticModel.mgViews;
        [self.viewController.navigationController pushViewController:moreVC animated:YES];
    }else if (button.tag == MoreVCTypeTypeCityView){
        NSLog(@"我是更多景点");
        TacticMoreCitiesVC *moreVC = [[TacticMoreCitiesVC alloc] initWithViewType:2];
        //        moreVC.moreArray = self.tacticModel.mgViews;
        [self.viewController.navigationController pushViewController:moreVC animated:YES];
    }else if (button.tag == MoreVCTypeTypeFood){
        NSLog(@"我是更多美食");
    }
}
@end
