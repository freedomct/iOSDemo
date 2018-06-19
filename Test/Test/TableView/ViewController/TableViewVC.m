//
//  TableViewVC.m
//  Test
//
//  Created by FengZi on 2018/4/20.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "TableViewVC.h"
#import "MyCell.h"
#import <Masonry/Masonry.h>
@interface TableViewVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[MyCell class] forCellReuseIdentifier:@"mycell"];
    [self.view addSubview:tableView];
    
    tableView.tableFooterView = [self footerViewForTableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


#pragma mark - -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    cell.textLabel.text = @"56";
    cell.detailTextLabel.text = @"12";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc]init];
    header.backgroundColor = [UIColor redColor];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc]init];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}
#pragma mark - -
- (UIView *)footerViewForTableView {
    UIView *footer = [[UIView alloc]init];
    footer.backgroundColor = [UIColor greenColor];
    footer.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200);
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"yang";
    [footer addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(footer);
        make.height.mas_equalTo(44);
    }];
    return footer;
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
