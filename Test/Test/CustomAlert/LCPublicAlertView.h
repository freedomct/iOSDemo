//
//  LCPublicAlertView.h
//  LongChain
//
//  Created by FengZi on 2018/4/12.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
@interface LCPublicAlertView : UIView

+ (instancetype)alertInstance;

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
