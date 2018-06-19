//
//  CustomPickViewVC.m
//  Test
//
//  Created by FengZi on 2018/5/17.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "CustomPickViewVC.h"
#import <Masonry/Masonry.h>

@interface CustomPickViewVC ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray *nameArray;

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, assign) NSInteger selectedProvinces;

@property (nonatomic, assign) NSInteger selectedCity;

@property (nonatomic, assign) NSInteger selectedArea;

@end

@implementation CustomPickViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.datas = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];

}

- (IBAction)showPickView:(id)sender {
    
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    NSString *address = [[NSBundle mainBundle]pathForResource:@"address" ofType:@"json"];
    
    self.selectedCity = 0;
    self.selectedProvinces = 0;
    NSData *data = [[NSData alloc] initWithContentsOfFile:address];
    // 对数据进行JSON格式化并返回字典形式
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSDictionary *temp = dic[@"data"];
    self.datas = temp[@"body"];
    
    UIView *toolBar = [[UIView alloc]init];
    toolBar.frame = CGRectMake(0, 156, self.view.frame.size.width, 44);
    toolBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:toolBar];
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 200)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    [self.view addSubview:self.pickerView];
    [self.pickerView reloadAllComponents];//刷新UIPickerView
}

#pragma mark - - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    NSInteger rowCount =0;
    switch (component) {
        case 0:  //  省 / 直辖市
        {
            rowCount = self.datas.count;
        }
            break;
        case 1:  //  市
        {
            
            NSDictionary *provinces = self.datas[self.selectedProvinces];
//            NSLog(@"provinces = %@",provinces);
            NSArray *child = provinces[@"child"];
            rowCount = child.count;
        }
            break;
        case 2:  //  区
        {
            NSDictionary *provinces = self.datas[self.selectedProvinces];
//            NSLog(@"provinces = %@",provinces);
            NSArray *cityChild = provinces[@"child"];
            NSDictionary *area = cityChild[self.selectedCity];
            NSArray *areaChild = area[@"child"];

            rowCount = areaChild.count;

        }
            break;
            
        default:
            break;
    }
    return rowCount;
}

#pragma mark - - UIPickerViewDelegate

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return self.nameArray[row];
//}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    switch (component) {
        case 0:
        {
            self.selectedProvinces = row;

        }
            break;
        case 1:
        {
            self.selectedCity = row;
        }
            break;
        case 2:
        {
            self.selectedArea = row;
        }
            break;
            
        default:
            break;
    }
    [pickerView reloadAllComponents];
    NSLog(@"component = %ld row = %ld",component,row);

}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {

    if (!view) {
        view = [[UIView alloc]init];
    }
    UILabel *label = [[UILabel alloc]init];
    [view addSubview:label];
    switch (component) {
        case 0:  //  省 / 直辖市
        {
            NSDictionary *provinces = self.datas[row];
            NSLog(@"provinces = %@",provinces);
            NSString *provinceName = [NSString stringWithFormat:@"%@",provinces[@"name"]];
            label.text = provinceName;
        }
            break;
        case 1:  //  市
        {
            NSDictionary *provinces = self.datas[self.selectedProvinces];
            NSLog(@"provinces = %@",provinces);
            //
            NSArray *cityChild = provinces[@"child"];
            NSDictionary *cityDic = cityChild[row];
            NSString *cityName = [NSString stringWithFormat:@"%@",cityDic[@"name"]];
            label.text = cityName;
            
        }
            break;
        case 2:  //  区
        {
            NSDictionary *provinces = self.datas[self.selectedProvinces];
            NSLog(@"provinces = %@",provinces);
            //
            NSArray *cityChild = provinces[@"child"];
            NSDictionary *cityDic = cityChild[self.selectedCity];
            NSArray *areaChild = cityDic[@"child"];
            NSDictionary *areaDic = areaChild[row];
            NSString *areaName = [NSString stringWithFormat:@"%@",areaDic[@"name"]];
            
            label.text = areaName;

        }
            break;
            
        default:
            break;
    }

    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(view);
    }];
    return view;
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
