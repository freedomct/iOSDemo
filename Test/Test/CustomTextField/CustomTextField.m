//
//  CustomTextField.m
//  Test
//
//  Created by fengzi on 2018/7/29.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "CustomTextField.h"
#import <Masonry/Masonry.h>
@interface CustomTextField()<UITextFieldDelegate>

@end
@implementation CustomTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createCustomTextField];
    }
    return self;
}

- (void)createCustomTextField {
    _textField = [[UITextField alloc]init];
    _textField.borderStyle = UITextBorderStyleBezel;
    _textField.placeholder = @"test";
    _textField.delegate = self;
    [self addSubview:_textField];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
    UILabel *leftView = [[UILabel alloc]init];
    leftView.text = @"yang";
    leftView.backgroundColor = [UIColor redColor];
    leftView.textColor = [UIColor blackColor];
    leftView.frame = CGRectMake(0, 100, 60, 40);
    _textField.leftView = leftView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *rightView = [[UILabel alloc]init];
    rightView.text = @"yang";
    rightView.backgroundColor = [UIColor redColor];
    rightView.textColor = [UIColor blackColor];
    rightView.frame = CGRectMake(0, 0, 50, 50);
    _textField.rightView = rightView;
    _textField.rightViewMode = UITextFieldViewModeAlways;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChangeHandler) name:UITextFieldTextDidChangeNotification object:nil];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textDidChangeHandler {
    if (self.changeHandler) {
        self.changeHandler(_textField.text);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
