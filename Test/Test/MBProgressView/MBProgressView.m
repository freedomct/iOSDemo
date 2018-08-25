//
//  MBProgressView.m
//  testfdsf
//
//  Created by fengzi on 2018/7/23.
//  Copyright © 2018年 Fengzi. All rights reserved.
//

#import "MBProgressView.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressView ()

@end

@implementation MBProgressView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//  菊花
- (IBAction)IndicatorViewMode:(id)sender {
    
    MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.graceTime = 1.0f; //  如果请求在1秒内结束 那么就不显示当前view
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"网络加载中...";
    hud.detailsLabel.text = @"副标题";
    [hud hideAnimated:YES afterDelay:2.0f];
    
}

//  进度条 加 文本
- (IBAction)pregressModel:(id)sender {
    MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.graceTime = 1.0f; //  如果请求在1秒内结束 那么就不显示当前view
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = @"网络加载中...";
    hud.detailsLabel.text = @"副标题";
    hud.progress = 0.5;
    [hud hideAnimated:YES afterDelay:2.0f];
    
}


//  MBProgressHUDModeDeterminateHorizontalBar
//  菊花
- (IBAction)HorizontalBarMode:(id)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.contentMode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.label.text = @"loading ...";
    hud.contentColor = [UIColor yellowColor];
    hud.detailsLabel.text = @"加载中。。。";
    [hud hideAnimated:YES afterDelay:2.0f];
}

//  AnnularDeterminate
//  圆形的进度条
- (IBAction)AnnularDeterminateMode:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.progress = 0.9;
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.contentColor = [UIColor redColor];  //  修改文本显示的颜色
    hud.label.text = @"loading...";
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    [hud hideAnimated:YES afterDelay:2.0f];

}

//  自定义view
- (IBAction)customViewMode:(id)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [self myCustomView];
    hud.square = YES;
    hud.label.text = @"custom view";
    hud.animationType = MBProgressHUDAnimationFade;  //  显示 隐藏的动画
    //  hud 整个的背景视图
//    hud.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//    hud.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//    hud.bezelView.layer.backgroundColor =  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor;
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];

    [hud hideAnimated:YES afterDelay:2.0f];
    
}

- (UIView *)myCustomView {
//    UIView *customView = [[UIView alloc]init];
//    customView.backgroundColor = [UIColor redColor];
//    customView.frame = CGRectMake(0, 0, 100, 100);
//    customView.layer.cornerRadius = 10.0f;
//    customView.layer.masksToBounds = YES;
    
    //  水平进度条
//    MBBarProgressView *barProgressView = [[MBBarProgressView alloc]init];
//    barProgressView.lineColor = [UIColor blackColor];
//    barProgressView.progress = .4;
    
    MBRoundProgressView *roundProgressView = [[MBRoundProgressView alloc]init];
    roundProgressView.progress = 0.2;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        roundProgressView.progress = 0.4;

    });
    roundProgressView.backgroundTintColor = [UIColor redColor];
    roundProgressView.progressTintColor = [UIColor yellowColor];

//    UIImageView *lineImage = [[UIImageView alloc]init];
//    lineImage.image = [UIImage imageNamed:@"line"];
    return roundProgressView
    ;
}



//  文本说明
- (IBAction)first:(id)sender {
    
    MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.graceTime = 1.0f; //  如果请求在1秒内结束 那么就不显示当前view
    hud.mode = MBProgressHUDModeText;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    hud.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    hud.label.text = @"网络加载中...";
    hud.detailsLabel.text = @"副标题";
    [hud hideAnimated:YES afterDelay:2.0f];
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
