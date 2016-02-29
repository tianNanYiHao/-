//
//  PersonCenterBtnView.m
//  健客
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PersonCenterBtnView.h"

#import "FunctionButton.h"
@interface PersonCenterBtnView()
{
    UIImageView *_headImage;
    
}

@end

@implementation PersonCenterBtnView


+(instancetype)personCenterBtnViewWithFrame:(CGRect)frame
{
    PersonCenterBtnView *personView = [[PersonCenterBtnView alloc] initWithFrame:frame];
    [personView createFourBtn];
    return personView;
    
}
-(void)createFourBtn
{
    _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 265/4, 265/4)];
    _headImage.image = LFFImage(@"headportrait@2x");
    _headImage.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImage];

    UIButton *enterBtn = [LFFView createBtnWithFrame:CGRectMake(LFFScreenW/2, _headImage.y+_headImage.height/4, 151/2, 51/2) imageName:@"blueBtn_short@2x" text:@"登录" target:self sel:nil textFont:LFFFont(12) textColor:[UIColor whiteColor]];
    [self addSubview:enterBtn];
    
    UIImageView *fourBtnImgView = [LFFView createLineImageViewWithFrame:CGRectMake(0, self.height/2, LFFScreenW, self.height/2) imageName:nil];
    [self addSubview:fourBtnImgView];
    
    
    
    NSArray *fourBtnName = @[@"allOrder@2x",@"waitForPay@2x",@"waitForevaluate@2x",@"waitForrecive@2x"];
    NSArray *fourBtnLabName = @[@"全部订单",@"代付款",@"待评价",@"待收货"];

    CGFloat kMargin = (self.width/4-85/2)/2;
    CGFloat btnW = 85/2;
    for (int i = 0; i<4; i++) {
        
        UIView *fourView = [[UIView alloc]initWithFrame:CGRectMake(i*self.width/4, self.height/2, LFFScreenW, self.height/2)];
        fourView.backgroundColor = [UIColor whiteColor];
        [self addSubview:fourView];
        
        UIImageView *fourLineView = [LFFView createLineImageViewWithFrame:CGRectMake(self.width/4-1, 0, 1, self.height/2) imageName:@"grayLineVertical@2x"];
        [fourView addSubview:fourLineView];
        
        UIButton *btn = [LFFView createBtnWithFrame:CGRectMake(kMargin, kMargin, btnW, btnW) imageName:fourBtnName[i] text:nil target:self sel:nil textFont:nil textColor:nil];
        [fourView addSubview:btn];
        
        UILabel *lab = [LFFView createLabWithFrame:CGRectMake(0, btn.maxY+10, self.width/4, 20) color:[UIColor blackColor] font:LFFFont(12) text:fourBtnLabName[i]];
        lab.textAlignment = NSTextAlignmentCenter;
        [fourView addSubview:lab];
    }
 
}
@end
