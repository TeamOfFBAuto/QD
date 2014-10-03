//
//  TagManagerViewController.m
//  GUKE
//
//  Created by soulnear on 14-10-3.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "TagManagerViewController.h"

@interface TagManagerViewController ()

@end

@implementation TagManagerViewController
@synthesize myTableView = _myTableView;
@synthesize myFeed = _myFeed;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    if (IOS7_LATER) {
        _myTableView.separatorInset = UIEdgeInsetsZero;
    }
    [self.view addSubview:_myTableView];
    
    UIView * vvv = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,0)];
    _myTableView.tableFooterView = vvv;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _myFeed.tag_array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    TagListFeed * feed = [_myFeed.tag_array objectAtIndex:indexPath.row];

    cell.textLabel.text = feed.tag;
    
    UIButton * delete_button = [UIButton buttonWithType:UIButtonTypeCustom];
    delete_button.frame = CGRectMake(DEVICE_WIDTH - 70,5,60,34);
    delete_button.tag = 100 + indexPath.row;
    [delete_button setTitle:@"删除" forState:UIControlStateNormal];
    [delete_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    delete_button.layer.borderColor = [UIColor blueColor].CGColor;
    delete_button.layer.cornerRadius = 5;
    delete_button.layer.borderWidth = 0.5;
    [delete_button addTarget:self action:@selector(deleteButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:delete_button];
    
    return cell;
}



-(void)deleteButtonTap:(UIButton *)button
{
    TagListFeed * feed = [_myFeed.tag_array objectAtIndex:button.tag-100];
    
    __weak typeof(self)bself = self;
    
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID,@"tagId":feed.tagId};
    
    MBProgressHUD * hud = [SNTools returnMBProgressWithText:@"正在删除..." addToView:self.view];
    hud.mode = MBProgressHUDModeDeterminate;
    [AFRequestService responseData:BINGLI_TAG_DELETE_URL andparameters:parameters andResponseData:^(id responseData) {
        
        NSDictionary * dict = (NSDictionary *)responseData;
        NSString * code = [dict objectForKey:@"code"];
        if ([code intValue]==0)//说明请求数据成功
        {
            hud.labelText = @"删除成功";
            [hud hide:YES afterDelay:1.5];
            [bself.myFeed.tag_array removeObjectAtIndex:button.tag-100];
            [bself.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:button.tag-100 inSection:0], nil] withRowAnimation:UITableViewRowAnimationLeft];
            [bself.myTableView reloadData];
        }
    }];
    
    
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
