//
//  MyFavertViewCell.h
//  健客
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductDetailModel;

@interface MyFavertViewCell : UITableViewCell
@property (nonatomic,strong) ProductDetailModel *model;


+(instancetype)cellWithTableview:(UITableView*)tableivew;

@end
