//
//  CustomCursorIndexVC.m
//  Test
//
//  Created by FengZi on 2018/5/25.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "CustomCursorIndexVC.h"

@interface CustomCursorIndexVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation CustomCursorIndexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.textField becomeFirstResponder];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - -
- (void)textChange:(NSNotification *)noti {
    
    NSString *text = self.textField.text;
    NSString *temp = @"(m²)";
    
    
    if ([text rangeOfString:temp].location != NSNotFound) {
        
        //  已经有标识符了 移动光标
        NSLog(@"移动光标到 (m²) 之前");
        if ([text isEqualToString:temp]) {
            self.textField.text = @"";
        }
        //        NSInteger location = text.length - temp.length;
        //        UITextPosition* beginning = textField.beginningOfDocument;
        //        NSRange tempRange = NSMakeRange(location, temp.length);
        //        UITextPosition* startPosition = [textField positionFromPosition:beginning offset:tempRange.location];
        //
        //        UITextPosition* endPosition = [textField positionFromPosition:beginning offset:tempRange.location + tempRange.length];
        //        UITextRange* selectionRange = [textField textRangeFromPosition:startPosition toPosition:endPosition];
        //        [textField setSelectedTextRange:selectionRange];
        
        
        
        
    }else{
        
        //        NSString *number = [self judgeNumber:temp];
        NSString *str = [NSString stringWithFormat:@"%@%@",[self judgeNumber:text],temp];
        if (str.length > temp.length) {
            
        }
        self.textField.text = str;
        
        NSInteger location = text.length - temp.length - 1;
        UITextPosition* beginning =  self.textField.beginningOfDocument;
        NSRange tempRange = NSMakeRange(location, temp.length);
        UITextPosition* startPosition = [ self.textField positionFromPosition:beginning offset:tempRange.location];
        
        UITextPosition* endPosition = [ self.textField positionFromPosition:beginning offset:(str.length - temp.length)];
        UITextRange* selectionRange = [self.textField textRangeFromPosition:endPosition toPosition:endPosition];
        [ self.textField setSelectedTextRange:selectionRange];
        
        
    }

    
}

#pragma mark - -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    NSLog(@"textFieldShouldBeginEditing");
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    NSLog(@"textFieldDidBeginEditing");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

    NSLog(@"textFieldShouldEndEditing");
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textFieldDidEndEditing");

}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    NSLog(@"textFieldDidEndEditing reason");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    NSString *text = self.textField.text;
    NSString *temp = @"(m²)";
    
    if ([text rangeOfString:temp].location != NSNotFound) {
        
        //  已经有标识符了 移动光标
        NSLog(@"移动光标到 (m²) 之前");
        if ([text isEqualToString:temp]) {
            self.textField.text = @"";
        }
        
    }else{
        
        //        NSString *number = [self judgeNumber:temp];
        NSString *str = [NSString stringWithFormat:@"%@%@",[self judgeNumber:text],temp];
        if (str.length > temp.length) {
            
        }
        self.textField.text = str;
        
        NSInteger location = text.length - temp.length - 1;
        UITextPosition* beginning = textField.beginningOfDocument;
        NSRange tempRange = NSMakeRange(location, temp.length);
        UITextPosition* startPosition = [textField positionFromPosition:beginning offset:tempRange.location];
        
        UITextPosition* endPosition = [textField positionFromPosition:beginning offset:(str.length - temp.length)];
        UITextRange* selectionRange = [textField textRangeFromPosition:endPosition toPosition:endPosition];
        [textField setSelectedTextRange:selectionRange];
        
        
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    NSLog(@"textFieldShouldClear");
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   
    NSLog(@"textFieldShouldReturn");
    return YES;
}


- (NSString *)judgeNumber:(NSString *)origin {
    NSString *pureNumbers = [[origin componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    return pureNumbers;
    
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
