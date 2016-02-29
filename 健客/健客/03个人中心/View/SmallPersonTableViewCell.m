//
//  SmallPersonTableViewCell.m
//  健客
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SmallPersonTableViewCell.h"
#import "PersonCentrlModel.h"


@interface SmallPersonTableViewCell()
{
    UIImageView *_imageView;
    UILabel *_label;
    UILabel *_numberLab;
}

@end

@implementation SmallPersonTableViewCell



+(instancetype)samllPersonCellWithTableview:(UITableView *)tabelView
{
    static NSString *ID = @"id";
    SmallPersonTableViewCell *cell = [tabelView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SmallPersonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        [cell addSubviews];
    }
    return cell;
    
}

-(void)addSubviews
{
    //1
    CGFloat kMagin = (44-27/2)/2;
    _imageView = [LFFView createLineImageViewWithFrame:CGRectMake(kMagin, kMagin,27/2, 27/2) imageName:nil];
    [self.contentView addSubview:_imageView];
    
    //2
    _label = [LFFView createLabWithFrame:CGRectMake(_imageView.maxX*2, _imageView.y, LFFScreenW*4/5, _imageView.height) color:[UIColor blackColor] font:LFFFont(12) text:nil];
    [self.contentView addSubview:_label];
    
    //3
    _numberLab = [LFFView createLabWithFrame:CGRectMake(LFFScreenW-40, _label.y, 5, _label.height) color:[UIColor redColor] font:LFFFont(10) text:@"0"];
    [self.contentView addSubview:_numberLab];
    
    //4
    UIImageView *jiantou = [LFFView createLineImageViewWithFrame:CGRectMake(LFFScreenW-20, 44-36/3, 18/3, 31/3) imageName:@"arrow_right_icon"];
    jiantou.center = CGPointMake(LFFScreenW-20, 44/2);
    [self.contentView addSubview:jiantou];
  
}

-(void)setModel:(PersonCentrlModel *)model
{
    _model = model;
    
    _imageView.image = LFFImage(model.imageName);
    
    _label.text = model.laberName;
    
    _numberLab.text = model.numberLab;

}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
