//
//  TDListModel.m
//  GUKE
//
//  Created by soulnear on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "TDListModel.h"

@implementation TDListModel
@synthesize zhutiId = _zhutiId;
@synthesize typeId = _typeId;
@synthesize title = _title;
@synthesize psnname = _psnname;
@synthesize content = _content;
@synthesize smallPic = _smallPic;
@synthesize bigPic = _bigPic;
@synthesize createDate = _createDate;



-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        _zhutiId = [dic objectForKey:@"zhutiId"];
        _typeId = [dic objectForKey:@"typeId"];
        _title = [dic objectForKey:@"title"];
        _psnname = [dic objectForKey:@"psnname"];
        _content = [dic objectForKey:@"content"];
        _smallPic = [dic objectForKey:@"smallPic"];
        _bigPic = [dic objectForKey:@"bigPic"];
        _createDate = [dic objectForKey:@"createDate"];
    }
    
    return self;
}



@end
