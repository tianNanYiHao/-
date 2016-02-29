//
//  SubCategroyViewController.h
//  健客
//
//  Created by 刘斐斐 on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavRootViewController.h"
@interface SubCategroyViewController : NavRootViewController

@property (nonatomic,strong)NSString *itemID;
@property (nonatomic,strong)NSString *itemName;


@property (nonatomic,strong) NSString *urlStr;
@property (nonatomic,assign) BOOL isSearh;
@end
