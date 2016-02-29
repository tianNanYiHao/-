//
//  FindMdeicDetailViewCell.h
//  健客
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FindMdeicDetailModel;
@interface FindMdeicDetailViewCell : UITableViewCell

@property (nonatomic,strong) FindMdeicDetailModel *model;

+(instancetype)cellWithTableview:(UITableView*)tabelView WithNum:(NSIndexPath* )indexPath;

-(void)setModel:(FindMdeicDetailModel *)model WithNum:(NSIndexPath* )indexPath;



@end
