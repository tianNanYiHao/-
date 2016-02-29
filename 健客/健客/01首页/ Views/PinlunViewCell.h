//
//  PinlunViewCell.h
//  健客
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PinlunModel;


@interface PinlunViewCell : UITableViewCell
@property (nonatomic,strong) PinlunModel *model;

+(instancetype)cellWithTableview:(UITableView*)tableView;



@end
