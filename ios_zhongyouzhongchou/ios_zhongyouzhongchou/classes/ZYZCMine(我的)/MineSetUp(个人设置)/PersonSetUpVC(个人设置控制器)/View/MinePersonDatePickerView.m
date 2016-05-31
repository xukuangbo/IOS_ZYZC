//
//  MinePersonDatePickerView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/30.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MinePersonDatePickerView.h"
@interface MinePersonDatePickerView()
@property (nonatomic, weak) UIView *mapView;
@property (nonatomic, copy) NSString *dateString;
@end
@implementation MinePersonDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //弹出生日view
        self.backgroundColor = [UIColor clearColor];
        
//        CGFloat mapViewX = 0;
//        CGFloat mapViewW = KSCREEN_W - mapViewX * 2;
//        CGFloat mapViewH = 270 * KCOFFICIEMNT;
//        CGFloat mapViewY = KSCREEN_H - mapViewH;
        UIView *mapView = [[UIView alloc] init];
        mapView.backgroundColor = [UIColor ZYZC_BgGrayColor];
        [self addSubview:mapView];
        self.mapView = mapView;
        
        //    NSLog(@"%@", [NSLocale availableLocaleIdentifiers]);
        // 初始化UIDatePicker，旋转滚动选择日期类
        
        CGFloat datePickerX = 0;
        CGFloat datePickerY = 0;
        CGFloat datePickerW = KSCREEN_W - datePickerX * 2;
        CGFloat datePickerH = 270 * KCOFFICIEMNT;
        UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(datePickerX, datePickerY, datePickerW, datePickerH)];
        [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
        // 设置时区
        [datePicker setTimeZone:[NSTimeZone localTimeZone]];
        // 设置当前显示时间
        [datePicker setDate:[NSDate date] animated:YES];
        // 设置显示最大时间（此处为当前时间）
        [datePicker setMaximumDate:[NSDate date]];
        // 设置UIDatePicker的显示模式
        [datePicker setDatePickerMode:UIDatePickerModeDate];
        // 当值发生改变的时候调用的方法
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.mapView addSubview:datePicker];
        //    picView.hidden = YES;
        CGFloat margin = 5;
        CGFloat sureBtnX = margin;
        CGFloat sureBtnY = datePicker.bottom + margin;
        CGFloat sureBtnW = KSCREEN_W * 0.5;
        CGFloat sureBtnH = 44 * KCOFFICIEMNT;
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.backgroundColor = [UIColor ZYZC_MainColor];
        sureBtn.origin = CGPointMake(sureBtnX, sureBtnY);
        sureBtn.size = CGSizeMake(sureBtnW, sureBtnH);
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.layer.cornerRadius = 5;
        sureBtn.layer.masksToBounds = YES;
        [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [mapView addSubview:sureBtn];
        
        mapView.size = CGSizeMake(KSCREEN_W, sureBtn.bottom + margin);
        mapView.bottom = KSCREEN_H;
        sureBtn.centerX = self.centerX;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDateView)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)datePickerValueChanged:(UIDatePicker *)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.dateString = [formatter stringFromDate:sender.date];
}

- (void)sureBtnAction
{
    self.sureBlock(self.dateString);
    
    [self removeFromSuperview];
}

- (void)hideDateView
{
    [self removeFromSuperview];
}

@end
