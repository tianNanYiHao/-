//
//  ProductdDetCollectionViewCell.h
//  健客
//
//  Created by qianfeng on 15/10/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductDetailModel;

@interface ProductdDetCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)ProductDetailModel *model;

+(NSString*)indentifr;

@end
