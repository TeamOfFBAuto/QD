//
//  IndustryNewsCell.m
//  GUKE
//
//  Created by soulnear on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "IndustryNewsCell.h"

@implementation IndustryNewsCell





-(void)setInfoWith:(IndustryNewsModel *)info
{
    [self.head_imageView sd_setImageWithURL:[NSURL URLWithString:info.smallPic] placeholderImage:[UIImage imageNamed:@"user_default_ico"]];
    self.title_label.text = info.title;
    self.content_label.text = info.content;
    self.date_label.text = [SNTools dateFromString:info.createDate];
}




@end
