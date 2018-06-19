//
//  ImageCell.m
//  Test
//
//  Created by FengZi on 2018/4/24.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "ImageCell.h"
@implementation ImageCell


- (void)updateCellWithImage:(UIImage *)image {
    
    
    self.image.image = image;
//    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//
//    CGSize size =  CGSizeMake(image.pixelWidth, image.pixelHeight);
        // 从asset中获得图片
    
//        [[PHImageManager defaultManager] requestImageForAsset:image targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
////            NSLog(@"info = %@",info);
//            NSString *path = [NSString stringWithFormat:@"%@",info[@"PHImageFileURLKey"]];
//            self.image.image = [[UIImage alloc]initWithContentsOfFile:path];
//
//        }];
}
@end
