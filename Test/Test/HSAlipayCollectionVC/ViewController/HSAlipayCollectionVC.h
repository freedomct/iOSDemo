//
//  HSAlipayCollectionVC.h
//  HSShopC
//  阿里收款码
//  Created by fengzi on 2018/8/2.
//  Copyright © 2018年 HS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BindAliapyAccountHandler)(void);

@interface HSAlipayCollectionVC : UIViewController

@property (nonatomic, copy) BindAliapyAccountHandler bindAlipayHandler;

@end
