//
//  MineTravelTagBgView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define MineTravelTagsTitleFont [UIFont systemFontOfSize:15]
#define MineTravelTagsDetailTitleFont [UIFont systemFontOfSize:12]
#import "MineTravelTagBgView.h"
#import "MineTravelTagButton.h"
#import "MineTravelTagsModel.h"
#import "MBProgressHUD+MJ.h"
@interface MineTravelTagBgView()

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *detailTitle;

@property (nonatomic, strong) NSArray *titleArray;



@end

@implementation MineTravelTagBgView
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title DetailTitle:(NSString *)detailTitle TitleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _maxCount = 0;
        self.userInteractionEnabled = YES;
        _title  = title;
        _detailTitle = detailTitle;
        
        //大标题
        CGSize titleSize = [ZYZCTool calculateStrLengthByText:title andFont:MineTravelTagsTitleFont andMaxWidth:MAXFLOAT];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KEDGE_DISTANCE, KEDGE_DISTANCE, titleSize.width, titleSize.height)];
        titleLabel.text = title;
        titleLabel.font = MineTravelTagsTitleFont;
        titleLabel.textColor = [UIColor grayColor];
        [self addSubview:titleLabel];
        
        CGSize detailSize = [ZYZCTool calculateStrLengthByText:detailTitle andFont:MineTravelTagsDetailTitleFont andMaxWidth:MAXFLOAT];
        UILabel *detailTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right + KEDGE_DISTANCE, KEDGE_DISTANCE, detailSize.width, detailSize.height)];
        detailTitleLabel.text = detailTitle;
        detailTitleLabel.font = MineTravelTagsDetailTitleFont;
        detailTitleLabel.textColor = [UIColor grayColor];
        detailTitleLabel.bottom = titleLabel.bottom;
        [self addSubview:detailTitleLabel];
        
        
        NSUInteger totalRow = (titleArray.count + 3) / 4;
        CGFloat realHeight = totalRow * ( MineTravelTagButtonH + KEDGE_DISTANCE) + titleLabel.bottom + KEDGE_DISTANCE;
        self.height = realHeight;
        self.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
        
        
        CGFloat buttonW = (frame.size.width - 5 * KEDGE_DISTANCE) / 4;
        CGFloat buttonH = MineTravelTagButtonH;
        for (int i = 0; i < titleArray.count; i++) {
            int row = i / 4;
            int col = i % 4;
            CGFloat buttonX = col * (buttonW + KEDGE_DISTANCE) + KEDGE_DISTANCE;
            CGFloat buttonY = row * (buttonH + KEDGE_DISTANCE) + KEDGE_DISTANCE + titleLabel.bottom;
            MineTravelTagsModel *model = titleArray[i];
            
            MineTravelTagButton *button = [[MineTravelTagButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
            __weak typeof(&*self) weakSelf = self;
            __weak typeof(&*button) weakButton = button;
            button.buttonClickBlock = ^(){
               
                if (_maxCount <= 10) {
                    //先判断在变颜色
                    weakButton.selected = !weakButton.selected;
                    if (weakButton.selected == YES) {
                        
                        weakSelf.maxCount++;
                        
                        weakButton.backgroundColor = [UIColor ZYZC_MainColor];
                        
                        weakButton.layer.borderColor = [UIColor ZYZC_MainColor].CGColor;
                    }else{
                        weakSelf.maxCount--;
                        
                        weakButton.backgroundColor = [UIColor clearColor];
                        
                        weakButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
                    }
                }else{
                    [MBProgressHUD showError:@"最大标签数为10!"];
                }
            };
            button.textString = model.value;
//            button.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1.0];
            [self addSubview:button];
        }
    }
    return self;
}

@end
