//
//  GeventListViewController.h
//  GUKE
//
//  Created by gaomeng on 14-10-5.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITTCalDay.h"
#import "GRefreshTableView.h"
#import "GeventModel.h"

@interface GeventListViewController : SNViewController<UITableViewDataSource,RefreshDelegate>
{
    RefreshTableView *_tableView;
}


@property(nonatomic,strong)ITTCalDay *calDay;


@end
