//
//  WebViewTest.m
//  Test
//
//  Created by FengZi on 2018/3/21.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "WebViewTest.h"

@interface WebViewTest ()<WKScriptMessageHandler>

@end

@implementation WebViewTest

- (void)viewDidLoad {

//    NSString *urlStr = @"http://10.53.145.194:16020/h5/appview/#/mgm";
    self.urlStr = @"https://www.baidu.com/";
//    NSString *urlStr = @"http://10.53.147.46:8088/#/mgm";

//    self.urlStr = @"http://10.53.145.194:16020/h5/appview/#/mgm";
//    self.urlStr = @"https://www.baidu.com/";

//    self.scriptMessages = @[@"getInfo",@"login"];
    self.scriptMessages = [NSMutableArray arrayWithObject:@"getInfo"];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scriptMessages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:obj];
    }];
}
- (void)addUserScriptWithName:(NSString *)name {
    
    [self.config.userContentController addScriptMessageHandler:self name:name];

}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"body = %@",message.body);
    NSString *script = message.body[@"successCallbackFuncName"];
    NSString *action = [NSString stringWithFormat:@"%@(123)",script];
    [self.wkWebView evaluateJavaScript:action completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@",result);
        
    }];
    
    [userContentController addScriptMessageHandler:self name:script];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
