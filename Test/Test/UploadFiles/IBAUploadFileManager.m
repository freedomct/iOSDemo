//
//  IBAUploadFileManager.m
//  IBABoss
//
//  Created by Yun on 16/8/16.
//  Copyright © 2016年 IBA. All rights reserved.
//

#import "IBAUploadFileManager.h"
#import <AFNetworking/AFNetworking.h>
@implementation IBAUploadFileManager

#pragma mark - - 单例
+ (IBAUploadFileManager *)uploadManager
{
    static dispatch_once_t onceToken;
    static id uploadManager;
    dispatch_once(&onceToken, ^{
        
        uploadManager = [[self alloc]init];
        
    });
    return uploadManager;
}

#pragma mark - - upload
- (void)uploadFile:(id)uploadFile
              Path:(NSString *)seriviceURL
          mimeType:(NSString *)mimeTypeStr
              name:(NSString *)nameStr
              Name:(NSString *)fileNameStr
         parameter:(id)uploadParameter
      successBlock:(void (^)(id sender))uploadSuccessBlock
         failBlock:(void (^)(id sender))uploadFailBlock
{
    if (!uploadFile || [uploadFile isKindOfClass:[NSNull class]]) {
        NSLog(@"==========\n\n\n\n文件不存见或为空\n\n\n\n==========");
        return;
    }
    NSData *uploadData = nil;
    if ([uploadFile isKindOfClass:[UIImage class]]) {
        /*image*/
        uploadData = UIImageJPEGRepresentation(uploadFile, 0.1);
    }else if ([uploadFile isKindOfClass:[NSString class]]){
        /*文件路径/文件名*/
        if ([uploadFile rangeOfString:@"/"].location != NSNotFound) {
            
            UIImage *uploadImage = [UIImage imageWithContentsOfFile:uploadFile];
            uploadData = UIImageJPEGRepresentation(uploadImage, 0.1);
            
        }else{
            
            UIImage *uploadImage = [UIImage imageNamed:uploadFile];
            uploadData = UIImageJPEGRepresentation(uploadImage, 0.1);
            
        }
    }else if ([uploadFile isKindOfClass:[NSData class]]){
        /*二进制文件*/
        uploadData = uploadFile;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [self checkTrackIDForHeaderWithManager:manager];
    
    
    [manager POST:seriviceURL parameters:uploadParameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:uploadData name:nameStr fileName:fileNameStr mimeType:mimeTypeStr];
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        uploadSuccessBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        uploadFailBlock(error.userInfo);
    }];
}

#pragma mark - - HTTPHeader Setting
-(void)checkTrackIDForHeaderWithManager:(AFHTTPSessionManager *)manager{
    
//    NSString *trackIDStr =  [[IBAUserModel sharedInstance]getTrackId];
//    if (![trackIDStr isKindOfClass:[NSNull class]] && trackIDStr.length > 0) {
//        [manager.requestSerializer setValue:trackIDStr forHTTPHeaderField:@"trackId"];
//    }else{
//
//        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"trackId"];
//
//    }
//    [manager.requestSerializer setValue:@"3" forHTTPHeaderField:@"channel"];
    
}

@end
