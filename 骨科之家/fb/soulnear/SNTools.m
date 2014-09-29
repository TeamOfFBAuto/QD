//
//  SNTools.m
//  GUKE
//ni
//  Created by soulnear on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "SNTools.h"

@implementation SNTools

+(NSString *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:destDate];
    return destDateString;
}


+ (void)showMBProgressWithText:(NSString *)text addToView:(UIView *)aView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = text;
    hud.margin = 15.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}










@end














