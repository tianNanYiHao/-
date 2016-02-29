//
//  AllCategroyRightCell.h
//  健客
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AllCategroyModel;

@interface AllCategroyRightCell : UITableViewCell

@property (nonatomic,strong)AllCategroyModel *model;


+(instancetype)cellWithTabelview:(UITableView*)tableview;


@end
