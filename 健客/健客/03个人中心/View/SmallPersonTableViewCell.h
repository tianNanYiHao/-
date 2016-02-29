//
//  SmallPersonTableViewCell.h
//  健客
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonCentrlModel;

@interface SmallPersonTableViewCell : UITableViewCell
@property (nonatomic,strong)PersonCentrlModel *model;

+(instancetype)samllPersonCellWithTableview:(UITableView*)tabelView;



@end
