//
//  SNTools.h
//  GUKE
//
//  Created by soulnear on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNTools : NSObject

///时间转换，输入2014-09-10 10：20：21 返回09：10
+(NSString *)dateFromString:(NSString *)dateString;

///弹出一个提示浮层，1.5秒后自动消失
+ (void)showMBProgressWithText:(NSString *)text addToView:(UIView *)aView;











@end























