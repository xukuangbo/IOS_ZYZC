//
//  WXApiShare.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/14.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "WXApiShare.h"

@implementation WXApiShare
+ (void) shareWebPageWithTitle:(NSString *)title andDesc:(NSString *)description andThumbImage:(NSString *)thumbImage andWebUrl:(NSString *)webUrl
{
    WXMediaMessage *message=[WXMediaMessage message];
    message.title=title;
    message.description=description;
    //图片不能大于10k
    [message setThumbImage:[UIImage imageNamed:@"btn_fzc_pre"]];
    WXWebpageObject *webpageObject=[WXWebpageObject object];
    webpageObject.webpageUrl=@"http://itunes.apple.com/cn/app/id533655318?mt=8";message.mediaObject=webpageObject;
    
    SendMessageToWXReq *req=[[SendMessageToWXReq alloc]init];
    req.bText=NO;
    req.message=message;
    req.scene=WXSceneTimeline;
    
    [WXApi sendReq:req];
}
@end























