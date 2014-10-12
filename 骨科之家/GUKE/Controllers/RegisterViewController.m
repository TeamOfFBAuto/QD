//
//  RegisterViewController.m
//  UnisLiCai
//
//  Created by tusinfo on 14-9-25.
//  Copyright (c) 2014年 tusinfo. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "Interface.h"
@interface RegisterViewController ()
{
    UIScrollView *_scrollView;
    //UIView *_bgView;
    UIButton *nextBtn;
    UITextField *username;
    UITextField *firstname;
    UITextField *mobile;
    UITextField *password;
    UITextField *email;
    NSArray *fieldArr;//存放输入框
    NSUInteger sexFlag;
    NSUInteger keyBoardHeight;
}
@end
#define RIGHTITEM_BTN_TAG 202
@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigetion];
    [self creatUI];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)backToIndex{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 导航布局
- (void)navigetion
{
    // 导航的设置
        UIView *bgNavi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 190, 44)];
        bgNavi.backgroundColor = [UIColor clearColor];
        bgNavi.userInteractionEnabled = YES;
        
        UIImageView *logoView = [[UIImageView alloc]initWithImage:[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guke_top_logo_arrow@2x" ofType:@"png"]]];
        
        logoView.backgroundColor = [UIColor clearColor];
        logoView.frame = CGRectMake(0, 4, 36, 36);
        
        logoView.contentMode = UIViewContentModeScaleAspectFit;
        logoView.userInteractionEnabled = YES;
        
        UILabel *loginLabel = [[UILabel alloc]initWithFrame:CGRectMake(44, 7, 160, 30)];
        loginLabel.text = @"注册";
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
    
    
}
- (void)tapAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
// UIButtonClick Action
- (void)btnClick:(UIButton *)sender
{
   
}

// 设置UI布局
- (void)creatUI{
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    // 用户名
    UILabel *usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 50, 20)];
    usernameLabel.text = LOCALIZATION(@"login_username_input");
    usernameLabel.textAlignment = NSTextAlignmentLeft;
    usernameLabel.textColor = [UIColor blackColor];
    usernameLabel.font = [UIFont systemFontOfSize:14.0f];
    
    username = [[UITextField alloc]initWithFrame:CGRectMake(75, 45/2, (560-150)/2, (235-175)/2)];
    [username setBorderStyle:UITextBorderStyleLine];
    
    username.layer.borderColor = [GETColor(234, 234, 234) CGColor];
    username.layer.cornerRadius = 3;
    username.layer.borderWidth = 1;
    username.delegate = self;
    username.tag = 101;
    username.font = [UIFont systemFontOfSize:14.0f];
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    // 分割线1
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = GETColor(234, 234, 234);
    lineView1.frame = CGRectMake(0, (255-130)/2, SCREEN_WIDTH, 1);
    
    //密码
    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 30+(270-175+5)/2, 50, 20)];
   passwordLabel.text = LOCALIZATION(@"login_username_pwd");
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.textColor = [UIColor blackColor];
    passwordLabel.font = [UIFont systemFontOfSize:14.0f];
    
    password = [[UITextField alloc]initWithFrame:CGRectMake(75, 45/2+(270-175+5)/2, (560-150)/2, (235-175)/2)];

    [password setBorderStyle:UITextBorderStyleLine];
    password.layer.borderColor = [GETColor(234, 234, 234) CGColor];
    password.layer.borderWidth = 1;
    password.layer.cornerRadius = 3;
    password.delegate = self;
    password.tag = 102;
    password.font = [UIFont systemFontOfSize:14.0f];
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    // 分割线2
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = GETColor(234, 234, 234);
    lineView2.frame = CGRectMake(0, (255-130)/2+(270-175+4)/2, SCREEN_WIDTH, 1);
    
    
    // 姓名
    UILabel *firstnameLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 30+(270-175+5)/2*2, 50, 20)];
    firstnameLabel.text = LOCALIZATION(@"userinfo_firstname");
    firstnameLabel.textAlignment = NSTextAlignmentLeft;
    firstnameLabel.textColor = [UIColor blackColor];
    firstnameLabel.font = [UIFont systemFontOfSize:14.0f];
    
    firstname = [[UITextField alloc]initWithFrame:CGRectMake(75, 45/2+(270-175+5)/2*2, (560-150)/2, (235-175)/2)];
    [firstname setBorderStyle:UITextBorderStyleLine];
    firstname.layer.borderColor = [GETColor(234, 234, 234) CGColor];
    firstname.layer.borderWidth = 1;
    firstname.layer.cornerRadius = 3;
    firstname.delegate = self;
    firstname.tag = 103;
    firstname.font = [UIFont systemFontOfSize:14.0f];
    firstname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    //分割线3
    UIView *lineView3 = [[UIView alloc] init];
    lineView3.backgroundColor = GETColor(234, 234, 234);
    lineView3.frame = CGRectMake(0, (255-130)/2+(270-175+4)/2*2, SCREEN_WIDTH, 1);
    
    // 手机号
    UILabel *mobileLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30+(270-175+5)/2*3, 50, 20)];
    mobileLabel.text = LOCALIZATION(@"mobileNum");
    mobileLabel.textAlignment = NSTextAlignmentLeft;
    mobileLabel.textColor = [UIColor blackColor];
    mobileLabel.font = [UIFont systemFontOfSize:14.0f];
    
    mobile = [[UITextField alloc]initWithFrame:CGRectMake(75, 45/2+(270-175+5)/2*3, (560-150)/2, (235-175)/2)];
    [mobile setBorderStyle:UITextBorderStyleLine];
    mobile.layer.borderColor = [GETColor(234, 234, 234) CGColor];
    mobile.layer.borderWidth = 1;
    mobile.layer.cornerRadius = 3;
    mobile.delegate = self;
    mobile.tag = 103;
    mobile.font = [UIFont systemFontOfSize:14.0f];
    mobile.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    UIView *lineView4 = [[UIView alloc] init];
    lineView4.backgroundColor = GETColor(234, 234, 234);
    lineView4.frame = CGRectMake(0, (255-130)/2+(270-175+4)/2*3, SCREEN_WIDTH, 1);
    
    // 邮箱
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 30+(270-175+5)/2*4-3, 50, 20)];
    emailLabel.text = LOCALIZATION(@"userinfo_email_ch");
    emailLabel.textAlignment = NSTextAlignmentLeft;
    emailLabel.textColor = [UIColor blackColor];
    emailLabel.font = [UIFont systemFontOfSize:14.0f];
    
    email = [[UITextField alloc]initWithFrame:CGRectMake(75, 45/2+(270-175+5)/2*4-3, (560-150)/2, (235-175)/2)];
    [email setBorderStyle:UITextBorderStyleLine];
    email.layer.borderColor = [GETColor(234, 234, 234) CGColor];
    email.layer.borderWidth = 1;
    email.layer.cornerRadius = 3;
    email.delegate = self;
    email.tag = 104;
    email.font = [UIFont systemFontOfSize:14.0f];
    email.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    // 分割线5
    UIView *lineView5 = [[UIView alloc] init];
    lineView5.backgroundColor = GETColor(234, 234, 234);
    lineView5.frame = CGRectMake(0, (255-130)/2+(270-175+4)/2*4, SCREEN_WIDTH, 1);
    
    UIButton *rigesterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigesterBtn.frame = CGRectMake(10, SCREEN_HEIGHT - 105, SCREEN_WIDTH - 20, 35);
    rigesterBtn.layer.borderColor = [GETColor(234, 234, 234) CGColor];
    rigesterBtn.layer.borderWidth = 1;
    rigesterBtn.layer.cornerRadius = 5;
    rigesterBtn.tag = 107;
    [rigesterBtn setTitle:LOCALIZATION(@"rigester_btn") forState:UIControlStateNormal];
    [rigesterBtn setTitleColor:GETColor(247, 253, 248) forState:UIControlStateNormal];
    rigesterBtn.layer.backgroundColor = [GETColor(42, 168, 74) CGColor];
    rigesterBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    rigesterBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [rigesterBtn addTarget:self action:@selector(redisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加手势收键盘
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [_scrollView addGestureRecognizer:tableViewGesture];
    
    //加载试图
    
    [_scrollView addSubview:usernameLabel];
    [_scrollView addSubview:username];
    
    [_scrollView addSubview:passwordLabel];
    [_scrollView addSubview:password];

    [_scrollView addSubview:firstnameLabel];
    [_scrollView addSubview:firstname];
    
    [_scrollView addSubview:mobileLabel];
    [_scrollView addSubview:mobile];
    
    [_scrollView addSubview:emailLabel];
    [_scrollView addSubview:email];
    
    
    [_scrollView addSubview:rigesterBtn];
    
    [_scrollView addSubview:lineView1];
    [_scrollView addSubview:lineView2];
    [_scrollView addSubview:lineView3];
    [_scrollView addSubview:lineView4];
    [_scrollView addSubview:lineView5];
    
    [self.view addSubview:_scrollView];
}
// 提交
- (void)redisterBtn:(UIButton *)sender{
    if ([username.text isEqualToString:@""] || username.text == nil) {
        NSString *alertText = @"用户名不能为空";//LOCALIZATION(@"login_empty_password");
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertText message:@"" delegate:self cancelButtonTitle:LOCALIZATION(@"dialog_ok")otherButtonTitles:nil];
        [alert show];
        return;
    }
    if ([password.text isEqualToString:@""] || password.text == nil) {
        NSString *alertText = @"密码不能为空";//LOCALIZATION(@"login_empty_username");
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertText message:@"" delegate:self cancelButtonTitle:LOCALIZATION(@"dialog_ok")otherButtonTitles:nil];
        [alert show];
        return;
    }
    if ([firstname.text isEqualToString:@""] || firstname.text == nil) {
        NSString *alertText = @"请输入姓名";//LOCALIZATION(@"login_empty_username");
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertText message:@"" delegate:self cancelButtonTitle:LOCALIZATION(@"dialog_ok")otherButtonTitles:nil];
        [alert show];
        return;
    }
            NSString *name = username.text?username.text:@" ";//
         NSString *psd = password.text?password.text:@" ";
         NSString *trueName = firstname.text?firstname.text:@" ";
         NSString *phoneNumber = mobile.text?mobile.text:@" ";
         NSString *emailDress = email.text?email.text:@" ";
        NSDictionary *parameter = @{@"username":name,@"password":psd,@"firstname":trueName,@"mobile":phoneNumber,@"email":emailDress,@"mobilecode":emailDress};
        [AFRequestService responseData:REGISTER_URL andparameters:parameter andResponseData:^(NSData *responseData) {
            NSDictionary *dic = (NSDictionary *)responseData;
            NSUInteger codeNum = [[dic objectForKey:@"code"] integerValue];
            if (codeNum == CODE_SUCCESS) {
                NSString *alertText = @"注册成功";//LOCALIZATION(@"login_empty_password");
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertText message:@"" delegate:self cancelButtonTitle:LOCALIZATION(@"dialog_ok")otherButtonTitles:nil];
                [alert show];
            }
            else if (codeNum == CODE_ERROE){
                NSString *alertText = @"账号、手机号或账号重复";//LOCALIZATION(@"login_empty_password");
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertText message:@"" delegate:self cancelButtonTitle:LOCALIZATION(@"dialog_ok")otherButtonTitles:nil];
                alert.tag = 501;
                [alert show];
            }
            else if (codeNum == CODE_ERROE){
                NSString *alertText = @"验证码不正确";//LOCALIZATION(@"login_empty_password");
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertText message:@"" delegate:self cancelButtonTitle:LOCALIZATION(@"dialog_ok")otherButtonTitles:nil];
                [alert show];
            }

        } andFailfailWithRequest:^{
            NSString *alertText = @"请检查网络状态";//LOCALIZATION(@"login_empty_password");
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertText message:@"" delegate:self cancelButtonTitle:LOCALIZATION(@"dialog_ok")otherButtonTitles:nil];
            [alert show];
        }];
   
}
// 验证手机号码格式是否正确
- (BOOL)checkTel:(NSString *)str

{
    
    if ([str length] == 0) {
        
        NSString *alertText = @"请先输入手机号";//LOCALIZATION(@"login_empty_username");
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertText message:@"" delegate:self cancelButtonTitle:LOCALIZATION(@"dialog_ok")otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        return NO;
        
    }
    return isMatch;
}
#pragma mark ====== keyboardAction
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    _scrollView.frame = CGRectMake(_scrollView.frame.origin.x, _scrollView.frame.origin.y, _scrollView.frame.size.width, self.view.frame.size.height - height);
    _scrollView.contentOffset = CGPointMake(0, height);
    keyBoardHeight = height;
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [UIView beginAnimations:@"Curl1"context:nil];//动画开始
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_scrollView cache:YES];
    _scrollView.frame = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT);
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    _scrollView.contentOffset = CGPointMake(0, 0);
    [UIView commitAnimations];
    
    
}
// 键盘收起
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
// 键盘收起
- (void)commentTableViewTouchInSide{
    [username resignFirstResponder];
    [mobile resignFirstResponder];
    [email resignFirstResponder];
    [firstname resignFirstResponder];
    [password resignFirstResponder];
}
#pragma mark ====== UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 501) {
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    else{
        return;
    }
}
}


@end
