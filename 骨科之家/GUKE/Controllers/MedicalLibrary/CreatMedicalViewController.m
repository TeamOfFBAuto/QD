//
//  CreatMedicalViewController.m
//  GUKE
//  新建病历页面
//  Created by ianMac on 14-9-24.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "CreatMedicalViewController.h"

@interface CreatMedicalViewController ()
// 自定义导航栏
- (void)loadNavigation;
@end

@implementation CreatMedicalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadNavigation];
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
    loginLabel.text = @"病历库";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.backgroundColor = [UIColor clearColor];
    loginLabel.font = [UIFont systemFontOfSize:16];
    [bgNavi addSubview:logoView];
    [bgNavi addSubview:loginLabel];
    loginLabel = nil;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [logoView addGestureRecognizer:tap];
    tap = nil;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:bgNavi];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    rightView.backgroundColor = [UIColor clearColor];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame = CGRectMake(0, (44-28)/2+1, 44, 28);
    rightBtn.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
    rightBtn.layer.cornerRadius = 4;
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightBtn];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    //主tableview
    
    _mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    _mainTableView.delegate=self;
    _mainTableView.dataSource=self;
    [self.view addSubview:_mainTableView];
    
    
    
}

// 手势事件
- (void)tapAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

// "提交"的点击事件
- (void)btnClick
{
    NSLog(@"点击提交按钮");
}



#pragma mark-tableviewdelegateAndDatesource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 10;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier=@"cell";
    
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    return cell;

}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
