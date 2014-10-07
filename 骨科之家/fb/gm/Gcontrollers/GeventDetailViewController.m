//
//  GeventDetailViewController.m
//  GUKE
//
//  Created by gaomeng on 14-10-4.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "GeventDetailViewController.h"
#import "GMettingSignUpViewController.h"
#import "UILabel+GautoMatchedText.h"

#import "MBProgressHUD.h"


#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"




#import "AlixLibService.h"


//#import "AlixLibService.h"

@interface GeventDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UIAlertViewDelegate>
{
    GmettingDetailTableViewCell *_tmpCell;
    MBProgressHUD *_hud;
    UIWebView *_webView;
}
@end

@implementation GeventDetailViewController



-(void)dealloc{
    
    NSLog(@"%s",__FUNCTION__);
    _webView.delegate = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"GMJOINSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"GMESCSUCCESS" object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",self.dataModel.eventTitle);
    self.aTitle = @"会议日程";
    
    NSLog(@"%s",__FUNCTION__);
    
    [self prepareNetData];
    
//    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,iPhone5?568:568-64) style:UITableViewStylePlain];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    [self.view addSubview:tableView];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prepareNetData1) name:@"GMJOINSUCCESS" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(prepareNetData2) name:@"GMESCSUCCESS" object:nil];
    
    
    
}


//报名成功后的通知方法
-(void)prepareNetData1{
    
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"正在加载";
    
    NSString *eventIdStr = self.dataModel.eventId;
    
    
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID,@"eventId":eventIdStr};
    
    [AFRequestService responseData:CALENDAR_EVENT andparameters:parameters andResponseData:^(id responseData) {
        
        NSDictionary * dict = (NSDictionary *)responseData;
        NSString * code = [dict objectForKey:@"code"];
        NSDictionary *eventDic = [dict objectForKey:@"event"];
        if ([code intValue]==0)//说明请求数据成功
        {
            
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            NSLog(@"loadSuccess");
            
            NSLog(@"查看活动  %@",dict);
            
            NSString *isbaoming = @"1";
            
            self.dataModel = [[GeventModel alloc]initWithDic:eventDic];
            self.dataModel.userExists = isbaoming;
            self.dataModel.userlist = [dict objectForKey:@"userlist"];
            if (!_webView) {
                _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 275, 0)];
            }
            [_webView loadHTMLString:self.dataModel.context baseURL:nil];
            _webView.delegate = self;
            _webView.hidden = YES;
            [self.view addSubview:_webView];
            
            //            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, iPhone5?568-64:568-64-64) style:UITableViewStylePlain];
            //            tableView.delegate = self;
            //            tableView.dataSource = self;
            //            [self.view addSubview:tableView];
            
            
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"加载失败，请重新加载" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [al show];
            NSLog(@"%d",[code intValue]);
        }
    }];
}

//取消报名成功后的通知方法
-(void)prepareNetData2{
    
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"正在加载";
    
    NSString *eventIdStr = self.dataModel.eventId;
    
    
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID,@"eventId":eventIdStr};
    
    [AFRequestService responseData:CALENDAR_EVENT andparameters:parameters andResponseData:^(id responseData) {
        
        NSDictionary * dict = (NSDictionary *)responseData;
        NSString * code = [dict objectForKey:@"code"];
        NSDictionary *eventDic = [dict objectForKey:@"event"];
        if ([code intValue]==0)//说明请求数据成功
        {
            
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            NSLog(@"loadSuccess");
            
            NSLog(@"查看活动  %@",dict);
            
            NSString *isbaoming = @"0";
            
            self.dataModel = [[GeventModel alloc]initWithDic:eventDic];
            self.dataModel.userExists = isbaoming;
            self.dataModel.userlist = [dict objectForKey:@"userlist"];
            
            
            if (!_webView) {
                _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 275, 0)];
            }
            [_webView loadHTMLString:self.dataModel.context baseURL:nil];
            _webView.delegate = self;
            _webView.hidden = YES;
            [self.view addSubview:_webView];
            [self.view addSubview:_webView];
            
            //            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, iPhone5?568-64:568-64-64) style:UITableViewStylePlain];
            //            tableView.delegate = self;
            //            tableView.dataSource = self;
            //            [self.view addSubview:tableView];
            
            
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"加载失败，请重新加载" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [al show];
            NSLog(@"%d",[code intValue]);
        }
    }];
}





-(void)prepareNetData{
    
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"正在加载";
    
    NSString *eventIdStr = self.dataModel.eventId;
    
    
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID,@"eventId":eventIdStr};

    [AFRequestService responseData:CALENDAR_EVENT andparameters:parameters andResponseData:^(id responseData) {
        
        NSDictionary * dict = (NSDictionary *)responseData;
        NSString * code = [dict objectForKey:@"code"];
        NSDictionary *eventDic = [dict objectForKey:@"event"];
        if ([code intValue]==0)//说明请求数据成功
        {
            
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            NSLog(@"loadSuccess");
            
            NSLog(@"查看活动  %@",dict);
            
            NSString *isbaoming = self.dataModel.userExists;
            
            self.dataModel = [[GeventModel alloc]initWithDic:eventDic];
            self.dataModel.userExists = isbaoming;
            self.dataModel.userlist = [dict objectForKey:@"userlist"];
            
            if (!_webView) {
                _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 275, 0)];
            }
            [_webView loadHTMLString:self.dataModel.context baseURL:nil];
            _webView.delegate = self;
            _webView.hidden = YES;
            [self.view addSubview:_webView];
            
//            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, iPhone5?568-64:568-64-64) style:UITableViewStylePlain];
//            tableView.delegate = self;
//            tableView.dataSource = self;
//            [self.view addSubview:tableView];
            
            
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"加载失败，请重新加载" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [al show];
            NSLog(@"%d",[code intValue]);
        }
    }];
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
    
    if (_tmpCell) {
        height = [_tmpCell loadCustomViewWithIndexPath:indexPath dataModel:self.dataModel];
    }else{
        _tmpCell = [[GmettingDetailTableViewCell alloc]init];
        _tmpCell.delegate = self;
        [_tmpCell loadCustomViewWithIndexPath:indexPath dataModel:self.dataModel];
    }
    
    return height;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    GmettingDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[GmettingDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.delegate = self;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    [cell loadCustomViewWithIndexPath:indexPath dataModel:self.dataModel];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


-(void)btnClicked:(UIButton *)sender{
    if (sender.tag == 10) {//报名
        
        NSLog(@"我要报名");
        
        GMettingSignUpViewController *gg = [[GMettingSignUpViewController alloc]init];
        gg.dataModel = self.dataModel;
        [self.navigationController pushViewController:gg animated:YES];
        
        
        
    }else if (sender.tag == 11){//取消报名
        NSLog(@"取消报名");
        
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.labelText = @"正在取消";
        
        [self eventquitNetWork];
        
        
        
    }else if (sender.tag == 12){//支付费用
        
        NSLog(@"支付费用");
        
        
        [self PayForAli];
        
        
    }
    
}


#pragma mark---支付宝相关

-(void)PayForAli{

    NSString *appScheme = @"gukezhuanjia";
    NSString* orderInfo = [self getOrderInfo:2];
    NSString* signedStr = [self doRsa:orderInfo];
    
    NSLog(@"%@",signedStr);
    
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
    
    [AlixLibService payOrder:orderString AndScheme:appScheme seletor:nil target:self];


}


-(NSString*)getOrderInfo:(int)index
{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
//    Product *product = [_products objectAtIndex:index];
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = self.dataModel.eventTitle; //商品标题
    order.productDescription = @"discription"; //商品描   述
    order.amount = [NSString stringWithFormat:@"%@",[NSString _859ToUTF8:self.dataModel.fee]];//商品价格
   order.notifyURL =  @"http%3A%2F%2Fwwww.xxx.com"; //回调URL
    
    return [order description];
}

- (NSString *)generateTradeNO
{
    const int N = 15;
    
    NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *result = [[NSMutableString alloc] init] ;
    srand(time(0));
    for (int i = 0; i < N; i++)
    {
        unsigned index = rand() % [sourceString length];
        NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
        [result appendString:s];
    }
    return result;
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    
    
    
    NSLog(@"private==%@",signedString);
    return signedString;
    
    
}

#pragma mark - 支付完成的回调
-(void)aliresault{

    NSLog(@"阿里回调");
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"正在加载";
    
    NSString *eventUserIdStr = @"0";
    
    if (self.dataModel.userlist.count > 0) {
        for (NSDictionary *dic in self.dataModel.userlist) {
            NSString *userId = [dic objectForKey:@"userId"];
            if ([GET_U_ID isEqualToString:userId]) {
                eventUserIdStr = [dic objectForKey:@"eventUserId"];
            }
        }
    }
    
    
    
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID,@"eventUserId":eventUserIdStr};
    
    [AFRequestService responseData:CALENDAR_EVENT andparameters:parameters andResponseData:^(id responseData) {
        
        NSDictionary * dict = (NSDictionary *)responseData;
        NSString * code = [dict objectForKey:@"code"];
        NSDictionary *eventDic = [dict objectForKey:@"event"];
        if ([code intValue]==0)//说明请求数据成功
        {
            
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            NSLog(@"loadSuccess");
            
            NSLog(@"查看活动  %@",dict);
            
            NSString *isbaoming = @"1";
            
            self.dataModel = [[GeventModel alloc]initWithDic:eventDic];
            self.dataModel.userExists = isbaoming;
            self.dataModel.userlist = [dict objectForKey:@"userlist"];
            if (!_webView) {
                _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 275, 0)];
            }
            [_webView loadHTMLString:self.dataModel.context baseURL:nil];
            _webView.delegate = self;
            _webView.hidden = YES;
            [self.view addSubview:_webView];
            
            [self prepareNetData1];
            
            
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"加载失败，请重新加载" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [al show];
            NSLog(@"%d",[code intValue]);
        }
    }];
    
    
    

}



#pragma mark--支付宝相关结束




#pragma mark -  取消报名
-(void)eventquitNetWork{
    
    
    NSString *eventIdStr = self.dataModel.eventId;
    
    NSDictionary *parameters = @{@"userId":GET_U_ID,@"sid":GET_S_ID,@"eventId":eventIdStr};
    
    [AFRequestService responseData:CALENDAR_EVENTQUIT andparameters:parameters andResponseData:^(id responseData) {
        
        NSDictionary * dict = (NSDictionary *)responseData;
        NSString * code = [dict objectForKey:@"code"];
        if ([code intValue]==0)//说明请求数据成功
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [al show];
            
            
        }else{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    int height = [height_str intValue];
    webView.frame = CGRectMake(0,0,290,height);
    NSLog(@"height: %@", [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]);
    
    self.webViewHeight = [[webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]intValue] +10;
    
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, iPhone5?568-64:568-64-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101) {
        if (buttonIndex == 0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}





@end
