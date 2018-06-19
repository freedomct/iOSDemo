//
//  SystemPhotoVC.m
//  Test
//
//  Created by FengZi on 2018/4/16.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "SystemPhotoVC.h"
#import <Photos/Photos.h>
#import "ImageCell.h"

@interface SystemPhotoVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollection;

@property (nonatomic, strong) NSMutableArray *imageArr;

@end

@implementation SystemPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageArr = [NSMutableArray arrayWithCapacity:0];
    
    
//    PHFetchOptions *options = [PHFetchOptions new];
//
//    PHFetchResult *topLevelUserCollections = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:options];
//
//    PHAssetCollectionSubtype subType = PHAssetCollectionSubtypeAlbumRegular;
//    PHFetchResult *smartAlbumsResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
//                                                                                subtype:subType
//                                                                                options:options];
//
//    [smartAlbumsResult enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isKindOfClass:[PHAssetCollection class]]) {
//            PHAssetCollection *asset = (PHAssetCollection *)obj;
//            PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:asset options:[PHFetchOptions new]];
//            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [self.imageArr addObject:obj];
//            }];
//
//        }
//    }];
//
//
//    [self.photoCollection reloadData];
    
    
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    
    //获取相机胶卷所有图片
    PHFetchResult *assets = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    
    //设置显示模式
    /*
     PHImageRequestOptionsResizeModeNone    //选了这个就不会管传如的size了 ，要自己控制图片的大小，建议还是选Fast
     PHImageRequestOptionsResizeModeFast    //根据传入的size，迅速加载大小相匹配(略大于或略小于)的图像
     PHImageRequestOptionsResizeModeExact    //精确的加载与传入size相匹配的图像
     */
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.synchronous = NO;
    option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
//    CGSize imageSize = CGSizeMake(CGRectGetWidth(self.view.frame)/4, CGRectGetWidth(self.view.frame)/4);
    typeof(self)weakSelf = self;
    for (PHAsset *asset in assets) {
//        NSLog(@"%@",asset);
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(screenSize.width * 0.5, screenSize.height * 0.5) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            //我这里用个模型接储存了图片的 localIdentifier 和图片本身
            //还有很多信息，根据自己的需求来取
//            CellModel * model = [CellModel new];
//            model.localIdentifier = asset.localIdentifier;
//            model.image = [UIImage imageWithData:UIImageJPEGRepresentation(result, 0.5)];
            NSLog(@"info = %@",info);
            [weakSelf.imageArr addObject:result];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
//                NSLog(@"imageArr = %@",self.imageArr);
                [weakSelf.photoCollection reloadData];
            });
            
        }];
        
    }
    
  

}

//  获取所有相册中的原图
- (void)getOriginalImages {
    
    PHFetchResult *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];

    for (PHAssetCollection *assetCollection in assetCollections) {
        
        [self enumerateAssetsInAssetCollection:assetCollection original:YES];
    }
    
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    // 遍历相机胶卷,获取大图
    [self enumerateAssetsInAssetCollection:cameraRoll original:YES];
    
}

//  获取相册中所有的缩略图
- (void)getThumbnailImages
{
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
//    for (PHAssetCollection *assetCollection in assetCollections) {
//
//        if ([assetCollection.localizedTitle isEqualToString:@"Camera Roll"]) {
//            [self enumerateAssetsInAssetCollection:assetCollection original:NO];
//
//        }
//    }
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [self enumerateAssetsInAssetCollection:cameraRoll original:NO];
}



/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original
{
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
    for (PHAsset *asset in assets) {
        [self.imageArr addObject:asset];

        NSLog(@"asset = %@",asset);
//        // 是否要原图
//        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
//
//        dispatch_queue_t imageQueue = dispatch_queue_create("com.yang.image", DISPATCH_QUEUE_CONCURRENT);
//        dispatch_async(imageQueue, ^{
//            // 从asset中获得图片
//            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
////                NSLog(@"%@", info);
////                NSString *fileURLKey = [NSString stringWithFormat:@"%@",info[@"PHImageFileURLKey"]];
//                [self.imageArr addObject:result];
//            }];
//            NSLog(@"imageArr = %@",self.imageArr);
//        });
        
    }
    NSLog(@"self.imageArr = %@",self.imageArr);

}



#pragma mark - - UICollectionViewDataSource UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    [cell updateCellWithImage:self.imageArr[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArr.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.view.frame)/4, CGRectGetWidth(self.view.frame)/4);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIView *baseView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    baseView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = self.imageArr[indexPath.row];
    imageview.frame = [[UIScreen mainScreen]bounds];
    [baseView addSubview:imageview];
    [[UIApplication sharedApplication].keyWindow addSubview:baseView];
    
    
    UITapGestureRecognizer *dismiss = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
    [baseView addGestureRecognizer:dismiss];
}

- (void)dismiss:(UIGestureRecognizer *)gesture {
    UIView *superView = gesture.view;
    [superView removeFromSuperview];
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
