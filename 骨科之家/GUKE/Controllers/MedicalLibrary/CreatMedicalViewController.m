//
//  CreatMedicalViewController.m
//  GUKE
//  新建病历页面
//  Created by ianMac on 14-9-24.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "CreatMedicalViewController.h"
#import "CreateMedicalCell.h"
#import "UIImage+fixOrientation.h"
#import "QiDiPopoverView.h"
#import "imgUploadModel.h"
#import "CreateMedicalFilesCell.h"
#import "ChooseCaseTypeViewController.h"

@interface CreatMedicalViewController ()<UITextViewDelegate,CreateMedicalFilesCellDelegate>
{
    ///存放条件数据
    NSMutableArray * content_array;
    ///治疗方案
    UITextView * treatment_case;
    ///治疗方案默认文字
    UILabel * placeHolder_treatment_case;
    
    ///弹出框
    QiDiPopoverView * popOver;
    
    UITextField * groupName;
    
    ///存放完成的数据（视频、图片、录音）
    NSMutableArray * data_array;
    
    
}
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
    
    content_array = [NSMutableArray arrayWithObjects:@"姓名",@"性别",@"就诊时间",@"诊断",@"病人手机号",@"家属手机号",@"治疗方案",@"病历号",@"身份证号",@"标记编号",nil];
    data_array = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillShowKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillHideKeyboard:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(uploadData:)
                                                 name:@"uploadData"
                                               object:nil];
    
}

-(void)uploadData:(NSNotification *)notification
{
    NSLog(@"notification ---  %@",notification);
    
    
}


#pragma mark-显示收回键盘

- (void)handleWillShowKeyboard:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    CGRect rect = _mainTableView.frame;
    rect.size.height = rect.size.height-height;
    
    _mainTableView.frame = rect;
}

- (void)handleWillHideKeyboard:(NSNotification *)notification
{
    _mainTableView.frame = CGRectMake(0,0,DEVICE_WIDTH,DEVICE_HEIGHT);
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
    loginLabel.text = @"新建病历库";
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
    _mainTableView.tableHeaderView = [self loadSectionView];
    [self.view addSubview:_mainTableView];
}

// 手势事件
- (void)tapAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

/// "提交"的点击事件
- (void)btnClick
{
    NSLog(@"点击提交按钮");
    ChooseCaseTypeViewController * chooseType = [[ChooseCaseTypeViewController alloc] init];
    [self.navigationController pushViewController:chooseType animated:YES];
}


#pragma mark - 加载头视图
-(UIView *)loadSectionView
{
    CGRect viewFrame = CGRectMake(0,0,DEVICE_WIDTH,120);
    UIView * view = [[UIView alloc] initWithFrame:viewFrame];
    UITextView * text_view = [[UITextView alloc] initWithFrame:CGRectMake(10,10,DEVICE_WIDTH-20,60)];
    text_view.textAlignment = NSTextAlignmentLeft;
    text_view.textColor = [UIColor lightGrayColor];
    text_view.font = [UIFont systemFontOfSize:14];
    text_view.layer.borderColor = [UIColor blueColor].CGColor;
    text_view.layer.borderWidth = 0.5;
    [view addSubview:text_view];
    
    NSArray * image_array = [NSArray arrayWithObjects:@"guke_ic_addcamera",@"guke_ic_addvoice.png",@"guke_ic_addvideo.png",@"guke_ic_addphoto.png",nil];
    
    for (int i = 0;i < 4;i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((DEVICE_WIDTH-150)+37*i,80,27,28);
        button.tag = 1000+i;
        [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(doButtonEnd:) forControlEvents:UIControlEventTouchCancel];
        [button setImage:[UIImage imageNamed:[image_array objectAtIndex:i]] forState:UIControlStateNormal];
        [view addSubview:button];
    }
    return view;
}

#pragma makr - button点击方法
-(void)doButton:(UIButton *)sender
{
    switch (sender.tag - 1000) {
        case 0:///拍照
        {
            [self takePotoPicture:UIImagePickerControllerSourceTypeCamera];
        }
            break;
        case 1:///录音
        {
            [self recordStartQiDi];
        }
            break;
        case 2:///视频
        {
            
        }
            break;
        case 3:///相册
        {
            [self takePotoPicture:UIImagePickerControllerSourceTypePhotoLibrary];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)doButtonEnd:(UIButton *)sender
{
    if (sender.tag == 101) {
        [self recordEndQiDi];
    }
}

#pragma mark - 选择完文件后，输入介绍
-(void)inputIntroduce
{
    popOver = [[QiDiPopoverView alloc] init];
    [popOver showPopoverAtPoint:CGPointMake(viewSize.width, 0) inView:self.view withContentView:[self creatGroupView]];
    
}

- (UIView *)creatGroupView{
    UIView *contaiterView = [[UIView alloc]initWithFrame:CGRectMake(30, 64, viewSize.width-60, 170)];
    contaiterView.backgroundColor = [UIColor blackColor];
    
    UILabel *groupNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 150, 40)];
    groupNameLabel.text = LOCALIZATION(@"chat_groupname");
    groupNameLabel.textColor = [UIColor whiteColor];
    groupNameLabel.backgroundColor = [UIColor clearColor];
    groupNameLabel.font = [UIFont systemFontOfSize:16];
    [contaiterView addSubview:groupNameLabel];
    
    UIImageView *lineBg1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 45, contaiterView.frame.size.width, 2)];
    lineBg1.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"searchbglinered@2x" ofType:@"png"]];
    
    [contaiterView addSubview:lineBg1];
    
    groupName = [[UITextField alloc]initWithFrame:CGRectMake(5, 60, contaiterView.frame.size.width-10, 30)];
    [groupName setBorderStyle:UITextBorderStyleLine];
    groupName.layer.borderColor = [[UIColor orangeColor]CGColor];
    groupName.font = [UIFont systemFontOfSize:16];
    groupName.textColor = [UIColor whiteColor];
    groupName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    groupName.keyboardAppearance = UIKeyboardAppearanceDefault;
    groupName.keyboardType = UIKeyboardTypeDefault;
    groupName.returnKeyType = UIReturnKeyGo;
    [groupName becomeFirstResponder];
    groupName.tag = 10000;
    groupName.delegate = self;
    [contaiterView addSubview:groupName];
    
    UIImageView *lineBg2 = [[UIImageView alloc]initWithFrame:CGRectMake(6, 90, contaiterView.frame.size.width-10, 4)];
    lineBg2.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"searchbglinered@2x" ofType:@"png"]];
    
    [contaiterView addSubview:lineBg2];
    
    UIButton *dialogBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dialogBtn.frame = CGRectMake(30, 120, 70, 40);
    dialogBtn.backgroundColor = [UIColor clearColor];
    dialogBtn.tag = DIALOG_Btn_TAG;
    [dialogBtn setTitle:LOCALIZATION(@"dialog_cancel") forState:UIControlStateNormal];
    [dialogBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dialogBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    dialogBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    dialogBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    UIButton *subMitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subMitBtn.frame = CGRectMake(150, 120, 70, 40);
    subMitBtn.backgroundColor = [UIColor clearColor];
    subMitBtn.tag = SUBMIT_BTN_TAG;
    [subMitBtn setTitle:LOCALIZATION(@"button_submit") forState:UIControlStateNormal];
    [subMitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [subMitBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    subMitBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    subMitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [contaiterView addSubview:dialogBtn];
    [contaiterView addSubview:subMitBtn];
    
    return contaiterView;
}

-(void)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case DIALOG_Btn_TAG:///取消
        {
            [popOver dismiss];
            [data_array removeLastObject];
        }
            
            break;
        case SUBMIT_BTN_TAG:///完成
        {
            NSMutableDictionary * dic = [data_array lastObject];
            [dic setObject:groupName.text forKey:@"content"];
            [_mainTableView reloadData];
        }
            
            break;
            
        default:
            break;
    }
}


// 触发录音事件
- (void)recordStartQiDi
{
    NSString *originWav = [VoiceRecorderBaseVC getCurrentTimeString];
    if (!self.recorderVC) {
        self.recorderVC = [[ChatVoiceRecorderVC alloc]init];
        _recorderVC.vrbDelegate = (id)self;
    }
    [self.recorderVC beginRecordByFileName:originWav];
}

// 结束录音事件
- (void)recordEndQiDi
{
    [self.recorderVC end];
    
}

#pragma mark - 录音方法
#pragma mark record 开始录音
#pragma mark ---------record delegate
- (void)VoiceRecorderBaseVCRecordFinish:(NSString *)_filePath fileName:(NSString *)_fileName withVoiceLenth:(CGFloat)length{
    int a =(int) length;
    if (a > 0) {
        [self wavToAmr:_filePath with:_fileName length:length];
    }
}
-(void)wavToAmr:(NSString *)_filePath  with:(NSString *)_fileName length:(CGFloat)length{
    [VoiceConverter wavToAmr:_filePath amrSavePath:[VoiceRecorderBaseVC getPathByFileName:[_fileName stringByAppendingString:@"wavToAmr"] ofType:@"amr"]];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_fileName,@"fid",_filePath,@"fileName",[NSNumber numberWithInt:(int)length],@"length", nil];
    
    NSMutableData * data = [NSMutableData dataWithContentsOfFile:[VoiceRecorderBaseVC getPathByFileName:[_fileName stringByAppendingString:@"wavToAmr"] ofType:@"amr"]];
    [dic setObject:data forKey:@"fileData"];
    [dic setObject:@"voice" forKey:@"type"];
    [data_array addObject:dic];
    
    NSLog(@"%@==%@",_filePath,_fileName);
    [self inputIntroduce];
}


#pragma mark imagepicker delegate
-(void)takePotoPicture:(UIImagePickerControllerSourceType)sourceType{
    //指定图片来源
    //    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypeCamera;
    //判断如果摄像机不能用图片来源与图片库
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"不能使用相机" message:@"本地图片" delegate:self cancelButtonTitle:LOCALIZATION(@"dialog_ok") otherButtonTitles: nil];
            [alertView show];
            return;
        }
    }
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    //[[TabBarView sharedTabBarView] hideTabbar:YES animated:YES];
    [self presentViewController:picker animated:YES completion:^{}];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [[info objectForKey:UIImagePickerControllerOriginalImage] fixOrientation];
    [picker dismissViewControllerAnimated:YES completion:^{
        
        imgUploadModel * imageModel = [[imgUploadModel alloc] init];
        UIImage *newImage = [image imageByScalingOrgSize:CGSIZE_SCALE_MAX];
        NSData * aData = UIImageJPEGRepresentation(newImage, 1);
        imageModel.imageName = [NSString stringWithFormat:@"%@.jpg",[UUID createUUID]];
        imageModel.imageData = aData;
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[UUID createUUID],@"fid",[NSNumber numberWithFloat:aData.length/1024],@"length",imageModel,@"fileData",@"image",@"type",nil];
        
        [data_array addObject:dic];
        
        [self inputIntroduce];
    }];
    // 发送图片
//    [self sureUpload:image withType:SEND_Type_photo];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark-tableviewdelegateAndDatesource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10 + data_array.count;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row < data_array.count)
    {
        NSDictionary * dic = [data_array objectAtIndex:indexPath.row];
        
        static NSString * cell1 = @"cell1";
        CreateMedicalFilesCell * cell = [tableView dequeueReusableCellWithIdentifier:cell1];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CreateMedicalFilesCell" owner:self options:nil] objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.content_textView.text = [dic objectForKey:@"content"];
        cell.filesSize_label.text = [NSString stringWithFormat:@"%@k",[dic objectForKey:@"length"]];
        
        NSString * type = [dic objectForKey:@"type"];
        if ([type isEqualToString:@"voice"])
        {
            
        }else if ([type isEqualToString:@"image"])
        {
            imgUploadModel * model = [dic objectForKey:@"fileData"];
            UIImage * image = [UIImage imageWithData:model.imageData];            
            
            cell.Files_imageView.image = image;
            
        }else if ([type isEqualToString:@"video"])
        {
            
        }
        
        return cell;
        
    }else if (indexPath.row == 6+data_array.count)
    {
        static NSString * identifier = @"identifier";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        if (!treatment_case)
        {
            treatment_case = [[UITextView alloc] initWithFrame:CGRectMake(10,5,DEVICE_WIDTH-20,60)];
            treatment_case.tag = 100 + indexPath.row;
            treatment_case.textAlignment = NSTextAlignmentLeft;
            treatment_case.layer.cornerRadius = 5;
            treatment_case.font = [UIFont systemFontOfSize:15];
            treatment_case.delegate = self;
            treatment_case.layer.masksToBounds = YES;
            treatment_case.layer.borderColor = [UIColor grayColor].CGColor;
            treatment_case.layer.borderWidth = 0.5;
            [cell.contentView addSubview:treatment_case];
            
            
            placeHolder_treatment_case = [[UILabel alloc] initWithFrame:CGRectMake(10,5,200,20)];
            placeHolder_treatment_case.text = @"治疗方案";
            placeHolder_treatment_case.font = [UIFont systemFontOfSize:15];
            placeHolder_treatment_case.textAlignment = NSTextAlignmentLeft;
            placeHolder_treatment_case.textColor = [UIColor blackColor];
            [treatment_case addSubview:placeHolder_treatment_case];
        }
        
        return cell;
    }else
    {
        static NSString *identifier=@"cell";
        
        CreateMedicalCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell)
        {
            cell = [[CreateMedicalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSString * title = [content_array objectAtIndex:indexPath.row-data_array.count];
        cell.title_label.text = title;
        cell.input_textView.tag = indexPath.row + 100;
        cell.input_textView.delegate = self;
        
        CGSize aSize = [title sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        
        CGRect titleFrame = cell.title_label.frame;
        
        titleFrame.size.width = aSize.width;
        cell.title_label.frame = titleFrame;
        
        float input_widht = DEVICE_WIDTH - 20 - aSize.width -10;
        
        //        CGSize input_tv_size = [SNTools returnStringHeightWith:cell.input_textView.text WithWidth:input_widht WithFont:15];
        
        CGRect textViewFrame = CGRectMake(aSize.width+10,10,input_widht,25);
        cell.input_textView.frame = textViewFrame;
        
        cell.input_line_view.frame = CGRectMake(aSize.width+10,textViewFrame.origin.y+textViewFrame.size.height+2.5,input_widht+5,4);
        
        return cell;
    }
    
    
//    if (indexPath.row == 6)
//    {
//        static NSString * identifier = @"identifier";
//        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (cell == nil)
//        {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        }
//        
//        if (!treatment_case)
//        {
//            treatment_case = [[UITextView alloc] initWithFrame:CGRectMake(10,5,DEVICE_WIDTH-20,60)];
//            treatment_case.tag = 100 + indexPath.row;
//            treatment_case.textAlignment = NSTextAlignmentLeft;
//            treatment_case.layer.cornerRadius = 5;
//            treatment_case.font = [UIFont systemFontOfSize:15];
//            treatment_case.delegate = self;
//            treatment_case.layer.masksToBounds = YES;
//            treatment_case.layer.borderColor = [UIColor grayColor].CGColor;
//            treatment_case.layer.borderWidth = 0.5;
//            [cell.contentView addSubview:treatment_case];
//            
//            
//            placeHolder_treatment_case = [[UILabel alloc] initWithFrame:CGRectMake(10,5,200,20)];
//            placeHolder_treatment_case.text = @"治疗方案";
//            placeHolder_treatment_case.font = [UIFont systemFontOfSize:15];
//            placeHolder_treatment_case.textAlignment = NSTextAlignmentLeft;
//            placeHolder_treatment_case.textColor = [UIColor blackColor];
//            [treatment_case addSubview:placeHolder_treatment_case];
//        }
//        
//        return cell;
//    }else
//    {
//        static NSString *identifier=@"cell";
//        
//        CreateMedicalCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
//        
//        if (!cell)
//        {
//            cell = [[CreateMedicalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        NSString * title = [content_array objectAtIndex:indexPath.row];
//        cell.title_label.text = title;
//        cell.input_textView.tag = indexPath.row + 100;
//        cell.input_textView.delegate = self;
//        
//        CGSize aSize = [title sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
//        
//        CGRect titleFrame = cell.title_label.frame;
//        
//        titleFrame.size.width = aSize.width;
//        cell.title_label.frame = titleFrame;
//        
//        float input_widht = DEVICE_WIDTH - 20 - aSize.width -10;
//        
////        CGSize input_tv_size = [SNTools returnStringHeightWith:cell.input_textView.text WithWidth:input_widht WithFont:15];
//        
//        CGRect textViewFrame = CGRectMake(aSize.width+10,10,input_widht,25);
//        cell.input_textView.frame = textViewFrame;
//        
//        cell.input_line_view.frame = CGRectMake(aSize.width+10,textViewFrame.origin.y+textViewFrame.size.height+2.5,input_widht+5,4);
//        
//        return cell;
//    }
    return nil;

}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < data_array.count)
    {
        return 80;
    }else if (indexPath.row == 6+data_array.count)
    {
        return 90;
    }else
    {
        return 50;
    }

//    if (indexPath.row == 6+data_array.count) {
//        return 90;
//    }else
//    {
//        return 50;
//    }
}

#pragma mark - CreateMedicalFileCellDelegate
-(void)deleteFilesTap:(CreateMedicalFilesCell *)cell
{
    NSIndexPath * indexPath = [_mainTableView indexPathForCell:cell];
    
    if (indexPath.row < data_array.count)
    {
        [data_array removeObjectAtIndex:indexPath.row];
        [_mainTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


#pragma mark - UITextViewDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
//    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:textView.tag-100 inSection:0];
//    [_mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //碰到换行，键盘消失
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    if (textView.text.length > 0) {
        placeHolder_treatment_case.text = @"";
    }else
    {
        placeHolder_treatment_case.text = @"治疗方案";
    }
    
    return YES;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"uploadData" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];    
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
