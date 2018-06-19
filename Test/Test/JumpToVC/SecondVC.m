//
//  SecondVC.m
//  Test
//
//  Created by FengZi on 2018/4/17.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "SecondVC.h"
#import "ThirdVC.h"
#import <Masonry/Masonry.h>
#import "FirstVC.h"
@interface SecondVC ()

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"SecondVC";

    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *jump = [UIButton buttonWithType:UIButtonTypeCustom];
    [jump setTitle:@"跳转" forState:UIControlStateNormal];
    [jump setTitle:@"跳转" forState:UIControlStateSelected];
    jump.backgroundColor = [UIColor redColor];

    [jump addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jump];
    
    [jump  mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.mas_equalTo(self.view);
        make.width.and.height.mas_equalTo(100);
    }];
}


- (void)jump {
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[SecondVC class]]) {
            ThirdVC *third = [[ThirdVC alloc]init];
            [obj.navigationController pushViewController:third animated:YES];
            [viewControllers removeObject:obj];
            [viewControllers addObject:third];
            self.navigationController.viewControllers = viewControllers;
            NSLog(@"viewControllers = %@",viewControllers);
            *stop = YES;
        }
        
        
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
