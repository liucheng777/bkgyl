//
//  BaseNavigationController.m
//  bkgyl
//
//  Created by 黄诸龙 on 16/10/6.
//  Copyright © 2016年 刘施施. All rights reserved.
//

#import "BaseNavigationController.h"
#import "ThemeButton.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏背景颜色
    self.navigationBar.barTintColor = navColor;
    //用系统默认的设置字体颜色和大小
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:HGColor(164, 134, 96),NSFontAttributeName:[UIFont systemFontOfSize:20]};
}
//设置状态栏的颜色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)bakeAction
{
    [self popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
