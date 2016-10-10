//
//  LoginViewController.m
//  bkgyl
//
//  Created by 黄诸龙 on 16/10/7.
//  Copyright © 2016年 刘施施. All rights reserved.
//

#import "LoginViewController.h"
#import "TYAttributedLabel.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UITextField *_accountField;
    UITextField *_passwordField;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
    self.view.backgroundColor = HGColor(180, 148, 106);
    [self _createView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    UIImage *image = [[UIImage alloc] init];
    //    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setShadowImage:image];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] init];
    [self.navigationController.navigationItem setLeftBarButtonItem:left];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    self.navigationController.navigationBar.hidden = NO;
//}

-(void)_createView
{
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0 - 88, 80, 185, 176)];
    logoImageView.image = [UIImage imageNamed:@"loginLogol"];
    [self.view addSubview:logoImageView];
    
    UIImageView *accountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(48, logoImageView.bottom + 5, 24, 24)];
    accountImageView.image = [UIImage imageNamed:@"account"];
    [self.view addSubview:accountImageView];
    
    _accountField = [[UITextField alloc] initWithFrame:CGRectMake(accountImageView.right + 8, accountImageView.top, kScreenWidth - 130, 24)];
    _accountField.textColor = brown_button_color;
    _accountField.placeholder = @"请输入账号";
    _accountField.delegate = self;
    _accountField.font = HGfont(12);
    [_accountField setValue:brown_button_color forKeyPath:@"_placeholderLabel.textColor"];

    [self.view addSubview:_accountField];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(accountImageView.left, accountImageView.bottom + 8, kScreenWidth - 96, 1)];
    lineView.backgroundColor = brown_label_color;
    [self.view addSubview:lineView];
    
    UIImageView *passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(48, lineView.bottom + 8, 24, 24)];
    passwordImageView.image = [UIImage imageNamed:@"password"];
    [self.view addSubview:passwordImageView];
    
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(passwordImageView.right + 8, passwordImageView.top, kScreenWidth - 130, 24)];
    _passwordField.delegate = self;
    _passwordField.textColor = brown_button_color;
    _passwordField.placeholder = @"请输入密码";
    _passwordField.font = HGfont(12);
    _passwordField.secureTextEntry = YES;
    _passwordField.clearButtonMode = UITextFieldViewModeAlways;
    [_passwordField setValue:brown_button_color forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:_passwordField];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(accountImageView.left, passwordImageView.bottom + 8, kScreenWidth - 96, 1)];
    lineView1.backgroundColor = brown_label_color;
    [self.view addSubview:lineView1];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(lineView.left, lineView1.bottom + 20, lineView1.width, 40);
    [loginButton setBackgroundColor:brown_button_color];
    [loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:brown_label_color forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    TYAttributedLabel *label = [[TYAttributedLabel alloc] initWithFrame:CGRectMake(loginButton.left, loginButton.bottom + 10 , 150, 18)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    label = [CommonUtil getLabel:label str:[NSString stringWithFormat:@"还没有账号？<c>立即注册<c>"] color:@[brown_button_color,brown_label_color] font:@[@12]];
    [self.view addSubview:label];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerAction)];
    [label addGestureRecognizer:tap];
    
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetButton.frame = CGRectMake(loginButton.right - 60, label.top, 60, 18);
    forgetButton.titleLabel.font = HGfont(12);
    forgetButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetButton addTarget:self action:@selector(forgetButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [forgetButton setTitleColor: brown_label_color forState:UIControlStateNormal]; ;
    [self.view addSubview:forgetButton];
    
    [self _createThirdLoginView];
    
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
    [self.view endEditing:YES];
//    [_passwordField resignFirstResponder];
}

-(void)registerAction
{
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loginButtonAction
{
    NSLog(@"登录");
}

-(void)forgetButtonAction
{
    NSLog(@"忘记密码");
    ForgetPasswordViewController *vc = [[ForgetPasswordViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)_createThirdLoginView
{
    UIButton *qq = [UIButton buttonWithType:UIButtonTypeCustom];
    qq.frame = CGRectMake(kScreenWidth /2.0 - 35, kScreenHeight - 70, 30, 30);
    [qq setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [qq addTarget:self action:@selector(qqLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qq];
    
    UIButton *weChat = [UIButton buttonWithType:UIButtonTypeCustom];
    weChat.frame = CGRectMake(kScreenWidth /2.0 + 5 , kScreenHeight - 70, 30, 30);
    [weChat setImage:[UIImage imageNamed:@"weichat"] forState:UIControlStateNormal];
    [weChat addTarget:self action:@selector(weChatLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weChat];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, qq.top - 25, kScreenWidth, 18)];
    label.text = @"快速登录";
    label.font = HGfont(14);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = brown_label_color;
    [self.view addSubview:label];
}

-(void)qqLogin
{
    NSLog(@"qq");
}

-(void)weChatLogin
{
    NSLog(@"微信");
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
