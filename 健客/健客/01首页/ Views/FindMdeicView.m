//
//  FindMdeicView.m
//  健客
//
//  Created by qianfeng on 15/10/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FindMdeicView.h"
@interface FindMdeicView()
{
    UIImageView *_iamgeView;
    UILabel *_label;
    UILabel *_laber2;
    FindMdeicView *_view;
}

@end

@implementation FindMdeicView


+(instancetype)sectionViewWithFrame:(CGRect)frame iamgeName:(NSString *)imageName titleName:(NSString *)titleName mdeicDetail:(NSString *)mdeicDetail
{
    FindMdeicView *view = [[FindMdeicView alloc] initWithFrame:frame];

    [view createImageViewWithImageName:imageName];
    [view createTitleNameWithTitleName:titleName];
    [view createMdeicDetailWtit:mdeicDetail];
    return view;
}

-(void)createImageViewWithImageName:(NSString*)imgName
{
    //    1. imageVIew
    
        _iamgeView = [LFFView createLineImageViewWithFrame:CGRectMake(20, (CELLHeight-75/2)/2, 75/2, 75/2) imageName:imgName];
        [self addSubview:_iamgeView];

}

-(void)createTitleNameWithTitleName:(NSString*)titleName
{
    //
    //    //2 label
        _label = [LFFView createLabWithFrame:CGRectMake(_iamgeView.maxX+10, _iamgeView.y/4.0, LFFScreenW-_iamgeView.maxX, CELLHeight*2/3.0) color:[UIColor blackColor] font:LFFFont(14) text:titleName];
        [self addSubview:_label];
}
-(void)createMdeicDetailWtit:(NSString*)mdeicDetail
{
   //3 label2
        _laber2 = [LFFView createLabWithFrame:CGRectMake(_iamgeView.maxX+10, _iamgeView.maxY*2/3+5, LFFScreenW-_iamgeView.maxX, CELLHeight/3) color:[UIColor lightGrayColor] font:LFFFont(12) text:mdeicDetail];
        [self addSubview:_laber2];
}


@end
