//
//  ForgetPasswordViewController1.m
//  bkgyl
//
//  Created by 黄诸龙 on 16/10/10.
//  Copyright © 2016年 刘施施. All rights reserved.
//

#import "ForgetPasswordViewController1.h"
#import "ForgetPasswordViewController2.h"

@interface ForgetPasswordViewController1 ()<UITextFieldDelegate>
{
    UITextField *_telField;
    UITextField *_codeField;
}

@end

@implementation ForgetPasswordViewController1

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
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake( 10, 64 + 12, 15, 20)];
    imageView.image = [UIImage imageNamed:@"reg_tel"];
    [self.view addSubview:imageView];
    
    _telField = [[UITextField alloc] initWithFrame:CGRectMake(imageView.right + 14 , 64, kScreenWidth - 55, 44)];
    _telField.delegate = self;
    _telField.textColor = brown_label_color;
    _telField.font = HGfont(14);
    _telField.placeholder = @"请输入11位手机号";
    [self.view addSubview:_telField];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, _telField.bottom, kScreenWidth, 1)];
    lineView1.backgroundColor = HGColor(235, 235, 235);
    [self.view addSubview:lineView1];
    
    _codeField = [[UITextField alloc] initWithFrame:CGRectMake(imageView.right + 14 , lineView1.bottom, kScreenWidth - 55, 44)];
    _codeField.delegate = self;
    _codeField.textColor = brown_label_color;
    _codeField.font = HGfont(14);
    _codeField.placeholder = @"请输入手机验证码";
    [self.view addSubview:_codeField];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, _codeField.bottom, kScreenWidth, 1)];
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
    ForgetPasswordViewController2 *vc =  [[ForgetPasswordViewController2 alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
    [_telField resignFirstResponder];
    [_codeField resignFirstResponder];
}

@end
