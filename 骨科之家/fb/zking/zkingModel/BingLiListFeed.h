//
//  BingLiListFeed.h
//  GUKE
//
//  Created by szk on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import <Foundation/Foundation.h>
///文件数据类
@interface AttachListFeed : NSObject
///文件id
@property(nonatomic,strong)NSString * attachId;
///文件名
@property(nonatomic,strong)NSString * filename;
///文件链接地址
@property(nonatomic,strong)NSString * fileurl;

-(id)initWithDic:(NSDictionary *)dic;

@end

///病例标签
@interface TagListFeed : NSObject

///标签id
@property(nonatomic,strong)NSString * tagId;
///标签内容
@property(nonatomic,strong)NSString * tag;
///病历id
@property(nonatomic,strong)NSString * bingliId;
///用户id
@property(nonatomic,strong)NSString * userId;

-(id)initWithDic:(NSDictionary *)dic;

@end



@interface BingLiListFeed : NSObject

@property(nonatomic,strong)NSString * bingliId;

@property(nonatomic,strong)NSString * userId;

@property(nonatomic,strong)NSString * psnname;

@property(nonatomic,strong)NSString * sex;

@property(nonatomic,strong)NSString * zhenduan;

@property(nonatomic,strong)NSString * mobile;

@property(nonatomic,strong)NSString * relateMobile;

@property(nonatomic,strong)NSString * fangan;

@property(nonatomic,strong)NSString * binglihao;

@property(nonatomic,strong)NSString * leibieId;

@property(nonatomic,strong)NSString * idno;

@property(nonatomic,strong)NSString * jiuzhen;

@property(nonatomic,strong)NSString * bianma;

@property(nonatomic,strong)NSString * memo;

@property(nonatomic,strong)NSString * fenleiId;

@property(nonatomic,strong)NSString * createDate;

@property(nonatomic,strong)NSString * leibiename;

@property(nonatomic,strong)NSString * fenleiname;

@property(nonatomic,strong)NSString * firstname;

///文件数据
@property(nonatomic,strong)NSMutableArray * attach_array;
///标签数据
@property(nonatomic,strong)NSMutableArray * tag_array;

-(void)setBingLiListFeedDic:(NSDictionary *)mydic;






@end
