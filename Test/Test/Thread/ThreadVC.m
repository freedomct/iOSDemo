//
//  ThreadVC.m
//  Test
//
//  Created by FengZi on 2018/4/26.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "ThreadVC.h"

@interface ThreadVC ()

@end

@implementation ThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self groupThread];
}


- (void)groupThread {
    
    //  创建一个组
    dispatch_group_t group = dispatch_group_create();
    //  创建一个queue
    dispatch_queue_t firstQueue = dispatch_queue_create("com.yang.test", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"will enter task1");
    
    dispatch_group_enter(group);
    dispatch_group_async(group, firstQueue, ^{
        [self task1];
        dispatch_group_leave(group);
    });
    
    NSLog(@"will enter task2");
    dispatch_group_enter(group);
    dispatch_group_async(group, firstQueue, ^{
        [self task2];
        dispatch_group_leave(group);
    });
    
    NSLog(@"will enter task3");
    dispatch_group_enter(group);
    dispatch_group_async(group, firstQueue, ^{
        [self task3];
        dispatch_group_leave(group);
    });
    
    NSLog(@"come to notify");
    dispatch_group_notify(group, firstQueue, ^{
        NSLog(@"Enter notify");
        [self complete];
    });
    NSLog(@"Pass notify");
    
    
    
}

- (void)task1 {
    NSLog(@"1 Enter sleep 10");
    [NSThread sleepForTimeInterval:10];
    NSLog(@"1 Leave sleep 10");
}

- (void)task2 {
    NSLog(@"2 Enter sleep 10");
    [NSThread sleepForTimeInterval:10];
    NSLog(@"2 Leave sleep 10");
}

- (void)task3 {
    NSLog(@"3 Enter sleep 10");
    [NSThread sleepForTimeInterval:10];
    NSLog(@"3 Leave sleep 10");
}

- (void)complete {
    NSLog(@"All task finished");
//    结果
//    will enter task1
//    will enter task2
//    1 Enter sleep 10
//    will enter task3
//    2 Enter sleep 10
//    come to notify
//    3 Enter sleep 10
//    Pass notify
//    1 Leave sleep 10
//    2 Leave sleep 10
//    3 Leave sleep 10
//    Enter notify
//    All task finished
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
