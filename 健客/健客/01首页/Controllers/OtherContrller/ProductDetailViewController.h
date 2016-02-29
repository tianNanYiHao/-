//
//  ProductDetailViewController.h
//  健客
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavRootViewController.h"
#import "ProductDetailViewCell.h"
@interface ProductDetailViewController : NavRootViewController<ProductDetailViewCellDelegate>

@property (nonatomic,strong) NSString *productCode; //产品code
@property (nonatomic,strong) NSString *productName; //产品名


-(void)sendGuiGeBtn:(UIButton *)btn ProductCode:(NSString *)code;

-(void)sendFenXiangBtn:(UIButton *)btn productEffect:(NSString*)productEffect;

@end
