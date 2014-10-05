//
//  GcalendarDetailViewController.h
//  GUKE
//
//  Created by gaomeng on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//


//会议列表
#import <UIKit/UIKit.h>
#import "ITTCalDay.h"
#import "GRefreshTableView.h"
#import "GeventModel.h"


@interface GcalendarDetailViewController : SNViewController<UITableViewDataSource,RefreshDelegate>
{
    RefreshTableView *_tableView;
}
@property(nonatomic,strong)ITTCalDay *calDay;

@end
