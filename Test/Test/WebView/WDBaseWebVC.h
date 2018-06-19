//
//  WDBaseWebVC.h
//  WDJR
//  网页基类
//  Created by fengzi on 2018/1/22.
//  Copyright © 2018年 fengzi. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InteractiveType) {
    InteractiveTypeLogin,
    InteractiveTypeUserInfo,
    InteractiveTypeShare
};

typedef void(^InteractiveBlock)(id parameter);

@interface WDBaseWebVC : UIViewController

/**
 需要执行的script 语句集合
 */
@property (nonatomic, strong) NSArray *scriptMessages;

/**
 需要加载的链接
 */
@property (nonatomic, copy) NSString *urlStr;

/**
 webview 配置 如未设置 将使用默认的配置
 */
@property (nonatomic, strong) WKWebViewConfiguration *config;


@property (nonatomic, assign) InteractiveBlock interaction;

@property (nonatomic, strong) WKWebView *wkWebView;


/**
 重新加载页面
 */
- (void)reloadWebview;
@end
