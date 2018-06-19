//
//  WDAlipayAuthResultVC.m
//  WDJR
//
//  Created by FengZi on 2018/4/11.
//  Copyright © 2018年 WANDAPUHUI. All rights reserved.
//

#import "WDAlipayAuthResultVC.h"

@interface WDAlipayAuthResultVC ()

@end

@implementation WDAlipayAuthResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *resultImage = [[UIImageView alloc]init];
    resultImage.image = [UIImage imageNamed:@"yirenzheng"];
    [self.view addSubview:resultImage];
    
    [resultImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
    
    UILabel *desLabel = [[UILabel alloc]init];
    desLabel.text = @"已认证";
    [self.view addSubview:desLabel];
    
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(resultImage.mas_bottom).offset(10);
    }];
    
    UIButton *updateInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    [updateInfo setTitle:@"更新人行信息" forState:UIControlStateNormal];
    [updateInfo setTitle:@"更新人行信息" forState:UIControlStateSelected];
    [updateInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [updateInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    updateInfo.layer.cornerRadius = 10.0f;
    
    [self.view addSubview:updateInfo];
    
    [updateInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(desLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(44);
    }];
    
    
    
    UIButton *affirming = [UIButton buttonWithType:UIButtonTypeCustom];
    [affirming setTitle:@"信息安全保障中,仅用于授权安全校验" forState:UIControlStateNormal];
    [affirming setTitle:@"信息安全保障中,仅用于授权安全校验" forState:UIControlStateSelected];
    [affirming setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [affirming setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:affirming];
    
    [affirming mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view).offset(0);
        make.bottom.mas_equalTo(self.view).offset(-100);
    }];

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
