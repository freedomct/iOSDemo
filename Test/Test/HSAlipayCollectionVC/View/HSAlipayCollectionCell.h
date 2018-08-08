//
//  HSAlipayCollectionCell.h
//  HSShopC
//  阿里收款码  cell
//  Created by fengzi on 2018/8/2.
//  Copyright © 2018年 HS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSAlipayCollectionModel.h"

typedef void(^TextFieldDidChange)(id result);

@interface HSAlipayCollectionCell : UICollectionViewCell

//@property (nonatomic, strong) HSAccountTextField *textField;

@property (nonatomic, strong) UIButton *verificationCodeButton;

@property (nonatomic, copy) TextFieldDidChange textFieldTextChange;

@property (nonatomic, strong) HSAlipayCollectionModel *model;

@property (nonatomic, strong) UILabel *leftViewLabel;

@property (nonatomic, strong) UIView *rightView;

- (void)updateAlipayCollectionCellWithModel:(HSAlipayCollectionModel *)model;

@end
