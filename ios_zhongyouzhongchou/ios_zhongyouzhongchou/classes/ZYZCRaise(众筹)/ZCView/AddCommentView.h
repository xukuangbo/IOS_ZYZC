//
//  AddCommentView.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/16.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CommentSuccess)(NSString *content);
typedef void (^KeyBoardChange)(CGFloat height,BOOL change);


@interface AddCommentView : UIView
@property (nonatomic, strong) NSNumber *productId;
@property (nonatomic, copy  ) CommentSuccess commentSuccess;
@property (nonatomic, copy  ) KeyBoardChange   keyBoardChange;
@end
