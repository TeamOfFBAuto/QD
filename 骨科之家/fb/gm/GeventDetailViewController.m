//
//  GeventDetailViewController.m
//  GUKE
//
//  Created by gaomeng on 14-10-4.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "GeventDetailViewController.h"

@interface GeventDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation GeventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadNavigation];
    
    NSLog(@"%@",[NSString _859ToUTF8:self.dataModel.eventTitle]);
    
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if (indexPath.row == 3) {
        height = 300;
    }else{
        height = 50;
    }
    return height;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if (indexPath.row == 3) {
        
        NSArray *titleArray = @[@"报名",@"取消报名",@"支付费用"];
        
        for (int i = 0; i<3; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            btn.tag = 10+i;
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            btn.layer.cornerRadius = 4;
            
            if (i ==0) {
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setBackgroundColor:RGB(35, 178, 95)];
                
            }else if (i == 1){
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [btn setBackgroundColor:RGB(237, 238, 237)];
            }else if (i == 2){
                [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
                btn.layer.borderWidth = 2;
                btn.layer.borderColor = [[UIColor greenColor]CGColor];
                [btn setBackgroundColor:[UIColor whiteColor]];
            }
            
            
            [btn setFrame:CGRectMake(10, 10+i*(50+10), 300, 50)];
            
            [cell.contentView addSubview:btn];
        }
        
        
    }
    
    
    
    return cell;
    
}


-(void)btnClicked:(UIButton *)sender{
    if (sender.tag == 10) {//报名
        
        NSLog(@"我要报名");
        
    }else if (sender.tag == 11){//取消报名
        NSLog(@"取消报名");
    }else if (sender.tag == 12){//支付费用
        NSLog(@"支付费用");
    }
}







// 导航的设置
- (void)loadNavigation
{
    UIView *bgNavi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 190, 44)];
    bgNavi.backgroundColor = [UIColor clearColor];
    bgNavi.userInteractionEnabled = YES;
    
    UIImageView *logoView = [[UIImageView alloc]initWithImage:[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guke_top_logo_arrow@2x" ofType:@"png"]]];
    
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(0, 4, 36, 36);
    
    logoView.contentMode = UIViewContentModeScaleAspectFit;
    logoView.userInteractionEnabled = YES;
    
    UILabel *loginLabel = [[UILabel alloc]initWithFrame:CGRectMake(44, 7, 160, 30)];
    loginLabel.text = @"会议日程";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.backgroundColor = [UIColor clearColor];
    loginLabel.font = [UIFont systemFontOfSize:16];
    [bgNavi addSubview:logoView];
    [bgNavi addSubview:loginLabel];
    loginLabel = nil;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gPoPu)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [logoView addGestureRecognizer:tap];
    tap = nil;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:bgNavi];
    self.navigationItem.leftBarButtonItem = leftItem;
}


-(void)gPoPu{
    [self.navigationController popViewControllerAnimated:YES];
}






@end
