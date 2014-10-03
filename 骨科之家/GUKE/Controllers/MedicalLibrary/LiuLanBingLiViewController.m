//
//  LiuLanBingLiViewController.m
//  GUKE
//
//  Created by soulnear on 14-10-3.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "LiuLanBingLiViewController.h"
#import "LiuLanSectionView.h"

@interface LiuLanBingLiViewController ()

@end

@implementation LiuLanBingLiViewController
@synthesize myTableView = _myTableView;
@synthesize feed = _feed;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT) style:UITableViewStylePlain];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    if (IOS7_LATER) {
        _myTableView.separatorInset = UIEdgeInsetsZero;
    }
    [self.view addSubview:_myTableView];
    
}

-(void)loadBingliDetailData
{
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID,@"bingliId":_feed.bingliId};
    
    __weak typeof(self)wself=self;
    
    [AFRequestService responseData:BINGLI_DETAIL_URL andparameters:parameters andResponseData:^(id responseData) {
        
        NSDictionary * dict = (NSDictionary *)responseData;
        NSLog(@"dict ------  %@",dict);
        NSString * code=[NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]];
        
        if ([code intValue]==0)//说明请求数据成功
        {
            wself.feed = [dict objectForKey:@"bingli"];
            [wself.myTableView reloadData];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }else if (indexPath.row == 1)
    {
        return 50;
    }else if (indexPath.row == 2)
    {
        CGSize bl_height = [SNTools returnStringHeightWith:[NSString stringWithFormat:@"病历号：%@",self.feed.binglihao] WithWidth:240 WithFont:14];
        
        CGSize zd_height = [SNTools returnStringHeightWith:[NSString stringWithFormat:@"诊断：%@",self.feed.zhenduan] WithWidth:240 WithFont:14];
        
        return bl_height.height+zd_height.height+30;
    }else if (indexPath.row == 3)
    {
        CGSize size = [SNTools returnStringHeightWith:self.feed.fangan WithWidth:240 WithFont:14];
        return size.height+20;
    }else if (indexPath.row == 4)
    {
        CGSize size = [SNTools returnStringHeightWith:self.feed.memo WithWidth:240 WithFont:14];
        return size.height + 20;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.row == 0) {
        LiuLanSectionView * aView = [[[NSBundle mainBundle] loadNibNamed:@"LiuLanSectionView" owner:self options:nil] objectAtIndex:0];
        [aView setContentWithFenLei:_feed.fenleiname Date:_feed.jiuzhen UserName:_feed.psnname Sex:_feed.sex];
        [cell.contentView addSubview:aView];
    }else if (indexPath.row == 1)
    {
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        
        NSString * tag_string = [_feed.tag_array componentsJoinedByString:@"/"];
        UILabel * tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10,DEVICE_WIDTH-20,50)];
        tagLabel.text = [NSString stringWithFormat:@"标签：%@",tag_string];
        tagLabel.textAlignment = NSTextAlignmentLeft;
        tagLabel.textColor = [UIColor blackColor];
        tagLabel.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:tagLabel];
        
    }else if (indexPath.row == 2)
    {
        CGSize bl_height = [SNTools returnStringHeightWith:self.feed.binglihao WithWidth:240 WithFont:14];
        CGSize zd_height = [SNTools returnStringHeightWith:self.feed.zhenduan WithWidth:240 WithFont:14];
        
        UILabel * binglihao = [[UILabel alloc] initWithFrame:CGRectMake(10,10,DEVICE_WIDTH-20,bl_height.height)];
        binglihao.text = [NSString stringWithFormat:@"病历号：%@",_feed.binglihao];
        binglihao.textAlignment = NSTextAlignmentLeft;
        binglihao.textColor = [UIColor blackColor];
        binglihao.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:binglihao];
        
        UILabel * zhenduan = [[UILabel alloc] initWithFrame:CGRectMake(10,20+bl_height.height,DEVICE_WIDTH-20,zd_height.height)];
        zhenduan.text = [NSString stringWithFormat:@"诊断：%@",_feed.zhenduan];
        zhenduan.textAlignment = NSTextAlignmentLeft;
        zhenduan.textColor = [UIColor blackColor];
        zhenduan.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:zhenduan];
        
    }else if (indexPath.row == 3)
    {
        CGSize size = [SNTools returnStringHeightWith:self.feed.fangan WithWidth:240 WithFont:14];
        
        UILabel * zhiliaofangan = [[UILabel alloc] initWithFrame:CGRectMake(10,10,DEVICE_WIDTH-20,size.height)];
        zhiliaofangan.text = [NSString stringWithFormat:@"治疗方案：%@",_feed.fangan];
        zhiliaofangan.textAlignment = NSTextAlignmentLeft;
        zhiliaofangan.textColor = [UIColor blackColor];
        zhiliaofangan.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:zhiliaofangan];
        
    }else if (indexPath.row == 4)
    {
        CGSize size = [SNTools returnStringHeightWith:self.feed.memo WithWidth:240 WithFont:14];
        
        UILabel * binglishuoming = [[UILabel alloc] initWithFrame:CGRectMake(10,10,DEVICE_WIDTH-20,size.height)];
        binglishuoming.text = [NSString stringWithFormat:@"病例说明：%@",_feed.fangan];
        binglishuoming.textAlignment = NSTextAlignmentLeft;
        binglishuoming.textColor = [UIColor blackColor];
        binglishuoming.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:binglishuoming];
    }
    
    
    return cell;
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
