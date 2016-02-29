//
//  NavRootViewController.m
//  健客
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NavRootViewController.h"
#import "JumpTabBarListViewController.h"
@interface NavRootViewController ()<WYPopoverControllerDelegate>
{
    UIBarButtonItem *_rightItem;
    WYPopoverController *_popoverVc;
    
    
}
@end

@implementation NavRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

#pragma mark - 设置导航按钮
-(void)createBarButtonItem
{
    UIBarButtonItem *letfItem = [LFFTool createButtonItemStal:UIBarButtonSystemItemReply target:self action:@selector(backg:) color:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = letfItem;
    
     _rightItem = [LFFTool createButtonItemStal:UIBarButtonSystemItemAdd target:self action:@selector(more:) color:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = _rightItem;
}

//返回按钮
-(void)backg:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//更多内容按钮
-(void)more:(UIButton*)sender
{
    JumpTabBarListViewController *jump = [[JumpTabBarListViewController alloc] init];
    
    
        //此设置必须在传值之后, 否则就会提前进入allList 导致传值失败!!!~~~~
        //popover 用allList 的preferredContentSize 来约束自己的大小
        jump.preferredContentSize = CGSizeMake(80, 22*4);
        jump.view.backgroundColor = [UIColor blackColor];
    
    //    //创建popover
        _popoverVc = [[WYPopoverController alloc] initWithContentViewController:jump];
    //    //设置代理
        _popoverVc.delegate = self;
    
        [_popoverVc presentPopoverFromRect:CGRectMake(LFFScreenW-40, 0, 0, 0) inView:self.view permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES];
  
    
}

#pragma mark  - WYpopover代理方法
/**
 *  当点击朦层调用这个方法，返回YES可以隐藏，反之不行
 */
- (BOOL)popoverControllerShouldDismiss:(WYPopoverController *)popoverController
{
    LFFLog(@"列表消失");
    
    return YES;
}

/**
 *  当popover消失的时候调用的方法
 */
- (void)popoverControllerDidDismiss:(WYPopoverController *)popoverController
{
    NSLog(@"看不见我~");
    
    // 写下面的2句，可以省内存
    _popoverVc.delegate = nil;
    _popoverVc = nil;
}
@end
