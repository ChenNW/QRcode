//
//  thirdViewController.m
//  二维码
//
//  Created by Cnw on 2017/3/29.
//  Copyright © 2017年 Cnw. All rights reserved.
//

#import "thirdViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface thirdViewController ()<AVCaptureMetadataOutputObjectsDelegate>
/** session */
@property(nonatomic ,strong)AVCaptureSession *session;
@end

@implementation thirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 扫描
    AVCaptureSession * session = [[AVCaptureSession alloc] init];
    // 1. 设置输入
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 把摄像头当做输入设备
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [session addInput:input];
    
    // 2. 设置输出
    AVCaptureMetadataOutput * outInput = [[AVCaptureMetadataOutput alloc] init];
    
    // 设置输出结果的代理
    [outInput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:outInput];
    // 3. 创建会话,连接输入和输
    // 3.1 设置二维码可以识别的码制
    [outInput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    // 3.2 添加视频预览图层
    AVCaptureVideoPreviewLayer * layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
    // 4. 启动扫描
    [session startRunning];

}

// 代理方法,扫描到结果调用
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{

    if (metadataObjects.count >0) {
        AVMetadataMachineReadableCodeObject * objt = [metadataObjects lastObject];
        NSLog(@"---------%@-------",objt);
    }
}
@end
