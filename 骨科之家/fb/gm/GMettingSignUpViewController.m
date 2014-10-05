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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.aTitle = @"会议报名";
    
    
    for (int i = 0; i<4; i++) {
        UILabel *contentLable = [[UILabel alloc]initWithFrame:CGRectMake(65, 45, 100, 20)];
        contentLable.backgroundColor = [UIColor redColor];
        [self.contentLabelArray addObject:contentLable];
    }
    
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
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
        
        UITextField *contentLabel = [[UITextField alloc]initWithFrame:CGRectMake(70, 45, 200, 20)];
        contentLabel.backgroundColor = [UIColor redColor];
        [ccView addSubview:contentLabel];
        [self.contentLabelArray addObject:contentLabel];
        [cell.contentView addSubview:ccView];
        ccView.frame = CGRectMake(15, 23, 290, 75);
        titleLabel.text = @"姓名";
        
    }else if (indexPath.row == 1){
        
        UITextField *contentLabel = [[UITextField alloc]initWithFrame:CGRectMake(70, 45, 200, 20)];
        contentLabel.backgroundColor = [UIColor redColor];
        [ccView addSubview:contentLabel];
        [cell.contentView addSubview:ccView];
        titleLabel.text = @"手机号";
    }else if (indexPath.row == 2){
        UITextField *contentLabel = [[UITextField alloc]initWithFrame:CGRectMake(70, 45, 200, 20)];
        contentLabel.backgroundColor = [UIColor redColor];
        [ccView addSubview:contentLabel];
        [cell.contentView addSubview:ccView];
        titleLabel.text = @"邮箱";
    }else if (indexPath.row == 3){
        UITextField *contentLabel = [[UITextField alloc]initWithFrame:CGRectMake(70, 45, 200, 20)];
        contentLabel.backgroundColor = [UIColor redColor];
        [ccView addSubview:contentLabel];
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
}


@end
