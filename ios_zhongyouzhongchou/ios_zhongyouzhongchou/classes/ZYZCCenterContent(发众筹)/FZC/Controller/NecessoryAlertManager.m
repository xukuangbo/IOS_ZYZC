//
//  NecessoryAlertManager.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/3.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "NecessoryAlertManager.h"
#import "MoreFZCDataManager.h"
#import "MBProgressHUD+MJ.h"
@implementation NecessoryAlertManager

+ (BOOL)showNecessoryAlertView01
{
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    if (manager.goal_goals.count<2) {
        [MBProgressHUD showError:ZYLocalizedString(@"error_no_dest")];
        return YES;
    }
    if (!manager.goal_startDate&&!manager.goal_backDate) {
        [MBProgressHUD showError:ZYLocalizedString(@"error_no_travelTime")];
        return YES;
    }
    if (!manager.goal_travelTheme) {
        [MBProgressHUD showError:ZYLocalizedString(@"error_no_travel_theme")];
        return YES;
    }
    if (!manager.goal_travelThemeImgUrl) {
        [MBProgressHUD showError:ZYLocalizedString(@"error_no_travel_image")];
        return YES;
    }
    return NO;
}

+ (BOOL)showNecessoryAlertView02
{
    if (![self showNecessoryAlertView01]) {
        MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
        
        if (!manager.raiseMoney_totalMoney) {
            [MBProgressHUD showError:ZYLocalizedString(@"error_no_spell_buy_price")];
            return YES;
        }
        if (!manager.raiseMoney_wordDes&&!manager.raiseMoney_voiceUrl&&!manager.raiseMoney_movieUrl) {
            [MBProgressHUD showError:ZYLocalizedString(@"error_no_travelDesc")];
            return YES;
        }
        return NO;
    } ;
    return YES;
}

+ (BOOL)showNecessoryAlertView03
{
    if (![self showNecessoryAlertView02]) {
        MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
        
        if (!manager.travelDetailDays.count) {
            [MBProgressHUD showError:ZYLocalizedString(@"error_no_travelSchedule")];
            return YES;
        }
        return NO;
    }
    return YES;
}

+ (BOOL)showNecessoryAlertView04
{
    if (![self showNecessoryAlertView03]) {
        MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
        
        if ([manager.return_returnPeopleStatus isEqualToString:@"1"]) {
            if (!manager.return_returnPeopleNumber||!manager.return_returnPeopleMoney) {
                [MBProgressHUD showError:ZYLocalizedString(@"error_no_return1")];
                return YES;
            }
            else
            {
                if (!manager.return_wordDes&&!manager.return_voiceUrl&&!manager.return_movieUrl) {
                    [MBProgressHUD showError:ZYLocalizedString(@"error_no_return1")];
                    return YES;
                }
            }
        }
        if ([manager.return_returnPeopleStatus01 isEqualToString:@"1"]) {
            if (!manager.return_returnPeopleNumber01||!manager.return_returnPeopleMoney01) {
                [MBProgressHUD showError:ZYLocalizedString(@"error_no_return2")];
                return YES;
            }
            else
            {
                if (!manager.return_wordDes01&&!manager.return_voiceUrl01&&!manager.return_movieUrl01) {
                    [MBProgressHUD showError:ZYLocalizedString(@"error_no_return2")];
                    return YES;
                }
            }
        }
        
        if (!manager.return_togetherRateMoney) {
            [MBProgressHUD showError:ZYLocalizedString(@"error_no_togetherTravel_money_rate")];
            return YES;
        }
        return NO;
    }
    return YES;
}



+ (BOOL)showNecessoryAlertView
{
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    if (manager.goal_goals.count<2) {
        [MBProgressHUD showError:ZYLocalizedString(@"error_no_dest")];
        return YES;
    }
    if (!manager.goal_startDate&&!manager.goal_backDate) {
        [MBProgressHUD showError:ZYLocalizedString(@"error_no_travelTime")];
        return YES;
    }
    if (!manager.goal_travelTheme) {
        [MBProgressHUD showError:ZYLocalizedString(@"error_no_travel_theme")];
        return YES;
    }
    if (!manager.goal_travelThemeImgUrl) {
        [MBProgressHUD showError:ZYLocalizedString(@"error_no_travel_image")];
        return YES;
    }
    if (!manager.raiseMoney_totalMoney) {
        [MBProgressHUD showError:ZYLocalizedString(@"error_no_spell_buy_price")];
        return YES;
    }
    if (!manager.raiseMoney_wordDes&&!manager.raiseMoney_voiceUrl&&!manager.raiseMoney_movieUrl) {
        [MBProgressHUD showError:ZYLocalizedString(@"error_no_travelDesc")];
        return YES;
    }
    if (!manager.travelDetailDays.count) {
        [MBProgressHUD showError:ZYLocalizedString(@"error_no_travelSchedule")];
        return YES;
    }
    if (!manager.return_togetherMoneyPercent) {
        [MBProgressHUD showError:ZYLocalizedString(@"error_no_togetherTravel_money_rate")];
        return YES;
    }
    if ([manager.return_returnPeopleStatus isEqualToString:@"1"]) {
        if (!manager.return_returnPeopleNumber||!manager.return_returnPeopleMoney) {
            [MBProgressHUD showError:ZYLocalizedString(@"error_no_return1")];
            return YES;
        }
        else
        {
            if (!manager.return_wordDes&&!manager.return_voiceUrl&&!manager.return_movieUrl) {
                [MBProgressHUD showError:ZYLocalizedString(@"error_no_return1")];
                return YES;
            }
        }
    }
    if (manager.return_returnPeopleStatus01) {
        if (!manager.return_returnPeopleNumber01||!manager.return_returnPeopleMoney01) {
            [MBProgressHUD showError:ZYLocalizedString(@"error_no_return2")];
            return YES;
        }
        else
        {
            if (!manager.return_wordDes01&&!manager.return_voiceUrl01&&!manager.return_movieUrl01) {
                [MBProgressHUD showError:ZYLocalizedString(@"error_no_return2")];
                return YES;
            }
        }
    }
    return NO;
    
}

@end
