//
//  RegisterViewController.m
//  bkgyl
//
//  Created by 黄诸龙 on 16/10/7.
//  Copyright © 2016年 刘施施. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITextField *_accountField;
    UITextField *_telField;
    UITextField *_codeField;
    UITextField *_passwordField;
    UITextField *_passwordField1;
}
@property (strong, nonatomic)UITableView *tableView;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
    [self _createView];
    self.title = @"注册";
}
-(void)_createView
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorColor = HGColor(235, 235, 235);
    self.tableView = tableview;
    [self.view addSubview:tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 20, 20)];
        imageView.image = [UIImage imageNamed:@"reg_account"];
        [cell.contentView addSubview:imageView];
        
        _accountField = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, kScreenWidth - 60, 44)];
        _accountField.delegate = self;
        _accountField.placeholder = @"请输入姓名";
        _accountField.textColor = brown_label_color;
        _accountField.font = HGfont(12);
        [cell.contentView addSubview:_accountField];
        
    }
    else if (indexPath.row == 1)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 15, 20)];
        imageView.image = [UIImage imageNamed:@"reg_tel"];
        [cell.contentView addSubview:imageView];
        
        _telField = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, kScreenWidth - 60, 44)];
        _telField.delegate = self;
        _telField.placeholder = @"请输11位手机号码";
        _telField.textColor = brown_label_color;
        _telField.font = HGfont(12);
        [cell.contentView addSubview:_telField];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth - 88 - 10, 5, 88, 34);
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [button setTitleColor:brown_label_color forState:UIControlStateNormal];
        button.layer.cornerRadius = 5;
        button.titleLabel.font = HGfont(14);
        button.backgroundColor = HGColor(229,223,220);
        [button addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
    }
    else if (indexPath.row == 2)
    {
        _codeField = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, kScreenWidth - 60, 44)];
        _codeField.delegate = self;
        _codeField.placeholder = @"请输入手机验证码，或技术自动获取验证码";
        _codeField.textColor = brown_label_color;
        _codeField.font = HGfont(12);
        [cell.contentView addSubview:_codeField];
        
    }
    else if (indexPath.row == 3)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 20, 20)];
        imageView.image = [UIImage imageNamed:@"reg_password"];
        [cell.contentView addSubview:imageView];
        
        _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, kScreenWidth - 60, 44)];
        _passwordField.delegate = self;
        _passwordField.placeholder = @"请输入6-16位密码";
        _passwordField.textColor = brown_label_color;
        _passwordField.font = HGfont(12);
        _passwordField.secureTextEntry = YES;
        [cell.contentView addSubview:_passwordField];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenWidth - 80, 15, 18, 14);
        [button setImage:[UIImage imageNamed:@"see_sel"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(seeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    else if (indexPath.row == 4)
    {
        _passwordField1 = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, kScreenWidth - 60, 44)];
        _passwordField1.delegate = self;
        _passwordField1.placeholder = @"请再次确认6-16位密码";
        _passwordField1.textColor = brown_label_color;
        _passwordField1.font = HGfont(12);
        _passwordField1.secureTextEntry = YES;
        [cell.contentView addSubview:_passwordField1];
    }
    
    else
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 12, 20, 20);
        [button setImage:[UIImage imageNamed:@"xuanze_sel"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(readAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(button.right, button.center.y - 8, 200, 16);
        button1.titleLabel.textAlignment = NSTextAlignmentLeft;
        button1.titleLabel.font = HGfont(14);
        [button1 setTitle: @"我已阅读并接受百康注册协议" forState:UIControlStateNormal];
        [button1 setTitleColor:brown_label_color forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(agreementAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button1];
        
        UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        registerButton.frame = CGRectMake(45, button1.bottom + 85, kScreenWidth - 90, 44);
        [registerButton setBackgroundColor:brown_button_color];
        [registerButton setTitleColor:brown_label_color forState:UIControlStateNormal];
        [registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:registerButton];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        return kScreenHeight - 64 - 44 * 5;
    }
    return 44;
}

-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
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
    [_passwordField resignFirstResponder];
    [_passwordField1 resignFirstResponder];
    [_codeField resignFirstResponder];
    [_telField resignFirstResponder];
}

-(void)getCodeAction
{
    NSLog(@"获取验证码");
}

-(void)agreementAction
{
    NSLog(@"接受协议");
    
}
-(void)registerAction
{
    NSLog(@"注册");
}

-(void)seeButtonAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    _passwordField1.secureTextEntry = btn.selected;
    _passwordField.secureTextEntry = btn.selected;
}

-(void)readAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
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
