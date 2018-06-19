//
//  WDBaseViewController.h
//  WDJR
//
//  Created by owen du on 2017/12/27.
//  Copyright © 2017年 WANDAPUHUI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Masonry/Masonry.h>
#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSInteger, ErrorBaseViewModeStatus) {
    //  NoError.
    ErrorBaseViewModeStatusNoError,
    /// NoData.
    ErrorBaseViewModeStatusNoData,
    /// NoNet.
    ErrorBaseViewModeStatusNoNet,
};

@interface ErrorBaseView : UIControl

@property(nonatomic, strong) UIImageView *errorView;
@property(nonatomic, strong) UILabel *lbOfErrorViewTitle;
@property(nonatomic, assign) ErrorBaseViewModeStatus status; //默认：ErrorViewModeStatusNoData

@end

@interface WDBaseViewController : UIViewController

@property (nonatomic,    weak) MBProgressHUD *progressHUB;
@property (nonatomic,    weak) MBProgressHUD *loadDataHUB;
@property (nonatomic,    copy) NSString *systemTime;

- (void)showException:(NSString *)text; // 显示异常信心

- (void)startLoadIng:(NSString *)text; // 菊花加载文案

- (void)hideLoadIng; // 移除菊花加载

- (void)defineUIStatusBarStyleLightContent; // 状态栏为白色

- (void)defineUIStatusBarStyleDefault; // 状态栏黑色

- (void)clickRightBtn:(UIButton *)sender; // 点击右上角按钮

/**
 设置右上角的文字按钮

 @param title 文字
 @param color 文字颜色
 */
- (void)setRightTitle:(NSString *)title
           rightColor:(UIColor *)color;


/**
 设置右边按钮图片

 @param name 图片名称
 */
- (void)setRightBtnWithImageName:(NSString*)name;


/**
 创建白色导航栏【本导航栏是加阴影的导航栏】
 */
- (void)createWhiteNavBar;

/**
 创建蓝色导航栏 不加阴影
 */
- (void)createBlueNavBar;

/**
 移除白色导航栏【目的把阴影设置给重置】
 */
- (void)hideNavBarWhiteShadowOpacity;


/**
 视图返回
 */
- (void)clickBackNav;

/**
 抛出异常View展示

 @param subview 异常视图
 @param status 枚举
 */
- (void)showErrorViewOnSubview:(UIView *)subview
                   errorStatus:(ErrorBaseViewModeStatus)status;


/**
 请求红点的网络请求
 */
- (void)getUnreadMessageRefresh;

/**
 显示导航栏是否有未读消息红点

 @param isHasMessage YES为有未读消息,NO为无为读消息
 */
- (void)showIsHaveMessageWithIsHasMessage:(BOOL)isHasMessage;


@end
