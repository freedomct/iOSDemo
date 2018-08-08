//
//  ViewController.m
//  Test
//
//  Created by FengZi on 2018/3/19.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>
#import "Header.h"
#import <Masonry/Masonry.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "MainCell.h"

#import "FirstVC.h"
#import "TableViewVC.h"
#import "JudgeStringNumVC.h"
#import "SearchController.h"
#import "AVCaptureSessionVC.h"
#import "SystemPhotos.h"

@interface ViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//@property (nonatomic, strong) UIWebView *webView;
//@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (weak, nonatomic) IBOutlet UIButton *testButton;
@property (nonatomic, strong) UITableView *loanListTableView;


@property (nonatomic, copy) NSString *action;

@property (nonatomic, assign) BOOL updateStatusBar;

@property (nonatomic, strong) NSArray *datas;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSInteger section = 12;
    NSLog(@"%ld",(long)(section = 12));
    NSLog(@"%ld",(long)(section == 12));



    
//    _datas = @[
//               @[@"1",@"2",@"3",@"4",@"5"],
//               @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"]
//               ];
    
    _datas = @[@"1、WKWebView",@"2、TableView",@"3、ReactiveCocoa",@"4、自定义饼图",@"5、自定义Alert 弹窗",@"6、获取开机时间",@"7、跳转到指定的VC",@"8、UITableView",@"9、判断字符串是否有小数",@"10、弹出搜索",@"11、图片列表",@"12、多线程",@"13、lottie",@"14、CustomActionSheet",@"15、CustomPickView",@"16、输入框控制光标",@"17、调用系统 摄像头扫描二维码",@"18、获取系统相册图片",@"19、Masonry Test",@"20、自定义 UITextField"];
    
//    [self.collectionView registerClass:[Header class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
//    [config.userContentController addScriptMessageHandler:self name:@"getInfo"];
//    _wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 100) configuration:config];
//    [self.view addSubview:_wkWebView];
//    NSString *urlStr = @"https://www.baidu.com";
////    NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"demo3.html" ofType:nil];
//
////    NSURL *url = [[NSURL alloc]initFileURLWithPath:urlStr];
//    NSURL *url = [NSURL URLWithString:urlStr];
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
//    _wkWebView.UIDelegate = self;
//    _wkWebView.navigationDelegate = self;
//    [_wkWebView loadRequest:request];
//    UIWebView *webview = [[UIWebView alloc]initWithFrame:self.view.frame];
//    webview.backgroundColor = [UIColor redColor];
//    NSString *urlStr = @"https://www.baidu.com";
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLRequest *reques = [NSURLRequest requestWithURL:url];
//    [webview loadRequest:reques];
//    [self.view addSubview:webview];
    
//    NSString *origin = @"https://www.baidu.com";
//    NSString *result = [origin stringByAppendingPathComponent:@"yang"];
////    NSString *last = [NSString stringWithFormat:@"%@yan",origin];
//    NSLog(@"result = %@",result);
////    NSLog(@"last = %@",last);
//
//    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
////    NSLog(@"paths = %@",paths);
//    NSString *path = [paths[0] stringByAppendingPathComponent:@"yang"];
//    NSLog(@"path = %@",path);
    
    
//    NSString *phoneNum = @"13615291094";
//    [phoneNum stringByPaddingToLength:12 withString:@"yang" startingAtIndex:0];
//    NSLog(@"phoneNum = %@ length = %ld",phoneNum,phoneNum.length);
//    UIImageView *arrow = [[UIImageView alloc]init];
//    arrow.contentMode = UIViewContentModeScaleAspectFit;
//
//    arrow.image = [UIImage imageNamed:@"cel_ic_more"];
//    arrow.backgroundColor = [UIColor redColor];
//    [self.view addSubview:arrow];
//    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(self.view.mas_top).offset(100);
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//    }];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
    
    //去掉导航栏底部的黑线
//    UIImage *image = [UIImage new];
//
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//
//
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        Header *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
//        header.backgroundColor = [UIColor redColor];
//        return header;
//    }
//    return nil;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (_datas.count > row) {
        [cell updateCellWithDesTitle:_datas[row]];
    }
    return cell;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _datas.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    return CGSizeMake(CGRectGetWidth(self.view.frame), 50);

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击");
    NSInteger row = [indexPath row];
    switch (row) {
        case 0:  // WKWebview
        {
            
        }
            break;
        case 1:  //  UITableView
        {
            TableViewVC *tableView = [[TableViewVC alloc]init];
            [self.navigationController pushViewController:tableView animated:YES];
        }
            break;
        case 2: //  ReactiveCocoa
        {
            [self performSegueWithIdentifier:@"showReactiveCocoa" sender:self];
        }
            break;
        case 3:  //  饼图
        {
            [self performSegueWithIdentifier:@"showChart" sender:self];
        }
            break;
        case 4:  //  自定义 alert
        {
            [self performSegueWithIdentifier:@"showAlert" sender:self];
        }
            break;
        case 5:  //  获取开机时间
        {
            [self performSegueWithIdentifier:@"showDeviceOpenTime" sender:self];

        }
            break;
        case 6:  //  跳转到指定的VC
        {
            FirstVC *first = [[FirstVC alloc]init];
            [self.navigationController pushViewController:first animated:YES];
        }
            break;
        case 7:  //  UITableView
        {
            TableViewVC *tableView = [[TableViewVC alloc]init];
            [self.navigationController pushViewController:tableView animated:YES];
            
            
        }
            break;
        case 8:
        {
            JudgeStringNumVC *judge = [[JudgeStringNumVC alloc]init];
            [self.navigationController pushViewController:judge animated:YES];
            
        }
            break;
        case 9:  // searchBar
        {
            SearchController *searchVC = [[SearchController alloc]init];
            [self.navigationController pushViewController:searchVC animated:YES];
//            [self presentViewController:searchVC animated:NO completion:nil];
            
        }
            break;
        case 10:  //  设置buttonContentView
        {
            [self performSegueWithIdentifier:@"showPhotoLists" sender:self];
        }
            break;
        case 11:  //  多线程
        {
            [self performSegueWithIdentifier:@"showThread" sender:self];
        }
            break;
        case 12:  //  lottie 动画
        {
            NSLog(@"lottie 动画");
        }
            break;
        case 13:  //  CustomActionSheet
        {
            [self performSegueWithIdentifier:@"showCustomAction" sender:self];
        }
            break;
        case 14:  //  CustomPickView
        {
            [self performSegueWithIdentifier:@"showPickView" sender:self];
        }
            break;
        case 15:  //  自定义输入框光标 位置
        {
            [self performSegueWithIdentifier:@"showCursorChange" sender:self];
        }
            break;
        case 16:  //  调用系统摄像头扫描二维码
        {
            NSLog(@"扫描");
            
            AVCaptureSessionVC *captureSession = [[AVCaptureSessionVC alloc]init];
            [self.navigationController pushViewController:captureSession animated:YES];
        }
            break;
        case 17:  //  获取系统相册 及图片
        {
            SystemPhotos *photos = [[SystemPhotos alloc]init];
            [self.navigationController pushViewController:photos animated:YES];
        }
            break;
        case 18:  //  masonry demo
        {
            [self performSegueWithIdentifier:@"showMansoyDemo" sender:self];
        }
            break;
        case 19:  //  设置TextField
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - - json 转 Dic
- (id)jsonToDic:(id)jsonStr
{
    NSAssert([jsonStr isKindOfClass:[NSString class]], @"转换的参数不正确");
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *jsonError;
    NSDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    NSAssert(jsonStr, @"解析失败,请检查传入的json字符串格式或是否为空");
    
    return tempDic;
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"开始加载 didStartProvisionalNavigation");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"有内容返回 didCommitNavigation %f",webView.estimatedProgress);
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    NSLog(@"页面加载完成 didFinishNavigation");
//    [webView evaluateJavaScript:@"toCallAppFunc1()" completionHandler:^(id result, NSError * _Nullable error) {
//
//        NSLog(@"%@ %@",result,error);
//        // 接受返回的参数，result中
//
//    }];
    [webView evaluateJavaScript:@"getInfo()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didFailProvisionalNavigation");

}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"");
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}


#pragma mark - WKUIDelegate
// 创建一个新的WebView
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
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
    NSLog(@"%@",message);
    completionHandler();
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:message.body];
    NSLog(@"message = %@",dic);
    NSString *action = [dic objectForKey:@"successCallbackFuncName"];
    _action = action;
    
}

- (IBAction)test:(id)sender {
    
    _updateStatusBar = !_updateStatusBar;
    [self setNeedsStatusBarAppearanceUpdate];
//    [_wkWebView reload];    
//        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"successCallbackFuncName('')",@"123"]];
    NSString *js = [NSString stringWithFormat:@"%@(\'%@\')", _action,@"123"];
    [_wkWebView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"result = %@ error = %@",result,error);
    }];

    

}


- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if (_updateStatusBar) {
        return UIStatusBarStyleDefault;

    }else{
        return UIStatusBarStyleLightContent;

    }
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
