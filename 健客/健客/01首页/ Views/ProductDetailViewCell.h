//
//  ProductDetailViewCell.h
//  健客
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductDetailModel;



@protocol ProductDetailViewCellDelegate <NSObject>
#pragma mark 设置规格按钮代理
-(void)sendGuiGeBtn:(UIButton*)btn ProductCode:(NSString*)code;

#pragma mark 设置收藏按钮代理

#pragma mark 设置分享按钮代理
-(void)sendFenXiangBtn:(UIButton *)btn productEffect:(NSString*)productEffect;

@end

@interface ProductDetailViewCell : UITableViewCell
@property (nonatomic,strong) ProductDetailModel *model ;
@property (nonatomic,assign)id<ProductDetailViewCellDelegate> delegate;

+(instancetype)cellWithTableView:(UITableView*)tableview withIndexPath:(NSIndexPath*)Indexpath;

-(void)setModel:(ProductDetailModel *)model withIndexPath:(NSIndexPath*)Indexpath;


@end
