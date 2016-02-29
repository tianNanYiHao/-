//
//  AdverViewCell.m
//  健客
//
//  Created by 刘斐斐 on 15/10/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AdverViewCell.h"
#import "HomePageView.h"
#import "HomaPageModel.h"
@interface AdverViewCell()
@property (nonatomic,strong)UIImageView *adverImg;

@end
@implementation AdverViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self  = [super initWithFrame:frame]) {
        _adverImg = [[UIImageView alloc] init];
        _adverImg.frame = CGRectMake(0, 0, self.width, self.height);
        [self addSubview:_adverImg];
        
    }return self;
}

-(void)setHomePagemodel:(HomaPageModel *)homePagemodel
{
    _homePagemodel = homePagemodel;
    [_adverImg setImageWithURL:[NSURL URLWithString:homePagemodel.head_img]];
 
}

+(NSString *)indetifier
{
    return @"adverCell";
}
@end
