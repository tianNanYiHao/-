//
//  LFFTool.m
//  健客
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LFFTool.h"
#import "HomaPageModel.h"
@implementation LFFTool

+(void)setObject:(id)obj forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)objforKey:(NSString *)key
{
   return  [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

+(void)setObject:(BOOL)bol forkey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setBool:bol forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(BOOL)objectforKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

//创建导航栏左右item
+(UIBarButtonItem*)createButtonItemStal:(UIBarButtonSystemItem)stal target:(id)target action:(SEL)sel color:(UIColor*)color
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:stal target:target action:sel];
    [item setTintColor:color];
    return item;
    
}

+(void)sendGETWtihURL:(NSString*)urlStr parameters:(NSDictionary *)dict SuccessBlock:(SuccessBlock)successBlock ErrorBlock:(ErrorBlock)errorblock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorblock(error);
    }];
}


+(NSArray*)addModelWithKey:(NSString*)key withDict:(NSDictionary*)dict toModel:(HomaPageModel*)model
{
    NSArray *arr = [dict objectForKey:key];
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (NSDictionary *dictT in arr) {
        [model setValuesForKeysWithDictionary:dictT];
        [dataArray addObject:model];
    }
    return dataArray;

}

+(NSString*)getTitleWithURL:(NSString *)urlStr withString:(NSString *)str
{
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlStr]];
    TFHpple *xpath = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *elements = [xpath searchWithXPathQuery:str];
    for (TFHppleElement *element in elements) {
        return element.text;
    }
    return nil;
    
}
@end
