//
//  AboutProductViewCell.h
//  健客
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AboutProductModel;
@interface AboutProductViewCell : UICollectionViewCell

@property (nonatomic,strong) AboutProductModel *model;

+(NSString*)identif;
@end
