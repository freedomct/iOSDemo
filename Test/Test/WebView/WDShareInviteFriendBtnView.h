//
//  WDShareInviteFriendBtnView.h
//  WDJR
//
//  Created by 吴晨 on 2018/1/18.
//  Copyright © 2018年 WANDAPUHUI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <JavaScriptCore/JavaScriptCore.h>
typedef void (^ClickShareButton)(NSInteger shareIndex);

@protocol WDShareInviteFriendBtnViewDelegate <NSObject>

- (void)wdShareInviteFriendBtnViewCliked:(UIButton *)btn; // 移除当前视图

@end

@interface WDShareInviteFriendBtnView : UIView

@property (nonatomic,   copy) ClickShareButton sharePlatform;
@property (nonatomic,   weak) id <WDShareInviteFriendBtnViewDelegate> delegate;


/**
 初始化

 @param frame 坐标
 @param names 平台名称
 @param images 平台应用图标
 */
- (id)initWithFrame:(CGRect)frame
 sharePlatformNames:(NSArray *)names
     platformImages:(NSArray *)images; // 创建页面

@end
