//
//  SubCateGroyViewCell.h
//  健客
//
//  Created by 刘斐斐 on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SubCategroyModel;

@interface SubCateGroyViewCell : UITableViewCell

@property (nonatomic,strong)SubCategroyModel *model;


+(instancetype)cellWithTableView:(UITableView *)tableview;


-(void)setModel:(SubCategroyModel *)model WithisSearch:(BOOL)isSearch;
+(CGFloat)cellHeight;


@end
