//
//  WDAlipayAuthResultVC.h
//  WDJR
//  芝麻授权结果页
//  Created by FengZi on 2018/4/11.
//  Copyright © 2018年 WANDAPUHUI. All rights reserved.
//

#import "UIKit/UIKit.h"
#import <Masonry/Masonry.h>
typedef NS_ENUM(NSInteger, AlipayAuthResult){
    /*  授权成功  */
    AlipayAuthResultSuccess,
    /*  未授权  */
    AlipayAuthResultUnauthorized,
    /*  未知  */
    AlipayAuthResultUnknow
};
@interface WDAlipayAuthResultVC : UIViewController

@property (nonatomic, assign) AlipayAuthResult authResult;

@end
