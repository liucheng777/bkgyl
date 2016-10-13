//
//  FieldViewController.m
//  bkgyl
//
//  Created by 黄诸龙 on 16/10/8.
//  Copyright © 2016年 刘施施. All rights reserved.
//

#import "FieldViewController.h"
#import "MJRefresh.h"

@interface FieldViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (assign,nonatomic) NSInteger pageIndex;

@property (strong,nonatomic) UITableView *tableView;
@end

@implementation FieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
    self.navigationItem.title = @"科普园地";
    _buttonNames = @[@"科学辩证",@"科普论文",@"环境科学",@"遗传基因",@"华夏文化",@"养生保健知识"];
    _buttonImgs = @[@"field_1",@"field_2",@"field_3",@"field_4",@"field_5",@"field_6"];
    [self _createView];
}

-(void)_createView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
    [self.view addSubview:_tableView];
    self.listArray = [NSMutableArray array];
    self.pageIndex = 1;
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(self) weakSelf = self;
    // 添加传统的下拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        //        [weakSelf fetchData:weakSelf.pageIndex];
        [weakSelf fetchData:weakSelf.pageIndex];
        [weakSelf.tableView.header endRefreshing];
    }];
    [self.tableView.legendHeader beginRefreshing];
    
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        weakSelf.pageIndex ++;
        //        [weakSelf fetchData:weakSelf.pageIndex];
        [weakSelf fetchData:weakSelf.pageIndex];
        [weakSelf.tableView.footer endRefreshing];
    }];
}


- (void)fetchData:(NSInteger)page{
//    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    HttpService *service = [HttpService getInstance];
    NSDictionary *param = [NSDictionary dictionary];
//    if (!userInfo)
//    {
//        param = @{@"uid":@"",@"page":[NSString stringWithFormat:@"%zi",page]};
//    }
//    else
//    {
//        param = @{@"uid":userInfo[@"uid"],@"page":[NSString stringWithFormat:@"%zi",page]};
//    }
    [service POST:nil parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *list = responseObject;
        if (page == 1) {
            [self.listArray removeAllObjects];
            [self.tableView.footer resetNoMoreData];
        }
        
        //        有无更多数据
        if (responseObject == [NSNull null] ||[list count] == 0) {
            [self.tableView.footer noticeNoMoreData];
        } else {
            [self.listArray addObjectsFromArray:list];
        }
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) return 2;
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (id subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    if (indexPath.section == 0)
    {
        _bannerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 148.0 / 320.0 * kScreenWidth)];
        _bannerScrollView.contentSize = CGSizeMake(kScreenWidth * _bannerList.count, 148.0 / 320.0 * kScreenWidth);
        [cell.contentView addSubview:_bannerScrollView];
        _bannerScrollView.showsHorizontalScrollIndicator = NO;
        _bannerScrollView.showsVerticalScrollIndicator = NO;
        _bannerScrollView.pagingEnabled = YES;
        _bannerScrollView.bounces = NO;
        _bannerScrollView.delegate = self;
        
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.center = CGPointMake(cell.contentView.width / 2.0, 148.0 / 320.0 * kScreenWidth - 20);
        _pageControl.numberOfPages = _bannerList.count;
        _pageControl.pageIndicatorTintColor = HGolorAlpha(226,232,226,0.5);
        _pageControl.currentPageIndicatorTintColor = HGolorAlpha(38,187,29,0.8);
        [cell.contentView addSubview:_pageControl];
        
        for (int i = 0; i < _bannerList.count; i++) {
//            NSDictionary *ad = _bannerList[i];
            CGFloat x = i * kScreenWidth;
            UIImageView *firstView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, kScreenWidth, 148.0 / 320.0 * kScreenWidth)];
            firstView.contentMode = UIViewContentModeScaleAspectFill;
            firstView.clipsToBounds = YES;
            firstView.image = [UIImage imageNamed:_bannerList[i]];
//            [firstView setImageWithURL:[CommonUtil getImageNsUrl:ad[@"src"]] placeholderImage:[UIImage imageNamed:@"banner_ios1@2x.jpg"]];
            [_bannerScrollView addSubview:firstView];
            UIButton *imageBtn = [[UIButton alloc]initWithFrame:firstView.frame];
            imageBtn.tag = i;
//            [imageBtn addTarget:self action:@selector(imageBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            [_bannerScrollView addSubview:imageBtn];
        }
    }
    
    else if (indexPath.section == 1)
    {
        CGFloat buttonWidth = kScreenWidth / 3;
        for (int i = 0; i<_buttonNames.count; i++)
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.userInteractionEnabled = NO;
            //            button.layer.cornerRadius = 20;
            //            button.clipsToBounds = YES;
            [button setImage:[UIImage imageNamed:_buttonImgs[i]] forState:UIControlStateNormal];
            button.tag = 40 + i;
            [view addSubview:button];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [UIColor whiteColor];
            view.tag = 170 + i;
            [cell.contentView addSubview:view];
            
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction:)];
            [view addGestureRecognizer:tapGes];
            
            label.textAlignment = NSTextAlignmentCenter;
//            label.textColor = [UIColor lightGrayColor];
            label.text = _buttonNames[i];
            label.font = [UIFont systemFontOfSize:12];
            [view addSubview:label];
            if (i < 3)
            {
                view.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, 93.0 / 320.0 * kScreenWidth);
            }
            else
            {
                view.frame = CGRectMake((i - 3) * buttonWidth, 93.0 / 320.0 * kScreenWidth, buttonWidth, 93.0 / 320.0 * kScreenWidth);
            }
            button.frame = CGRectMake(view.width / 2 - 20, view.height / 2.0 - 10 - 20, 40, 40);
            label.frame = CGRectMake(0, button.bottom + 5 , view.width, 15);
            [cell.contentView addSubview:view];
        }
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 84.0 / 667.0 * kScreenHeight, kScreenWidth, 1)];
//        lineView.backgroundColor = TABLE_BG_COLOR;
//        [cell.contentView addSubview:lineView];
        
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, 15, 2, 14)];
            lineView.backgroundColor = HGColor(57, 122, 145);
            [cell.contentView addSubview:lineView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(lineView.right + 5, 0, 100, 44)];
            label.text = @"科普论文";
            label.font = HGfont(14);
            [cell.contentView addSubview:label];
            
            UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(5, 43, kScreenWidth - 10, 1)];
            lineView1.backgroundColor = HGColor(235, 235, 235);
            [cell.contentView addSubview:lineView1];
        }
        else
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 20, 24)];
            imageView.image = [UIImage imageNamed:@"book"];
            [cell.contentView addSubview:imageView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 10, 8, kScreenWidth - 50, 14)];
            label.text = @"科普园地";
            label.font = HGfont(14);
            [cell.contentView addSubview:label];
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 10, label.bottom + 6, kScreenWidth - 50, 8)];
            timeLabel.text = @"2678人阅读-29.00k";
            timeLabel.font = HGfont(10);
            [cell.contentView addSubview:timeLabel];
        }
    }
    else
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 20, 24)];
        imageView.image = [UIImage imageNamed:@"book"];
        [cell.contentView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 10, 8, kScreenWidth - 50, 14)];
        label.text = @"科普园地";
        label.font = HGfont(14);
        [cell.contentView addSubview:label];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 10, label.bottom + 6, kScreenWidth - 50, 8)];
        timeLabel.text = @"2678人阅读-29.00k";
        timeLabel.font = HGfont(10);
        [cell.contentView addSubview:timeLabel];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0.01;
 
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return 148.0 / 320.0 * kScreenWidth;
    if (indexPath.section == 1) return 186.0 / 320.0 * kScreenWidth;
    if (indexPath.section == 2 && indexPath.row == 0) return 44;
    return 50;
}


-(void)loadBannerData{
//    HttpService *service = [HttpService getInstance];
//    NSDictionary *param = nil;
//    
//    [service POST:nil parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        _bannerList = responseObject;
//        [_tableView reloadData];
//        _timeNum = 0;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
//        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
    _bannerList = @[@"banner_1",@"banner_1"];
}

#pragma mark -按钮方法
-(void)buttonAction:(id)sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    NSInteger num = [tap view].tag - 170;
    NSLog(@"%li",num);
//        TinyIndexSubViewController *vc = [[TinyIndexSubViewController alloc] init];
//        NSArray *arr = @[@"助残",@"助善",@"助老",@"助学",@"扶贫",@"救急",@"其他"];
//        vc.title = _buttonNames[i];
//        vc.type = [NSNumber numberWithInteger:(num + 1)];
//        self.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//        self.hidesBottomBarWhenPushed = NO;

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self loadBannerData];
    //    UIImage *image = [[UIImage alloc] init];
    //    [self.navigationController.navigationBar setShadowImage:image];
    //    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _bannerScrollView) {
        CGFloat app_width = [CommonUtil getVersionWidth];
        CGFloat imageWidth = kScreenWidth + app_width;
        NSInteger currentPage = (int)_bannerScrollView.contentOffset.x / imageWidth;
        _pageControl.currentPage = currentPage;
    }
}

// scrollview滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    计算页码
    //    页码 = (contentoffset.x + scrollView一半宽度)/scrollView宽度
    
    CGFloat scrollviewW =  _bannerScrollView.frame.size.width;
    CGFloat x = _bannerScrollView.contentOffset.x;
    NSInteger page = (x + scrollviewW / 2) /  scrollviewW;
    _pageControl.currentPage = page;
    _bannerScrollView.tag = page;
}

-(void)timerAction:(NSTimer *)timer
{
    CGFloat app_width = [CommonUtil getVersionWidth];
    CGFloat imageWidth = kScreenWidth + app_width;
    
    NSInteger b = _bannerScrollView.tag;
    if (_timeNum % 2 == 0) {
        b++;
    }
    b = b % _bannerList.count;
    _bannerScrollView.tag = b;
    [_bannerScrollView setContentOffset:CGPointMake(b * imageWidth, 0) animated:YES];
    _timeNum ++;
}


-(void)viewDidDisappear:(BOOL)animated
{
    [_timer invalidate];
    _timer = nil;
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
