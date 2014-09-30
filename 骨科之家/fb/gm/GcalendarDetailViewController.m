//
//  GcalendarDetailViewController.m
//  GUKE
//
//  Created by gaomeng on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "GcalendarDetailViewController.h"

@interface GcalendarDetailViewController ()
{
    int _page;//第几页
    int _pageCapacity;//一页请求几条数据
    NSArray *_dataArray;//数据源
}
@end

@implementation GcalendarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 300, 100)];
    label.text = [NSString stringWithFormat:@"%@",self.calDay];
    [self.view addSubview:label];
    
//    _tableView = [[RefreshTableView alloc]initWithFrame:CGRectMake(0, 64, 320, 568-64)];
//    _tableView.refreshDelegate = self;//用refreshDelegate替换UITableViewDelegate
//    _tableView.dataSource = self;
//    [self.view addSubview:_tableView];
//    
//    _page = 1;
//    _pageCapacity = 20;
//    
//    [_tableView showRefreshHeader:YES];//进入界面先刷新数据
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - 下拉刷新上提加载更多
/**
 *  刷新数据列表
 *
 *  @param dataArr  新请求的数据
 *  @param isReload 判断在刷新或者加载更多
 */
- (void)reloadData:(NSArray *)dataArr isReload:(BOOL)isReload
{
    if (isReload) {
        
        _dataArray = dataArr;
        
    }else
    {
        NSMutableArray *newArr = [NSMutableArray arrayWithArray:_dataArray];
        [newArr addObjectsFromArray:dataArr];
        _dataArray = newArr;
    }
    
    [_tableView performSelector:@selector(finishReloadigData) withObject:nil afterDelay:1.0];
}



//请求网络数据
-(void)prepareNetData{
    
    NSString *dateStr = [NSString stringWithFormat:@"%@",self.calDay];
    NSString *pageCapacityStr = [NSString stringWithFormat:@"%d",_pageCapacity];
    NSString *pageStr = [NSString stringWithFormat:@"%d",_page];
    
    NSString *dateStr_ = @"2014-09-25";
    
    NSLog(@"%@",dateStr);
    
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID,@"date":dateStr_,@"pageSize":pageCapacityStr,@"page":pageStr};
    
    
    [AFRequestService responseData:CALENDAR_ACTIVITIESTABLEVIEW andparameters:parameters andResponseData:^(id responseData) {
        
        NSDictionary * dict = (NSDictionary *)responseData;
        NSString * code = [dict objectForKey:@"code"];
        if ([code intValue]==0)//说明请求数据成功
        {
            NSLog(@"loadSuccess");
            NSLog(@"%@",dict);
            
            NSArray *dataArray = [dict objectForKey:@"eventlist"];
            
            if (dataArray.count < _pageCapacity) {
                
                _tableView.isHaveMoreData = NO;
                
            }else
            {
                _tableView.isHaveMoreData = YES;
            }
            
            [_tableView reloadData];
            
            
        }else{
            NSLog(@"%d",[code intValue]);
            if (_tableView.isReloadData) {
                
                _page --;
                
                [_tableView performSelector:@selector(finishReloadigData) withObject:nil afterDelay:1.0];
            }
        }
    }];
    
    
    
    
    
}


#pragma - mark RefreshDelegate <NSObject>

- (void)loadNewData
{
    _page = 1;
    
    [self prepareNetData];
}

- (void)loadMoreData
{
    NSLog(@"loadMoreData");
    
    _page ++;
    
    [self prepareNetData];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__FUNCTION__);
}

- (CGFloat)heightForRowIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}




#pragma mark -  UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}







@end
