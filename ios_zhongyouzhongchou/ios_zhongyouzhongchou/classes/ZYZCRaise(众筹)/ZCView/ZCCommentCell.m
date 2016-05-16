//
//  ZCCommitCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/16.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCCommentCell.h"

@interface ZCCommentCell ()
@property (nonatomic,strong)UIButton *iconImg;
@end

@implementation ZCCommentCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
    }
    return self;
}

-(void)configUI
{
    
}

-(void)setCommentModel:(ZCCommentModel *)commentModel
{
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
