//
//  PinlunViewCell.m
//  健客
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PinlunViewCell.h"
#import "PinlunModel.h"
@interface PinlunViewCell()
{
    UILabel *_evaluaLab;
    UIImageView *_starIV;
    UILabel *_evaluaCountLab;
    UILabel *_evaluaContentLab;
    UILabel *_userNameLab;
    UILabel *_timeLab;
    
    UIImageView *_starBg;
    
    UIView *_view;
    UIImageView *_lineH;
}
@end

@implementation PinlunViewCell

+(instancetype)cellWithTableview:(UITableView *)tableView
{
    static NSString *ID = @"id";
    PinlunViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[PinlunViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        [cell addSubviews];
    }return cell;
}

-(void)addSubviews
{
    //1评价
    _evaluaLab = [LFFView createLabWithFrame:CGRectMake(10, 5, 40, 20) color:[UIColor blackColor] font:LFFFont(12) text:@"评价:"];
    [self.contentView addSubview:_evaluaLab];
    
    //2starBG
    for (int i = 0; i<5; i++) {
        _starBg = [LFFView createLineImageViewWithFrame:CGRectMake(_evaluaLab.maxX+i*(15+1), 5, 15, 15) imageName:@"evaluate_star_normal@2x"];
        [self.contentView addSubview:_starBg];
        
    }
    
    //3评价数量
    _evaluaCountLab = [LFFView createLabWithFrame:CGRectMake(LFFScreenW*9/10-20, 0, LFFScreenW/10, 40) color:[UIColor lightGrayColor] font:LFFFont(10) text:nil];
    [self.contentView addSubview:_evaluaCountLab];
    
    //4 lineH
    _lineH = [LFFView createLineImageViewWithFrame:CGRectMake(0,_starBg.maxY+5, LFFScreenW, 1) imageName:@"grayLine@2x"];
    [self.contentView addSubview:_lineH];
    
    //5 评论内容
    _evaluaContentLab = [LFFView createLabWithFrame:CGRectMake(_evaluaLab.x, _lineH.maxY+10, LFFScreenW-2*_evaluaLab.x, 50) color:[UIColor blackColor] font:LFFFont(12) text:nil];
    _evaluaContentLab.numberOfLines = 0;
    [self.contentView addSubview:_evaluaContentLab];
    
    //6名字
    _userNameLab = [LFFView createLabWithFrame:CGRectMake(_evaluaContentLab.x, _evaluaContentLab.maxY+5, LFFScreenW/3, 15) color:[UIColor lightGrayColor] font:LFFFont(10) text:nil];
    [self.contentView addSubview:_userNameLab];
    
    //7时间
    _timeLab = [LFFView createLabWithFrame:CGRectMake(LFFScreenW/2-10, _userNameLab.y, LFFScreenW/2, 15) color:[UIColor lightGrayColor] font:LFFFont(10) text:nil];
    _timeLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeLab];
    
//    //bgview
//    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFFScreenW, 20)];
//    [self.contentView addSubview:_view];
//    _view.backgroundColor = LFFBGColor;
    
    
}


-(void)setModel:(PinlunModel *)model
{
    _model = model;
    
    for (int i = 0; i<[model.star floatValue]; i++) {
        _starIV= [LFFView createLineImageViewWithFrame:CGRectMake(_evaluaLab.maxX+i*(15+1), 5, 15, 15) imageName:@"evaluate_star_selected@2x"];
        [self.contentView addSubview:_starIV];
        
    }
    
    _evaluaCountLab.text = [NSString stringWithFormat:@"数量:%@",model.number];
    _evaluaCountLab.width = 40;
    
    CGFloat evaluaContentLabHeight = [model.evaluationDetials boundingRectWithSize:CGSizeMake(LFFScreenW-2*_evaluaLab.x, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:LFFFont(12)} context:nil].size.height;
    _evaluaContentLab.height = evaluaContentLabHeight;
    _evaluaContentLab.text = model.evaluationDetials;
    
    _userNameLab.text = model.userName;
    _userNameLab.y = _evaluaContentLab.maxY+10;
    
    
    _timeLab.text = model.evaluateTime;
    _timeLab.y = _evaluaContentLab.maxY+10;

    
    model.cellHeight = _timeLab.maxY;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    

    // Configure the view for the selected state
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}
@end
