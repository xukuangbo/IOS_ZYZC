//
//  ReturnSecondCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ReturnSecondCell.h"

@implementation ReturnSecondCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        ReturnCellBaseBGView *bgImageView = [ReturnCellBaseBGView viewWithRect:CGRectMake(10, 0, KSCREEN_W - 20, 150) title:@"支持任意金额" image:[UIImage imageNamed:@"btn_xs_one"] selectedImage:nil desc:@"可多次支持，最多可支持众筹剩余金额的100%。每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。可多次支持，最多可支持众筹剩余金额的100%。每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。可多次支持，最多可支持众筹剩余金额的100%。每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。可多次支持，最多可支持众筹剩余金额的100%。每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。可多次支持，最多可支持众筹剩余金额的100%。每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。"];
        [self.contentView addSubview:bgImageView];
        self.bgImageView = bgImageView;
        
        
    }
    return self;
}
- (void)setOpen:(BOOL)open
{
    if (_open != open) {
        _open = open;
        
        if (open == YES) {
            //这里就是展开，改变所有东西的值
            self.bgImageView.height = 350;
            self.bgImageView.descLabel.numberOfLines = 0;
            self.bgImageView.descLabel.height = 290;
            self.bgImageView.downButton.hidden = YES;
        }else{
            self.bgImageView.height = 150;
            self.bgImageView.descLabel.numberOfLines = 3;
            self.bgImageView.descLabel.height = 90;
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    
    
}

@end
