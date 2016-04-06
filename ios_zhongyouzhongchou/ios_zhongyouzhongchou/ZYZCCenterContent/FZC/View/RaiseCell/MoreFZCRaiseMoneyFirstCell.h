//
//  MoreFZCRaiseMoneyFirstCell.h
//  ios_zhongyouzhongchou

#import "MoreFZCBaseTableViewCell.h"
#import "RaiseMoneyFirstModel.h"

#define kRaiseMoneyRealHeight 100
typedef void (^ChangeHeightBlock)(RaiseMoneyFirstModel *);


@interface MoreFZCRaiseMoneyFirstCell : MoreFZCBaseTableViewCell<UITextFieldDelegate>
/**
 *  明细按钮
 */
@property (nonatomic, weak) UIButton *openButton;
/**
 *  背景白图
 */
@property (nonatomic, weak) UIImageView *bgView;
/**
 *  添加明细的界面
 */
@property (nonatomic, weak) UIView *detailView;

/**
 *  真正的高度
 */
@property (nonatomic, assign) CGFloat realHeight;
/**
 *  money输入框
 */
@property (nonatomic, weak) UITextField *moneyTextfiled;

//4个输入框的数据
@property (nonatomic, weak) UITextField *sightTextfiled;
@property (nonatomic, weak) UITextField *transportTextfiled;
@property (nonatomic, weak) UITextField *liveTextfiled;
@property (nonatomic, weak) UITextField *eatTextfiled;

@property (nonatomic, strong) RaiseMoneyFirstModel *model;

@property (nonatomic, copy) ChangeHeightBlock changeHeightBlock;
@end
