//
//  SearchViewController.m
//  bkgyl
//
//  Created by 黄诸龙 on 16/10/6.
//  Copyright © 2016年 刘施施. All rights reserved.
//

#import "SearchViewController.h"
#import "LoginViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setTitleColor:brown_label_color forState:UIControlStateNormal];
    button.frame = CGRectMake(50, kScreenHeight / 2.0 - 17, kScreenWidth - 100, 34);
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)buttonAction
{
    LoginViewController *vc = [[LoginViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
