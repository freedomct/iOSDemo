//
//  CommentImageCell.h
//  MasonryDemo
//
//  Created by FengZi on 09/11/2017.
//  Copyright © 2017 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DelSelectedImageBlock)(void);
@interface CommentImageCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *commentImage;

@property (nonatomic, strong) UIButton *delButton;

@property (nonatomic, copy) DelSelectedImageBlock delBlock;

- (void)updateCommentWithParameter:(id)parameter;


@end
