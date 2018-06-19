
//
//  Footer.m
//  MasonryDemo
//
//  Created by FengZi on 09/11/2017.
//  Copyright © 2017 yang. All rights reserved.
//

#import "Footer.h"
#import <Masonry/Masonry.h>
@implementation Footer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
        
        submit.backgroundColor = [UIColor colorWithRed:193.0/255.0 green:28.0/255.0 blue:28.0/255.0 alpha:1.0];

        [submit setTitle:@"提交" forState:UIControlStateNormal];
        [submit setTitle:@"提交" forState:UIControlStateSelected];
        [submit addTarget:self action:@selector(commentSubmit) forControlEvents:UIControlEventTouchUpInside];
        submit.tintColor = [UIColor whiteColor];
        submit.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        submit.layer.cornerRadius = 3.0f;
        [self addSubview:submit];

        [submit mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self).with.offset(10);
            make.bottom.equalTo(self).with.offset(-10);
            make.left.equalTo(self).with.offset(20);
            make.right.equalTo(self).with.offset(-20);
        }];
        
    }
    return self;
}

- (void)commentSubmit {
    
    self.submitBlock();
}
@end
