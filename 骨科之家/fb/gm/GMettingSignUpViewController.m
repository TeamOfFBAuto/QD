//
//  GMettingSignUpViewController.m
//  GUKE
//
//  Created by gaomeng on 14-10-4.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "GMettingSignUpViewController.h"

@interface GMettingSignUpViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation GMettingSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSLog(@"%s",__FUNCTION__);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.aTitle = @"会议报名";
    
    
    self.contentLabelArray = [NSMutableArray arrayWithCapacity:4];
    
    for (int i = 0; i<4; i++) {
        UITextField *contentLabel = [[UITextField alloc]initWithFrame:CGRectMake(60, 45, 200, 20)];
        [self.contentLabelArray addObject:contentLabel];
    }
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
   
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CGFloat height = 0;
    
    if (indexPath.row == 0) {
        height = 90;
    }else if (indexPath.row == 1){
        height = 65;
    }else if (indexPath.row == 2){
        height = 65;
    }else if (indexPath.row == 3){
        height = 65;
    }else if (indexPath.row == 4){
        height = 300;
        
    }
    return height;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifeir";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    //自定义view
    UIView *ccView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, 290, 75)];
    //横线
    UIView *hengview = [[UIView alloc]initWithFrame:CGRectMake(0, 65, 290, 1)];
    hengview.backgroundColor = RGB(29, 153, 174);
    //竖线
    UIView *shuView = [[UIView alloc]initWithFrame:CGRectMake(0, 55, 1, 10)];
    shuView.backgroundColor = RGB(29, 153, 174);
    //竖线
    UIView *shuView1 = [[UIView alloc]initWithFrame:CGRectMake(289, 55, 1, 10)];
    shuView1.backgroundColor  = RGB(29, 153, 174);
    //titilelabel
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(11, 45, 60, 20)];
    titleLabel.textColor = RGB(169, 168, 168);
    titleLabel.font  =[ UIFont systemFontOfSize:17];
    
    ccView.userInteractionEnabled = YES;
    
    [ccView addSubview:shuView];
    [ccView addSubview:hengview];
    [ccView addSubview:shuView1];
    [ccView addSubview:titleLabel];
    
    
    
    if (indexPath.row == 0) {
        
        
        [ccView addSubview:self.contentLabelArray[0]];
        [cell.contentView addSubview:ccView];
        ccView.frame = CGRectMake(15, 23, 290, 75);
        titleLabel.text = @"姓名";
        
    }else if (indexPath.row == 1){
        
        
        [ccView addSubview:self.contentLabelArray[1]];
        [cell.contentView addSubview:ccView];
        titleLabel.text = @"手机号";
    }else if (indexPath.row == 2){
        
        [ccView addSubview:self.contentLabelArray[2]];
        [cell.contentView addSubview:ccView];
        titleLabel.text = @"邮箱";
    }else if (indexPath.row == 3){
        
        [ccView addSubview:self.contentLabelArray[3]];
        [cell.contentView addSubview:ccView];
        titleLabel.text= @"QQ";
    }else if (indexPath.row == 4){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:RGB(35, 178, 95)];
        btn.layer.cornerRadius = 4;
        [btn addTarget:self action:@selector(tijiaoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(15, 45, 290, 40)];
        [cell.contentView addSubview:btn];
        
    }
    

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}



//提交按钮点击
-(void)tijiaoBtnClicked{
    
    NSLog(@"%s",__FUNCTION__);
    
    [self netWorking];
    
    
    
}



//请求网络数据
-(void)netWorking{
   
    UILabel *nameLabel = self.contentLabelArray[0];
    NSString *userNameStr = nameLabel.text;
    
    UILabel *phoneLabel = self.contentLabelArray[1];
    NSString *phoneStr = phoneLabel.text;
    
    UILabel *emailLabel = self.contentLabelArray[2];
    NSString *emailStr = emailLabel.text;
    
    UILabel *qqLabel = self.contentLabelArray[3];
    NSString *qqStr = qqLabel.text;
    
    NSString *eventIdStr = self.dataModel.eventId;
    
    
    
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID,@"eventId":eventIdStr,@"username":userNameStr,@"mobile":phoneStr,@"email":emailStr};
    
    [AFRequestService responseData:CALENDAR_EVENTJOIN andparameters:parameters andResponseData:^(id responseData) {
        
        NSDictionary * dict = (NSDictionary *)responseData;
        NSString * code = [dict objectForKey:@"code"];
        if ([code intValue]==0)//说明请求数据成功
        {
            NSLog(@"loadSuccess");
            NSLog(@"%@",dict);
            
        }else{
            
            NSLog(@"erroCode:%@",code);
            NSString *erroCodeStr = nil;
            if ([code intValue]==2) {
                erroCodeStr =  @"活动不存在或者已经超过报名截止时间";
            }else if ([code intValue] == 3){
                erroCodeStr = @"重复报名";
            }
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"报名失败" message:erroCodeStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [al show];
            
        }
    }];
}






@end
