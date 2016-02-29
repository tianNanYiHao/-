//
//  AdverViewCell.h
//  健客
//
//  Created by 刘斐斐 on 15/10/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomaPageModel;
@interface AdverViewCell : UICollectionViewCell

@property (nonatomic,strong) HomaPageModel *homePagemodel;
@property (nonatomic,strong) NSArray *arr;


+(NSString*)indetifier;

@end
