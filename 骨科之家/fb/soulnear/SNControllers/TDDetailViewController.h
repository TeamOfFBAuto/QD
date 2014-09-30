//
//  TDDetailViewController.h
//  GUKE
//
//  Created by soulnear on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//
/*
 **主题讨论正文页
 */

#import <UIKit/UIKit.h>
#import "TDListModel.h"

@interface TDDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}

@property(nonatomic,strong)TDListModel * info;

@property(nonatomic,strong)UITableView * myTableVIEW;
@end
