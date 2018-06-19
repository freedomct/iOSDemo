//
//  IBAUploadFileManager.h
//  IBABoss
//
//  Created by Yun on 16/8/16.
//  Copyright © 2016年 IBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBAUploadFileManager : NSObject


/**
 *  @author Yun
 *
 *  上传单例
 *
 *  @return 返回当前上传类本身
 */
+ (IBAUploadFileManager *)uploadManager;


/**
 *  @author Yun
 *
 *  上传图片文件
 *
 *  @param uploadFile         需上传的文件 type: image data str
 *  @param seriviceURL         服务器路径
 *  @param mimeTypeStr        mimeType
 *  @param nameStr            名称
 *  @param fileNameStr        文件名
 *  @param uploadParameter    参数
 *  @param uploadSuccessBlock 上传成功回调
 *  @param uploadFailBlock    上传失败回调
 */
- (void)uploadFile:(id)uploadFile
              Path:(NSString *)seriviceURL
          mimeType:(NSString *)mimeTypeStr
              name:(NSString *)nameStr
              Name:(NSString *)fileNameStr
         parameter:(id)uploadParameter
      successBlock:(void (^)(id sender))uploadSuccessBlock
         failBlock:(void (^)(id sender))uploadFailBlock;



@end
