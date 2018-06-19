//
//  CommentImageCell.m
//  MasonryDemo
//
//  Created by FengZi on 09/11/2017.
//  Copyright © 2017 yang. All rights reserved.
//

#import "CommentImageCell.h"
#import <Masonry/Masonry.h>
@implementation CommentImageCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 创建一个UIImageView控件
        // 将UILabel控件添加到该单元格中
        self.commentImage = [[UIImageView alloc]init];
        self.commentImage.image = [UIImage imageNamed:@"cam"];
        self.commentImage.frame = CGRectMake(2, 2, CGRectGetWidth(self.contentView.frame) - 4, CGRectGetHeight(self.contentView.frame) - 4);
        [self.contentView addSubview:self.commentImage];
        // 设置边框
        // 设置圆角
        self.layer.cornerRadius = 8.0;
        self.layer.masksToBounds = YES;
        
        _delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delButton addTarget:self action:@selector(delSelectedImage) forControlEvents:UIControlEventTouchUpInside];
        _delButton.hidden = YES;
        [_delButton setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        [_delButton setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];

        [self addSubview:_delButton];
        
        [_delButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.mas_top).with.offset(-2);
            make.right.equalTo(self.mas_right).with.offset(2);
        }];
    }
    return self;
}


- (void)updateCommentWithParameter:(id)parameter
{
    if (parameter) {
        self.commentImage.image = parameter;
        _delButton.hidden = NO;
        NSLog(@"修改图片");

    }else{
        
        UIImage *defaultImage = [UIImage imageNamed:@"cam"];
        self.commentImage.image = defaultImage;

    }
}

- (void)delSelectedImage {
    
    if (self.delBlock) {
        self.delBlock();
    }
}
@end
