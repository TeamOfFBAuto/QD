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
    
    [self.head_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASE_URL,info.smallPic]] placeholderImage:[UIImage imageNamed:@"defaults_iamge@2x.png"]];
    self.title_label.text = info.title;
    self.content_label.text = info.content;
    self.date_label.text = [SingleInstance handleDate:info.createDate];
}




@end
