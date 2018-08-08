//
//  HSAlipayCollectionCell.m
//  HSShopC
//
//  Created by fengzi on 2018/8/2.
//  Copyright © 2018年 HS. All rights reserved.
//

#import "HSAlipayCollectionCell.h"
#import <Masonry/Masonry.h>
@implementation HSAlipayCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        UITextField *textField = [[UITextField alloc]init];
        textField.borderStyle = UITextBorderStyleBezel;
        textField.placeholder = @"test";
        [self addSubview:textField];

        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];


        UILabel *leftView = [[UILabel alloc]init];
        leftView.text = @"yang";
        leftView.backgroundColor = [UIColor redColor];
        leftView.textColor = [UIColor blackColor];
        leftView.frame = CGRectMake(0, 100, 60, 40);
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewModeAlways;

        UILabel *rightView = [[UILabel alloc]init];
        rightView.text = @"yang";
        rightView.backgroundColor = [UIColor redColor];
        rightView.textColor = [UIColor blackColor];
        rightView.frame = CGRectMake(0, 0, 50, 50);
        textField.rightView = rightView;
        textField.rightViewMode = UITextFieldViewModeAlways;

        
        
//        _textField = [[HSAccountTextField alloc]initWithPlaceholder:@""];
//        _textField.textChangeBlock = ^(id result) {
//            weakSelf.textFieldTextChange(result);
//        };
//        [self.contentView addSubview:_textField];
//        
//        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(20);
//            make.right.mas_equalTo(-20);
//            make.bottom.mas_equalTo(0);
//            make.height.mas_equalTo(44);
//        }];
//        
//        
//        _leftViewLabel = [[UILabel alloc]init];
//        _leftViewLabel.textColor = RGB(102.0f, 102.0f, 102.0f);
//        _leftViewLabel.font = [UIFont systemFontOfSize:15.0f];
//        _leftViewLabel.frame = CGRectMake(0, 0, 60, 44);
//        _textField.textField.leftView = _leftViewLabel;
//        _textField.textField.leftViewMode = UITextFieldViewModeAlways;
//        
//        _rightView = [[UIView alloc]init];
//        _rightView.frame = CGRectMake(0, 0, 80, 44);
//        _textField.textField.rightViewMode = UITextFieldViewModeAlways;
//
//        _verificationCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_verificationCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
//        [_verificationCodeButton setTitle:@"发送验证码" forState:UIControlStateSelected];
//        [_verificationCodeButton setTitleColor:RGB(201.0f, 201.0f, 201.0f) forState:UIControlStateNormal];
//        [_verificationCodeButton setTitleColor:RGB(201.0f, 201.0f, 201.0f) forState:UIControlStateSelected];
//        _verificationCodeButton.layer.cornerRadius = 15.0f;
//        _verificationCodeButton.enabled = NO;
//        _verificationCodeButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
//        _verificationCodeButton.layer.borderWidth = 1.0f;
//        _verificationCodeButton.layer.borderColor = RGB(201.0f, 201.0f, 201.0f).CGColor;
//        [_verificationCodeButton addTarget:self action:@selector(sendVerificationCode) forControlEvents:UIControlEventTouchUpInside];
//        [_rightView addSubview:_verificationCodeButton];
//        //        _verificationCodeButton.layer.borderColor = RGB(255.0f, 102.0f, 91.0f).CGColor;
//
//        [_verificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(0);
//            make.centerY.mas_equalTo(weakSelf.rightView.mas_centerY);
//            make.height.mas_equalTo(30);
//            make.width.mas_equalTo(100);
//        }];
    }
    return self;
}

- (void)updateAlipayCollectionCellWithModel:(HSAlipayCollectionModel *)model {
    
    
    _leftViewLabel.text = model.title;
//    _textField.text = model.text;
//    _textField.placeholder = model.placeholder;
    _model = model;
    switch (model.alipayCellType) {
        case AlipayCellTypeUserName:
        {
//            _textField.textField.keyboardType = UIKeyboardTypeDefault;

        }
            break;
        case AlipayCellTypeUserAccount:
        {
//            _textField.textField.keyboardType = UIKeyboardTypeEmailAddress;

        }
            break;
        case AlipayCellTypeUserPhone:
        {
//            _textField.textField.keyboardType = UIKeyboardTypeNumberPad;
        }
            break;
        case AlipayCellTypeUserVerificationCode:
        {
//            _textField.textField.keyboardType = UIKeyboardTypeNumberPad;
//            _textField.textField.rightView = _rightView;
        }
            break;
            
        default:
            break;
    }
    
}

- (void)sendVerificationCode {
    NSLog(@"发送验证码");
}
@end
