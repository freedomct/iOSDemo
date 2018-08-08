//
//  HSAlipayCollectionVC.m
//  HSShopC
//
//  Created by fengzi on 2018/8/2.
//  Copyright © 2018年 HS. All rights reserved.
//

#import "HSAlipayCollectionVC.h"
#import "HSAlipayCommitFooter.h"
#import "HSAlipayCollectionCell.h"
#import "HSAlipayCollectionModel.h"
#import <Masonry/Masonry.h>

static NSString *const alipayCollectionCellIdentifier = @"alipayCollectionCellIdentifier";
static NSString *const alipayCollectionFooterIdentifier = @"alipayCollectionFooterIdentifier";

@interface HSAlipayCollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *alipayCollection;

@property (nonatomic, strong) NSArray <HSAlipayCollectionModel *>*alipayDatas;

@property (nonatomic, copy) __block NSString *flag;

@end

@implementation HSAlipayCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"绑定收款信息";
    [self configLocalData];
}

#pragma mark - -
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    HSAlipayCommitFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:alipayCollectionFooterIdentifier forIndexPath:indexPath];
//    [footer updateAlipayCommitFooter:[self.flag boolValue]];
//    footer.commitUserCollectionHandler = ^{
//        NSLog(@"提交用户信息");
//    };
//    return footer;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = [indexPath row];

    HSAlipayCollectionCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:alipayCollectionCellIdentifier forIndexPath:indexPath];
   
    collectionCell.textFieldTextChange = ^(id result) {
        
        NSLog(@"result = %@",result);
//        [weakSelf checkAlipayCollectionCodeInfo];
        
    };
    if (self.alipayDatas.count > row) {
        [collectionCell updateAlipayCollectionCellWithModel:self.alipayDatas[row]];
    }
    return collectionCell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger itemCount = (section == 0) ? self.alipayDatas.count : 0;
    return itemCount;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.view.frame), 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    CGFloat height = (section == 0) ? 0 : 100;
    return CGSizeMake(CGRectGetWidth(self.view.frame), height);

}

#pragma mark - -
- (UICollectionView *)alipayCollection {
    if (!_alipayCollection) {
        
        UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
        _alipayCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _alipayCollection.backgroundColor = [UIColor whiteColor];
        _alipayCollection.delegate = self;
        _alipayCollection.dataSource = self;
        [_alipayCollection registerClass:[HSAlipayCollectionCell class] forCellWithReuseIdentifier:alipayCollectionCellIdentifier];
        [_alipayCollection registerClass:[HSAlipayCommitFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:alipayCollectionFooterIdentifier];
        [self.view addSubview:_alipayCollection];
        
        [_alipayCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuide).offset(0);
        }];
    }
    return _alipayCollection;
}

#pragma mark - -

- (void)configLocalData {
    
    self.flag = @"0";
    
    HSAlipayCollectionModel *userNameModel = [[HSAlipayCollectionModel alloc]init];
    userNameModel.title = @"姓名";
    userNameModel.text = @"";
    userNameModel.placeholder = @"请输入支付宝认证的真实姓名";
    userNameModel.alipayCellType = AlipayCellTypeUserName;
    
    HSAlipayCollectionModel *userAlipayAccountModel = [[HSAlipayCollectionModel alloc]init];
    userAlipayAccountModel.title = @"支付宝";
    userAlipayAccountModel.text = @"";
    userAlipayAccountModel.placeholder = @"请输入支付宝账号";
    userAlipayAccountModel.alipayCellType = AlipayCellTypeUserAccount;
    
    HSAlipayCollectionModel *userPhoneNumModel = [[HSAlipayCollectionModel alloc]init];
    userPhoneNumModel.title = @"手机号";
    userPhoneNumModel.text = @"";
    userPhoneNumModel.placeholder = @"请输入手机号码";
    userPhoneNumModel.alipayCellType = AlipayCellTypeUserPhone;
    
    HSAlipayCollectionModel *verificationCodeModel = [[HSAlipayCollectionModel alloc]init];
    verificationCodeModel.title  =@"验证码";
    verificationCodeModel.text = @"";
    verificationCodeModel.placeholder = @"请输入验证码";
    verificationCodeModel.alipayCellType = AlipayCellTypeUserVerificationCode;
    
    self.alipayDatas = @[userNameModel,userAlipayAccountModel,userPhoneNumModel,verificationCodeModel];
    [self.alipayCollection reloadData];

}
- (void)commitUserAlipayAccount {
    if (self.bindAlipayHandler) {
        self.bindAlipayHandler();
    }
}

- (void)checkAlipayCollectionCodeInfo {
    
    self.flag = @"1";
    [self.alipayDatas enumerateObjectsUsingBlock:^(HSAlipayCollectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.text.length == 0) {
        }
    }];
    
//    [self.alipayCollection reloadSections:[NSIndexSet indexSetWithIndex:1]];
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
