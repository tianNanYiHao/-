//
//  MassageBoxLeftCell.h
//  健客
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MassageBoxLeftModel;

@interface MassageBoxLeftCell : UITableViewCell
@property (nonatomic,strong)MassageBoxLeftModel *model;

+(instancetype)cellWithTabelView:(UITableView *)tableview selected:(BOOL)isSelected;

+(CGFloat)cellHeight;

@end
