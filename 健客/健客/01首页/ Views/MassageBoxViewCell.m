//
//  MassageBoxViewCell.m
//  健客
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MassageBoxViewCell.h"
#import "MassageBoxModel.h"
@interface MassageBoxViewCell()
{
    UIImageView *_iamgeView;
    UILabel *_label;
    UILabel *_laber2;
    
    int _number;
    
}
@end
@implementation MassageBoxViewCell


+(instancetype)cellWithTableView:(UITableView*)tableView withNumber:(int)number
{
    static NSString *Id = @"id";
    MassageBoxViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[MassageBoxViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
        
        [cell addSubviews:number];
    }
    return cell;

}

-(void)addSubviews:(int)number
{
    _number = number;

//    if (_number == 3) {
//        //1. imageVIew
//        _iamgeView = [LFFView createLineImageViewWithFrame:CGRectMake(20, (CELLHeight-75/2)/2, 75/2, 75/2) imageName:nil];
//        [self.contentView addSubview:_iamgeView];
//        
//        //2 label
//        _label = [LFFView createLabWithFrame:CGRectMake(_iamgeView.maxX+10, _iamgeView.y, LFFScreenW-_iamgeView.maxX, self.contentView.height*2/3) color:[UIColor blackColor] font:LFFFont(14) text:nil];
//        [self.contentView addSubview:_label];
//        
//        //3 label2
//        _laber2 = [LFFView createLabWithFrame:CGRectMake(_iamgeView.maxX+10, _iamgeView.maxY*2/3+5, LFFScreenW-_iamgeView.maxX, self.contentView.height/3) color:[UIColor lightGrayColor] font:LFFFont(12) text:nil];
//        [self.contentView addSubview:_laber2];
//        
//    }

    if (_number == 2) {
        //1. imageVIew
        _iamgeView = [LFFView createLineImageViewWithFrame:CGRectMake(20, (CELLHeight-75/2)/2, 75/2, 75/2) imageName:nil];
        [self.contentView addSubview:_iamgeView];
        
        
        //2 label
        _label = [LFFView createLabWithFrame:CGRectMake(_iamgeView.maxX+10, _iamgeView.y, LFFScreenW-_iamgeView.maxX, self.contentView.height*2/3) color:[UIColor blackColor] font:LFFFont(14) text:nil];
        [self.contentView addSubview:_label];
        
        //3 label2
        _laber2 = [LFFView createLabWithFrame:CGRectMake(_iamgeView.maxX+10, _iamgeView.maxY*2/3+5, LFFScreenW-_iamgeView.maxX, self.contentView.height/3) color:[UIColor lightGrayColor] font:LFFFont(12) text:nil];
        [self.contentView addSubview:_laber2];
        _laber2.adjustsFontSizeToFitWidth = YES;

    }
    if(number == 1){
        //1. imageVIew
        _iamgeView = [LFFView createLineImageViewWithFrame:CGRectMake(20, 5, 38, 38) imageName:nil];
        [self.contentView addSubview:_iamgeView];
        
        //2 label
        _label = [LFFView createLabWithFrame:CGRectMake(_iamgeView.maxX+10, _iamgeView.y, LFFScreenW-_iamgeView.maxX, self.contentView.height*2/3) color:[UIColor darkGrayColor] font:LFFFont(14) text:nil];
        [self.contentView addSubview:_label];
        
        //3
        UIImageView *jiantou = [LFFView createLineImageViewWithFrame:CGRectMake(LFFScreenW-20, 44-36/3, 18/3, 31/3) imageName:@"arrow_right_icon"];
        jiantou.center = CGPointMake(LFFScreenW-20, 44/2);
        [self.contentView addSubview:jiantou];
    }
    
}

-(void)setModel:(MassageBoxModel *)model
{
    _model = model;
    _iamgeView.image = LFFImage(model.iamgeName);
    _label.text = model.titleName;
    
    if (_number == 2) {
        _laber2.text = model.introduce;
    }
//    if (_number == 3) {
//        _laber2.text = model.introduce;
//    }

}

+(CGFloat)cellHeight
{
    return CELLHeight;
}


@end
