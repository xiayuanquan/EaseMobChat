//
//  ToolManager.m
//  KenJiao
//
//  Created by mac on 16/2/18.
//  Copyright © 2016年 xiayuanquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)


/**
 *  快速创建一个item
 *
 *  @param imageName 图片名称
 *  @param target    监听者
 *  @param action    监听方法
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;


/**
 *  快速创建一个显示图片的item
 *  @param icon     正常图片
 *  @param highIcon 高亮图片
 *  @param target   监听者
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;


/**
 *  快速创建一个文字的item
 *
 *  @param frame  尺寸
 *  @param title  文字
 *  @param corlor 文字颜色
 *  @param size   文字大小
 *  @param target 目标
 *  @param action 监听方法
 */
+(UIBarButtonItem *)itemWithFrame:(CGRect)frame Title:(NSString *)title TitleColor:(UIColor *)corlor sizeFont:(CGFloat)size target:(id)target action:(SEL)action;

/**
 *  快速创建一个文字的右边item
 *
 *  @param frame  尺寸
 *  @param title  文字
 *  @param corlor 文字颜色
 *  @param size   文字大小
 *  @param target 目标
 *  @param done 监听方法
 */
+(NSArray *)itemWithFrame:(CGRect)frame Title:(NSString *)title TitleColor:(UIColor *)corlor size:(CGFloat)size target:(id)target action:(SEL)dene;
@end
