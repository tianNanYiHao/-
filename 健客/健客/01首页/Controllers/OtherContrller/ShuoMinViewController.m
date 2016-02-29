//
//  ShuoMinViewController.m
//  健客
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ShuoMinViewController.h"

@interface ShuoMinViewController ()

@end

@implementation ShuoMinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = LFFBGColor;
    [self createBarButtonItem];
    
    self.title = @"产品说明书";
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:self.view.bounds];
    
    NSString *str = _productDescription;
    
    //创建字符集 
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"<br/><br/>\n "];
    str = [[str componentsSeparatedByCharactersInSet:doNotWant] componentsJoinedByString:@" "];
    NSArray *arr = [str componentsSeparatedByString:@"\n"];
    for (int i = 0; i<arr.count; i++) {
        NSString *str1 = [NSString stringWithFormat:@"%@\n",arr[i]];
        LFFLog(@"%@",str);
        
        
        lab.textAlignment = NSTextAlignmentLeft;
        lab.text = str1;
        lab.numberOfLines = 0;

        
    }
    
    
    
    [self.view addSubview:lab];
  

}
@end
