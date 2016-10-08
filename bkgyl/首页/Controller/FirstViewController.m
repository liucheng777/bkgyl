//
//  FirstViewController.m
//  bkgyl
//
//  Created by 黄诸龙 on 16/10/6.
//  Copyright © 2016年 刘施施. All rights reserved.
//

#import "FirstViewController.h"
#import "LoginViewController.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "FieldViewController.h"

@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSMutableArray *listArray;
@property (strong,nonatomic) UITableView *tableView;
@property (assign,nonatomic) NSInteger pageIndex;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"百康供应链科技";
    [self _createView];
}

-(void)_createView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = HGColor(237, 237, 237);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
//    [self.tableView setContentInset:UIEdgeInsetsMake(-65, 0, 0, 0)];
    [self.view addSubview:self.tableView];
    _pageIndex = 1;
    _listArray = [NSMutableArray array];
//    __weak typeof(self) weakSelf = self;
//    
//    
//    // 添加传统的下拉刷新
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    [self.tableView addLegendHeaderWithRefreshingBlock:^{
//        weakSelf.pageIndex = 1;
//        [weakSelf fetchData:weakSelf.pageIndex];
//        [weakSelf.tableView.header endRefreshing];
//    }];
//    [self.tableView.legendHeader beginRefreshing];
//    
//    // 添加传统的上拉刷新
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    [self.tableView addLegendFooterWithRefreshingBlock:^{
//        weakSelf.pageIndex ++;
//        [weakSelf fetchData:weakSelf.pageIndex];
//        [weakSelf.tableView.footer endRefreshing];
//    }];
}
//列表
- (void)fetchData:(NSInteger)page{
    HttpService *service = [HttpService getInstance];
    NSDictionary *param = @{@"page":[NSString stringWithFormat:@"%zi",page],
                            };
    
    [service POST:nil parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSArray *list = responseObject;
        if (page == 1)
        {
            [self.listArray removeAllObjects];
            [self.tableView.footer resetNoMoreData];
        }
        
        //        有无更多数据
        if (responseObject == [NSNull null] ||[list count] == 0)
        {
            [self.tableView.footer noticeNoMoreData];
        }
        else
        {
            [self.listArray addObjectsFromArray:list];
        }
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 1;
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
    cell.backgroundColor = HGColor(237, 237, 237);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 148.0 / 320.0 * kScreenWidth)];
        imageView.image = [UIImage imageNamed:@"banner_1"];
        [cell.contentView addSubview:imageView];
    }
    else if (indexPath.section == 1)
    {

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 10, 90.0 / 310.0 * (kScreenWidth - 10) )];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 5;
        view.clipsToBounds = YES;
        [cell.contentView addSubview:view];
        CGFloat width = (kScreenWidth - 10) / 4.0;
        NSArray *arr = @[@"VIP专享",@"群英荟萃",@"科普园地",@"公益之窗"];
        for (int i = 0; i < 4; i++)
        {
            UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, view.height)];
            [view addSubview:subview];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(subview.width / 2.0 - 16, view.height / 2.0 - 22, 32, 24);
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fImage_%i",i + 1]] forState:UIControlStateNormal];
            button.tag = 100 + i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [subview addSubview:button];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, button.bottom + 10, subview.width, 10)];
            label.text = arr[i];
            label.textColor = brown_label_color;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = HGfont(10);
            [subview addSubview:label];
            if (i > 0) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i * width, 4, 1, view.height - 8)];
                lineView.backgroundColor = HGColor(220, 220, 220);
                [view addSubview:lineView];
            }
        }
    }
    else if (indexPath.section == 2)
    {
        NSArray *arr = @[@"产业动态",@"文明卖场",@"创客空间"];
        CGFloat width = (kScreenWidth - 20) / 3.0;
        for (int i = 0; i < 3; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5 + (5 + width) * i, 5, width, 132.0 / 320 * kScreenWidth)];
            view.backgroundColor = [UIColor whiteColor];
            view.tag = 110 + i;
            view.clipsToBounds = YES;
            [cell.contentView addSubview:view];
            
            UITapGestureRecognizer *tap = [[ UITapGestureRecognizer alloc] initWithTarget:self action:@selector(themeAction:)];
            [view addGestureRecognizer:tap];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, width, 12)];
            label.text = arr[i];
            label.font = HGfont(10);
            label.textColor = brown_label_color;
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, label.bottom + 5, width, 10)];
            label1.text = @"立即进入";
            label1.font = HGfont(8);
            label1.textColor = brown_label_color;
            label1.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label1];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, view.height - 90, view.width, 90)];
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image_%i", i + 1]];
            imageView.userInteractionEnabled = YES;
            [view addSubview:imageView];
        }
    }
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 148.0 / 320.0 * kScreenWidth;
    }
    else if (indexPath.section == 1)
    {
        return 90.0 / 310.0 * (kScreenWidth - 10) + 10;
    }
    else if (indexPath.section == 1)
    {
        return 132.0 / 320 * kScreenWidth;
    }
    
    return 44;
}
-(void)buttonAction:(UIButton *)btn
{
    NSLog(@"%li",btn.tag - 100);
    if (btn.tag == 102) {
        FieldViewController *vc = [[FieldViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}
-(void)themeAction:(UITapGestureRecognizer *)tap
{
    NSInteger tag = [tap view].tag - 110;
    NSLog(@"%li",tag);
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
