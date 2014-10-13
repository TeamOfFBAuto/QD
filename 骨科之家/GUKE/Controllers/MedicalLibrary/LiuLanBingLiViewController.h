//
//  LiuLanBingLiViewController.h
//  GUKE
//
//  Created by soulnear on 14-10-3.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BingLiListFeed.h"

#import "InfoFileTableViewCell.h"
@protocol LiuLanBingLiViewDelegate<NSObject>
@optional
- (void)repeatLoadData;
@end


@interface LiuLanBingLiViewController : SNViewController<UITableViewDataSource,UITableViewDelegate,InfoFileTableViewCellDelegate>
{
    
}
@property(nonatomic,assign)id<LiuLanBingLiViewDelegate>delegate;

@property(nonatomic,strong)UITableView * myTableView;

@property(nonatomic,strong)BingLiListFeed * feed;

@property(nonatomic,strong)BingLiListFeed * myFeed;

@property(nonatomic,strong)NSString * theId;
@property(nonatomic,strong)MPMoviePlayerController *moviePlayer;


@end
