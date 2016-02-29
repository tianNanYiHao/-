//
//  LFFTool.h
//  健客
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class HomaPageModel;
typedef void (^SuccessBlock)(id responserData);
typedef void (^ErrorBlock)(NSError *error);


@interface LFFTool : NSObject

//沙盒存版本号
+(void)setObject:(id)obj forKey:(NSString*)key;
//沙盒获取版本号
+(id)objforKey:(NSString*)key;

+(void)setObject:(BOOL)bol forkey:(NSString*)key;
+(BOOL)objectforKey:(NSString*)key;

//创建导航栏左右item
+(UIBarButtonItem*)createButtonItemStal:(UIBarButtonSystemItem)stal target:(id)target action:(SEL)sel color:(UIColor*)color;

//封装网络请求
+(void)sendGETWtihURL:(NSString*)urlStr parameters:(NSDictionary *)dict SuccessBlock:(SuccessBlock)successBlock ErrorBlock:(ErrorBlock)errorblock;

//封装添加model
+(NSArray*)addModelWithKey:(NSString*)key withDict:(NSDictionary*)dict toModel:(HomaPageModel*)model;

//封装解析html (获取title)
+(NSString*)getTitleWithURL:(NSString*)urlStr withString:(NSString*)str;




@end
