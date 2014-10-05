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
{
    GmettingDetailTableViewCell *_tmpCell;
}
@end

@implementation GeventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",[NSString _859ToUTF8:self.dataModel.eventTitle]);
    self.aTitle = @"会议日程";
    
    NSLog(@"%s",__FUNCTION__);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
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
    order.amount = [NSString stringWithFormat:@"%@",self.dataModel.fee]; //商品价格
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
