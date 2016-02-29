//
//  MassageBoxLeftCell.m
//  健客
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MassageBoxLeftCell.h"
#import "MassageBoxLeftModel.h"

@interface MassageBoxLeftCell()
{
    UILabel *_title;
    
}
@end

@implementation MassageBoxLeftCell


+(instancetype)cellWithTabelView:(UITableView *)tableview selected:(BOOL)isSelected
{
    static NSString *Id = @"id";
    MassageBoxLeftCell *cell = [tableview dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[MassageBoxLeftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
        
        [cell addSubviewsSelected:isSelected];
        if (isSelected) {
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
    }
    return cell;
    
}

-(void)addSubviewsSelected:(BOOL)iSelected
{
    _title = [LFFView createLabWithFrame:CGRectMake(20, self.height/4+10, self.width*2.0/3, self.height/2) color:[UIColor blackColor] font:LFFFont(15) text:nil];
    
    UIImageView *lineH = [LFFView createLineImageViewWithFrame:CGRectMake(0, 0, self.width, 1) imageName:@"grayLine@2x"];
    [self.contentView addSubview:lineH];

    [self.contentView addSubview:_title];
    
    
//    if (iSelected) {
//        LFFLog(@"iSelected");
//        UILabel *labelYes = [[UILabel alloc] initWithFrame:CGRectMake(5, _title.y, self.width/3, self.height/2)];
//        labelYes.text = @"√";
//        [self.contentView addSubview:labelYes];
//    }
    
    
}

-(void)setModel:(MassageBoxLeftModel *)model
{
    _model = model;
    
    
    _title.text = model.CategoryName;
    

}

+(CGFloat)cellHeight
{
    return (LFFScreenH-64)/8;
}

@end
