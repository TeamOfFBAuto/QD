//
//  TDDetailCell.m
//  GUKE
//
//  Created by soulnear on 14-9-30.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "TDDetailCell.h"

@implementation TDDetailCell
@synthesize content_label = _content_label;
@synthesize content_imageView = _content_imageView;
@synthesize voice_imageView = _voice_imageView;
@synthesize voive_array = _voive_array;
@synthesize isAnimationVoice = _isAnimationVoice;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setInfoWith:(ReplyListModel *)info
{
    if (info.theType == SEND_Type_content)
    {
        CGRect rectr;
        if (IOS7_LATER) {
            rectr = [info.context boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
        }
        else{
        NSAttributedString * attributeString = [[NSAttributedString alloc]initWithString:info.context attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}];
        rectr = [attributeString boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        }
        
        
        _background_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(56,37,rectr.size.width+20,rectr.size.height+20)];
        _background_imageView.image = [[UIImage imageNamed:@"chatfrom_bg_voice_playing.9.png"] stretchableImageWithLeftCapWidth:18 topCapHeight:26];
        [self.contentView addSubview:_background_imageView];
        
        _content_label = [[UILabel alloc] initWithFrame:CGRectMake(12,10,rectr.size.width,rectr.size.height)];
        _content_label.text = info.context;
        _content_label.numberOfLines = 0;
        _content_label.backgroundColor = [UIColor clearColor];
        _content_label.font = [UIFont systemFontOfSize:14];
        _content_label.textAlignment = NSTextAlignmentLeft;
        _content_label.textColor = [UIColor blackColor];
        [_background_imageView addSubview:_content_label];
        
    }else if (info.theType == SEND_Type_photo)
    {
        _content_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(56,37,120,80)];
        _content_imageView.contentMode = UIViewContentModeScaleToFill;
        [_content_imageView sd_setImageWithURL:[SNTools returnUrl:[[info.attach_array objectAtIndex:0] fileurl]] placeholderImage:nil];
        [self.contentView addSubview:_content_imageView];
        
    }else if (info.theType == SEND_Type_voice)
    {
        AttachListModel * model = [info.attach_array objectAtIndex:0];
        
        _background_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(56,37,150,36)];
        _background_imageView.image = [[UIImage imageNamed:@"chatfrom_bg_voice_playing.9.png"] stretchableImageWithLeftCapWidth:18 topCapHeight:26];
        _background_imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_background_imageView];
        
        _voice_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15,10,14,16)];
        _voice_imageView.image = [UIImage imageNamed:@"voice_L0"];
        _voice_imageView.userInteractionEnabled = NO;
        [_background_imageView addSubview:_voice_imageView];
 
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voiceTap:)];
        [_background_imageView addGestureRecognizer:tap];
        
        
        _voice_lenght_label = [[UILabel alloc] initWithFrame:CGRectMake(220,37,30,36)];
        _voice_lenght_label.text =[NSString stringWithFormat:@"%@’’",model.voiceLength];
        _voice_lenght_label.textAlignment = NSTextAlignmentLeft;
        _voice_lenght_label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_voice_lenght_label];
        
        voice_url = model.fileurl;
        
        [self initilization];
        
    }else if (info.theType == SEND_Type_other)
    {
        
    }
    
    //_header_imageView.image = [UIImage imageNamed:@"user_default_ico"];w
    NSString *iconUrl = [UserInfoDB selectFeildString:@"icon" andcuId:GET_USER_ID anduserId:info.userId];
    [_header_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_BASE_URL,iconUrl]] placeholderImage:[UIImage imageNamed:@"user_default_ico"]];
    _userName_label.text = info.firstname;
    _date_label.text = info.createDate;
    _date_label.layer.cornerRadius = 3;
    _date_label.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    _date_label.textAlignment = NSTextAlignmentCenter;
    _date_label.textColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
    
}
+ (CGFloat)heightForCell:(ReplyListModel *)info{
    if (info.theType == SEND_Type_content)
    {
        CGFloat height = 110;
            CGSize resultSize=[info.context?info.context :@"" sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(DEVICE_WIDTH-100, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        if (resultSize.height+20+26 > 110)
        {
            height = resultSize.height+20+26;
        }
        return height;
        
    }else if (info.theType == SEND_Type_photo)
    {
        return 130;
        
    }else if (info.theType == SEND_Type_voice)
    {
        return 110;
        
    }else if (info.theType == SEND_Type_other)
    {
        return 0;
    }
    else {
        return 0;
    }
}
-(void)voiceTap:(UITapGestureRecognizer *)sender
{
    [self playVoice];
    _voice_imageView.animationImages = _voive_array;
    _voice_imageView.animationDuration = 1;
    _isAnimationVoice = YES;
    [_voice_imageView startAnimating];

}


////////播放动画的制作
#pragma mark - 图片需要自己设置--不能为nil 对象
-(void)initilization{
    _voive_array = [[NSMutableArray alloc] initWithObjects:
                          [UIImage imageNamed:@"voice_L1.png"],
                          [UIImage imageNamed:@"voice_L2.png"],
                          [UIImage imageNamed:@"voice_L3.png"],nil];
}
- (void)restoreDisplay{
    //还原录音图
    [_voice_imageView stopAnimating];
    _voice_imageView.image = [UIImage imageNamed:@"voice_L0.png"];
}
// 更新声音图片
-(void)updateVoiceImage:(NSInteger)index withSender:(BOOL)isSelfSend
{
    NSAssert(index>_voive_array.count, @"-----弹出");
    if (index>_voive_array.count) {
        index = _voive_array.count-1;
    }
    _voice_imageView.image = [_voive_array objectAtIndex:index];
}

#pragma mark - 播放声音
-(void)playVoice
{
    __weak typeof(self)bself = self;
    voicePlayCenter = [[VoicePlayCenter alloc] init];
    voicePlayCenter.playDelegate = self;// 播放声音的代理方法
    PlayerModel *model = [[PlayerModel alloc] init];
    model.fileId = voice_url;
    [voicePlayCenter downloadPlayVoice:model];
    _background_imageView.userInteractionEnabled = NO;
    voicePlayCenter.block = ^(){
        [bself restoreDisplay];
        bself.background_imageView.userInteractionEnabled = YES;
    };
}



@end



















