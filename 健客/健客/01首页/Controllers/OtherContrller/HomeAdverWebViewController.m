//
//  HomeAdverWebViewController.m
//  健客
//
//  Created by qianfeng on 15/10/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HomeAdverWebViewController.h"

@interface HomeAdverWebViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    
}
@end

@implementation HomeAdverWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LFFBGColor;
    self.title = _titleName;
    
    [self createBarButtonItem];
    
    [self createWebView];
    
}
#pragma mark 重写父类方法 只让导航栏有一个返回按钮
-(void)createBarButtonItem
{
    UIBarButtonItem *letfItem = [LFFTool createButtonItemStal:UIBarButtonSystemItemReply target:self action:@selector(backg:) color:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = letfItem;
}
//返回按钮
-(void)backg:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createWebView
{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, LFFScreenH-64)];
    [self.view addSubview:_webView];
    _webView.scrollView.bounces = NO;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    _webView.delegate  = self;

}
#pragma mark - WebView代理方法


@end
