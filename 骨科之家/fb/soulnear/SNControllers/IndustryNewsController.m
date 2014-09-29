//
//  IndustryNewsController.m
//  GUKE
//
//  Created by soulnear on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "IndustryNewsController.h"

@implementation IndustryNewsController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self getIndustryNewsData];
}

#pragma mark - 请求数据方法
-(void)getIndustryNewsData
{
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID};
    
    [AFRequestService responseData:INDUSTRY_NEWS_URL andparameters:parameters andResponseData:^(id responseData) {
        NSDictionary * dict = (NSDictionary *)responseData;
        
        NSLog(@"dic ----   %@",dict);
        
    }];
    
    
}






@end
