//
//  LCPublicAlertView.m
//  LongChain
//
//  Created by FengZi on 2018/4/12.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "LCPublicAlertView.h"
#define SWidth [UIScreen mainScreen].bounds
@implementation LCPublicAlertView


+ (instancetype)alertInstance {
    
    LCPublicAlertView *alert = [[self alloc]init];
    return alert;
//    static dispatch_once_t onceToken;
//    static LCPublicAlertView *alertView = nil;
//    dispatch_once(&onceToken, ^{
//        alertView = [[self alloc]init];
//        alertView.backgroundColor = RGBAlpha(0, 0, 0, 0.3);
//    });
//    return alertView;
}
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    
    LCPublicAlertView *alert = [[LCPublicAlertView alloc]init];
    alert.frame = [UIScreen mainScreen].bounds;
    alert.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
    [[UIApplication sharedApplication].keyWindow addSubview:alert];

    
    UIView *baseView = [[UIView alloc]init];
    baseView.backgroundColor = [UIColor redColor];
    baseView.layer.cornerRadius = 5.0f;
    baseView.layer.masksToBounds = YES;
    [alert addSubview:baseView];
    
    CGRect titleRect = [title boundingRectWithSize:CGSizeMake(alert.frame.size.width - 40, 1000) options:NSStringDrawingUsesFontLeading attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} context:nil];
    NSLog(@"height = %f",CGRectGetHeight(titleRect));
    
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(alert);
        make.left.mas_equalTo(alert).offset(20);
        make.right.mas_equalTo(alert).offset(-20);
        make.height.mas_equalTo((CGRectGetHeight(titleRect) + 100));

    }];

    //  message
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:12.0f];
    messageLabel.textColor = [UIColor lightTextColor];
    messageLabel.textAlignment = NSTextAlignmentLeft;
    messageLabel.numberOfLines = 0;
    [baseView addSubview:messageLabel];

    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(baseView);
        make.left.mas_equalTo(baseView).offset(20);
        make.right.mas_equalTo(baseView).offset(-20);

    }];

    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [baseView addSubview:titleLabel];

    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(alert.mas_centerX);
        make.bottom.mas_equalTo(messageLabel.mas_top).offset(-15);
    }];
//
    
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
