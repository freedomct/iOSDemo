//
//  CustomActionSheetVC.m
//  Test
//
//  Created by FengZi on 2018/5/11.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "CustomActionSheetVC.h"
#import <Masonry/Masonry.h>
@interface CustomActionSheetVC ()

@end

@implementation CustomActionSheetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)showAction:(id)sender {
    
    [self showAction];
}

- (void)showAction {
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    vc.view.backgroundColor = [UIColor blackColor];
    UIAlertAction *first = [UIAlertAction actionWithTitle:@"first" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *second = [UIAlertAction actionWithTitle:@"second" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *third = [UIAlertAction actionWithTitle:@"third" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *fouth = [UIAlertAction actionWithTitle:@"first" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *destructive = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [vc addAction:first];
    [vc addAction:second];
    [vc addAction:third];
    [vc addAction:fouth];
    [vc addAction:cancel];
    [vc addAction:destructive];
       
    vc.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2);
    [self presentViewController:vc animated:YES completion:nil];

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
