//
//  SubCateGroyViewCell.m
//  健客
//
//  Created by 刘斐斐 on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SubCateGroyViewCell.h"
#import "SubCategroyModel.h"
@interface SubCateGroyViewCell()
{
    UIImageView *_productIamge;
    UILabel *_productName;
    UILabel *_productGuige;
    UILabel *_productMaker;
    UILabel *_productOurPrice;
    UILabel *_productmarkprice;
    UIImageView *_shopCarImg;

    
    
}
@end

@implementation SubCateGroyViewCell

a   {
   static NSString *Id = @"id";
    SubCateGroyViewCell *cell = [tableview dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[SubCateGroyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
        
        [cell addSubviews];
        
    
    }return cell;
    
}

-(void)addSubviews
{

    
    //1图片
    CGFloat imgeWH = 80;
    _productIamge = [LFFView createLineImageViewWithFrame:CGRectMake(15, 15, imgeWH, 80) imageName:@"QQIcon@2x"];
    [self.contentView addSubview:_productIamge];
    
    //2.name
    _productName = [LFFView createLabWithFrame:CGRectMake(_productIamge.maxX+5, 15, LFFScreenW-_productIamge.maxX-50, 20) color:nil font:LFFFont(12) text:@"名字"];
    [self.contentView addSubview:_productName];
    
    //3 规格
    _productGuige = [LFFView createLabWithFrame:CGRectMake(_productName.x, _productName.maxY, _productName.width, _productName.height*2.0/3) color:[UIColor lightGrayColor] font:LFFFont(10) text:@"规格:"];
    [self.contentView addSubview:_productGuige];
    
    //4 shopCar
    _shopCarImg = [LFFView createLineImageViewWithFrame:CGRectMake(_productGuige.maxX+5, _productGuige.y, 27, 27) imageName:@"jionshopcart@2x"];
    [self.contentView addSubview:_shopCarImg];
    
    //5maker
    _productMaker = [LFFView createLabWithFrame:CGRectMake(_productGuige.x, _productGuige.maxY+5, _productGuige.width, _productGuige.height) color:[UIColor lightGrayColor] font:LFFFont(10) text:@"厂家"];
    [self.contentView addSubview:_productMaker];
    
    //6 我价格
    _productOurPrice = [LFFView createLabWithFrame:CGRectMake(_productMaker.x, _productMaker.maxY+5, _productIamge.width, _productMaker.height+5) color:[UIColor redColor] font:LFFFont(12) text:@"￥888"];
    [self.contentView addSubview:_productOurPrice];
    
    //市场价
    _productmarkprice = [LFFView createLabWithFrame:CGRectMake(_productOurPrice.maxX+5, _productOurPrice.y, LFFScreenW-_productOurPrice.maxY, 80-_productMaker.maxY+10) color:[UIColor lightGrayColor] font:LFFFont(10) text:@"市场价"];
    [self.contentView addSubview:_productmarkprice];
    
}

-(void)setModel:(SubCategroyModel *)model WithisSearch:(BOOL)isSearch
{
    _model = model;

    if (isSearch == NO) {
        LFFLog(@"????????");
        [_productIamge setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.jianke.net%@",model.productPic]]];
        NSString *ourPrice = [NSString stringWithFormat:@"%.2f",[model.productOurprice floatValue]/100];
        _productOurPrice.text = [NSString stringWithFormat:@"￥:%@",ourPrice];
        
    }else
    {
        LFFLog(@"!!!!!!!%@",model.productPic);
        [_productIamge setImageWithURL:[NSURL URLWithString:model.productPic] placeholderImage:LFFImage(@"headportraitSmall")];
        NSString *ourPrice = [NSString stringWithFormat:@"%.2f",[model.ourPrice floatValue]/100];
        _productOurPrice.text = [NSString stringWithFormat:@"￥:%@",ourPrice];

    }
    

    
//    [_productIamge setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.jianke.net%@",model.productPic]]];
    _productName.text  = model.productName;
    _productGuige.text = [NSString stringWithFormat:@"规格:%@",model.productSize];
    _productMaker.text = [NSString stringWithFormat:@"厂商:%@",model.productMake];
        
    NSString *markPrice = [NSString stringWithFormat:@"%.2f",[model.productMarketPrice floatValue]/100];
    _productmarkprice.text = [NSString stringWithFormat:@"市场价:￥%@",markPrice];

}


+(CGFloat)cellHeight
{
   
    return 110;
    
}


@end
