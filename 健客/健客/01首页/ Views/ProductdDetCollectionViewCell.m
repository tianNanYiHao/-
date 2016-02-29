//
//  ProductdDetCollectionViewCell.m
//  健客
//
//  Created by qianfeng on 15/10/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ProductdDetCollectionViewCell.h"
#import "ProductDetailModel.h"
@interface ProductdDetCollectionViewCell()
{
    UIImageView *_iamgeADView;
}
@end

@implementation ProductdDetCollectionViewCell




-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _iamgeADView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/4, 0, self.width/2, self.height)];
        [self.contentView addSubview:_iamgeADView];
    }return self;
}

-(void)setModel:(ProductDetailModel *)model
{
    _model = model;
    [_iamgeADView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.jianke.net%@",model.head_img]]];
 
    
}


+(NSString*)indentifr
{
    return @"indentifr";
}


@end
