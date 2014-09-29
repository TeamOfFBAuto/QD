//
//  GcalendarViewController.m
//  GUKE
//
//  Created by gaomeng on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "GcalendarViewController.h"

#import "ITTBaseDataSourceImp.h"

#import "GcalendarDetailViewController.h"

@interface GcalendarViewController ()
{
    ITTCalendarView *_calendarView;
}
@end
//// 获取当前用户的userId和sId
//#define GET_USER_ID [[NSUserDefaults standardUserDefaults] objectForKey:U_ID]
//#define GET_S_ID [[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN_K]
//#define GET_U_NAME [[NSUserDefaults standardUserDefaults] objectForKey:U_NAME]
//#define GET_GROUP_ID [[NSUserDefaults standardUserDefaults] objectForKey:U_NAME]
//#define IS_AUTOLOG [[[NSUserDefaults standardUserDefaults] objectForKey:@"autoLogin"] boolValue]
//#define TABLE_HEIGHT [[[NSUserDefaults standardUserDefaults] objectForKey:@"tableHeight"] floatValue]
@implementation GcalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
//    if (_calendarView.appear)
//    {
//        [_calendarView hide];
//    }
//    else
//    {
//        [_calendarView showInView:self.view];
//    }
    
    
    _calendarView = [ITTCalendarView viewFromNib];
    ITTBaseDataSourceImp *dataSource = [[ITTBaseDataSourceImp alloc] init];
    _calendarView.date = [NSDate dateWithTimeIntervalSinceNow:2*24*60*60];
    _calendarView.dataSource = dataSource;
    _calendarView.delegate = self;
    _calendarView.frame = CGRectMake(8, 64, 309, 0);
    _calendarView.allowsMultipleSelection = TRUE;
    [_calendarView showInView:self.view];
    
//    [self network];
    
    
}


-(void)network{
    
    
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID,@"pageSize":@"20",@"page":@"1"};
    NSString *datestr = [NSString stringWithFormat:@"%@",[NSDate date]];
    
    NSLog(@"%@",datestr);
    
    [AFRequestService responseData:CALENDAR_ACTIVITIES andparameters:parameters andResponseData:^(id responseData) {
        
        NSDictionary * dict = (NSDictionary *)responseData;
        NSString * code = [dict objectForKey:@"code"];
        if ([code intValue]==0)//说明请求数据成功
        {
            NSLog(@"loadSuccess");
            NSLog(@"%@",dict);
            
        }else{
            NSLog(@"%d",[code intValue]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
- (void)calendarViewDidSelectDay:(ITTCalendarView*)calendarView calDay:(ITTCalDay*)calDay{
    
    NSLog(@"%@",calDay);
    
//    [self.navigationController pushViewController:[[GcalendarDetailViewController alloc]init] animated:YES];
}
- (void)calendarViewDidSelectPeriodType:(ITTCalendarView*)calendarView periodType:(PeriodType)periodType{
    NSLog(@"%s",__FUNCTION__);
}

@end
