//
//  HSAlipayCommitFooter.h
//  HSShopC
//
//  Created by fengzi on 2018/8/3.
//  Copyright © 2018年 HS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommitUserCollectionCodeHandler)(void);

@interface HSAlipayCommitFooter : UICollectionReusableView


@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, copy) CommitUserCollectionCodeHandler commitUserCollectionHandler;

- (void)updateAlipayCommitFooter:(BOOL)enable;

@end
