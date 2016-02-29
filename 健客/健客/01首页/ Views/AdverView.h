//
//  AdverView.h
//  健客
//
//  Created by 刘斐斐 on 15/10/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdverView;

@protocol AdverViewDelegate <NSObject>
//写一个代理方法 传递自己 和 url
-(void)sentAdverView:(AdverView*)view withUrl:(NSString*)url;

@end

@interface AdverView : UIView

@property (nonatomic,strong) NSArray *dataArray1; //数据数组
@property (nonatomic,assign)id<AdverViewDelegate> delegate;


@property (nonatomic,assign) CGFloat scollectionItemheight;// collection 高度

//提供一个创建adverView的方法
+(instancetype)createAdverViewWtihFrame:(CGRect)frame dataArr:(NSArray*)arr;
@end
