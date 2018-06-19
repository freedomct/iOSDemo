//
//  SearchController.m
//  Test
//
//  Created by FengZi on 2018/4/21.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "SearchController.h"

@interface SearchController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating,UISearchControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
// 数据源数组
@property (nonatomic, strong) NSMutableArray *datas;
// 搜索结果数组
@property (nonatomic, strong) NSMutableArray *results;

@property (nonatomic, strong) NSMutableArray *historyDatas;

@property (nonatomic, strong) UIView *headerView;
@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavigationBar];
    
    // 创建UISearchController, 这里使用当前控制器来展示结果
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    // 设置结果更新代理
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
    // 因为在当前控制器展示结果, 所以不需要这个透明视图
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleDefault;
//    UISearchBarStyleDefault,    // currently UISearchBarStyleProminent
//    UISearchBarStyleProminent,  // used my Mail, Messages and Contacts
//    UISearchBarStyleMinimal     // used by Calendar, Notes and Music

    // 将searchBar赋值给tableView的tableHeaderView
//    _headerView = [[UIView alloc]init];
//    _headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100);
//    UIImageView *image = [[UIImageView alloc]init];
//    image.frame = _headerView.frame;
//    image.image = [UIImage imageNamed:@"home_bg"];
//    [_headerView addSubview:image];
    self.navigationItem.titleView = self.searchController.searchBar;
    self.searchController.searchBar.scopeButtonTitles = @[@"图片",@"音乐",@"视频",@"文档",@"全部"];
    self.searchController.searchBar.scopeBarBackgroundImage = [UIImage imageNamed:@"home_bg"];
    self.searchController.searchBar.showsScopeBar = YES;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.tableView.bounces = NO;
    [self.searchController.searchBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"UISegmentedControl = %@",obj);
        [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[UISegmentedControl class]]) {
                    NSLog(@"UISegmentedControl = %@",obj);
                    UISegmentedControl *segment = (UISegmentedControl *)obj;
                    segment.tintColor = [UIColor clearColor];
                    NSDictionary * normalTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16.0f],NSForegroundColorAttributeName : [UIColor grayColor]};
                    [segment setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
                    // 选中状态下
                    NSDictionary * selctedTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:20.0f],NSForegroundColorAttributeName : [UIColor redColor]};
                    [segment setTitleTextAttributes:selctedTextAttributes forState:UIControlStateSelected];
                    [segment addTarget:self action:@selector(segmentedControl_one:) forControlEvents:UIControlEventValueChanged];
                }
            }];
        }];
    }];
    
    NSArray *history = @[@"1",@"2",@"3"];
    self.historyDatas = [NSMutableArray arrayWithArray:history];
    
    NSArray *tempArr = @[@"搜索1",@"搜索2",@"搜索3",@"搜索4",@"搜索5",@"搜索6",@"搜索17",@"搜索81",@"搜索9",@"搜索16",@"搜索45",@"搜索80",@"搜索65",@"搜索10",@"搜索34",@"搜索09"];
    self.datas = [NSMutableArray arrayWithArray:tempArr];
}
- (void)segmentedControl_one:(UISegmentedControl *)seg {
    NSLog(@"选中的index = %ld",(long)seg.selectedSegmentIndex);
}
#pragma mark - -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    // 这里通过searchController的active属性来区分展示数据源是哪个
    if (self.searchController.active ) {
        
        cell.textLabel.text = [self.results objectAtIndex:indexPath.row];
    } else {
        
        cell.textLabel.text = [self.historyDatas objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 这里通过searchController的active属性来区分展示数据源是哪个
    if (self.searchController.active) {
        
        return self.results.count ;
    }else{
        return self.historyDatas.count;

    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.searchController.active) {
        NSLog(@"选择了搜索结果中的%@", [self.results objectAtIndex:indexPath.row]);
    } else {
        
        NSLog(@"选择了列表中的%@", [self.datas objectAtIndex:indexPath.row]);
    }
    
}
#pragma mark - - 
- (void)willPresentSearchController:(UISearchController *)searchController {
    NSLog(@"willPresentSearchController");
}
- (void)didPresentSearchController:(UISearchController *)searchController {
    NSLog(@"didPresentSearchController");

}
- (void)willDismissSearchController:(UISearchController *)searchController {
    NSLog(@"willDismissSearchController");

}

- (void)didDismissSearchController:(UISearchController *)searchController {
    NSLog(@"didDismissSearchController");

}
#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *inputStr = searchController.searchBar.text ;
    if (self.results.count > 0) {
        [self.results removeAllObjects];
    }
    for (NSString *str in self.datas) {
        
        if ([str.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
            
            [self.results addObject:str];
        }
    }
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 56, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

- (NSMutableArray *)datas {
    if (_datas == nil) {
        _datas = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _datas;
}

- (NSMutableArray *)results {
    if (_results == nil) {
        _results = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _results;
}


- (void)customNavigationBar {
    
    UIImage *image = [UIImage imageNamed:@"navBackground"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *leftBackItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"home_ic_back_n"] style:UIBarButtonItemStyleDone target:self action:@selector(popToBack)];
    leftBackItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBackItem;

    if (self.navigationController.viewControllers.count > 1) {
    }
}
- (void)popToBack {
    [self.navigationController popViewControllerAnimated:YES];
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
