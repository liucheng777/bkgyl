//
//  ForgetPasswordViewController.m
//  bkgyl
//
//  Created by 黄诸龙 on 16/10/10.
//  Copyright © 2016年 刘施施. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ForgetPasswordViewController1.h"

@interface ForgetPasswordViewController ()<UITextFieldDelegate>
{
    UITextField *_accountField;
}

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
    self.title = @"找回密码";
    [self _createView];
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 64, kScreenWidth - 20, 44)];
    label.text = @"请在下面输入您要找回的账号：";
    label.textColor = brown_label_color;
    label.font = HGfont(14);
    [self.view addSubview:label];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, label.bottom, kScreenWidth, 1)];
    lineView.backgroundColor = HGColor(235, 235, 235);
    [self.view addSubview:lineView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,lineView.bottom + 10, 24, 24)];
    imageView.image = [UIImage imageNamed:@"account"];
    [self.view addSubview:imageView];
    
    _accountField = [[UITextField alloc] initWithFrame:CGRectMake(imageView.right + 14 , lineView.bottom, kScreenWidth - 55, 44)];
    _accountField.delegate = self;
    _accountField.textColor = brown_label_color;
    _accountField.font = HGfont(14);
    _accountField.placeholder = @"请输入姓名";
    [self.view addSubview:_accountField];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, _accountField.bottom, kScreenWidth, 1)];
    lineView1.backgroundColor = HGColor(235, 235, 235);
    [self.view addSubview:lineView1];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(45, lineView1.bottom + 90, kScreenWidth - 90, 44);
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
    ForgetPasswordViewController1 *vc =  [[ForgetPasswordViewController1 alloc]init];
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
    [_accountField resignFirstResponder];
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
