//
//  FindMdeicVIewCell.h
//  健客
//
//  Created by qianfeng on 15/10/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FindMdeicModel;

@interface FindMdeicViewCell : UITableViewCell

@property (nonatomic,strong)FindMdeicModel *model;

+(instancetype)cellWithTableView:(UITableView*)tableView;

+(CGFloat)cellHeight;

@end
