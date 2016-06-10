//
//  MineTravelTagsFirstView.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeRealHeightBlock)(CGFloat);
@interface MineTravelTagsFirstView : UICollectionView

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, copy) ChangeRealHeightBlock changeRealHeightBlock;
@end
