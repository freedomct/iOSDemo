//
//  ThirdVC.m
//  Test
//
//  Created by FengZi on 2018/4/17.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "ThirdVC.h"
#import <Masonry/Masonry.h>

@interface ThirdVC ()

@end

@implementation ThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"ThirdVC";

    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *firstLabel = [[UILabel alloc]init];
    firstLabel.backgroundColor = [UIColor redColor];
    firstLabel.text = @"ThirdVC";
    [self.view addSubview:firstLabel];
    
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.and.height.mas_equalTo(100);
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
