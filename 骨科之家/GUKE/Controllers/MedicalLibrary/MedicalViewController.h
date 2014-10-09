//
//  MedicalViewController.h
//  GUKE
//  病历库
//  Created by ianMac on 14-9-24.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"
#import "CreatMedicalViewController.h"
#import "LiuLanBingLiViewController.h"

@interface MedicalViewController : SNViewController<MBProgressHUDDelegate,LiuLanBingLiViewDelegate>

// 创建病历库的列表
@property (nonatomic, strong) PullTableView *tableView;
@end
