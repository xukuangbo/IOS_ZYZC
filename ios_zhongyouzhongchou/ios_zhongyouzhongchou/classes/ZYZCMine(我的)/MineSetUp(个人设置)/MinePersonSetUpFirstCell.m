//
//  MinePersonSetUpFirstCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MinePersonSetUpFirstCell.h"

@implementation MinePersonSetUpFirstCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *mapView = [[UIView alloc] init];
        [self.contentView addSubview:mapView];
        
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}


@end
