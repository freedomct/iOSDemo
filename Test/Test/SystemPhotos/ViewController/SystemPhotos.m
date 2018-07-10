//
//  SystemPhotos.m
//  Test
//
//  Created by fengzi on 2018/6/25.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "SystemPhotos.h"
#import <Photos/Photos.h>


@interface SystemPhotos ()

@end

@implementation SystemPhotos

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"获取系统图片";
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
