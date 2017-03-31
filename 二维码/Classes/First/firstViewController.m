//
//  firstViewController.m
//  二维码
//
//  Created by Cnw on 2017/3/29.
//  Copyright © 2017年 Cnw. All rights reserved.
//

#import "firstViewController.h"
#import <CoreImage/CoreImage.h>


@interface firstViewController ()<UITextViewDelegate>
@property (strong, nonatomic)  UIImageView *imageView;
@property (strong, nonatomic)  UITextView *textView;

@end

@implementation firstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _imageView.backgroundColor = [UIColor redColor];
    [self setUI];
   
    
    
}
-(void)setUI
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kscreenW/4, 100, kscreenW/2, kscreenW/2)];
    [self.view addSubview:_imageView];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(spacing, CGRectGetMaxY(_imageView.frame) + spacing, kscreenW - 2 * spacing, kscreenH/3)];
    _textView.delegate = self;
    
    _textView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_textView];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self setData:textView.text];
}

-(void)setData:(NSString *)str
{
    // 1.创建二维码滤镜
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 1.1 恢复默认设置
    [filter setDefaults];
    // 2.设置过滤输入数据
    // 2.1 字符串转data
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    // 3,从二维码滤镜里面,获取结果图片
    CIImage * image = [filter outputImage];
    // 3.1缩放图片
    image = [image imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    // 4.图片处理,设置图片
    self.imageView.image = [UIImage imageWithCIImage:image];
    
}

@end
