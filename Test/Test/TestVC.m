//
//  TestVC.m
//  Test
//
//  Created by fengzi on 2018/7/29.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(test) name:UITextFieldTextDidChangeNotification object:nil];
    
}


- (void)test {
    
    NSString *inputText = _textField.text;
    NSLog(@"inputText = %@",inputText);
    _textField.text = inputText;
    if ([inputText hasSuffix:@"-"]) {
        //  删除操作
        _textField.text = [inputText substringWithRange:NSMakeRange(0, inputText.length - 1)];
    }else{
        inputText = [inputText stringByReplacingOccurrencesOfString:@"-" withString:@""];

        NSMutableString *years = [[NSMutableString alloc]initWithString:inputText];

        if (inputText.length > 4) {
            [years insertString:@"-" atIndex:4];
        }
        if (inputText.length > 6) {
            [years insertString:@"-" atIndex:7];
        }
      
        _textField.text = years;
        if (_textField.text.length > 10) {
            _textField.text = [_textField.text substringWithRange:NSMakeRange(0, 10)];
        }
    }
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
