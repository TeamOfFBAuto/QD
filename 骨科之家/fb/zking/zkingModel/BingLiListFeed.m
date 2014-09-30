//
//  BingLiListFeed.m
//  GUKE
//
//  Created by szk on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "BingLiListFeed.h"

@implementation BingLiListFeed


-(void)setBingLiListFeedDic:(NSDictionary *)mydic{

    self.bingliId=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"bingliId"]];
    
    self.userId=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"userId"]];
    
    self.psnname=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"psnname"]];
    
    self.sex=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"sex"]];
    
    self.zhenduan=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"zhenduan"]];

    self.mobile=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"mobile"]];
    
    self.relateMobile=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"relateMobile"]];
    
    self.fangan=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"fangan"]];
    
    self.binglihao=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"binglihao"]];
    
    self.leibieId=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"leibieId"]];
    
    self.idno=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"idno"]];
    
    self.bianma=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"bianma"]];
    
    self.memo=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"memo"]];
    
    self.fenleiId=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"fenleiId"]];
    
    self.createDate=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"createDate"]];
    
    self.leibiename=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"leibiename"]];
    
    self.fenleiname=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"fenleiname"]];
    
    self.firstname=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"firstname"]];
    


}


@end
