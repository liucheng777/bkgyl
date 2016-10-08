//
//  CommonUtil.h
//  bkgyl
//
//  Created by 黄诸龙 on 16/10/6.
//  Copyright © 2016年 刘施施. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYAttributedLabel.h"
@interface CommonUtil : NSObject
+ (CGFloat)getVersionWidth;
+ (UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size;
+ (BOOL)isValidateMobile:(NSString *)mobile;
+ (BOOL)isValidateEmail:(NSString *)email;
+ (NSURL *)getImageNsUrl:(NSString *)url;
+ (NSString *)getJSONStr:(id)theData;
+(TYAttributedLabel *)getLabel:(TYAttributedLabel *)label1 str:(NSString *)text color:(NSArray *)colorArray  font:(NSArray *)fontArray;
@end
