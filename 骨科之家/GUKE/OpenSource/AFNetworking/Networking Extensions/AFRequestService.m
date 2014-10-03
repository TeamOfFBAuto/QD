//
//  AFRequestService.m
//  WeiTongShi
//
//  Created by qidi on 14-6-3.
//  Copyright (c) 2014年 qidi. All rights reserved.
//

#import "AFRequestService.h"
#import "UserDefaultsCatch.h"
#import "Interface.h"
#import "MBProgressHUD.h"
#import "imgUploadModel.h"
@implementation AFRequestService
// 单纯的post请求
+(void)responseData:(NSString *)requestURL andparameters:(NSDictionary *)parameters andResponseData:(getDataBlock)getdata
{
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [manager POST:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            getdata(responseObject);
           
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        }];

}
// 最后个参数为联网请求失败执行的方法
+(void)responseData:(NSString *)requestURL andparameters:(NSDictionary *)parameters andResponseData:(getDataBlock)getdata andFailfailWithRequest:(failWithRequest)failRequest;
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        getdata(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failRequest();
    }];
    
}
// 上传单个附件
+ (void)responseDataWithImage:(NSString *)requestURL andparameters:(NSDictionary *)parameters andImageData:(NSData *)ImageData andfieldType:(NSString *)typeName andfileName:(NSString *)name andResponseData:(getDataBlock)getdata
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:requestURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:ImageData name:typeName fileName:name mimeType:@"image/jpeg"];
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        getdata(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
  
}
// 上传单个附件
+ (void)responseDataWithFile:(NSString *)requestURL andparameters:(NSDictionary *)parameters andImageData:(NSData *)ImageData andfieldType:(NSString *)typeName andfileName:(NSString *)name andMimeType:(NSString *)mimeTypeName andResponseData:(getDataBlock)getdata
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [manager POST:requestURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:ImageData name:typeName fileName:name mimeType:mimeTypeName];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        getdata(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSString *alertcontext = LOCALIZATION(@"tip_msg_neterror");
         NSString *alertText = LOCALIZATION(@"dialog_prompt");
        NSString *alertOk = LOCALIZATION(@"dialog_ok");
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertText message:alertcontext delegate:self cancelButtonTitle:alertOk otherButtonTitles:nil];
        [alert show];
    }];
    
}

+ (void)responseData:(NSString *)requestURL andparameters:(NSDictionary *)parameters andResponseData:(getDataBlock)getdata andCathtype:(int)type andID:(int)_id andtypeName:(NSString *)name
{
    if (IOS7_LATER) {
        // 使用userDefaults来存储用户账号关联的信息
        if ([UserDefaultsCatch getCache:type andID:_id andTypeName:name]) {
            id responseObject = (id)[UserDefaultsCatch getCache:type andID:_id andTypeName:name];
            getdata(responseObject);
        }
        AFNetAPIClient *manage1 = [AFNetAPIClient shareClient];
        manage1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [manage1 POST:requestURL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString *oldString = [NSString stringWithFormat:@"%@",[UserDefaultsCatch getCache:type andID:_id andTypeName:name]];
            NSString *newstring = [NSString stringWithFormat:@"%@",responseObject];
            // 如果没有缓存
            if (![UserDefaultsCatch getCache:type andID:_id andTypeName:name]){
                [UserDefaultsCatch saveCache:type andID:_id andTypeName:name andString:responseObject];
                getdata(responseObject);
            }
            else {
                if (![oldString isEqualToString:newstring]) {
                    // 用户网络数据发生变化，则更新本地的数据
                    [UserDefaultsCatch saveCache:type andID:_id andTypeName:name andString:responseObject];
                    // 发送通知，是否网络数据有变化，有变化重新加载数据
                    [[NSNotificationCenter defaultCenter] postNotificationName:IS_DATACHANG object:nil userInfo:nil];
                }
                else{
                    // 相等则返回
                    return;
                }
            }
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
           
        }];
        
    }
    else{
        if ([UserDefaultsCatch getCache:type andID:_id andTypeName:name]) {
            id responseObject = (id)[UserDefaultsCatch getCache:type andID:_id andTypeName:name];
            getdata(responseObject);
        }
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [manager POST:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            id oldResponseObject = (id)[UserDefaultsCatch getCache:type andID:_id andTypeName:name];
            if (![UserDefaultsCatch getCache:type andID:_id andTypeName:name]){
                [UserDefaultsCatch saveCache:type andID:_id andTypeName:name andString:responseObject];
                getdata(responseObject);
            }
            else {
                if (![oldResponseObject isEqual:responseObject]) {
                    // 用户网络数据发生变化，则更新本地的数据
                    [UserDefaultsCatch saveCache:type andID:_id andTypeName:name andString:responseObject];
                    // 发送通知，是否网络数据有变化，有变化重新加载数据
                    [[NSNotificationCenter defaultCenter] postNotificationName:IS_DATACHANG object:nil userInfo:nil];
                }
                else{
                    // 相等则返回
                    return;
                }
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
        }];
        
        
    }
}
+ (void)responseDataWithFirstWeb:(NSString *)requestURL andparameters:(NSDictionary *)parameters andResponseData:(getDataBlock)getdata andCathtype:(int)type andID:(int)_id
{
    // __weak
    if (IOS7_LATER) {
       
        AFNetAPIClient *manage1 = [AFNetAPIClient shareClient];
        manage1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [manage1 POST:requestURL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            
                // 用户网络数据发生变化，则更新本地的数据
                [UserDefaultsCatch saveCache:type andID:_id andString:responseObject];
                 getdata(responseObject);
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        id responseObject = (id)[UserDefaultsCatch getCache:type andID:_id];
                        getdata(responseObject);
        }];
        
    }
    else{
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [manager POST:requestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
                // 用户网络数据发生变化，则更新本地的数据
                [UserDefaultsCatch saveCache:type andID:_id andString:responseObject];
                getdata(responseObject);
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
                 id responseObject = (id)[UserDefaultsCatch getCache:type andID:_id];
                 getdata(responseObject);
            
        }];
        
        
    }
}

// 上传多个附件
+ (void)responseDataWithImage:(NSString *)requestURL andparameters:(NSDictionary *)parameters andDataArray:(NSMutableArray *)dataArray andfieldType:(NSString *)typeName andfileName:(NSString *)name andResponseData:(getDataBlock)getdata
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    // 上传进度
    MBProgressHUD *myProgressHUD = [[MBProgressHUD alloc] initWithWindow:[[[UIApplication sharedApplication] delegate] window]];
    myProgressHUD.mode = MBProgressHUDModeIndeterminate;
    myProgressHUD.animationType = MBProgressHUDAnimationZoom;
    [[[[UIApplication sharedApplication] delegate] window] addSubview:myProgressHUD];
    [[[[UIApplication sharedApplication] delegate] window] bringSubviewToFront:myProgressHUD];
    myProgressHUD.labelText = @"正在上传，请等待";
    [myProgressHUD show:YES];
    
    if (!dataArray.count) {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        [manager POST:requestURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            getdata(responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
    else{
           __block int i = 0;
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            [manager POST:requestURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
               
                for (id object in dataArray) {
                    i++;
                    
                    if ([object isKindOfClass:[NSDictionary class]]) {
                        
                        NSDictionary *dic = (NSDictionary *)object;
                        NSData *ImageData = [[NSData alloc] initWithContentsOfFile:[dic objectForKey:@"fileName"]];
                        NSString *tempVoice = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fid"]];
                        NSString *voiceName = [tempVoice stringByAppendingString:@".amr"];

                
                        [formData appendPartWithFileData:ImageData name:[NSString stringWithFormat:@"attach%d",i] fileName:voiceName mimeType:@"audio/amr"];
                    }
                    else{
                        NSData *ImageData = ((imgUploadModel *)object).imageData;
                        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
                        
                        NSString *imgName = [NSString stringWithFormat:@"%@",((imgUploadModel *)object).imageName];
                        [formData appendPartWithFileData:ImageData name:[NSString stringWithFormat:@"attach%d",i] fileName:imgName mimeType:@"image/jpeg"];
                        
                    }
                }
              
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [myProgressHUD hide:YES];
                if (i == dataArray.count) {
                    getdata(responseObject);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [myProgressHUD hide:YES];
            }];
            
        }
}

@end
