//
//  AVCaptureSessionVC.m
//  Test
//
//  Created by FengZi on 2018/5/29.
//  Copyright © 2018年 FengZi. All rights reserved.
//

#import "AVCaptureSessionVC.h"
#import <AVFoundation/AVFoundation.h>

@interface AVCaptureSessionVC ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation AVCaptureSessionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSError *error = nil;
    
    // 初始化会话
    _session = [[AVCaptureSession alloc] init];
    
    // 设置会话设置输出质量
    _session.sessionPreset = AVCaptureSessionPresetMedium;
    
    // 获取需要的设备
    AVCaptureDevice *device = [AVCaptureDevice
                               defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device
                                                                        error:&error];
    if (!input) {
        // Handling the error appropriately.
    }
    [_session addInput:input];
    
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    //
    AVCaptureMetadataOutput *output2 = [[AVCaptureMetadataOutput alloc] init];
    [_session addOutput:output2];
    [output2 setMetadataObjectsDelegate:self queue:queue];
    
    // 设置为二维码类型（AVMetadataObjectTypeQRCode），
    // 还有其他类型，可以去接口文件里查看
    [output2 setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // Start the session running to start the flow of data
    [_session startRunning];
    
    //预览层的生成，实时获取摄像头数据
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    self.previewLayer.frame = CGRectMake(0, 64, 300, 304);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    NSLog(@"metadataObjects = %@",metadataObjects);
    if (metadataObjects.count > 0) {
        //获得扫描数据，最后一个是最新扫描的数据
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        // 结果  object.stringValue
        dispatch_async(dispatch_get_main_queue(), ^{
//            _label.text = object.stringValue;
            
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
//            _label.text = @"没有扫描到数据";
        });
        
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
