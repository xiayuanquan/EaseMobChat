//
//  UILabel+KJLabel.m
//  KenJiao
//
//  Created by mac on 16/3/5.
//  Copyright © 2016年 xiayuanquan. All rights reserved.
//

#import "UILabel+KJLabel.h"

@implementation UILabel (KJLabel)

+(UILabel *)createLabel:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor alignmentType:(NSTextAlignment)alignment size:(CGFloat)sizeFont{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.textColor = titleColor;
    label.textAlignment = alignment;
    label.font = [UIFont systemFontOfSize:sizeFont];
    return label;
}

@end
