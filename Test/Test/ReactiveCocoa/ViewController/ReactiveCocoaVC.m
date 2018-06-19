//
//  ReactiveCocoaVC.m
//  Test
//
//  Created by FengZi on 2018/4/10.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "ReactiveCocoaVC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ReactiveCocoaVC ()

@end

@implementation ReactiveCocoaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        return YES;
//    }];
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
