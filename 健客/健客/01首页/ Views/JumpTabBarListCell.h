//
//  JumpTabBarListCell.h
//  健客
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JumpTabBarListModel;
@interface JumpTabBarListCell : UITableViewCell

@property (nonatomic,strong) JumpTabBarListModel *model;

+(instancetype)cellWithTabelView:(UITableView*)tabeleview ;


@end
