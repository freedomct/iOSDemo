//
//  CustomTextField.h
//  Test
//
//  Created by fengzi on 2018/7/29.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TextChange) (id result);

@interface CustomTextField : UIView

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) TextChange changeHandler;

@end
