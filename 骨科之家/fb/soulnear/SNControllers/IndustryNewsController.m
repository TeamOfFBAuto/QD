//
//  IndustryNewsController.m
//  GUKE
//
//  Created by soulnear on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "IndustryNewsController.h"
#import "IndustryNewsModel.h"
#import "IndustryNewsCell.h"

@interface IndustryNewsController ()
{
    ///数据存放
    NSMutableArray * data_array;
}
@end

@implementation IndustryNewsController
@synthesize myTableView = _myTableView;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    data_array = [NSMutableArray array];
    
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:_myTableView];
    
    [self getIndustryNewsData];
}

#pragma mark - 请求数据方法
-(void)getIndustryNewsData
{
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID,@"pageSize":@"20",@"page":@"1"};
    
    [AFRequestService responseData:INDUSTRY_NEWS_URL andparameters:parameters andResponseData:^(id responseData) {
        
        NSDictionary * dict = (NSDictionary *)responseData;
        NSLog(@"dic -----  %@",dict);
        NSString * code = [dict objectForKey:@"code"];
        if ([code intValue]==0)//说明请求数据成功
        {
            NSArray * array = [dict objectForKey:@"dongtailist"];
            
            for (NSDictionary * dic in array) {
                IndustryNewsModel * model = [[IndustryNewsModel alloc] initWithDic:dic];
                [data_array addObject:model];
            }
            
            [_myTableView reloadData];
        }
    }];
    
}


#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data_array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    
    IndustryNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"IndustryNewsCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    IndustryNewsModel * model = [data_array objectAtIndex:indexPath.row];
    
    [cell setInfoWith:model];
    
    return cell;
}


@end

















