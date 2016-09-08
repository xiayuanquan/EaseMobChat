//
//  UILabel+KJLabel.h
//  KenJiao
//
//  Created by mac on 16/3/5.
//  Copyright © 2016年 xiayuanquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (KJLabel)

/**
 *  创建标签
 *
 *  @param frame      尺寸
 *  @param title      文字
 *  @param titleColor 文字颜色
 *  @param alignment  对齐方式
 *  @param sizeFont   字体大小
 */
+(UILabel *)createLabel:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor alignmentType:(NSTextAlignment)alignment size:(CGFloat)sizeFont;
@end
