//
//  FunctionButton.m
//  健客
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FunctionButton.h"

@implementation FunctionButton

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height;
    
    return CGRectMake(0, -10, imageW, imageH);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleWH = contentRect.size.width;
    return CGRectMake(-5, 17, titleWH+10, titleWH+10);
}
@end
