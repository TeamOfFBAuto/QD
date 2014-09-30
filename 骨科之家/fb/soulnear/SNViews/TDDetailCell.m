//
//  TDDetailCell.m
//  GUKE
//
//  Created by soulnear on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "TDDetailCell.h"

@implementation TDDetailCell
@synthesize content_label = _content_label;
@synthesize content_imageView = _content_imageView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setInfoWith:(ReplyListModel *)info
{
    if (info.theType == SEND_Type_content)
    {
        
    }else if (info.theType == SEND_Type_photo)
    {
        
    }else if (info.theType == SEND_Type_voice)
    {
        
    }else if (info.theType == SEND_Type_other)
    {
        
    }
    
//    _header_imageView sd_setImageWithURL:[SNTools returnUrl:info.] placeholderImage:<#(UIImage *)#>
    _header_imageView.image = [UIImage imageNamed:@"user_default_ico"];
    _userName_label.text = info.firstname;
    
    
}




@end



















