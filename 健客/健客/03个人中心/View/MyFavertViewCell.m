//
//  MyFavertViewCell.m
//  健客
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyFavertViewCell.h"
#import "ProductDetailModel.h"

@interface MyFavertViewCell ()
{
    UIImageView *_iamgeView;
    UILabel *_nameLab;
    UILabel *_ourPrice;
    UILabel *_markPrice;
    UIButton *_buyNotiBtn;
    UIButton *_buyBtn;
}
@end

@implementation MyFavertViewCell


+(instancetype)cellWithTableview:(UITableView *)tableivew
{
    static NSString *Id = @"id";
    MyFavertViewCell *cell = [tableivew dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[MyFavertViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id
                ];
        
        [cell addSubviews];
    }
    return cell;
}

-(void)addSubviews
{
    //1.
    _iamgeView = [LFFView createLineImageViewWithFrame:CGRectMake(10, 10, 80, 80) imageName:@"defaultPic@2x"];
    [self.contentView addSubview:_iamgeView];

    //2.
    _nameLab = [LFFView createLabWithFrame:CGRectMake(_iamgeView.maxX+10, _iamgeView.y, LFFScreenW/2, 20) color:[UIColor blackColor] font:LFFFont(15) text:nil];
    [self.contentView addSubview:_nameLab];
    
    //.我价格
    _ourPrice = [LFFView createLabWithFrame:CGRectMake(_nameLab.x, _nameLab.maxY, LFFScreenW/4, 20) color:[UIColor redColor] font:LFFFont(12) text:@"11" ];
    [self.contentView addSubview:_ourPrice];
    
    //市场价
    _markPrice = [LFFView createLabWithFrame:CGRectMake(_ourPrice.maxX+30, _ourPrice.y, LFFScreenW/4, 20) color:[UIColor lightGrayColor] font:LFFFont(12) text:@"22"];
    [self.contentView addSubview:_markPrice];
    
    //买药提醒
    _buyNotiBtn = [LFFView createBtnWithFrame:CGRectMake(_ourPrice.x, _ourPrice.maxY+10, LFFScreenW/4, 25) imageName:nil text:@"买药提醒" target:self sel:nil textFont:LFFFont(12) textColor:[UIColor blackColor]];
    _buyNotiBtn.backgroundColor = LFFBGColor;
    _buyNotiBtn.layer.cornerRadius = 2;
    _buyNotiBtn.layer.borderWidth = 0.5;
    _buyNotiBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [self.contentView addSubview:_buyNotiBtn];
    
    //加入购物车
    _buyBtn = [LFFView createBtnWithFrame:CGRectMake(_buyNotiBtn.maxX+10, _buyNotiBtn.y, LFFScreenW/4, 25) imageName:nil text:@"加入购物车" target:self sel:nil textFont:LFFFont(12) textColor:[UIColor whiteColor]];
    _buyBtn.backgroundColor = [[UIColor alloc] initWithRed:0/255.0 green:130/255.0 blue:240/255.0 alpha:1.0];
    _buyBtn.layer.cornerRadius = 2;
    _buyBtn.layer.borderWidth = 0.5;
    _buyBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.contentView addSubview:_buyBtn];
    
    
    UIImageView *lineH = [LFFView createLineImageViewWithFrame:CGRectMake(0, 0, LFFScreenW, 1) imageName:@"grayLine@2x"];
    [self.contentView addSubview:lineH];
    
    
}
-(void)setModel:(ProductDetailModel *)model
{
    _model = model;
    
    [_iamgeView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.jianke.net%@",model.head_img]]];
    _nameLab.text = model.productName;

    _ourPrice.text = [NSString stringWithFormat:@"软妹币:%.2f",[model.ourPrice floatValue]/100];
    _markPrice.text = [NSString stringWithFormat:@"市场价:%.2f",[model.marketPrice floatValue]/100];
    

}

@end
