
//
//  DeviceOpenTime.m
//  Test
//
//  Created by FengZi on 2018/4/16.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "DeviceOpenTime.h"

@interface DeviceOpenTime ()

@property (weak, nonatomic) IBOutlet UILabel *openTime;

@end

@implementation DeviceOpenTime

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设备开机时间";
    NSString *time = [self getLaunchSystemTime];
    NSLog(@"open time = %@",time);
    self.openTime.text = time;
}

- (NSString *)getLaunchSystemTime {
    
//    NSTimeInterval systemUpTimer = [NSProcessInfo processInfo].systemUptime;
//    NSDate *currentDate = [NSDate new];
//    NSDate *startTime = [currentDate dateByAddingTimeInterval:(-systemUpTimer)];
//
//    NSTimeInterval convertStartTimeToSecond = [startTime timeIntervalSince1970];
//    return convertStartTimeToSecond;
//
//    NSProcessInfo *info = [NSProcessInfo processInfo];
//    NSDate *now = [NSDate date];
//    NSTimeInterval interval = [now timeIntervalSince1970];
//
//    NSLog(@"start time %@",[self getDateStrFromTimeStep:(interval - info.systemUptime)]);
    NSProcessInfo *info = [NSProcessInfo processInfo];
    NSDate *now = [NSDate date];
    NSTimeInterval interval = [now timeIntervalSince1970];
    
    NSTimeInterval time = interval - info.systemUptime;
    NSDate *timestepDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:info.systemUptime];
    NSLog(@"currentDate = %@",currentDate);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *formatterTime = [NSString stringWithFormat:@"%@",[formatter stringFromDate:timestepDate]];
    NSLog(@"formatterTime = %@",formatterTime);
    
    return formatterTime;
    
    
    
    
//    NSProcessInfo *process = [[NSProcessInfo alloc]init];
//
//    NSDate *date1 = [[NSDate alloc] init];
//    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:process.systemUptime sinceDate:date1];
//    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:process.systemUptime];
//    NSLog(@"%@",[date earlierDate:date1]);
//    //   Wed Mar 14 22:33:46 2018
//
//    NSDate *now = [NSDate date];
//
//    NSDate *yesterDay = [now dateByAddingTimeInterval:-process.systemUptime];
//    NSLog(@"yesterDay = %@",yesterDay);

}

- (NSString *)getDateStrFromTimeStep:(long long)timestep{
    
    NSDate *timestepDate = [NSDate dateWithTimeIntervalSince1970:timestep];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:timestepDate];
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
