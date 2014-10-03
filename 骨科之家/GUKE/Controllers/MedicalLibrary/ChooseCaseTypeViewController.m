//
//  ChooseCaseTypeViewController.m
//  GUKE
//
//  Created by soulnear on 14-10-3.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "ChooseCaseTypeViewController.h"

@interface ChooseCaseTypeViewController ()
{
    NSMutableArray * data_array;
}

@end

@implementation ChooseCaseTypeViewController
@synthesize myTableView = _myTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aTitle = @"选择病历分类";
    data_array = [NSMutableArray array];
    
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    if (IOS7_LATER) {
        _myTableView.separatorInset = UIEdgeInsetsZero;
    }
    [self.view addSubview:_myTableView];
    
    [self loadBingLiListData];
    
}

#pragma mark - 请求数据
-(void)loadBingLiListData
{
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID};
    
    [AFRequestService responseData:BINGLI_TYPE_LIST_URL andparameters:parameters andResponseData:^(id responseData) {
        
        NSDictionary * dict = (NSDictionary *)responseData;
        NSString * code = [dict objectForKey:@"code"];
        if ([code intValue]==0)//说明请求数据成功
        {
            NSArray * array = [dict objectForKey:@"fenleilist"];
            if ([array isKindOfClass:[NSArray class]])
            {
                for (NSDictionary * dic in array) {
                    [data_array addObject:dic];
                }
                [_myTableView reloadData];
            }
        }else
        {
            [SNTools showMBProgressWithText:@"加载数据失败" addToView:self.view];
        }
    }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data_array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString _859ToUTF8:[[data_array objectAtIndex:indexPath.row] objectForKey:@"fenleiName"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadData" object:[[data_array objectAtIndex:indexPath.row] objectForKey:@"fenleiId"]];
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
