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


#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"




#import "AlixLibService.h"


//#import "AlixLibService.h"

@interface GeventDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation GeventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",[NSString _859ToUTF8:self.dataModel.eventTitle]);
    self.aTitle = @"会议日程";
    
    NSLog(@"%s",__FUNCTION__);
    
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
        height = 300;
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
    
    if (indexPath.row == 0) {//会议名称
        
        //会议名称
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 230, 30)];
        titleLabel.textColor = RGB(72, 158, 181);
        titleLabel.text = [NSString _859ToUTF8:self.dataModel.eventTitle];
        [titleLabel setMatchedFrame4LabelWithOrigin:CGPointMake(20, 20) width:230];
        
        //限定名额
        UILabel *numLimitLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame)+5, 65, 17)];
        numLimitLabel.font = [UIFont systemFontOfSize:15];
        numLimitLabel.textColor = RGB(168,168,168);
        numLimitLabel.text = @"限定名额";
        UILabel *cNumLimintLabel  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(numLimitLabel.frame)+5, numLimitLabel.frame.origin.y, 10, 17)];
        cNumLimintLabel.textColor = RGB(168,168,168);
        cNumLimintLabel.text = [NSString _859ToUTF8:self.dataModel.userLimit];
        
        //
        
        
        [cell.contentView addSubview:titleLabel];
        [cell.contentView addSubview:numLimitLabel];
        [cell.contentView addSubview:cNumLimintLabel];
        
    }else if (indexPath.row == 1){//会议时间
        
        UILabel *meettingTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 65, 20)];
        meettingTimeLabel.text = @"会议时间";
        UILabel *cMeettingTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(meettingTimeLabel.frame)+5, meettingTimeLabel.frame.origin.y, 65, 20)];
        cMeettingTimeLabel.text = self.dataModel.eventTime;
        
        UILabel *meetingEndTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 43, 65, 20)];
        meetingEndTimeLabel.text = @"报名截止";
        UILabel *cMeetingEndTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(meetingEndTimeLabel.frame)+5, meetingEndTimeLabel.frame.origin.y, 65, 20)];
        cMeetingEndTimeLabel.text = self.dataModel.endTime;
        [cell.contentView addSubview:meettingTimeLabel];
        [cell.contentView addSubview:cMeettingTimeLabel];
        [cell.contentView addSubview:meetingEndTimeLabel];
        [cell.contentView addSubview:cMeetingEndTimeLabel];
        
    }else if (indexPath.row == 2){//活动地点
        
    }else if (indexPath.row == 3) {//会议议程以及报名
        
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
        
        GMettingSignUpViewController *gg = [[GMettingSignUpViewController alloc]init];
        [self.navigationController pushViewController:gg animated:YES];
        
        
        
    }else if (sender.tag == 11){//取消报名
        NSLog(@"取消报名");
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
    order.productName = @"productName"; //商品标题
    order.productDescription = @"discription"; //商品描   述
    order.amount = [NSString stringWithFormat:@"998"]; //商品价格
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


-(void)aliresault{

    NSLog(@"阿里回调");

}



#pragma mark--支付宝相关结束











@end
