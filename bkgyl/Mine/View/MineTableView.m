//
//  MineTableView.m
//  bkgyl
//
//  Created by 蒋佳恩 on 16/10/7.
//  Copyright © 2016年 刘施施. All rights reserved.
//

#import "MineTableView.h"

@implementation MineTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - UITableViewDataSource\UITableViewDelegate
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

//每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section < 2) return 2;
    if (section == 2) return 3;
    return 1;
}

//设置每组的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    cell.backgroundColor = HGColor(237, 237, 237);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 154)];
            topView.backgroundColor = HGColor(194, 164, 125);
            [cell.contentView addSubview:topView];
            UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0 - 50, 15, 100, 100)];
            iconView.layer.masksToBounds = YES;
            iconView.layer.cornerRadius = 50;
            iconView.layer.borderWidth = 3.0;
            iconView.layer.borderColor = [HGColor(203, 178, 149) CGColor];
            iconView.image = [UIImage imageNamed:@"mineImage_1"];
            [topView addSubview:iconView];
            UILabel *nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0 - 100, iconView.bottom, 200, 30)];
            nickNameLabel.text = @"138 7063 6235";
            nickNameLabel.textColor = [UIColor whiteColor];
            nickNameLabel.textAlignment = NSTextAlignmentCenter;
            nickNameLabel.font = HGfont(14);
            [topView addSubview: nickNameLabel];
        }else if (indexPath.row == 1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
            view.backgroundColor = [UIColor whiteColor];
            view.clipsToBounds = YES;
            [cell.contentView addSubview:view];
            CGFloat width = (kScreenWidth - 10) / 3.0;
            NSArray *arr = @[@"账户余额",@"我的收藏",@"我的预约"];
            for (int i = 0; i < 3; i++)
            {
                UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, view.height)];
                [view addSubview:subview];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(subview.width / 2.0 - 16, view.height / 2.0 - 22, 32, 24);
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"mineImage_%i",i + 2]] forState:UIControlStateNormal];
                button.tag = 100 + i;
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [subview addSubview:button];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, button.bottom + 8, subview.width, 12)];
                label.text = arr[i];
                label.textColor = brown_label_color;
                label.textAlignment = NSTextAlignmentCenter;
                label.font = HGfont(12);
                [subview addSubview:label];
                
                if (i > 0) {
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, 1, 64)];
                    lineView.backgroundColor = HGColor(220, 220, 220);
                    [view addSubview:lineView];
                }
            }
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell = nil;
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            cell.textLabel.text = @"我的订单";
            cell.textLabel.font = HGfont(13);
            cell.textLabel.textColor = brown_label_color;
            cell.detailTextLabel.text = @"查看全部订单";
            cell.detailTextLabel.textColor = [UIColor lightGrayColor];
            cell.detailTextLabel.font = HGfont(12);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
            view.backgroundColor = [UIColor whiteColor];
            view.clipsToBounds = YES;
            [cell.contentView addSubview:view];
            CGFloat width = (kScreenWidth - 10) / 5.0;
            NSArray *arr = @[@"待付款",@"待发货",@"待收货",@"待评价",@"售后"];
            for (int i = 0; i < 5; i++)
            {
                UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, view.height)];
                [view addSubview:subview];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(subview.width / 2.0 - 16, view.height / 2.0 - 22, 32, 24);
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"mineImage_%i",i + 5]] forState:UIControlStateNormal];
                button.tag = 200 + i;
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [subview addSubview:button];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, button.bottom + 8, subview.width, 12)];
                label.text = arr[i];
                label.textColor = [UIColor grayColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.font = HGfont(12);
                [subview addSubview:label];
                
                if (i > 0) {
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, 1, 64)];
                    lineView.backgroundColor = HGColor(220, 220, 220);
                    [view addSubview:lineView];
                }
            }
        }
    }else{
        NSArray *arr = @[@"地址管理",@"我的会员",@"我的消息",@"在线客服"];
        long index;
        if (indexPath.section == 2) {
            index = indexPath.row;
        }else{
            index = 3;
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"mineImage_%ld",index + 10]];
        cell.textLabel.text = arr[index];
        cell.textLabel.font = HGfont(14);
        cell.textLabel.textColor = brown_label_color;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) return 154;
        return 64;
    }
    if (indexPath.section == 1) return 64;
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0.1;
    return 16;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(void)viewDidLayoutSubviews {
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)])  {
        [self setLayoutMargins:UIEdgeInsetsZero];
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

- (void)buttonAction:(UIButton *)button{
    
}

@end
