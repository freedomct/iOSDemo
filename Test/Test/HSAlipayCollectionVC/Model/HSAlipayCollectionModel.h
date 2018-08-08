//
//  HSAlipayCollectionModel.h
//  HSShopC
//
//  Created by fengzi on 2018/8/2.
//  Copyright © 2018年 HS. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM (NSInteger, AlipayCellType){
    AlipayCellTypeUserName,
    AlipayCellTypeUserAccount,
    AlipayCellTypeUserPhone,
    AlipayCellTypeUserVerificationCode
};

@interface HSAlipayCollectionModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, assign) AlipayCellType alipayCellType;

@end
