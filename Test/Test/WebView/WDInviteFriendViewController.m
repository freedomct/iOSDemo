//
//  WDInviteFriendViewController.m
//  WDJR
//
//  Created by 吴晨 on 2018/1/10.
//  Copyright © 2018年 WANDAPUHUI. All rights reserved.
//  邀请好友介绍页面

#import "WDInviteFriendViewController.h"
//#import "MainBaseNavigationVC.h"
//#import "WDInputMobileViewController.h" // 输入手机号页面
//#import "WDShareInviteFriendViewController.h" // 邀请好友
//#import "WDActiveRuleViewController.h" // 活动规则


#define SCREEN_WIDTH              ([UIScreen mainScreen].bounds.size.width)
#define kScaleH  SCREEN_HEIGHT / 667.0f  // 4.7屏幕高度尺寸比例
#define kSafeAreaTopHeight (SCREEN_HEIGHT == 812.0 ? 88 : 64)
#define SCREEN_HEIGHT             ([UIScreen mainScreen].bounds.size.height)

@interface WDInviteFriendViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView; // 滚动视图
@property (nonatomic, strong) UIView *backGroundView; // 所有的子View放到这个视图上

@end

@implementation WDInviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"邀请好友";
    [self display];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self createWhiteNavBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self hideNavBarWhiteShadowOpacity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI布局
- (void)display {
    // introceImageView
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"sharefriend_introduce_%d.jpg",(int)SCREEN_WIDTH]];
    UIImageView *introceImageView = [[UIImageView alloc] initWithImage:image];
    introceImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (image.size.width / SCREEN_WIDTH) * SCREEN_HEIGHT);
    introceImageView.contentMode = UIViewContentModeScaleAspectFit;
    introceImageView.userInteractionEnabled = YES;
    [self.backGroundView addSubview:introceImageView];
    // 设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, (image.size.width / SCREEN_WIDTH) * SCREEN_HEIGHT);
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.backGroundView];

    // 活动规则
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"活动规则" forState:UIControlStateNormal];
    [btn0 setTitle:@"活动规则" forState:UIControlStateSelected];
    btn0.backgroundColor = [UIColor redColor];
    btn0.layer.cornerRadius = 0.7;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"活动规则" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.tag = 0;
    [btn addTarget:self action:@selector(pressBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    btn0.frame = CGRectMake(SCREEN_WIDTH - 100, 29, 100, 34);
  
    // 通过贝塞尔曲线加圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn0.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(17, 17)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = btn0.bounds;
    maskLayer.path = maskPath.CGPath;
    btn0.layer.mask = maskLayer;
    [introceImageView addSubview:btn0];
    
    // 堆放底部的按钮视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, image.size.height - 300, SCREEN_WIDTH, 300)];
    view.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:view];
    
    // 创建一个view是为了给以下按钮加阴影,圆角如果加上masksToBounds = YES就不会有阴影
    UIView *shadowView = [[UIView alloc] init];
    shadowView.backgroundColor = [UIColor clearColor];
    shadowView.layer.shadowOpacity = 1.98f;
    shadowView.layer.shadowColor = [UIColor redColor].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0, 4.2);
    shadowView.clipsToBounds = NO;
    [view addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view).offset(-50);
        make.left.equalTo(view).offset(32);
        make.right.equalTo(view).offset(-32);
        make.height.mas_equalTo(48);
    }];
    
    // 立即邀请赚iPhone8【邀请好友】
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"立即邀请赚iPhone8" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(pressBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    btn1.layer.cornerRadius = 24.0f;
    btn1.layer.masksToBounds = YES;
    [shadowView addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.and.left.right.equalTo(shadowView);
    }];
}

#pragma mark - Actions
- (void)clickBackNav
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pressBtnClicked:(UIButton *)btn {
    if (btn.tag == 0) {
        // 活动规则
//        WDActiveRuleViewController *activeRuleVC = [[WDActiveRuleViewController alloc] init];
//        [self.navigationController pushViewController:activeRuleVC animated:YES];
    }
    else {
//        if ([UserAgent userHaveLogin]) {
//            // 立即邀请好友
//            WDShareInviteFriendViewController *shareInviteFriendVC = [[WDShareInviteFriendViewController alloc] init];
//            [self.navigationController presentViewController:shareInviteFriendVC animated:YES completion:NULL];
//        }
//        else {
//            // 调用登录页面
//            WDInputMobileViewController *inputMobileVC = [[WDInputMobileViewController alloc] init];
//            inputMobileVC.enterType = PresentType;
//            MainBaseNavigationVC *navVC = [[MainBaseNavigationVC alloc] initWithRootViewController:inputMobileVC];
//            [self.navigationController presentViewController:navVC animated:YES completion:NULL];
//        }
    }
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - kSafeAreaTopHeight)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _scrollView.frame.size.height)];
        _backGroundView.backgroundColor = [UIColor clearColor];
    }
    
    return _backGroundView;
}

#pragma  mark - Public
- (UIButton *)buttonWithTitle:(NSString *)title
           SetButtonLabelFontSize:(CGFloat)titleLabelFontSize
     SetBackGroundNormalColor:(UIColor *)normalColor
        SetBackGroundHltColor:(UIColor *)hltColor
                    ButtonTag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
//    [btn setBackgroundImage:[Tool createImageWithColor:normalColor] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[Tool createImageWithColor:hltColor] forState:UIControlStateHighlighted];
    btn.tag = tag;
    [btn addTarget:self action:@selector(pressBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}


@end
