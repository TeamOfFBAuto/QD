//
//  GmettingDetailTableViewCell.m
//  GUKE
//
//  Created by gaomeng on 14-10-5.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "GmettingDetailTableViewCell.h"
#import "UILabel+GautoMatchedText.h"
#import "GeventDetailViewController.h"

@implementation GmettingDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(CGFloat)loadCustomViewWithIndexPath:(NSIndexPath*)indexPath dataModel:(GeventModel*)theModel{
    
    CGFloat height = 0;
    
    if (indexPath.row == 0) {//会议名称
        
        //会议名称
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 230, 30)];
        titleLabel.textColor = RGB(72, 158, 181);
        titleLabel.text = [NSString _859ToUTF8:theModel.eventTitle];
        [titleLabel setMatchedFrame4LabelWithOrigin:CGPointMake(20, 20) width:230];
        
        //限定名额
        UILabel *numLimitLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame)+5, 75, 17)];
        numLimitLabel.font = [UIFont systemFontOfSize:15];
        numLimitLabel.textColor = RGB(168,168,168);
        numLimitLabel.text = @"限定名额：";
        UILabel *cNumLimintLabel  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(numLimitLabel.frame)+5, numLimitLabel.frame.origin.y, 10, 17)];
        cNumLimintLabel.textColor = RGB(168,168,168);
        cNumLimintLabel.text = [NSString _859ToUTF8:theModel.userLimit];
        
        //已报名
        
        
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:numLimitLabel];
        [self.contentView addSubview:cNumLimintLabel];
        
        
        height = CGRectGetMaxY(numLimitLabel.frame)+20;
        
        
        
    }else if (indexPath.row == 1){//会议时间
        //会议时间
        UILabel *meettingTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 75, 20)];
        meettingTimeLabel.font = [UIFont systemFontOfSize:15];
        meettingTimeLabel.text = @"会议时间：";
        meettingTimeLabel.textColor = RGB(98, 97, 97);
        
        UILabel *cMeettingTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(meettingTimeLabel.frame)+5, meettingTimeLabel.frame.origin.y, 150, 20)];
        cMeettingTimeLabel.textColor = RGB(168,168,168);
        cMeettingTimeLabel.font = [UIFont systemFontOfSize:15];
        cMeettingTimeLabel.text = theModel.eventTime;
        
        //报名截止
        UILabel *meetingEndTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 43, 75, 20)];
        meetingEndTimeLabel.text = @"报名截止：";
        meetingEndTimeLabel.font = [UIFont systemFontOfSize:15];
        meetingEndTimeLabel.textColor = RGB(98, 97, 97);
        
        UILabel *cMeetingEndTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(meetingEndTimeLabel.frame)+5, meetingEndTimeLabel.frame.origin.y, 100, 20)];
        cMeetingEndTimeLabel.font = [UIFont systemFontOfSize:15];
        cMeetingEndTimeLabel.textColor = RGB(168,168,168);
        cMeetingEndTimeLabel.text = theModel.endTime;
        [self.contentView addSubview:meettingTimeLabel];
        [self.contentView addSubview:cMeettingTimeLabel];
        [self.contentView addSubview:meetingEndTimeLabel];
        [self.contentView addSubview:cMeetingEndTimeLabel];
        
        height = CGRectGetMaxY(cMeetingEndTimeLabel.frame)+20;
        
        
        
        
    }else if (indexPath.row == 2){//活动地点
        //活动地点
        UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 75, 20)];
        addressLabel.textColor = RGB(98, 97, 97);
        addressLabel.font = [UIFont systemFontOfSize:15];
        addressLabel.text = @"活动地点：";
        
        UILabel *cAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(addressLabel.frame)+5, addressLabel.frame.origin.y, 200, 20)];
        cAddressLabel.font = [UIFont systemFontOfSize:15];
        cAddressLabel.textColor = RGB(168,168,168);
        cAddressLabel.text = [NSString _859ToUTF8:theModel.address ];
        [cAddressLabel setMatchedFrame4LabelWithOrigin:CGPointMake(CGRectGetMaxX(addressLabel.frame)+5, addressLabel.frame.origin.y) width:200];
        [self.contentView addSubview:addressLabel];
        [self.contentView addSubview:cAddressLabel];
        
        //会议费用
        UILabel *feeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(cAddressLabel.frame)+5, 75, 20)];
        feeLabel.textColor = RGB(98, 97, 97);
        feeLabel.font = [UIFont systemFontOfSize:15];
        feeLabel.text = @"会议费用：";
        
        UILabel *cFeeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(feeLabel.frame)+5, feeLabel.frame.origin.y, 200, 20)];
        cFeeLabel.textColor = RGB(168, 168, 168);
        cFeeLabel.text = [[NSString _859ToUTF8:theModel.fee]stringByAppendingString:@"元"];
        
        [self.contentView addSubview:feeLabel];
        [self.contentView addSubview:cFeeLabel];
        
        
        //联系电话
        UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(feeLabel.frame)+5, 75, 20)];
        phoneLabel.font = [UIFont systemFontOfSize:15];
        phoneLabel.textColor = RGB(72, 158, 181);
        phoneLabel.text = @"联系电话：";
        
        UILabel *cPhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneLabel.frame)+5, phoneLabel.frame.origin.y, 200, 20)];
        cPhoneLabel.font = [UIFont systemFontOfSize:15];
        cPhoneLabel.textColor = RGB(72, 158, 181);
        cPhoneLabel.text = [NSString _859ToUTF8:theModel.phone];
        
        [self.contentView addSubview:phoneLabel];
        [self.contentView addSubview:cPhoneLabel];
        
        
        height = CGRectGetMaxY(phoneLabel.frame)+20;
        
        
    }else if (indexPath.row == 3) {//会议议程以及报名
        
        //会议议程
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 75, 20)];
        titleLabel.text = @"会议议程";
        titleLabel.textColor = RGB(72, 158, 181);
        titleLabel.font = [UIFont systemFontOfSize:15];
        
        UILabel *contextLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame)+5, 200, 20)];
        contextLabel.font = [UIFont systemFontOfSize:15];
        contextLabel.textColor = RGB(168, 168, 168);
        contextLabel.text = [NSString _859ToUTF8:theModel.context];
        [contextLabel setMatchedFrame4LabelWithOrigin:CGPointMake(20, CGRectGetMaxY(titleLabel.frame)+5) width:275];
        
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:contextLabel];
        
        
        
        
        
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
                [btn setTitleColor:RGB(35, 178, 95) forState:UIControlStateNormal];
                btn.layer.borderWidth = 1;
                btn.layer.borderColor = [RGB(35, 178, 95)CGColor];
                [btn setBackgroundColor:[UIColor whiteColor]];
            }
            
            
            [btn setFrame:CGRectMake(10, CGRectGetMaxY(contextLabel.frame)+20 +i*(50+10), 300, 50)];
            
            [self.contentView addSubview:btn];
            
            height = CGRectGetMaxY(btn.frame)+20;
        }
        
    }
    
        
        
        return height;
    
}



-(void)btnClicked:(UIButton *)sender{
    [self.delegate btnClicked:sender];
}




@end
