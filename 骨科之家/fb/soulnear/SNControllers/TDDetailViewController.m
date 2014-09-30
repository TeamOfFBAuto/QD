//
//  TDDetailViewController.m
//  GUKE
//
//  Created by soulnear on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "TDDetailViewController.h"
#import "ReplyListModel.h"
#import "Toolbar.h"

@interface TDDetailViewController ()<ToolbarDelegate>
{
    NSMutableArray * data_array;
    int currentPage;
    Toolbar * toolBar;
}

@end

@implementation TDDetailViewController
@synthesize info = _info;
@synthesize myTableVIEW = _myTableVIEW;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    data_array = [NSMutableArray array];
    currentPage = 1;
    
    _myTableVIEW = [[UITableView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT) style:UITableViewStylePlain];
    _myTableVIEW.delegate = self;
    _myTableVIEW.dataSource = self;
    _myTableVIEW.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:_myTableVIEW];
    
    _myTableVIEW.tableHeaderView = [self loadSectionView];
    
    [self getCommentData];
    
    
    toolBar = [[Toolbar alloc] initWithFrame:CGRectMake(0,DEVICE_HEIGHT, 0, 0)];
    toolBar.delegate = self;
    [toolBar showInView:self.view withValidHeight:DEVICE_HEIGHT];
}

#pragma mark - 获取评论数据
-(void)getCommentData
{
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID,@"pageSize":@"20",@"page":[NSString stringWithFormat:@"%d",currentPage]};
    
    [AFRequestService responseData:TOPIC_DISCUSS_COMMENT_URL andparameters:parameters andResponseData:^(id responseData) {
        
        NSDictionary * dict = (NSDictionary *)responseData;
        NSLog(@"dict -------  %@",dict);
        NSString * code = [dict objectForKey:@"code"];
        if ([code intValue]==0)//说明请求数据成功
        {
            if (data_array.count == [[dict objectForKey:@"recordCount"] intValue])
            {
                [SNTools showMBProgressWithText:@"没有更多数据了" addToView:self.view];
                return ;
            }
            
            NSArray * array = [dict objectForKey:@"replylist"];
            if ([array isKindOfClass:[NSArray class]])
            {
                for (NSDictionary * dic in array)
                {
                    ReplyListModel * model = [[ReplyListModel alloc] initWithDic:dic];
                    [data_array addObject:model];
                }
            }
            [_myTableVIEW reloadData];
        }
    }];
}


#pragma mark - 加载headerView
-(UIView *)loadSectionView
{
    float height = 0.0f;
    
    UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,0)];
    aView.backgroundColor = [UIColor whiteColor];
    
    CGRect rectr = [self.info.title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} context:nil];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,20,DEVICE_WIDTH-30,rectr.size.height)];
    titleLabel.numberOfLines = 0;
    titleLabel.text = _info.title;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [aView addSubview:titleLabel];
    
    height += 20 + rectr.size.height;
    
    if (![_info.bigPic isKindOfClass:[NSNull class]])
    {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15,height + 30,250,150)];
        [imageView sd_setImageWithURL:[SNTools returnUrl:_info.bigPic] placeholderImage:[UIImage imageNamed:@"guke_image_loading"]];
        
        [aView addSubview:imageView];
        
        height += 30 + 150;
    }
    
    CGRect rectr1 = [self.info.content boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
    
    UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,height+20,DEVICE_WIDTH-30,rectr1.size.height)];
    contentLabel.numberOfLines = 0;
    contentLabel.text = _info.content;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.font = [UIFont systemFontOfSize:14];
    [aView addSubview:contentLabel];
    
    height += 30 + rectr1.size.height + 20;
    
    aView.frame = CGRectMake(0,0,DEVICE_WIDTH-30,height);
    
    
    return aView;
}


#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data_array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    
    
    
    
    
    
    return cell;
}

#pragma mark - ToolBarDelegate
- (BOOL)placeTextViewShouldReturn:(HPGrowingTextView *)textView
{
    
    
    return YES;
}
- (void)toolBarPicture
{
    
}

- (void)toolView:(Toolbar *)textView index:(NSInteger)index
{
    
}

// 触发录音事件
- (void)recordStartQiDi
{
    
}

// 结束录音事件
- (void)recordEndQiDi
{
    
}

//should change frame
- (void)toolViewDidChangeFrame:(Toolbar *)textView
{
    
}
- (void)changeFrame
{
    
}


- (void)didReceiveMemoryWarning
{
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
