//
//  WDBaseViewController.m
//  WDJR
//
//  Created by owen du on 2017/12/27.
//  Copyright © 2017年 WANDAPUHUI. All rights reserved.
//

#import "WDBaseViewController.h"
#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SCREEN_WIDTH              ([UIScreen mainScreen].bounds.size.width)
#define kScaleH  SCREEN_HEIGHT / 667.0f  // 4.7屏幕高度尺寸比例
#define kSafeAreaTopHeight (SCREEN_HEIGHT == 812.0 ? 88 : 64)
#define SCREEN_HEIGHT             ([UIScreen mainScreen].bounds.size.height)
#define IOS_VERSION               [[[UIDevice currentDevice] systemVersion] floatValue]


@implementation ErrorBaseView

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setUp];
        [self addTarget:self action:@selector(clickSelf:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)setUp {
    
    _errorView = [[UIImageView alloc] init];
    [self addSubview:_errorView];
    _errorView.image = [UIImage imageNamed:@"pub_ic_state_nodate.png"];
    [_errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-80*kScaleH);
        make.width.mas_equalTo(80.f);
        make.height.mas_equalTo(80.f);
    }];
    
    _lbOfErrorViewTitle = [[UILabel alloc] init];
    _lbOfErrorViewTitle.textColor = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.30f];
    _lbOfErrorViewTitle.textAlignment = NSTextAlignmentCenter;
    _lbOfErrorViewTitle.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:_lbOfErrorViewTitle];
    [_lbOfErrorViewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.errorView.mas_bottom).offset(20*kScaleH);
        make.left.equalTo(self);
        make.right.equalTo(self);
    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(self.status == ErrorBaseViewModeStatusNoData){
        _errorView.image = [UIImage imageNamed:@"icon_none_data.png"];
        _lbOfErrorViewTitle.text = @"暂无数据";
    }
    else if(self.status == ErrorBaseViewModeStatusNoNet) {
        _errorView.image = [UIImage imageNamed:@"pub_ic_state_nonet.png"];
        _lbOfErrorViewTitle.text = @"网络异常";
    }
    else {
        _errorView.image = nil;
        _lbOfErrorViewTitle.text = @"";
    }
}

#pragma mark - Actions
- (void)clickSelf:(id)sender {
    
    if (self.status == ErrorBaseViewModeStatusNoNet) {
        //  todo
    }
}


@end

@interface WDBaseViewController ()

{
    MBProgressHUD *HUD;
    ErrorBaseView *errorView;
}

@property (nonatomic, assign) NSTimeInterval previousShowTime;

@end

@implementation WDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blueColor];
    
    // 隐藏阴影线
    [self hideNavBarWhiteShadowOpacity];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initNavBar];
}
- (void)getUnreadMessageRefresh {
    
}
- (void)initNavBar
{
    // 初始化导航栏
    if (self.navigationController.viewControllers.count > 1) {
        
//        [self.navigationController.navigationBar setBackgroundImage:[Tool createImageWithColor:KAPPBlueColor] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = NO;
        
        UIButton *  backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
        [backBtn addTarget:self action:@selector(clickBackNav) forControlEvents:UIControlEventTouchUpInside];
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backBtn setImage:[UIImage imageNamed:@"nav_ic_back_white"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"nav_ic_back_white_hlt"] forState:UIControlStateHighlighted];
        UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        [self defineUIStatusBarStyleLightContent];
        
    } else {
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:kUIColorFromRGB(0x353535)}];
        
        [self defineUIStatusBarStyleDefault];
    }
}

#pragma mark - network


- (void)showIsHaveMessageWithIsHasMessage:(BOOL)isHasMessage {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)defineUIStatusBarStyleLightContent
{
    // 白色状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)defineUIStatusBarStyleDefault
{
    // 黑色状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)showException:(NSString *)text
{
    if (text.length) {
        
        MBProgressHUD *hub = [[MBProgressHUD alloc] initWithView:self.view];
        hub.removeFromSuperViewOnHide = YES;
        hub.mode = MBProgressHUDModeText;
        hub.animationType = MBProgressHUDAnimationFade;
        hub.detailsLabel.text = text;
        if (IOS_VERSION >= 11.0) {
            hub.bezelView.color = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.752]; // hub的背景色
        } else {
            hub.bezelView.color = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.12]; // hub的背景色
        }
        hub.detailsLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
        hub.bezelView.layer.shadowRadius = 1.56f;
        hub.bezelView.layer.shadowColor = kUIColorFromRGB(0xFFCC01).CGColor;
        hub.bezelView.layer.shadowOpacity = 0.240f;
        hub.detailsLabel.textColor = [UIColor whiteColor]; // 异常文字字体颜色
        hub.offset = CGPointMake(0.f, MBProgressMaxOffset); // 放在底部
        [self.view addSubview:hub];
        [hub showAnimated:YES];
        [hub hideAnimated:YES afterDelay:2.0f];
    }
}

- (void)startLoadIng:(NSString *)text {
    if (text != nil) {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        HUD.bezelView.color = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.82];
        HUD.contentColor = [[UIColor whiteColor] colorWithAlphaComponent:0.78];
        HUD.userInteractionEnabled = YES;
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.label.text = text;
        HUD.label.textColor = [UIColor whiteColor];
        if (SCREEN_WIDTH == 320) {
            HUD.offset = CGPointMake(0.f, -50);
        }
        if (IOS_VERSION >= 9.0) {
            HUD.label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15.0f];
        }
        else {
            HUD.label.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
        }
        [HUD showAnimated:YES];
        HUD.removeFromSuperViewOnHide = YES;
        if (![HUD isDescendantOfView:self.view]) {
            [self.view addSubview:HUD];
        }
        [self.view bringSubviewToFront:HUD];
    }
}

#pragma - custom getter
- (MBProgressHUD *)progressHUB
{
    if (!_progressHUB) {
        MBProgressHUD *hub = [[MBProgressHUD alloc] initWithView:self.view];
        hub.bezelView.color = [kUIColorFromRGB(0x000000) colorWithAlphaComponent:0.78];
        hub.contentColor = [[UIColor whiteColor] colorWithAlphaComponent:0.78];
        [self.view addSubview:hub];
        _progressHUB = hub;
    }
    [self.view bringSubviewToFront:_progressHUB];
    return _progressHUB;
}

- (void)hideLoadIng {
    
    HUD.removeFromSuperViewOnHide = YES;
    if (HUD != nil) {
        [HUD hideAnimated:YES];
    }
}

- (void)clickBackNav
{
    [self hideNavBarWhiteShadowOpacity];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 自定义白色导航栏

- (void)createWhiteNavBar {
    // 修改导航栏色值
//    [self.navigationController.navigationBar setBackgroundImage:[Tool createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    // 返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_ic_back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackNav)];
    // 设置导航栏字体
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:kUIColorFromRGB(0x353535)}];
    // 导航栏加载阴影
    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(-1.56,1.56);
    self.navigationController.navigationBar.layer.shadowOpacity = 0.18f;
    self.navigationController.navigationBar.translucent = NO;
    
    [self defineUIStatusBarStyleDefault];
}

#pragma mark - 自定义蓝色导航栏

-(void)createBlueNavBar
{
//    [self.navigationController.navigationBar setBackgroundImage:[Tool createImageWithColor:[AppConfig shareConfig].mainColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *  backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    [backBtn addTarget:self action:@selector(clickBackNav) forControlEvents:UIControlEventTouchUpInside];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn setImage:[UIImage imageNamed:@"nav_ic_back_white"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"nav_ic_back_white_hlt"] forState:UIControlStateHighlighted];
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self defineUIStatusBarStyleLightContent];
}

- (void)hideNavBarWhiteShadowOpacity {
    // 移除阴影
    self.navigationController.navigationBar.layer.shadowColor = [UIColor clearColor].CGColor;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0,0);
    self.navigationController.navigationBar.layer.shadowOpacity = 0.0f;
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark 设置右UIBarItem 的标题
- (void)setRightTitle:(NSString *)title
           rightColor:(UIColor *)color
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBtn:)];
     self.navigationController.navigationBar.tintColor = color;
    [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName, nil] forState:UIControlStateNormal]; // 设置UIBarButtonItem Normal文字大小
    [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName, nil] forState:UIControlStateHighlighted]; // 设置UIBarButtonItem Highlighted文字大小
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark 设置右键图片
-(void)setRightBtnWithImageName:(NSString*)name
{
   
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    [rightBtn setImage:[UIImage imageNamed:name] forState:0];
    [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)clickRightBtn:(UIButton*)sender
{
    
    
}

- (void)showErrorViewOnSubview:(UIView *)subview
                   errorStatus:(ErrorBaseViewModeStatus)status
{
    [errorView removeFromSuperview];
    if (status != ErrorBaseViewModeStatusNoError) {
        errorView = [[ErrorBaseView alloc] init];
        [errorView setStatus:status];
        [subview addSubview:errorView];
        errorView.frame = CGRectMake(0, 44, subview.frame.size.width, subview.frame.size.height-44.0f);
        errorView.hidden = NO;
    }
    else {
        errorView.hidden = YES;
    }
}


@end
