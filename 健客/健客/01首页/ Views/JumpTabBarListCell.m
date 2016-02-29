//
//  JumpTabBarListCell.m
//  健客
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JumpTabBarListCell.h"
#import "JumpTabBarListModel.h"
@interface JumpTabBarListCell ()
{
    UIImageView *_imageIV;
    UILabel *_label;
    
}
@end

@implementation JumpTabBarListCell



+(instancetype)cellWithTabelView:(UITableView *)tabeleview {
    static NSString *ID = @"id";
    JumpTabBarListCell *cell =[tabeleview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[JumpTabBarListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor blackColor];
        cell.alpha = 1;
        [cell addSubviews];
        
    }
    return cell;
}

-(void)addSubviews
{
    //1.image
    _imageIV = [LFFView createLineImageViewWithFrame:CGRectMake(0, 0, 87/5, 22) imageName:nil];
    [self.contentView addSubview:_imageIV];
    _imageIV.layer.masksToBounds = YES;
    
    
    
    //2 title
    _label = [LFFView createLabWithFrame:CGRectMake(_imageIV.maxX, (22-11)/2,80-_imageIV.maxX, 11) color:[UIColor whiteColor] font:LFFFont(10) text:nil];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_label];
    
}

-(void)setModel:(JumpTabBarListModel *)model
{
    _model = model;
    _imageIV.image = LFFImageSelect(model.iamgeName);
    
    _label.text = model.titleName;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    // Configure the view for the selected state
}
//取消按下的选择效果
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}
@end
