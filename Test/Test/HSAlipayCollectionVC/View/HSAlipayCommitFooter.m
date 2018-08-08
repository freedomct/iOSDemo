//
//  HSAlipayCommitFooter.m
//  HSShopC
//
//  Created by fengzi on 2018/8/3.
//  Copyright © 2018年 HS. All rights reserved.
//

#import "HSAlipayCommitFooter.h"
#import <Masonry/Masonry.h>
@implementation HSAlipayCommitFooter

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.backgroundColor = [UIColor redColor];
        _commitButton.enabled = YES;
        [_commitButton setTitle:@"yang" forState:UIControlStateNormal];
        [_commitButton setTitle:@"yang" forState:UIControlStateSelected];
        [_commitButton addTarget:self action:@selector(commitUserCollectionInfo) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commitButton];
        
        [_commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(44);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)updateAlipayCommitFooter:(BOOL)enable {
    

    _commitButton.enabled = enable;
}

- (void)commitUserCollectionInfo {
    NSLog(@"提交用户收款信息");
    if (self.commitUserCollectionHandler) {
        self.commitUserCollectionHandler();
    }
}
@end
