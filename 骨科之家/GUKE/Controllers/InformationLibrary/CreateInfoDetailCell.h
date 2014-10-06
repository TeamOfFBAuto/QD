//
//  CreateInfoDetailCell.h
//  GUKE
//
//  Created by soulnear on 14-10-6.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoicePlayCenter.h"

@interface MyAudioPlayer : AVAudioPlayer
{
    
}

@property(nonatomic,strong)UIImageView * aImageView;

@end

@class CreateInfoDetailCell;
@protocol CreateInfoDetailCellDelegate <NSObject>

@optional
-(void)deleteFilesTap:(CreateInfoDetailCell*)cell;

@end



@interface CreateInfoDetailCell : UITableViewCell<UIActionSheetDelegate,VoicePlayCenterDelegate,AVAudioPlayerDelegate>
{
    UIView * background;
    UIImageView * imgSaveView;
    VoicePlayCenter * voicePlayCenter;
    
    BOOL isAnimationVoice;
    
    NSArray * _voiceLeftImageArr;
}


@property (strong, nonatomic) IBOutlet UIButton *delete_button;


@property (strong, nonatomic) IBOutlet UIImageView *voice_icon;

@property (strong, nonatomic) IBOutlet UIImageView *files_imageView;

@property (strong, nonatomic) IBOutlet UILabel *files_label;

@property (strong, nonatomic) IBOutlet UILabel *files_size_label;
@property(nonatomic,assign)id<CreateInfoDetailCellDelegate>delegate;
///数据
@property(nonatomic,strong)id data_object;
///播放语音
@property(nonatomic,strong)MyAudioPlayer * player;

-(void)setInfoWith:(id)object;

- (IBAction)deleteButtonTap:(id)sender;



@end
