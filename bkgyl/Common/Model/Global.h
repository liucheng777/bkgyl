//
//  Global_h
//  bkgyl
//
//  Created by 黄诸龙 on 16/10/6.
//  Copyright © 2016年 刘施施. All rights reserved.
//
#import "ApiUri.h"

#ifndef Ebt_Global_h
#define Ebt_Global_h

#define SUCCESS_CODE @1
#define UNLOGIN_CODE @2
#define FAILURE_CODE @400
#define CODE_STRING @"code"

#define HGfont(s)  [UIFont systemFontOfSize:(s)]
#define HGColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define HGolorAlpha(r,g,b,alp) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(alp)]

//微信
#define kWXAPP_ID @"wx3b1a795bf74dfbaa"
#define kWXAPP_SECRET @"430a1892eb0e1d35fa6eb6f804920948"

//JPUSH
#define kJPUSH_APP_ID @"b2b02c4b132e0e42cbe343f5"
#define kJPUSH_APP_SECRET @"b3e3b9cd627b25275946dd8e"

#define ACTIVITY_ID @3
#define RECT_LOG(f) NSLog(@"\nx:%f\ny:%f\nwidth:%f\nheight:%f\n",f.origin.x,f.origin.y,f.size.width,f.size.height)
#define NETWORK_ERROR @"网络错误"
#endif
