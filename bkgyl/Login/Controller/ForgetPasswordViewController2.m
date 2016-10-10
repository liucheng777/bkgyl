//
//  ForgetPasswordViewController2.m
//  bkgyl
//
//  Created by 黄诸龙 on 16/10/10.
//  Copyright © 2016年 刘施施. All rights reserved.
//

#import "ForgetPasswordViewController2.h"


@interface ForgetPasswordViewController2 ()<UITextFieldDelegate>
{
    UITextField *_password;
    UITextField *_password1;
}

@end

@implementation ForgetPasswordViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
    self.title = @"找回密码";
    [self _createView];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    UIImage *image = [[UIImage alloc] init];
    //    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setShadowImage:image];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    [self.navigationController.navigationItem setLeftBarButtonItem:left];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

-(void)_createView
{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake( 10, 64 + 10, 24, 24)];
    imageView.image = [UIImage imageNamed:@"password"];
    [self.view addSubview:imageView];
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake(imageView.right + 14 , 64, kScreenWidth - 55, 44)];
    _password.delegate = self;
    _password.textColor = brown_label_color;
    _password.font = HGfont(14);
    _password.placeholder = @"请输入6-16位密码";
    [self.view addSubview:_password];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, _password.bottom, kScreenWidth, 1)];
    lineView1.backgroundColor = HGColor(235, 235, 235);
    [self.view addSubview:lineView1];
    
    _password1 = [[UITextField alloc] initWithFrame:CGRectMake(imageView.right + 14 , lineView1.bottom, kScreenWidth - 55, 44)];
    _password1.delegate = self;
    _password1.textColor = brown_label_color;
    _password1.font = HGfont(14);
    _password1.placeholder = @"请再次确认6-16位密码";
    [self.view addSubview:_password1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, _password1.bottom, kScreenWidth, 1)];
    lineView2.backgroundColor = HGColor(235, 235, 235);
    [self.view addSubview:lineView2];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(45, lineView2.bottom + 90, kScreenWidth - 90, 44);
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:brown_label_color forState:UIControlStateNormal];
    nextButton.titleLabel.font = HGfont(16);
    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    nextButton.backgroundColor = brown_button_color;
    [self.view addSubview:nextButton];
    
}

-(void)nextAction
{
    NSLog(@"下一步");
}

//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_password1 resignFirstResponder];
    [_password resignFirstResponder];
}

@end
