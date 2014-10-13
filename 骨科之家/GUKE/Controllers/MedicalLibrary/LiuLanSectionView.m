//
//  LiuLanSectionView.m
//  GUKE
//
//  Created by soulnear on 14-10-3.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "LiuLanSectionView.h"

@implementation LiuLanSectionView


-(void)setContentWithFenLei:(NSString *)fenlei Date:(NSString *)aDate UserName:(NSString *)aUserName Sex:(NSString *)aSex
{
    self.fenlei_label.text = fenlei;
    self.fenlei_label.textColor = GETColor(33, 139, 172);
    self.date_label.text = aDate;
    self.userName_label.text = aUserName;
    self.userName_label.textColor = GETColor(33, 139, 172);
    self.date_label.textColor = GETColor(33, 139, 172);
    self.sex_label.text = aSex;
    self.sex_label.textColor = GETColor(33, 139, 172);
}

@end
