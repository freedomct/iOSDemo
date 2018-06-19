//
//  WDShareInviteFriendBtnView.m
//  WDJR
//
//  Created by 吴晨 on 2018/1/18.
//  Copyright © 2018年 WANDAPUHUI. All rights reserved.
//

#import "WDShareInviteFriendBtnView.h"
#define SCREEN_WIDTH              ([UIScreen mainScreen].bounds.size.width)
#define kScaleH  SCREEN_HEIGHT / 667.0f  // 4.7屏幕高度尺寸比例
#define kSafeAreaTopHeight (SCREEN_HEIGHT == 812.0 ? 88 : 64)
#define SCREEN_HEIGHT             ([UIScreen mainScreen].bounds.size.height)

@interface WDShareInviteFriendBtnView ()

@property (nonatomic, strong) NSMutableArray *items; // 存放title【平台】的名字
@property (nonatomic, strong) NSMutableArray *images; // 平台logo

@end

@implementation WDShareInviteFriendBtnView

- (id)initWithFrame:(CGRect)frame
 sharePlatformNames:(NSArray *)names
     platformImages:(NSArray *)images
{
    if (self = [super initWithFrame:frame]) {
        [self.items addObjectsFromArray:[names mutableCopy]];
        [self.images addObjectsFromArray:[images mutableCopy]];
        NSLog(@"images = %@",self.images);
        

        [self setup];
    }
    
    return self;
}

#pragma mark - 布局UI
- (void)setup {
    // view0
    UIView *view0 = [self buttonViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 4.0f, 184 * 10)];
    [self addSubview:view0];
    // view1
    UIView *view1 = [self buttonViewWithFrame:CGRectMake(SCREEN_WIDTH / 4.0f, 0, SCREEN_WIDTH / 4.0f, 184 * 10)];
    [self addSubview:view1];
    // view2
    UIView *view2 = [self buttonViewWithFrame:CGRectMake((SCREEN_WIDTH / 4.0f) * 2, 0, SCREEN_WIDTH / 4.0f, 184 * 10)];
    [self addSubview:view2];
    // view3
    UIView *view3 = [self buttonViewWithFrame:CGRectMake((SCREEN_WIDTH / 4.0f) * 3, 0, SCREEN_WIDTH / 4.0f, 184 * 10)];
    [self addSubview:view3];
    
    // 朋友圈
    UIButton *friendCircleBtn = [self buttonSetNormalImageNamed:[UIImage imageNamed:self.images[0]] ButtonSetHltImageNamed:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",[self.images firstObject],@"_hig"]] ButtonSetTitle:[self.items firstObject] ButtonTag:1000];
    [view0 addSubview:friendCircleBtn];
    [friendCircleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(view0);
        make.height.mas_equalTo(80);
    }];
    
    // 微信好友
    UIButton *wechatBtn = [self buttonSetNormalImageNamed:[UIImage imageNamed:self.images[1]] ButtonSetHltImageNamed:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",self.images[1],@"_hig"]] ButtonSetTitle:self.items[1] ButtonTag:1001];
    [view1 addSubview:wechatBtn];
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(view1);
        make.height.equalTo(friendCircleBtn);
    }];
    
    // QQ好友
    UIButton *qqFriendBtn = [self buttonSetNormalImageNamed:[UIImage imageNamed:self.images[2]] ButtonSetHltImageNamed:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",self.images[2],@"_hig"]] ButtonSetTitle:self.items[2] ButtonTag:1002];
    [view2 addSubview:qqFriendBtn];
    [qqFriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(view2);
        make.height.equalTo(friendCircleBtn);
    }];
    
    // QQ空间
    UIButton *qZoneBtn = [self buttonSetNormalImageNamed:[UIImage imageNamed:self.images[3]] ButtonSetHltImageNamed:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",self.images[3],@"_hig"]] ButtonSetTitle:[self.items lastObject] ButtonTag:1003];
    [view3 addSubview:qZoneBtn];
    [qZoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(view3);
        make.height.equalTo(friendCircleBtn);
    }];
    
    // hideBtn
    UIButton *hideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [hideBtn setImage:[UIImage imageNamed:@"share_ic_delete.png"] forState:UIControlStateNormal];
    [hideBtn addTarget:self action:@selector(hideClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:hideBtn];
    [hideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(60);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-40 * 10);
    }];
}

#pragma mark - Actions
- (void)clickShareBtn:(UIButton *)sender {
    _sharePlatform(sender.tag - 1000);
}

- (void)hideClicked:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(wdShareInviteFriendBtnViewCliked:)]) {
        [_delegate wdShareInviteFriendBtnViewCliked:sender];
    }
}

#pragma mark - setter
- (void)setSharePlatform:(ClickShareButton)sharePlatform
{
    _sharePlatform = sharePlatform;
}

#pragma mark - getter
- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _items;
}

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _images;
}

#pragma mark - public
- (UIView *)buttonViewWithFrame:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    return view;
}

- (UIButton *)buttonSetNormalImageNamed:(UIImage *)normalImageNamed
                 ButtonSetHltImageNamed:(UIImage *)hltImageNamed
              ButtonSetTitle:(NSString *)title
                   ButtonTag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setImage:normalImageNamed forState:UIControlStateNormal];
    [btn setImage:hltImageNamed forState:UIControlStateHighlighted];
    btn.exclusiveTouch = YES;
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = btn.titleLabel.intrinsicContentSize.width;
        labelHeight = btn.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = btn.titleLabel.frame.size.width;
        labelHeight = btn.titleLabel.frame.size.height;
    }
    CGFloat imageWidth = 0.0;
    CGFloat imageHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中imageView的size为0，用下面的这种设置
        imageWidth = btn.imageView.intrinsicContentSize.width;
        imageHeight = btn.imageView.intrinsicContentSize.height;
    } else {
        imageWidth = btn.imageView.frame.size.width;
        imageHeight = btn.imageView.frame.size.height;
    }
    btn.imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - 5, 0.0f, 0.0f, -labelWidth);
    btn.titleEdgeInsets = UIEdgeInsetsMake(imageWidth + 10, -imageWidth, 0.0f, 0.0f);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter; // 使图片和文字水平居中显示
    btn.tag = tag;
    [btn addTarget:self action:@selector(clickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
