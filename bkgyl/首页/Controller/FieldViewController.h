//
//  FieldViewController.h
//  bkgyl
//
//  Created by 黄诸龙 on 16/10/8.
//  Copyright © 2016年 刘施施. All rights reserved.
//

#import "BaseViewController.h"

@interface FieldViewController : BaseViewController
{
    UIScrollView *_bannerScrollView;
    UIPageControl *_pageControl;
    NSArray *_bannerList;
    NSInteger _timeNum;
    NSArray *_buttonImgs;
    NSArray *_buttonNames;
    
}
@property (strong,nonatomic)NSTimer *timer;
@property (strong,nonatomic) NSMutableArray *listArray;

@end
