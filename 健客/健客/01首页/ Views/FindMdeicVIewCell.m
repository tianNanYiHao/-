//
//  FindMdeicVIewCell.m
//  健客
//
//  Created by qianfeng on 15/10/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FindMdeicVIewCell.h"
#import "FindMdeicModel.h"
@interface FindMdeicViewCell()

{
    UIImageView *_iamgeView;
    UILabel *_titleNameLab;
    
 
}
@end

@implementation FindMdeicViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView
{
    static NSString *Id = @"id";
    FindMdeicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[FindMdeicViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
        
        [cell addSubviews];
    }
    return cell;
    
}
-(void)addSubviews
{
   
        //1. imageVIew
    _iamgeView = [LFFView createLineImageViewWithFrame:CGRectMake(0, 0, LFFScreenW, 35) imageName:@"menuOtherBackView@2x"];
    [self.contentView addSubview:_iamgeView];
        
        //2 label
        _titleNameLab = [LFFView createLabWithFrame:CGRectMake(LFFScreenW/4 , 0, LFFScreenW, 35) color:[UIColor whiteColor] font:LFFFont(14) text:nil];
        [self.contentView addSubview:_titleNameLab];
    _titleNameLab.textAlignment = NSTextAlignmentLeft;
    
    UIImageView *lineH = [LFFView createLineImageViewWithFrame:CGRectMake(0, 34, LFFScreenW, 1) imageName:@"grayLine@2x"];
    [self.contentView addSubview:lineH];
    
    
}

-(void)setModel:(FindMdeicModel *)model
{
    _model = model;
    _titleNameLab.text = model.name;

}

+(CGFloat)cellHeight
{
    return 35;
}


//一下两个方法 可以让cell 点击不显示点击效果
-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

@end
