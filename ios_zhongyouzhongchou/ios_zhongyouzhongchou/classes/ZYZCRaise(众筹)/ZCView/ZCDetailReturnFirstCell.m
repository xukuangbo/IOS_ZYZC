//
//  ZCDetailReturnFirstCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/25.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define HASSUPPORTPEOPLE(numberPeople) [NSString stringWithFormat:@"已支持:%d位",numberPeople]
#define RETURNSUPPORT(money) [NSString stringWithFormat:@"回报支持:%d元",money]

#define TOGETHERSUPPORT(money) [NSString stringWithFormat:@"一起去:支持5％旅费(%d)元",money]

#import "ZCDetailReturnFirstCell.h"

@interface ZCDetailReturnFirstCell ()
//@property (nonatomic, strong) UIView *supportOneYuanView;
//@property (nonatomic, strong) UIView *supportAnyYuanView;
//@property (nonatomic, strong) UIView *returnSupportView;
//@property (nonatomic, strong) UIView *togetherView;

@property (nonatomic, assign) NSInteger oneYuanSupportPeople;
@property (nonatomic, assign) NSInteger anyYuanSupportPeople;
@property (nonatomic, assign) NSInteger returnSupportPeople;
@property (nonatomic, assign) NSInteger returnSupportLeftPeople;
@property (nonatomic, assign) NSInteger togetherPeople;
@property (nonatomic, assign) NSInteger signUpTogetherPeople;

@end

@implementation ZCDetailReturnFirstCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)configUI{
    [super configUI];
    [self.topLineView removeFromSuperview];
    [self.titleLab  removeFromSuperview];
    
    NSString *text01=@"大大里打到卡上的卡上打空间收到啦可是大对空射击阿莱克斯就啊索朗多吉啊索朗多吉阿斯利康打击打击了大声哭了的哈结束多哈的哈大哭大叫啊打卡机打了卡多久啊圣诞节啊了多大酒店啦睡觉啊说";
    NSString *text02=@"斯大林时代卡上打斯大林时代啦可是大对空射击阿莱克斯就啊索朗多吉啊索朗多吉阿斯利康打击打击了大声哭了的哈结束多哈的哈大哭大叫啊打卡机打了卡多久啊圣诞节啊了多大酒店啦睡觉啊说";
    NSString *text03=@"斯大林时代啦可是大对空射击阿莱克斯就啊索朗多吉啊";
    NSString *text04=@"等待就是克里斯朵夫塑料袋看风景的苏里科夫说斯大林时代卡上打斯大林时代啦可是大对空射击阿莱克斯就啊索朗多吉啊索朗多吉阿斯利康打击打击了大声哭了的哈结束多哈的哈大哭大叫啊打卡机打了卡多久啊圣诞节啊了多大酒店啦睡觉啊说";
   _supportOneYuanView =[[ZCDetailReturnCusView alloc]initSupportViewByTop:0 andTitle:@"支持1元" andText:text01 andSupportType:SuppurtOneYuan];
    [self.contentView addSubview:_supportOneYuanView];
    
    _supportAnyYuanView =[[ZCDetailReturnCusView alloc]initSupportViewByTop:_supportOneYuanView.bottom andTitle:@"支持任意金额：" andText:text02 andSupportType:SuppurtAnyYuan];
    [self.contentView addSubview:_supportAnyYuanView];
    
    _returnSupportView =[[ZCDetailReturnCusView alloc]initSupportViewByTop:_supportAnyYuanView.bottom andTitle:RETURNSUPPORT(0) andText:text03 andSupportType:SuppurtReturnMoney];
    [self.contentView addSubview:_returnSupportView];
    
    _togetherView =[[ZCDetailReturnCusView alloc]initSupportViewByTop:_returnSupportView.bottom andTitle:TOGETHERSUPPORT(0) andText:text04 andSupportType:SuppurtTogetherMoney];
    [self.contentView addSubview:_togetherView];


}

-(void)setCellModel:(ZCDetailReturnFirstCellModel *)cellModel
{
    _cellModel=cellModel;
    _supportOneYuanView.supportNumber=10;
    _supportAnyYuanView.supportNumber=20;
    _returnSupportView.limitNumber=5;
    _returnSupportView.supportNumber=10;
    
    _returnSupportView.titleLab.text=RETURNSUPPORT(200);
    _returnSupportView.titleLab.width=[ZYZCTool calculateStrLengthByText:RETURNSUPPORT(200) andFont:[UIFont systemFontOfSize:15] andMaxWidth:KSCREEN_W].width;
    
    _togetherView.titleLab.text=TOGETHERSUPPORT(200);
    _togetherView.titleLab.width=[ZYZCTool calculateStrLengthByText:TOGETHERSUPPORT(200) andFont:[UIFont systemFontOfSize:15] andMaxWidth:KSCREEN_W].width;
    
    _supportAnyYuanView.top=_supportOneYuanView.bottom+KEDGE_DISTANCE;
    _returnSupportView.top =_supportAnyYuanView.bottom+KEDGE_DISTANCE;
    _togetherView.top =_returnSupportView.bottom+KEDGE_DISTANCE;
    self.bgImg.height=_togetherView.bottom+KEDGE_DISTANCE;
    cellModel.cellHeight=self.bgImg.height;
}


//-(UIView *)createSupportViewByTop:(CGFloat   )top
//                         andTitle:(NSString *)title
//                          andText:(NSString *)text
//                   andSupportType:(SupportMoneyType )supportType
//{
//    UIView *supportView=[[UIView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, top, KSCREEN_W-4*KEDGE_DISTANCE, 0)];
//    if (supportType!=SuppurtOneYuan) {
//        //创建分割线
//        [supportView addSubview:[UIView lineViewWithFrame:CGRectMake(0, 0, supportView.width, 1) andColor:nil]];
//    }
//    //支持按钮
//    UIButton *supportBtn=[self createBtnByFrame:CGRectMake(supportView.width-60, 0, 60, 22) andSupportType:supportType];
//    [supportView addSubview:supportBtn];
//    //标题
//    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, supportView.width-supportBtn.width-2*KEDGE_DISTANCE, 20)];
//    titleLab.text=title;
//    titleLab.font=[UIFont systemFontOfSize:15];
//    titleLab.textColor=[UIColor ZYZC_RedTextColor];
//    [supportView addSubview:titleLab];
//    //内容介绍
//    CGFloat textWidth =supportView.width-30;
//    CGFloat textHeight=[ZYZCTool calculateStrByLineSpace:10.0 andString:text andFont:[UIFont systemFontOfSize:15] andMaxWidth:supportView.width-50].height;
//    if (textHeight>75 ) {
//        //添加更多按钮
//        UIButton *moreTextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        moreTextBtn.frame=CGRectMake(supportView.width-40, titleLab.bottom+60, 40, 30);
//        [moreTextBtn setImage:[UIImage imageNamed:@"btn_xxd"] forState:UIControlStateNormal];
//        moreTextBtn.tag=supportType;
//        moreTextBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 26, 0, 0);
//        [moreTextBtn addTarget:self action:@selector(openMoreText:) forControlEvents:UIControlEventTouchUpInside];
//        [supportView addSubview:moreTextBtn];
//        
//        if (_supportType==SuppurtOneYuan) {
//            moreTextBtn.top= titleLab.bottom+textHeight-15;
//        }
//        else
//        {
//            textHeight=75;
//        }
//
//    }
//    //添加内容标签
//    UILabel *textLab=[[UILabel alloc]initWithFrame:CGRectMake(0, titleLab.bottom+KEDGE_DISTANCE, textWidth, textHeight)];
//    textLab.font=[UIFont systemFontOfSize:15];
//    textLab.numberOfLines=3;
//    textLab.attributedText=[ZYZCTool setLineDistenceInText:text];
//    textLab.textColor=[UIColor ZYZC_TextBlackColor];
//    [supportView addSubview:textLab];
//    
//    //添加已支持多少位标签
//    UILabel *hasSupportPeopleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, textLab.bottom+KEDGE_DISTANCE, supportView.width, 20)];
//    hasSupportPeopleLab.font=[UIFont systemFontOfSize:13];
//    hasSupportPeopleLab.textColor=[UIColor ZYZC_TextBlackColor];
//    hasSupportPeopleLab.attributedText=[self customStringByString:HASSUPPORTPEOPLE(0)];
//    [supportView addSubview:hasSupportPeopleLab];
//    
//    supportView.height=hasSupportPeopleLab.bottom+KEDGE_DISTANCE;
//    return supportView;
//}
//
//#pragma mark --- 创建支持按钮
//-(UIButton *)createBtnByFrame:(CGRect )frame andSupportType:(SupportMoneyType )supportMoneyType
//{
//    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame=frame;
//    btn.tag=(NSInteger)supportMoneyType;
//    [btn setTitle:@"支持" forState:UIControlStateNormal];
//    btn.titleLabel.font=[UIFont systemFontOfSize:15];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn.backgroundColor=[UIColor ZYZC_MainColor];
//    btn.layer.cornerRadius=3;
//    btn.layer.masksToBounds=YES;
//    [btn addTarget:self action:@selector(supportMoney:) forControlEvents:UIControlEventTouchUpInside];
//    return  btn;
//}
//
//#pragma mark --- 展开更多内容
//-(void)openMoreText:(UIButton *)sender
//{
//    if (_openMoreText) {
//        _openMoreText(sender.tag);
//    }
//}
//
//#pragma mark --- 支持金额
//-(void)supportMoney:(UIButton *)sender
//{
//    switch (self.tag) {
//        case SuppurtOneYuan:
//            
//            break;
//        case SuppurtAnyYuan:
//            
//            break;
//        case SuppurtReturnMoney:
//            
//            break;
//        case SuppurtGoTogetherMoney:
//            
//            break;
//            
//        default:
//            break;
//    }
//}
//
//#pragma mark --- 改变文字样式
//-(NSAttributedString *)customStringByString:(NSString *)str
//{
//    NSMutableAttributedString *attrStr=[[NSMutableAttributedString alloc]initWithString:str];
//    NSRange range1=[str rangeOfString:@":"];
//   
//    NSRange range2=[str rangeOfString:@"位"];
//    
//    if (str.length) {
//        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(range1.location+1, range2.location-range1.location-1)];
//        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(range1.location+1, range2.location-range1.location-1)];
//    }
//    return  attrStr;
//}

@end








