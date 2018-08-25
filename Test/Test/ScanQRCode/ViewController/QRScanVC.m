//
//  QRScanVC.m
//  testfdsf
//
//  Created by fengzi on 2018/7/10.
//  Copyright © 2018年 Fengzi. All rights reserved.
//

#import "QRScanVC.h"
#import <AVFoundation/AVFoundation.h>
#import "ShadowView.h"
#import "ViewController.h"

@interface QRScanVC ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate>


/**
 输入数据源
 */
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;


/**
 输出数据源
 */
@property (nonatomic, strong) AVCaptureMetadataOutput *metadataOutput;


/**
 输入输出的中间桥梁，负责把捕获的音视频数据输出到设备上
 */
@property (nonatomic, strong) AVCaptureSession *session;


/**
 相机拍摄预览图层
 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

/**
 预览图层尺寸
 */
@property (nonatomic, assign) CGSize previewLayerSize;


/**
 扫描框尺寸
 */
@property (nonatomic, assign) CGSize showSize;

@property (nonatomic, strong) ShadowView *shadowView;

@end

@implementation QRScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)scanQRCode:(id)sender {
    
    
    ViewController *vc = [[ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    return;
    //开始二维码
    [self.session startRunning];
    
    [self allowScanRect];
    
    //显示范围
    self.showSize = CGSizeMake(200, 200);
    //调用
    [self createScanQR];
    //添加拍摄图层
    //添加拍摄图层
    [self.view.layer addSublayer:self.previewLayer];
    //开始二维码
    [self.session startRunning];
    //设置可用扫码范围
    [self allowScanRect];
    
    //添加上层阴影视图
    self.shadowView = [[ShadowView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
    [self.view addSubview:self.shadowView];
    self.shadowView.showSize = self.showSize;
  
    
}


- (void)createScanQR {
    //  创建输入数据源
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //  创建输出数据源
    self.metadataOutput = [[AVCaptureMetadataOutput alloc]init];
    [self.metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //  session 设置
    self.session = [[AVCaptureSession alloc]init];
    //  高质量采集
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    [self.session addInput:self.deviceInput];
    [self.session addOutput:self.metadataOutput];
    
    self.metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                                AVMetadataObjectTypeEAN13Code,
                                                AVMetadataObjectTypeEAN8Code,
                                                AVMetadataObjectTypeCode128Code];
    
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = self.view.bounds;
    // 将扫描框大小定义为属行, 下面会有调用

    self.previewLayerSize = CGSizeMake(self.previewLayer.frame.size.width, self.previewLayer.frame.size.height);
    
}

#pragma mark - 实现代理方法, 完成二维码扫描
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (metadataObjects.count > 0) {
        
        // 停止动画, 看完全篇记得打开注释, 不然扫描条会一直有动画效果
        //[self.shadowView stopTimer];
        
        //停止扫描
        [self.session stopRunning];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        NSLog(@"%@",metadataObject.stringValue);
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@", metadataObject.stringValue] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

/** 配置扫码范围 */
-(void)allowScanRect{
    
    
    /** 扫描是默认是横屏, 原点在[右上角]
     *  rectOfInterest = CGRectMake(0, 0, 1, 1);
     *  AVCaptureSessionPresetHigh = 1920×1080   摄像头分辨率
     *  需要转换坐标 将屏幕与 分辨率统一
     */
    
    //剪切出需要的大小位置
    CGRect shearRect = CGRectMake((self.previewLayerSize.width - self.showSize.width) / 2,
                                  (self.previewLayerSize.height - self.showSize.height) / 2,
                                  self.showSize.height,
                                  self.showSize.height);
    
    
    CGFloat deviceProportion = 1920.0 / 1080.0;
    CGFloat screenProportion = self.previewLayerSize.height / self.previewLayerSize.width;
    
    //分辨率比> 屏幕比 ( 相当于屏幕的高不够)
    if (deviceProportion > screenProportion) {
        //换算出 分辨率比 对应的 屏幕高
        CGFloat finalHeight = self.previewLayerSize.width * deviceProportion;
        // 得到 偏差值
        CGFloat addNum = (finalHeight - self.previewLayerSize.height) / 2;
        
        // (对应的实际位置 + 偏差值)  /  换算后的屏幕高
        self.metadataOutput.rectOfInterest = CGRectMake((shearRect.origin.y + addNum) / finalHeight,
                                                shearRect.origin.x / self.previewLayerSize.width,
                                                shearRect.size.height/ finalHeight,
                                                shearRect.size.width/ self.previewLayerSize.width);
        
    }else{
        
        CGFloat finalWidth = self.previewLayerSize.height / deviceProportion;
        
        CGFloat addNum = (finalWidth - self.previewLayerSize.width) / 2;
        
        self.metadataOutput.rectOfInterest = CGRectMake(shearRect.origin.y / self.previewLayerSize.height,
                                                (shearRect.origin.x + addNum) / finalWidth,
                                                shearRect.size.height / self.previewLayerSize.height,
                                                shearRect.size.width / finalWidth);
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
