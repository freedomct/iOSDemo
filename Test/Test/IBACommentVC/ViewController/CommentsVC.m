//
//  CommentsVC.m
//  MasonryDemo
//
//  Created by FengZi on 09/11/2017.
//  Copyright © 2017 yang. All rights reserved.
//

#import "CommentsVC.h"
#import <Masonry/Masonry.h>
#import "CommentImageCell.h"
#import "Header.h"
#import "Footer.h"

#import "IBAUploadFileManager.h"
@interface CommentsVC ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *startBaseView;

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@property (nonatomic, strong) UICollectionView *collection;

@property (nonatomic, strong) NSArray *choosedImages;

@end

@implementation CommentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self comments];
}
- (void)comments {
    
    UIScrollView *baseScrollView = [[UIScrollView alloc]init];
    baseScrollView.contentSize =CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    baseScrollView.showsVerticalScrollIndicator = NO;
    baseScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:baseScrollView];
    
    [baseScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor whiteColor];
    [baseScrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(baseScrollView).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
        make.width.equalTo(baseScrollView.mas_width);
        make.height.mas_equalTo(baseScrollView.contentSize.height - 64);
 
    }];
    
    //  商品信息 和撰写评论
    UIView *topInfoView = [[UIView alloc]init];
    [contentView addSubview:topInfoView];
    
    [topInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(contentView).with.offset(0);
        make.height.mas_equalTo(300);
    }];
    //  productInfo
    UIView *productInfoView = [[UIView alloc]init];
    [topInfoView addSubview:productInfoView];
    
    [productInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(topInfoView).with.offset(0);
        make.height.mas_equalTo(100);
    }];
    
    UIImageView *productImageView = [[UIImageView alloc]init];
    productImageView.backgroundColor = [UIColor blackColor];
    [productInfoView addSubview:productImageView];

    [productImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(productInfoView.mas_top).with.offset(5);
        make.bottom.mas_equalTo(productInfoView.mas_bottom).with.offset(-5);

        make.left.mas_equalTo(productInfoView.mas_left).with.offset(20);
        make.width.mas_equalTo(productImageView.mas_height);
    }];
    
    UILabel *des = [[UILabel alloc]init];
    des.text = @"评价";
    des.textColor = [UIColor colorWithRed:102/255 green:102/255 blue:102/255 alpha:1.0];
    des.font = [UIFont systemFontOfSize:15];
    [productInfoView addSubview:des];
    
    [des mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(productImageView.mas_right).with.offset(20);
        make.right.equalTo(productInfoView).with.offset(-10);
        make.top.mas_equalTo(productImageView.mas_top);
        make.height.mas_equalTo(44);

    }];
    
    //  start
    _startBaseView = [[UIView alloc]init];
    [productInfoView addSubview:_startBaseView];
    
    [_startBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.mas_equalTo(productImageView.mas_right).with.offset(0);
        make.right.equalTo(productInfoView).with.offset(-10);
        make.bottom.mas_equalTo(productImageView.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    for (int i = 0; i < 5; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setImage:[UIImage imageNamed:@"startSelected"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"startSelected"] forState:UIControlStateSelected];

        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_startBaseView addSubview:button];

        [button mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(_startBaseView).with.offset(20 + 30 * i);
            make.centerY.mas_equalTo(_startBaseView.mas_centerY);
            make.width.height.mas_equalTo(20);
        }];
        
    }
    
    UILabel *desTitle = [[UILabel alloc]init];
    desTitle.text = @"分享您的购买心得，有机会获得奖品哦...";
    desTitle.textColor = [UIColor colorWithRed:153/255 green:153/255 blue:153/255 alpha:1.0];
    desTitle.font = [UIFont systemFontOfSize:13];
    [topInfoView addSubview:desTitle];
    
    [desTitle mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(productInfoView.mas_bottom).with.offset(5);
        make.left.equalTo(productInfoView.mas_left).with.offset(20);
    }];
    
    UITextView *commentTextView = [[UITextView alloc]init];
    commentTextView.delegate = self;
    [topInfoView addSubview:commentTextView];
    
    [commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topInfoView).with.offset(5);
        make.right.and.bottom.equalTo(topInfoView).with.offset(-5);
        make.top.mas_equalTo(desTitle.mas_bottom).with.offset(5);
    }];
    
    //  lineView
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [productInfoView addSubview:lineView];

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.bottom.right.equalTo(productInfoView).with.offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
     // 上传图片
    UIView *bottom = [[UIView alloc]init];
    bottom.backgroundColor = [UIColor greenColor];
    [contentView addSubview:bottom];

    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.and.right.and.bottom.equalTo(contentView).with.offset(0);
        make.top.mas_equalTo(topInfoView.mas_bottom).with.offset(20);
    }];

    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collection.backgroundColor = [UIColor whiteColor];
    _collection.scrollEnabled = NO;
    _collection.delegate = self;
    _collection.dataSource = self;
    [_collection registerClass:[CommentImageCell class] forCellWithReuseIdentifier:@"comment"];
    
    [_collection registerClass:[Header class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [_collection registerClass:[Footer class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];

    [bottom addSubview:_collection];
    
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)click:(UIButton *)sender {
    
    
    NSInteger tag = sender.tag;
    [_startBaseView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *selectedButton = (UIButton *)obj;
            NSString *startImageName = (idx > tag) ? @"startNormal" : @"startSelected";
            [selectedButton setImage:[UIImage imageNamed:startImageName] forState:UIControlStateNormal];
            [selectedButton setImage:[UIImage imageNamed:startImageName] forState:UIControlStateSelected];
        }
        
    }];
    
    NSLog(@"%ld",(long)sender.tag);
}
#pragma mark - -

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        Header *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        return header;

        
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        
        Footer *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footer.submitBlock = ^{
           
            NSLog(@"提交评论");
        };
        return footer;
    }
    return nil;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = [indexPath row];
    CommentImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"comment" forIndexPath:indexPath];
    
    if (_choosedImages.count > row) {
        
        [cell updateCommentWithParameter:_choosedImages[row]];
    }else{
        
        [cell updateCommentWithParameter:nil];
    }
    cell.delBlock = ^{
        
        NSLog(@"删除 第几个图片");
        if (_choosedImages.count > 0) {
            NSMutableArray *temp = [NSMutableArray arrayWithArray:_choosedImages];
            [temp removeObjectAtIndex:row];
            _choosedImages = temp;
            [_collection reloadData];
        }
      
    };
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = (_choosedImages.count >= 6) ? 6 : _choosedImages.count + 1;
    return count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(self.view.frame)/4, CGRectGetWidth(self.view.frame)/4);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 80);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(CGRectGetWidth(self.view.frame), 44);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger itemNumber = [collectionView numberOfItemsInSection:0];
    NSLog(@"row = %ld count = %ld",itemNumber,_choosedImages.count);
    NSInteger row = [indexPath row];
    if (_choosedImages.count == 6){
     
        //  展示大图
        NSLog(@"展示大图");
    }else{
        //  弹出选择
        if (_choosedImages.count > row){
            //  展示大图
            NSLog(@"展示大图");
        }else{
            [self choosePhotoFromLibraryOrCamera ];

        }
    }
}
#pragma mark - - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"获取图片info = %@",info);
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"type = %@",type);
    UIImage *localImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:_choosedImages];
    [arr addObject:localImage];
    _choosedImages = arr;
    
    [self uploadSelectedImage:localImage];
    [_collection reloadData];
    
 
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - - Custom Methods
- (void)choosePhotoFromLibraryOrCamera
{
    
    UIAlertController *actionSheet = [[UIAlertController alloc]init];
    UIAlertAction *photoLibrary = [UIAlertAction actionWithTitle:@"从相册中选择" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"从相册选取");
        [self chooseImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }];
    UIAlertAction *camaera = [UIAlertAction actionWithTitle:@"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"拍照");
        [self chooseImageWithType:UIImagePickerControllerSourceTypeCamera];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style: UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"关闭");
    }];
    [actionSheet addAction:photoLibrary];
    [actionSheet addAction:camaera];
    [actionSheet addAction:cancel];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)chooseImageWithType:(UIImagePickerControllerSourceType)type
{
    switch (type) {
            case UIImagePickerControllerSourceTypePhotoLibrary: {
                [self LocalPhoto];
            }
            break;
            
            case UIImagePickerControllerSourceTypeCamera: {
                [self takePhoto];
            }
            break;
            
            case UIImagePickerControllerSourceTypeSavedPhotosAlbum: {
            }
            break;
    }
}

//打开本地相册
-(void)LocalPhoto
{
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker.delegate = self;
    //设置选择后的图片可被编辑
    _imagePicker.allowsEditing = YES;
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        //设置拍照后的图片可被编辑
        _imagePicker.allowsEditing = YES;
        _imagePicker.sourceType = sourceType;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }else{
        
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

- (void)uploadSelectedImage:(id)uploadImage
{
    
//    [self commitUserOrderComment];
  
    UIImage *image = uploadImage;
    //    image = [image scaleToSize:CGSizeMake(imageWidth, imageHeight)];
    NSString *uploadImageStr = [NSString stringWithFormat:@"%@uploadurl",@"domain"];
    
    IBAUploadFileManager *uploadManager = [IBAUploadFileManager uploadManager];
    [uploadManager uploadFile:image Path:uploadImageStr mimeType:@"image/jpeg" name:@"upload" Name:@"oneTrialReport.jpg" parameter:nil successBlock:^(id sender) {
        NSString *stateStr = [NSString stringWithFormat:@"%@",sender[@"state"]];
        
        NSLog(@"%@",sender);
        
    } failBlock:^(id sender) {
        
        NSLog(@"%@",sender);
    }];
    
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
