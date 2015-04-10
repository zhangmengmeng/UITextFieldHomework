//
//  QYViewController.m
//  UITextFieldHomework
//
//  Created by qingyun on 15-2-9.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"

@interface QYViewController ()

@end

@implementation QYViewController

- (void)loadView
{
    // 将self.view设置成一个UIControl，添加点击事件，辅助隐藏文本框的第一响应者
    self.view = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    [(UIControl *)self.view addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchDown];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 500, 220, 44)];
    _textField.borderStyle = UITextBorderStyleBezel;
    _textField.delegate = self;
    [self.view addSubview:_textField];
    
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myButton.frame = CGRectMake(50, 100, 220, 44);
    myButton.backgroundColor = [UIColor blueColor];
    [myButton setTitle:@"点我" forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:myButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 点击背景使文本框失去第一响应者
- (void)clickBack
{
    [_textField resignFirstResponder];
}

- (void)clickButton
{
    NSLog(@"clicking");
}

// 文本框进入编辑状态时，判断文本框的上边距，自身高度和距离键盘的距离，是否大于键盘的上边距，是则将self。view上衣该差值即可实现屏幕上移
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect oldFrame = _textField.frame;
    
    float offset = oldFrame.origin.y+oldFrame.size.height+20 - (self.view.frame.size.height -216);
    float width = [[UIScreen mainScreen] bounds].size.width;
    float height = [[UIScreen mainScreen] bounds].size.height;
    
    if (offset > 0) {
        [UIView beginAnimations:@"resetViewHeight" context:nil];
        [UIView setAnimationDuration:0.3];
        CGRect rect =  CGRectMake(0, -offset, width, height);
        self.view.frame = rect;
        [UIView commitAnimations];
    }
}

// 失去第一响应者的时候将self.view的frame复原
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"resetViewHeight" context:nil];
    [UIView setAnimationDuration:0.1];
    self.view.frame = [[UIScreen mainScreen] bounds];
    [UIView commitAnimations];
}
@end
