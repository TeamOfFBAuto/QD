//
//  AddTagViewController.m
//  GUKE
//
//  Created by soulnear on 14-10-3.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "AddTagViewController.h"

@interface AddTagViewController ()
{
    NSMutableArray * data_array;
    
    int total_num;
}

@end

@implementation AddTagViewController
@synthesize myTableView = _myTableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    total_num = 3;
    
    self.aTitle = @"添加标签";
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    if (IOS7_LATER) {
        _myTableView.separatorInset = UIEdgeInsetsZero;
    }
    [self.view addSubview:_myTableView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return total_num;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    for (UIView * view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
