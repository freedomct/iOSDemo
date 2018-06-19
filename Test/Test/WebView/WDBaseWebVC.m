//
//  WDBaseWebVC.m
//  WDJR
//
//  Created by fengzi on 2018/1/22.
//  Copyright © 2018年 fengzi. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "WDBaseWebVC.h"

@interface WDBaseWebVC ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, copy) NSString *action;

@property (nonatomic, strong) UIProgressView *progressView;


@end

@implementation WDBaseWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self webViewConfig];
}

- (void)webViewConfig {
    
    
    
    if (!_config) {
        
        _config = [[WKWebViewConfiguration alloc]init];
    }
    if (_scriptMessages.count > 0) {
        
        [_scriptMessages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *scriptMessage = [NSString stringWithFormat:@"%@",obj];
            [_config.userContentController addScriptMessageHandler:self name:scriptMessage];
            
        }];
        
    }
    _wkWebView = [[WKWebView alloc]initWithFrame:self.view.frame configuration:_config];
    [self.view addSubview:_wkWebView];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    _wkWebView.UIDelegate = self;
    _wkWebView.navigationDelegate = self;
    [_wkWebView loadRequest:request];
    
    
    self.progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.progress = 0.0;
//    self.progressView.progressViewStyle = UIProgressViewStyleBar;
    self.progressView.progressTintColor = [UIColor redColor];
    self.progressView.trackTintColor = [UIColor blackColor];
    [self.view addSubview:self.progressView];

}

#pragma mark - - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"开始加载 didStartProvisionalNavigation");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"有内容返回 didCommitNavigation %f",webView.estimatedProgress);
    [self.progressView setProgress:webView.estimatedProgress animated:YES];
    

    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    NSLog(@"页面加载完成 didFinishNavigation");
    [self.progressView setProgress:1 animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.progressView.hidden = YES;

    });

}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
    NSLog(@"didFailProvisionalNavigation");
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
    NSLog(@"yangyangyangyangyangyang");
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - - WKUIDelegate
// 创建一个新的WebView
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
//
//    return [[WKWebView alloc]init];
//}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"message = %@",message);
    
    completionHandler();
}

#pragma mark - - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSDictionary *resultDic = [NSDictionary dictionaryWithDictionary:message.body];
    NSLog(@"resultDic =%@",resultDic);
    self.interaction(resultDic);
    
}

#pragma mark - - CustomMethods
- (void)reloadWebview {
    
}

- (void)clickBackNav {
    
    if (self.wkWebView.backForwardList.backList.count > 0) {
        [self.wkWebView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
