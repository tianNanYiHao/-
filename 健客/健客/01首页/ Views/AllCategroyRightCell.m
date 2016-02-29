//
//  AllCategroyRightCell.m
//  健客
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AllCategroyRightCell.h"
#import "AllCategroyModel.h"
@interface AllCategroyRightCell()
{
    UILabel *_label;
    
}
@end

@implementation AllCategroyRightCell


+(instancetype)cellWithTabelview:(UITableView *)tableview
{
    
    static NSString*ID = @"id";
    AllCategroyRightCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[AllCategroyRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        [cell addSubviews];
        
    }return cell;
    
}
-(void)addSubviews
{
    _label = [LFFView createLabWithFrame:CGRectMake(10, 0, LFFScreenW/3, 44) color:[UIColor blackColor] font:LFFFont(12) text:nil];
    
    [self.contentView addSubview:_label];
    
    
}

-(void)setModel:(AllCategroyModel *)model
{
    _model = model;
    _label.text = [NSString stringWithFormat:@"> %@",model.itemName];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
    // Configure the view for the selected state
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}
@end
