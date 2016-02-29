//
//  PinlunModel.h
//  健客
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PinlunModel : NSObject

@property (nonatomic,strong) NSString *totalcount;  //评论数

@property (nonatomic,strong) NSString *totalStar;  //评分

//EvaluationDetials
@property (nonatomic,strong) NSString *star;  //评价
@property (nonatomic,strong) NSString *number;  //数量
@property (nonatomic,strong) NSString *evaluationDetials;  //评论内容
@property (nonatomic,strong) NSString *userName;  //评论人
@property (nonatomic,strong) NSString *evaluateTime;  //评论时间

@property (nonatomic,assign) CGFloat cellHeight;


@end
