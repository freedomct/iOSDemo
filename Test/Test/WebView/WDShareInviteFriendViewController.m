//
//  WDShareInviteFriendViewController.m
//  WDJR
//
//  Created by 吴晨 on 2018/1/18.
//  Copyright © 2018年 WANDAPUHUI. All rights reserved.
//  分享好友二维码页面

#import "WDShareInviteFriendViewController.h"
#import "WDShareInviteFriendBtnView.h" // 底部按钮的view视图

#import "SGQRCodeGenerateManager.h" // 生成二维码【第三方】
#define SCREEN_WIDTH              ([UIScreen mainScreen].bounds.size.width)
#define kScaleH  SCREEN_HEIGHT / 667.0f  // 4.7屏幕高度尺寸比例
#define kSafeAreaTopHeight (SCREEN_HEIGHT == 812.0 ? 88 : 64)
#define SCREEN_HEIGHT             ([UIScreen mainScreen].bounds.size.height)
#define kScaleW  SCREEN_WIDTH / 375.0     // 4.7屏幕宽度尺寸比例

@interface WDShareInviteFriendViewController () <WDShareInviteFriendBtnViewDelegate>

@property (nonatomic, strong) UIImageView *qrImageView; // 二维码图片

@end

@implementation WDShareInviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 由于该页面是模态出来的,UI展示是一个有背景的图片,只能定制每个手机不一样的尺寸
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"share_pic_background_%d",(int)SCREEN_HEIGHT]]];
    
    [self display];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self defineUIStatusBarStyleDefault];
    // 视图出现的时候,隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 视图移除的时候显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建UI视图
- (void)display {
    // QRCodeWhiteView【二维码大背景视图】
    UIView *QRCodeWhiteView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 256 * kScaleW) / 2.0f, 102 * kScaleH, 256 * kScaleW, 281 * kScaleW)];
    QRCodeWhiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:QRCodeWhiteView];
    
    // qrImageView【二维码】
    _qrImageView = [[UIImageView alloc] init];
    [QRCodeWhiteView addSubview:_qrImageView];
    [_qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(QRCodeWhiteView).offset(24 * kScaleW);
        make.right.equalTo(QRCodeWhiteView).offset(-24 * kScaleW);
        make.bottom.equalTo(QRCodeWhiteView).offset(-49 * kScaleW);
    }];
    
    // 扫码注册·额度最高5万元
    UILabel *introduceLabel = [[UILabel alloc] init];
    introduceLabel.text = @"扫码注册·额度最高5万元";
    introduceLabel.textColor = [UIColor blackColor];
    introduceLabel.font = [UIFont systemFontOfSize:12];
    introduceLabel.textAlignment = NSTextAlignmentCenter;
    [QRCodeWhiteView addSubview:introduceLabel];
    [introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(QRCodeWhiteView);
        make.bottom.equalTo(QRCodeWhiteView).offset(-19);
        make.height.mas_equalTo(14);
    }];
    
    // 通过链接地址linkUrl展示二维码图片
    _qrImageView.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:@"https://www.baidu.com" imageViewWidth:150];
    
    

    
    // shareBtnView【分享视图】
    WDShareInviteFriendBtnView *shareBtnView = [[WDShareInviteFriendBtnView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 184 * 10, SCREEN_WIDTH, 184 * 10) sharePlatformNames:@[@"朋友圈",@"微信好友",@"QQ好友",@"QQ空间"] platformImages:@[@"icon_inviteshare_wechatquan",@"icon_inviteshare_wechat",@"icon_inviteshare_qq",@"icon_inviteshare_qqspace"]];
    
    shareBtnView.delegate = self;
    [self.view addSubview:shareBtnView];
    
    shareBtnView.sharePlatform = ^(NSInteger shareIndex){
        switch (shareIndex) {
            case 0: {
                // 微信好友
//                [weakSelf sharePlatformState:SSDKPlatformSubTypeWechatTimeline ShareIndex:@"2"];
            }
                break;
            case 1: {
                // 朋友圈
//                [weakSelf sharePlatformState:SSDKPlatformSubTypeWechatSession ShareIndex:@"3"];
            }
                break;
            case 2: {
                // qq好友
//                [weakSelf sharePlatformState:SSDKPlatformSubTypeQQFriend ShareIndex:@"4"];
            }
                break;
            case 3: {
                // qq空间
//                [weakSelf sharePlatformState:SSDKPlatformSubTypeQZone ShareIndex:@"5"];
            }
                break;
            default:
                break;
        }
    };
}

#pragma mark - WDShareInviteFriendBtnViewDelegate
- (void)wdShareInviteFriendBtnViewCliked:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:NULL]; // 点击"X"移除当前视图
}

#pragma mark - public
//- (void)sharePlatformState:(SSDKPlatformType)platformType
//                ShareIndex:(NSString *)shareIndex
//{
//    // 分享的信息
//    kweakSelf;
//
//    // 生成链接地址
//    NSString *linkUrl = [NSString stringWithFormat:@"%@tel=%@&type=%@&clientName=%@",[WDConfiguration shareConfig].MGMShareUrlStr,[UserAgent mobileNum],shareIndex,[Tool numberSuitScanf:[UserAgent mobileNum]]];
//    // 这里对分享的url中文进行处理,否则shareSDK分享不出去,主要是对中文进行encode编码
//    linkUrl = [linkUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
//    // 通过链接地址展示二维码图片
//    UIImage *shareQRCodeImage = [UIImage imageNamed:@"icon_share_introduce.png"];
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:CONTENT_TEXT images:@[shareQRCodeImage] url:[NSURL URLWithString:linkUrl] title:SHARE_TITLE type:SSDKContentTypeWebPage];
//    [ShareSDK share:platformType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//        switch (state) {
//            case SSDKResponseStateBegin:
//            {    // 设置UI等操作
//                break;
//            }
//            case SSDKResponseStateSuccess:
//            {
//                // 分享成功之后移除
//                [weakSelf dismissViewControllerAnimated:YES completion:NULL];
//                break;
//            }
//            case SSDKResponseStateCancel:
//            {
//                // 取消分享
//                [weakSelf showException:@"分享取消"];
//                break;
//            }
//            case SSDKResponseStateFail:
//            {
//                NSLog(@"error:%@",error);
//                [Tool showAlert:@"分享失败" message:[NSString stringWithFormat:@"%@",error]];
//                [weakSelf dismissViewControllerAnimated:YES completion:NULL];
//                break;
//            }
//
//            default:
//                break;
//        }
//    }];
//}

@end

