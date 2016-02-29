//
//  AboutProductViewCell.m
//  健客
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AboutProductViewCell.h"
#import "AboutProductModel.h"

@interface AboutProductViewCell ()
{
    UIImageView *_imageVI;
    UILabel *_titleLab;
    UILabel *_detailLab;
    UILabel *_ourPriLab;
    UIImageView *_iamgeADView;
    
}
@end

@implementation AboutProductViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _imageVI = [LFFView createLineImageViewWithFrame:CGRectMake(0, 0, LFFScreenW/3, (self.height-20)/2) imageName:nil];
        [self.contentView addSubview:_imageVI];
        
        _titleLab = [LFFView createLabWithFrame:CGRectMake(0, _imageVI.maxY, LFFScreenW/3,_imageVI.height/2) color:[UIColor blackColor] font:LFFFont(12) text:nil];
        _titleLab.numberOfLines =0;
        [self.contentView addSubview:_titleLab];
        
        _detailLab = [LFFView createLabWithFrame:CGRectMake(0, _titleLab.maxY, LFFScreenW/3,_imageVI.height/2)color:[UIColor lightGrayColor] font:LFFFont(10) text:nil];
        _detailLab.numberOfLines = 0;
        [self.contentView addSubview:_detailLab];
        
        _ourPriLab = [LFFView createLabWithFrame:CGRectMake(0,_detailLab.maxY, LFFScreenW/3, _imageVI.height/4) color:[UIColor redColor] font:LFFFont(13) text:nil];
        [self.contentView addSubview:_ourPriLab];
        _ourPriLab.textAlignment = NSTextAlignmentCenter;
        
        
    }return self;
}
-(void)setModel:(AboutProductModel *)model
{
    _model = model;
    
    [_imageVI setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.jianke.net%@",model.productImageUrl]]];
    
    _titleLab.text = model.productName;
    
    _detailLab.text = model.productEffect;
    
    _ourPriLab.text = [NSString stringWithFormat:@"￥:%.2f",[model.ourPrice floatValue]/100];
    
    
}




+(NSString*)identif
{
    return @"id11";
}
@end
