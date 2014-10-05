//
//  GMettingSignUpViewController.m
//  GUKE
//
//  Created by gaomeng on 14-10-4.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "GMettingSignUpViewController.h"


@interface GMettingSignUpViewController ()
{
    MBProgressHUD *_hud;

}
@end

@implementation GMettingSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSLog(@"%s",__FUNCTION__);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.aTitle = @"会议报名";
    
    
    self.contentLabelArray = [NSMutableArray arrayWithCapacity:6];
    
    for (int i = 0; i<6; i++) {
        UITextField *contentLabel = [[UITextField alloc]initWithFrame:CGRectMake(10, 30, 200, 20)];
        contentLabel.font = [UIFont systemFontOfSize:15];
        switch (i) {
            case 0:
                contentLabel.placeholder = @"请输入姓名";
                break;
            case 1:
                contentLabel.placeholder = @"请输入电话";
                break;
            case 2:
                contentLabel.placeholder = @"请输入邮箱";
                break;
            case 3:
                contentLabel.placeholder = @"请输入单位";
                break;
            case 4:
                contentLabel.placeholder = @"请输入专业";
                break;
            case 5:
                contentLabel.placeholder = @"请输入职称";
                break;
            default:
                break;
        }
        [self.contentLabelArray addObject:contentLabel];
    }
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
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
    
    return 7;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CGFloat height = 0;
    

    height = 50;
    if (indexPath.row == 6) {
        height = 100;
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
    UIView *ccView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, 290, 50)];
    //横线
    UIView *hengview = [[UIView alloc]initWithFrame:CGRectMake(0, 49, 290, 1)];
    hengview.backgroundColor = RGB(29, 153, 174);
    //竖线
    UIView *shuView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 1, 10)];
    shuView.backgroundColor = RGB(29, 153, 174);
    //竖线
    UIView *shuView1 = [[UIView alloc]initWithFrame:CGRectMake(289, 40, 1, 10)];
    shuView1.backgroundColor  = RGB(29, 153, 174);
    
    ccView.userInteractionEnabled = YES;
    
    [ccView addSubview:shuView];
    [ccView addSubview:hengview];
    [ccView addSubview:shuView1];
    
    
    
    if (indexPath.row == 0) {
        
        [ccView addSubview:self.contentLabelArray[0]];
        [cell.contentView addSubview:ccView];
        
    }else if (indexPath.row == 1){
        [ccView addSubview:self.contentLabelArray[1]];
        [cell.contentView addSubview:ccView];
    }else if (indexPath.row == 2){
        
        [ccView addSubview:self.contentLabelArray[2]];
        [cell.contentView addSubview:ccView];
    }else if (indexPath.row == 3){
        
        [ccView addSubview:self.contentLabelArray[3]];
        [cell.contentView addSubview:ccView];
    }else if (indexPath.row == 4){
        [ccView addSubview:self.contentLabelArray[4]];
        [cell.contentView addSubview:ccView];
        
    }else if (indexPath.row == 5){
        [ccView addSubview:self.contentLabelArray[5]];
        [cell.contentView addSubview:ccView];
    }else if (indexPath.row == 6){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:RGB(35, 178, 95)];
        btn.layer.cornerRadius = 4;
        [btn addTarget:self action:@selector(tijiaoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        if (iPhone5) {
            [btn setFrame:CGRectMake(15, 50, 290, 40)];
        }else{
            [btn setFrame:CGRectMake(15, 50, 290, 40)];
        }
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



#pragma mark - 报名的网络请求方法

//请求网络数据
-(void)netWorking{
   
    //姓名
    UILabel *nameLabel = self.contentLabelArray[0];
    NSString *userNameStr = nameLabel.text;
    
    //电话
    UILabel *phoneLabel = self.contentLabelArray[1];
    NSString *phoneStr = phoneLabel.text;
    
    //邮箱
    UILabel *emailLabel = self.contentLabelArray[2];
    NSString *emailStr = emailLabel.text;
    
    //单位
    UILabel *companyLabel = self.contentLabelArray[3];
    NSString *companyStr = companyLabel.text;
    
    //专业
    UILabel *deptLabel = self.contentLabelArray[4];
    NSString *deptStr = deptLabel.text;
    
    //职称
    UILabel *positionLabel = self.contentLabelArray[5];
    NSString *positionStr = positionLabel.text;
    
    
    //活动id
    NSString *eventIdStr = self.dataModel.eventId;
    
    
    
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID,@"eventId":eventIdStr,@"username":userNameStr,@"mobile":phoneStr,@"email":emailStr,@"company":companyStr,@"dept":deptStr,@"position":positionStr};
    
    [AFRequestService responseData:CALENDAR_EVENTJOIN andparameters:parameters andResponseData:^(id responseData) {
        
        NSDictionary * dict = (NSDictionary *)responseData;
        NSString * code = [dict objectForKey:@"code"];
        if ([code intValue]==0)//说明请求数据成功
        {
            
//            [self hudWasHidden:_hud];
            
            NSLog(@"loadSuccess");
            NSLog(@"%@",dict);
            
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"报名成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            al.tag = 100;
            [al show];
            
        }else{
            
//            [self hudWasHidden:_hud];
            
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



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}




@end
