//
//  ZYZCMyWallet.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/18.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCMyWallet.h"

@implementation ZYZCMyWallet

-(void)getMyWallet
{
    NSDictionary *parameters=@{@"openid":[ZYZCTool getUserId]};
    [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:GET_MYWALLET andParameters:parameters andSuccessGetBlock:^(id result, BOOL isSuccess) {
        NSLog(@"%@",result);
        
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
}

@end
