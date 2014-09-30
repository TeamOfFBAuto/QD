//
//  TDDetailCell.h
//  GUKE
//
//  Created by soulnear on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplyListModel.h"

@interface TDDetailCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *header_imageView;

@property (strong, nonatomic) IBOutlet UILabel *userName_label;

@property (strong, nonatomic) IBOutlet UIImageView *background_imageView;

@property (strong, nonatomic) IBOutlet UILabel *date_label;

@property(nonatomic,strong)UILabel * content_label;

@property(nonatomic,strong)UIImageView * content_imageView;



-(void)setInfoWith:(ReplyListModel *)info;



@end
