//
//  JudgeStringNumVC.m
//  Test
//
//  Created by FengZi on 2018/4/21.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "JudgeStringNumVC.h"

@interface JudgeStringNumVC ()

@end

@implementation JudgeStringNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *floStr = @"12.000";
    NSString *intStr = @"12";
    NSLog(@"float = %d int = %d",[self isPureInt:floStr],[self isPureInt:intStr]);
}


//判断是否为整形：

- (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
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
