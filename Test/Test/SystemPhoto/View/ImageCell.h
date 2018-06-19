//
//  ImageCell.h
//  Test
//
//  Created by FengZi on 2018/4/24.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface ImageCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;

- (void)updateCellWithImage:(UIImage *)image ;

@end
