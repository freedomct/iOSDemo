//
//  MyAlertVC.m
//  Test
//
//  Created by FengZi on 2018/4/13.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "MyAlertVC.h"
#import "LCPublicAlertView.h"
@interface MyAlertVC ()

@end

@implementation MyAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)showAlert:(id)sender {
    
    
    [LCPublicAlertView showAlertWithTitle:@"提示" message:@"这是信息这是信息\n这是信息这是信息这是信息这是\n信息这是信息这是信息这是信息这是\n信息这是信息这是信息这是信息\n这是信息这是信息\n这是信息这是信息这是信息这是\n信息这是信息这是信息这是信息这是\n信息这是信息这是信息这是信息\n"];
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
