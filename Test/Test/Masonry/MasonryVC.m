//
//  MasonryVC.m
//  Test
//
//  Created by FengZi on 2018/4/16.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "MasonryVC.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Masonry/Masonry.h>
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

#import <Photos/Photos.h>
#import <ZLPhotoBrowser/ZLPhotoActionSheet.h>
#define RGB(r, g, b)   [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

#define Bounds [[UIScreen mainScreen] bounds]
@interface MasonryVC ()<PHPhotoLibraryChangeObserver,UIGestureRecognizerDelegate,UITextViewDelegate>

@property (nonatomic, assign) BOOL isExpanded;

@property (nonatomic, assign) CGFloat scale;

@property (nonatomic, strong) UIButton *growingButton;

@property (nonatomic, strong) UIView *redView;

@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) UIView *yellowView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UITextView *commentTextView;

@end

@implementation MasonryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc]init];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);

    }];
    
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.safeAreaInsets.left);
//        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.right.mas_equalTo(self.view.safeAreaInsets.right);
        
        make.height.mas_equalTo(100);
    }];
    
    NSLog(@"%f",self.view.safeAreaInsets.bottom);
    return;
    
    
    //    [self createView];
    
    //    [self createAnotherView];
    
    //    [self priorityLowView];
    
    //    [self testBasic];
    
    //    [self createGrowingButton];
    
    //    [self multipliedByTest];
    
    
    
    
    
    //    [self labelTest];
    
    //    [self exp4];
    
    //    UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    tempButton.backgroundColor = [UIColor redColor];
    //    [tempButton addTarget:self action:@selector(addView) forControlEvents:UIControlEventAllTouchEvents];
    //    [self.view addSubview:tempButton];
    //
    //    [tempButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.center.equalTo(self.view);
    //        make.width.mas_equalTo(100);
    //        make.height.mas_equalTo(50);
    //
    //    }];
    
    
    
    //    UITextField *file = [[UITextField alloc]init];
    //    file.backgroundColor = [UIColor blackColor];
    //    file.placeholder = @"yang";
    //    [self.view addSubview:file];
    //    [file mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(self.view).with.offset(40);
    //        make.centerX.equalTo(self.view);
    //        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.view.frame), 20));
    //    }];
    
    
    UIScrollView *baseScrollView = [[UIScrollView alloc]init];
    baseScrollView.backgroundColor = [UIColor whiteColor];
    baseScrollView.contentSize =CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    baseScrollView.showsVerticalScrollIndicator = NO;
    baseScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:baseScrollView];
    
    [baseScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    _contentView = [[UIView alloc]init];
    _contentView.backgroundColor = [UIColor grayColor];
    [baseScrollView addSubview:_contentView];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(baseScrollView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.equalTo(baseScrollView.mas_width);
        make.height.mas_equalTo((CGRectGetWidth(Bounds) - 20)/3 + 500);
        
    }];
    
    _commentTextView = [[UITextView alloc]init];
    _commentTextView.delegate = self;
    _commentTextView.backgroundColor = [UIColor redColor];
    
    _commentTextView.font = [UIFont systemFontOfSize:13.0f];
    _commentTextView.backgroundColor = [UIColor clearColor];
    [_contentView addSubview:_commentTextView];
    
    [_commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.mas_equalTo(_tempTextView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.view).offset(44);
        
        
    }];
    //    UIScrollView *baseScrollView = [[UIScrollView alloc]init];
    //    baseScrollView.backgroundColor = [UIColor blackColor];
    //    baseScrollView.pagingEnabled = YES;
    //    baseScrollView.delegate = self;
    //    baseScrollView.contentSize = CGSizeMake( CGRectGetWidth(self.view.frame) * 2 , CGRectGetHeight(self.view.frame)/10);
    //    baseScrollView.showsVerticalScrollIndicator = YES;
    //    baseScrollView.showsHorizontalScrollIndicator = YES;
    //    [self.view addSubview:baseScrollView];
    
    //    [baseScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    //    }];
    
    NSArray *temps = @[@"1",@"2"];
    [temps enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.backgroundColor = ([obj isEqualToString:@"1"]) ? [UIColor whiteColor] : [UIColor redColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(CGRectGetWidth(self.view.frame) * idx, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        
        [baseScrollView addSubview:imageView];
        
    }];
    
}
- (void)exp4 {
    
    //  声明区域 displayView 是显示区域 keyboardView 是键盘区域
    //  displayView
    
    UIView *displayView = [[UIView alloc]init];
    displayView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:displayView];
    
    UIView *keyboardView = [[UIView alloc]init];
    [self.view addSubview:keyboardView];
    
    //  先按1 ： 3分割 dispalyView （显示结果区域） 和 keyboardViewView （键盘区域）
    [displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(keyboardView).multipliedBy(0.3f);
    }];
    
    [keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(displayView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.and.right.equalTo(self.view);
    }];
    
    
    // 设置显示位置的数字为0
    UILabel *displayNum = [[UILabel alloc]init];
    [displayView addSubview:displayNum];
    displayNum.text = @"0";
    displayNum.font = [UIFont fontWithName:@"HeiTi SC" size:70];
    
    displayNum.textColor = [UIColor whiteColor];
    displayNum.textAlignment = NSTextAlignmentRight;
    [displayNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(displayView).with.offset(-10);
        make.bottom.equalTo(displayView).with.offset(-10);
    }];
    
    //  定义键盘键名称 ？ 号代表合并的单元格
    NSArray *keys = @[@"AC",@"+/-",@"%",@"÷"
                      ,@"7",@"8",@"9",@"x"
                      ,@"4",@"5",@"6",@"-"
                      ,@"1",@"2",@"3",@"+"
                      ,@"0",@"?",@".",@"="
                      ];
    
    int indexOfKeys = 0;
    for (NSString *key in keys) {
        
        //  循环所有键
        indexOfKeys ++;
        int rowNum = indexOfKeys % 4 == 0 ? (indexOfKeys / 4) : (indexOfKeys / 4) + 1;
        int colNum = indexOfKeys % 4 == 0 ? 4 : indexOfKeys % 4;
        NSLog(@"indexOfKeys = %d  rowNum = %d colNUm = %d",indexOfKeys,rowNum,colNum);
        UIButton *keyView = [UIButton buttonWithType:UIButtonTypeCustom];
        [keyboardView addSubview:keyView];
        
        [keyView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [keyView setTitle:key forState:UIControlStateNormal];
        
        [keyView.layer setBorderWidth:1];
        [keyView.layer setBorderColor:[UIColor blackColor].CGColor];
        
        
        [keyView.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30]];
        [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
            if ([key isEqualToString:@"0"] || [key isEqualToString:@"?"]) {
                if ([key isEqualToString:@"0"]) {
                    [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(keyboardView.mas_height).with.multipliedBy(0.2);
                        make.width.equalTo(keyboardView.mas_width).multipliedBy(0.5);
                        make.left.equalTo(keyboardView.mas_left);
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(0.9f);
                        
                    }];
                }
                if ([key isEqualToString:@"?"]){
                    [keyView removeFromSuperview];
                    
                    
                }
            }
            //  处理0 合并单元格
            else{
                //  正常的单元格
                make.width.equalTo(keyboardView.mas_width).with.multipliedBy(0.25);
                make.height.equalTo(keyboardView.mas_height).with.multipliedBy(0.2f);
                switch (rowNum) {
                    case 1:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(0.1f);
                        keyView.backgroundColor = [UIColor colorWithRed:205 green:205 blue:205 alpha:1];
                        
                    }
                        break;
                    case 2:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(0.3f);
                    }
                        break;
                    case 3:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(0.5f);
                    }
                        break;
                    case 4:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(0.7f);
                    }
                        break;
                    case 5:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(0.9f);
                    }
                        break;
                        
                    default:
                        break;
                }
                switch (colNum) {
                    case 1:
                        
                    {
                        make.left.equalTo(keyboardView.mas_left);
                    }
                        break;
                        
                    case 2:
                    {
                        make.right.equalTo(keyboardView.mas_centerX);
                    }
                        break;
                    case 3:
                    {
                        
                        make.left.equalTo(keyboardView.mas_centerX);
                    }
                        break;
                    case 4:
                    {
                        make.right.equalTo(keyboardView.mas_right);
                        [keyView setBackgroundColor:[UIColor colorWithRed:243 green:127 blue:38 alpha:1]];
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
    }
}
- (void)photoTest {
    
    
    ZLPhotoConfiguration *photoConfig = [ZLPhotoConfiguration defaultPhotoConfiguration];
    photoConfig.maxSelectCount = 10;
    photoConfig.maxPreviewCount = 20;
    
    ZLPhotoActionSheet *photpActionSheet = [[ZLPhotoActionSheet alloc] init];
//    photpActionSheet.configuration = photoConfig;
    
    photpActionSheet.sender = self;
    
    [photpActionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        //your codes
        NSLog(@"images = %@",images);
        
    }];
    
    //调用相册
    [photpActionSheet showPhotoLibrary];
    return;
    [photpActionSheet showPreviewAnimated:YES];
    
    //预览网络图片
    //    [actionSheet previewPhotos:arrNetImages index:0 hideToolBar:YES complete:^(NSArray * _Nonnull photos) {
    //        //your codes
    //
    //        NSLog(@"photos = %@",photos);
    //    }];
}
- (void)achievePhotos {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        
        //  无法访问相册
        NSLog(@"无法访问相册");
    }else{
        NSLog(@"访问相册");
        
        [[PHPhotoLibrary sharedPhotoLibrary]registerChangeObserver:self];
        [self getAllAssetInPhotoAblumWithAscending:YES];
    }
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //  刷新UI
    });
    
}

#pragma mark - 获取相册内所有照片资源
- (NSArray<PHAsset *> *)getAllAssetInPhotoAblumWithAscending:(BOOL)ascending
{
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    //ascending 为YES时，按照照片的创建时间升序排列;为NO时，则降序排列
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    
    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:option];
    
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAsset *asset = (PHAsset *)obj;
        NSLog(@"照片名%@", [asset valueForKey:@"filename"]);
        [assets addObject:asset];
    }];
    
    return assets;
}

- (void)photosWithAsset:(NSArray *)asset {
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    //仅显示缩略图，不控制质量显示
    /**
     PHImageRequestOptionsResizeModeNone,
     PHImageRequestOptionsResizeModeFast, //根据传入的size，迅速加载大小相匹配(略大于或略小于)的图像
     PHImageRequestOptionsResizeModeExact //精确的加载与传入size相匹配的图像
     */
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.networkAccessAllowed = YES;
    //param：targetSize 即你想要的图片尺寸，若想要原尺寸则可输入PHImageManagerMaximumSize
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        //解析出来的图片
        NSLog(@"image = %@",image);
    }];
}

- (void)labelTest {
    
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"显示1显示1显示1显示1显示1显示1显示1显示1显示1";
    label1.backgroundColor = [UIColor redColor];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.backgroundColor = [UIColor blackColor];
    label2.text = @"显示2显示2显示2显示2显示2显示2显示2";
    [self.view addSubview:label2];
    
    //    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.and.top.equalTo(self.view).width.offset(10);
    //        make.height.mas_equalTo(40);
    //        make.width.mas_equalTo(label2.mas_width);
    //    }];
    //
    
    
    // label1: 位于左上角
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.left.equalTo(self.view.mas_left).with.offset(2);
        // 40高度
        make.height.equalTo(@40);
    }];
    // label2: 位于右上角
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //左边贴着label1，间隔2
        make.left.equalTo(label1.mas_right).with.offset(5);
        //上边贴着父view，间隔5
        make.top.equalTo(self.view.mas_top).with.offset(100);
        //右边的间隔保持大于等于2，注意是lessThanOrEqual
        //这里的“lessThanOrEqualTo”放在从左往右的X轴上考虑会更好理解。
        //即：label2的右边界的X坐标值“小于等于”containView的右边界的X坐标值。
        make.right.lessThanOrEqualTo(self.view.mas_right).with.offset(-2);
        //只设置高度40
        make.height.equalTo(@40);
    }];
    //    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.and.right.equalTo(self.view).with.offset(10);
    //
    //    }];
    
    
    //设置label1的content hugging 为1000
    [label1 setContentHuggingPriority:UILayoutPriorityRequired
                              forAxis:UILayoutConstraintAxisHorizontal];
    
    [label1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //设置label1的content compression 为1000
    [label1 setContentCompressionResistancePriority:UILayoutPriorityRequired
                                            forAxis:UILayoutConstraintAxisHorizontal];
    [label1 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //设置右边的label2的content hugging 为1000
    [label2 setContentHuggingPriority:UILayoutPriorityRequired
                              forAxis:UILayoutConstraintAxisHorizontal];
    [label2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //设置右边的label2的content compression 为250
    [label2 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                            forAxis:UILayoutConstraintAxisHorizontal];
    [label2 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    
}

- (void)viewTest {
    
    UIView *view1 = [[UIView alloc]init];
    [self.view addSubview:view1];
    UIEdgeInsets insert = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(insert);
    }];
    [self comments];
}

- (void)comments {
    
    UIScrollView *baseScrollView = [[UIScrollView alloc]init];
    baseScrollView.contentSize =CGSizeMake(CGRectGetWidth(self.view.frame), 1000);
    baseScrollView.showsVerticalScrollIndicator = YES;
    baseScrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:baseScrollView];
    
    [baseScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor whiteColor];
    [baseScrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(baseScrollView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.equalTo(baseScrollView.mas_width);
        make.height.equalTo(baseScrollView).with.offset(baseScrollView.contentSize.height);
    }];
    
    UIView *infoView = [[UIView alloc]init];
    infoView.backgroundColor = [UIColor redColor];
    [contentView addSubview:infoView];
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(contentView).with.offset(0);
        make.height.mas_equalTo(200);
    }];
    
}

- (void)multipliedByTest {
    
    UIView *topView = [[UIView alloc]init];
    [topView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:topView];
    
    UIView *topInnerView = [[UIView alloc]init];
    [topInnerView setBackgroundColor:[UIColor greenColor]];
    [topView addSubview:topInnerView];
    
    UIView *bottomView = [[UIView alloc]init];
    [bottomView setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:bottomView];
    
    UIView *bottomInnerView = [[UIView alloc]init];
    [bottomInnerView setBackgroundColor:[UIColor blueColor]];
    [bottomView addSubview:bottomInnerView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(bottomView);
    }];
    [topInnerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(topInnerView.mas_height).multipliedBy(3);
        make.center.mas_equalTo(topView);
    }];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(topView);
        make.top.mas_equalTo(topView.mas_bottom);
    }];
    [bottomInnerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(bottomView);
        make.height.mas_equalTo(bottomInnerView.mas_width).multipliedBy(3);
        make.center.mas_equalTo(bottomView);
    }];
}

- (void)createGrowingButton {
    self.isExpanded = NO;
    
    self.growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.growingButton setTitle:@"点我展开" forState:UIControlStateNormal];
    self.growingButton.layer.borderColor = UIColor.greenColor.CGColor;
    self.growingButton.layer.borderWidth = 3;
    self.growingButton.backgroundColor = [UIColor redColor];
    [self.growingButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.growingButton];
    
    self.scale = 1.0;
    [self.growingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-350);
    }];
    //    [self.growingButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.center.equalTo(self.view);
    //        make.width.height.mas_equalTo(100 * self.scale);
    //        make.width.height.lessThanOrEqualTo(self.view);
    //
    //    }];
}

- (void)buttonClick {
    
    
    self.isExpanded = !self.isExpanded;
    if (!self.isExpanded) {
        [self.growingButton setTitle:@"点我展开" forState:UIControlStateNormal];
    } else {
        [self.growingButton setTitle:@"点我收起" forState:UIControlStateNormal];
    }
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    return;
    self.scale += 1.0;
    
    //  告诉self.view 约束需要更新
    [self.view setNeedsUpdateConstraints];
    
    //  调用此方法告诉self.view 检测是否需要服更新约束 若需要更新 下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
}
- (void)updateViewConstraints {
    
    
    //  这里写需要更新的约束 不用更新的约束将继续存在
    //  不会被取代 如其宽高小于屏幕宽高不需要重新再约束
    //    [self.growingButton mas_updateConstraints:^(MASConstraintMaker *make) {
    //
    //        make.width.height.mas_equalTo(100 * self.scale);
    //    }];
    
    
    // 这里使用update也能实现效果
    // remake会将之前的全部移除，然后重新添加
    __weak __typeof(self) weakSelf = self;
    [self.growingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        // 这里重写全部约束，之前的约束都将失效
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        if (weakSelf.isExpanded) {
            make.bottom.mas_equalTo(0);
        } else {
            make.bottom.mas_equalTo(-350);
        }
    }];
    [super updateViewConstraints];
}





- (void)testBasic {
    
    int padding = 15;
    
    UIView *greenView = [[UIView alloc]init];
    greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:greenView];
    
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).with.offset(padding);  //  x
        make.top.mas_equalTo(self.view.mas_top).with.offset(padding);  //  y
        make.bottom.mas_equalTo(blueView.mas_top).with.offset(-padding);  // Y
        make.width.mas_equalTo(redView);
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(greenView.mas_right).with.offset(padding);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-padding);
        make.bottom.and.height.mas_equalTo(greenView);
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).with.offset(padding);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-padding);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-padding);
        make.height.mas_equalTo(greenView);
    }];
    
    
}
- (void)priorityLowView {
    
    //  redView
    _redView = [[UIView alloc]init];
    _redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redView];
    
    
    //  blue view
    _blueView = [[UIView alloc]init];
    _blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_blueView];
    
    //  yellow view
    _yellowView = [[UIView alloc]init];
    _yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_yellowView];
    
    
    
    [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-80);
        make.height.equalTo([NSNumber numberWithInt:50]);
    }];
    
    
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.redView.mas_right).with.offset(40);
        make.bottom.width.height.mas_equalTo(self.redView);
    }];
    
    
    [_yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.blueView.mas_right).with.offset(40);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.bottom.width.height.mas_equalTo(self.redView);
        
        make.left.mas_equalTo(self.redView.mas_right).with.offset(20).priority(750);
    }];
    
    
    
}


- (void)createAnotherView {
    
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view1];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(150, 30, 30, 30);
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).with.offset(padding.top);
        make.left.equalTo(self.view.mas_left).with.offset(padding.left);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(padding.bottom);
        make.right.equalTo(self.view.mas_right).with.offset(padding.right);
    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).with.insets(padding);
    }];
    
}
- (void)createView {
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor redColor];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@10);
        make.left.equalTo(@10);
        make.bottom.equalTo(@(-10));
        make.right.equalTo(@(-10));
    }];
}

- (void)addView {
    [self imageScroll:@[]];
}

- (void)imageScroll:(NSArray *)images {
    
    UIScrollView *baseScrollView = [[UIScrollView alloc]init];
    baseScrollView.backgroundColor = [UIColor blackColor];
    baseScrollView.pagingEnabled = YES;
    baseScrollView.contentSize = CGSizeMake( CGRectGetWidth(self.view.frame) * 4, CGRectGetHeight(self.view.frame));
    baseScrollView.showsVerticalScrollIndicator = YES;
    baseScrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:baseScrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
    [baseScrollView addGestureRecognizer:tap];
    
    
    [baseScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    NSArray *temps = @[
                       @"https://mobile.ibalife.com/images/icon_Authentic.png",
                       @"https://mobile.ibalife.com/images/icon_boss.png",
                       @"https://mobile.ibalife.com/images/icon_o2o.png",
                       @"https://mobile.ibalife.com/images/icon_pc.png"
                       ];
    
    [temps enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(CGRectGetWidth(self.view.frame) * idx, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        
        
        [imageView setImageWithURL:[NSURL URLWithString:obj] placeholderImage:nil];
        
        
        [baseScrollView addSubview:imageView];
        
        NSString *desTitle = [NSString stringWithFormat:@"%lu/%lu",(idx + 1),(unsigned long)temps.count];
        UILabel *desLabel = [[UILabel alloc]init];
        desLabel.textColor = [UIColor whiteColor];
        desLabel.text = desTitle;
        [imageView addSubview:desLabel];
        [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(imageView).with.offset(20);
            make.centerX.equalTo(imageView.mas_centerX);
        }];
    }];
    
}

- (void)dismiss:(UITapGestureRecognizer *)tap {
    
    [tap.view removeFromSuperview];
}
- (IBAction)add:(id)sender {
    
//    self.loabel1.text = [self.loabel1.text stringByAppendingString:@"add"];
}

- (IBAction)plus:(id)sender {
    
    
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"点击");
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点击");
    return;
    [self.blueView removeFromSuperview];
    [UIView animateWithDuration:1.0 animations:^{
        
        [self.view layoutIfNeeded];
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
