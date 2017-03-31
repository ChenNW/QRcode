//
//  secondViewController.m
//  二维码
//
//  Created by Cnw on 2017/3/29.
//  Copyright © 2017年 Cnw. All rights reserved.
//

#import "secondViewController.h"

@interface secondViewController ()
/** imagview */
@property(nonatomic ,strong)UIImageView *imageView;
/** 开始识别按钮 */
@property(nonatomic ,strong)UIButton *btn;
/** label */
@property(nonatomic ,strong)UILabel *textLabel;
@end

@implementation secondViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // 图片
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100,  kscreenW- 40, 150)];
    _imageView.image = [UIImage imageNamed:@"123"];
    [self.view addSubview:_imageView];

    // 按钮
    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(kscreenW/3, CGRectGetMaxY(_imageView.frame) + 20, kscreenW/3, 44)];
    [self.btn setTitle:@"开始识别" forState:UIControlStateNormal];
    self.btn.backgroundColor = [UIColor orangeColor];
    [self.btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
    // 显示信息
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.btn.frame) + 60, _imageView.frame.size.width, 44)];
    self.textLabel.backgroundColor = [UIColor purpleColor];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.textLabel];
    
}
-(void)btnClick
{

    // 1. 需要获取的图片
    CIImage * image = [[CIImage alloc] initWithImage:_imageView.image];
    
    // 2.开始识别
    CIDetector  * detetor = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];

    // 3.探测二维码特征
      NSArray * fetures = [detetor featuresInImage:image];
    // 4.遍历数组
    for (CIFeature * feature  in fetures) {
        CIQRCodeFeature * fe = (CIQRCodeFeature *)feature;
        _textLabel.text = fe.messageString;
    }
}
@end
