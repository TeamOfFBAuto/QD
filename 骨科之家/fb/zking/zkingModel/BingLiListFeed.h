//
//  BingLiListFeed.h
//  GUKE
//
//  Created by szk on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@property(nonatomic,strong)NSString * bianma;

@property(nonatomic,strong)NSString * memo;

@property(nonatomic,strong)NSString * fenleiId;

@property(nonatomic,strong)NSString * createDate;

@property(nonatomic,strong)NSString * leibiename;

@property(nonatomic,strong)NSString * fenleiname;

@property(nonatomic,strong)NSString * firstname;


-(void)setBingLiListFeedDic:(NSDictionary *)mydic;






@end
