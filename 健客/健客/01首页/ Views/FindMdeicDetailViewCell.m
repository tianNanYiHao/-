//
//  FindMdeicDetailViewCell.m
//  健客
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FindMdeicDetailViewCell.h"
#import "FindMdeicDetailModel.h"
@interface FindMdeicDetailViewCell()
{
    UILabel *_detailLab;
    
    UILabel *_infoDetailLab;
    
    
    UIImageView *_iamgeView;
    UILabel *_titleLab;
    UILabel *_infoLab;
    UILabel *_ourPriceLab;
    UILabel *_markPriceLab;
    
    UILabel *_questionLab;
    
}
@end
@implementation FindMdeicDetailViewCell


+(instancetype)cellWithTableview:(UITableView*)tabelView WithNum:(NSIndexPath* )indexPath
{
    static NSString *Id = @"id";
    FindMdeicDetailViewCell *cell = [tabelView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[FindMdeicDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
        

        cell.backgroundColor = [UIColor whiteColor];
        
    }return cell;

}


-(void)addSubviewsWithNum:(NSIndexPath* )indexPath
{
    if (indexPath.section == 0) {
        _detailLab = [LFFView createLabWithFrame:CGRectMake(20, 10, LFFScreenW-40, 100) color:[UIColor blackColor] font:LFFFont(12) text:@"啦啦啦啦啦 "];
        _detailLab.numberOfLines = 0;
        [self.contentView addSubview:_detailLab];
        
    }
    if (indexPath.section == 1) {
        _infoDetailLab = [LFFView createLabWithFrame:CGRectMake(20, 10, LFFScreenW-40, 100) color:[UIColor blackColor] font:LFFFont(12) text:@"啦啦啦啦啦"];
        _infoDetailLab.numberOfLines = 0;
    
        [self.contentView addSubview:_infoDetailLab];
        
    }
    if (indexPath.section == 2) {
        //1
        _iamgeView = [LFFView createLineImageViewWithFrame:CGRectMake(5, 15, LFFScreenW/4, 80) imageName:nil];
        [self.contentView addSubview:_iamgeView];
        //2
        _titleLab = [LFFView createLabWithFrame:CGRectMake(_iamgeView.maxX+5, 15, LFFScreenW-LFFScreenW/4, 20) color:[UIColor blackColor] font:LFFFont(12) text:nil];
        [self.contentView addSubview:_titleLab];
        //3
        _infoLab = [LFFView createLabWithFrame:CGRectMake(_titleLab.x, _titleLab.maxY, LFFScreenW/2,45) color:[UIColor lightGrayColor] font:LFFFont(10) text:nil];
        _infoLab.numberOfLines = 0;
        [self.contentView addSubview:_infoLab];
        //4
        UIImageView *shopCar = [LFFView createLineImageViewWithFrame:CGRectMake(LFFScreenW-LFFScreenW/5, _titleLab.maxY, 27, 27) imageName:@"jionshopcart@2x"];
        [self.contentView addSubview:shopCar];
        
        //5 我价格
        _ourPriceLab = [LFFView createLabWithFrame:CGRectMake(_titleLab.x,_infoLab.maxY*4/5.0,50, _infoLab.height) color:[UIColor redColor] font:LFFFont(12) text:@"￥888"];
        [self.contentView addSubview:_ourPriceLab];
        
        //6 市场价
        _markPriceLab = [LFFView createLabWithFrame:CGRectMake(_ourPriceLab.maxX+30, _ourPriceLab.y,_infoLab.width*2/3.0 ,_ourPriceLab.height ) color:[UIColor lightGrayColor] font:LFFFont(10) text:@"市场价"];
        [self.contentView addSubview:_markPriceLab];
    }
    if (indexPath.section == 3) {
        _questionLab = [LFFView createLabWithFrame:CGRectMake(10, -5, LFFScreenW, 35) color:[UIColor lightGrayColor] font:LFFFont(12) text:nil];
 
        [self.contentView addSubview:_questionLab];
    }
    
}

-(void)setModel:(FindMdeicDetailModel *)model WithNum:(NSIndexPath* )indexPath;
{
    //首先删除所有的复用view cell 然后 再创建一cell(空壳)!! 然后再model赋值!! 这样就保证不会造成复用失败!!!
    for (UIView *View in self.contentView.subviews) {
        [View removeFromSuperview];
    }
    //创建cell(空壳)
    [self addSubviewsWithNum:indexPath];
    
    
    _model = model;
    
    if (indexPath.section == 0) {
        
        //创建字符集过滤不要的字符串
        NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"<p></p>"];
        model.summarize = [[model.summarize componentsSeparatedByCharactersInSet:doNotWant]componentsJoinedByString:@" "];
        
        CGFloat detailLabHeight = [model.summarize boundingRectWithSize:CGSizeMake(LFFScreenW-40, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:LFFFont(12)} context:nil].size.height;
        
        //重置文本高度
        _detailLab.height = detailLabHeight;
        model.cellHeight1 =  detailLabHeight+20; //在model中 创建一个高度模型 用来返回!!
        _detailLab.text = model.summarize;

    }if (indexPath.section == 1) {
        
        //创建字符集(过滤不要的字符)
        NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"<p><br />\r\n</p>\r\n<p>&nbsp;</p>"];
        model.treated = [[model.treated componentsSeparatedByCharactersInSet:doNotWant]componentsJoinedByString:@" "];
        
        CGFloat infoDetailLabHeight = [model.treated boundingRectWithSize:CGSizeMake(LFFScreenW-40, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:LFFFont(12)} context:nil].size.height;
        
        //重置文本高度
        _infoDetailLab.height = infoDetailLabHeight;
        model.cellHeight2 = infoDetailLabHeight+20; //在model中 创建一个高度模型 用来返回!!

        _infoDetailLab.text = model.treated;
        
    }if (indexPath.section == 2) {
        [_iamgeView setImageWithURL:[NSURL URLWithString:model.productPic]];
        _titleLab.text = model.productName;
        _infoLab.text = model.introduction;
        _ourPriceLab.text = [NSString stringWithFormat:@"￥:%@",model.ourPrice];
        _markPriceLab.text = [NSString stringWithFormat:@"市场价:%@",model.marketPrice];
        
    }if (indexPath.section == 3) {
        _questionLab.text = model.title;
        
    }

}



@end
