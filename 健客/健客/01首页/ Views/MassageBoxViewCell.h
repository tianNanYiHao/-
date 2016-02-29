//
//  MassageBoxViewCell.h
//  健客
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MassageBoxModel;

@interface MassageBoxViewCell : UITableViewCell
@property (nonatomic,strong)MassageBoxModel *model;

+(instancetype)cellWithTableView:(UITableView*)tableView withNumber:(int)number;

+(CGFloat)cellHeight;


@end
