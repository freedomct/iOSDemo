//
//  FirstVC.m
//  Test
//
//  Created by FengZi on 2018/4/17.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "FirstVC.h"
#import "SecondVC.h"
#import <Masonry/Masonry.h>
@interface FirstVC ()

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"FirstVC";
    UIButton *jump = [UIButton buttonWithType:UIButtonTypeCustom];
    jump.backgroundColor = [UIColor redColor];
    [jump setTitle:@"First 跳转" forState:UIControlStateNormal];
    [jump setTitle:@"First 跳转" forState:UIControlStateSelected];
    [jump addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jump];
    
    [jump  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.mas_equalTo(self.view);
        make.width.and.height.mas_equalTo(100);
    }];

    
}
- (void)jump {
    
    SecondVC *second = [[SecondVC alloc]init];
    
    [self.navigationController pushViewController:second animated:YES];
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
