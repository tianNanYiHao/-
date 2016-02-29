//
//  AppDelegate.m
//  健客
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"

#import "UMSocial.h" //友盟社会版
#define UMengAppkey @"54dda2f6fd98c5ec680008aa" //友盟appKey



@interface AppDelegate ()
{
    UIScrollView *_scrollView;
    UIView *_showBgVIew;
}
@property (nonatomic,strong) NSString *currentVersion;
@property (nonatomic,strong) NSString *saveVersion;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置友盟app key
    [UMSocialData setAppKey:UMengAppkey];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //系统版本号
    _currentVersion = [NSBundle mainBundle].infoDictionary[(NSString*)kCFBundleVersionKey];
  
    _saveVersion = [LFFTool objforKey:LFFVersion];

    
    if ([_currentVersion isEqualToString:_saveVersion]) {
        [self gotoMainTabBarController];
        
    }else {
        [self gotoWellcomePage];
        [LFFTool setObject:_currentVersion forKey:LFFVersion];
        
    }


    return YES;
}
#pragma mark - 进入主页面(程序)
-(void)gotoMainTabBarController
{
    CATransition *anima = [CATransition animation];
    anima.type = @"push";
    anima.subtype = kCATransitionFromTop;
    [self.window.layer addAnimation:anima forKey:nil];

    self.window.rootViewController = [[MainTabBarViewController alloc]init];
   
}
#pragma mark - 进入欢迎页面
-(void)gotoWellcomePage
{
    UIScrollView *scol = [[UIScrollView alloc] initWithFrame:self.window.bounds];
    [self.window addSubview:scol];
    scol.pagingEnabled = YES;
    
    int imagCuount = 4;
    for (int i = 0; i<4; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(i*LFFScreenW, 0, LFFScreenW, LFFScreenH)];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"startPage%d@2x",i]];
        image.userInteractionEnabled = YES;
        [scol addSubview:image];
        
        if (imagCuount-1 == i) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];

            btn.layer.cornerRadius = 8.0f;
            btn.clipsToBounds = YES;
            btn.frame = CGRectMake(0, 0, LFFScreenW/2, 42);
            btn.center = CGPointMake(LFFScreenW/2, LFFScreenH-42);
     
            btn.backgroundColor = [UIColor clearColor];
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            btn.titleLabel.font = LFFFont(18.0f);
            
            [btn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
            
            [image addSubview:btn];
        }
        
    }
    scol.contentSize = CGSizeMake(imagCuount*LFFScreenW, 0);
    scol.alwaysBounceHorizontal = YES;
    scol.bounces = NO;
    scol.showsHorizontalScrollIndicator = NO;
    _scrollView = scol;

}
-(void)btn
{
    [self gotoMainTabBarController];
}



#pragma mark - 程序重新获得焦点
- (void)applicationDidBecomeActive:(UIApplication *)application {

  
    if ([_saveVersion isEqualToString:_currentVersion]) {
    //背景
    UIView *bgView = [[UIView alloc]initWithFrame:self.window.bounds];
    bgView.userInteractionEnabled = YES;
    [self.window addSubview:bgView];
        _showBgVIew = bgView;
    
    
    //背景图
    UIImageView *iamge = [[UIImageView alloc]initWithFrame:self.window.bounds];
    iamge.image = [UIImage imageNamed:[NSString stringWithFormat:@"healthKnowMore000%d.jpg",arc4random()%10]];
      [bgView addSubview:iamge];
    iamge.userInteractionEnabled = YES;
    
    //按钮
    UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpBtn.frame = CGRectMake(0, 0, LFFScreenW/6, 20);
    jumpBtn.center = CGPointMake(LFFScreenW/2, LFFScreenH-80);
    jumpBtn.layer.cornerRadius = 3.0f;
    jumpBtn.layer.masksToBounds = YES;
    [jumpBtn setTitle:@"跳过 >" forState:UIControlStateNormal];
    jumpBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    jumpBtn.titleLabel.tintColor = [UIColor whiteColor];
    jumpBtn.layer.borderWidth = 0.5f;
    jumpBtn.backgroundColor = [UIColor clearColor];
    jumpBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [jumpBtn addTarget:self action:@selector(jumpToMainTabBarcontrol) forControlEvents:UIControlEventTouchUpInside];
    [iamge addSubview:jumpBtn];
    
    //灰色view
    UIView *coverView = [[UIView alloc]initWithFrame:CGRectMake(0, LFFScreenH/7, LFFScreenW, LFFScreenH/6)];
    coverView.alpha = 0.3;
    
    coverView.backgroundColor = [UIColor lightGrayColor];
    [iamge addSubview:coverView];
    //文字label
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(coverView.width/20, coverView.y+coverView.height/4-coverView.height/8, LFFScreenW-coverView.x, coverView.height/4)];
    titleLab.text = @"健康知多少";
    titleLab.font = LFFFont(25);
    titleLab.textColor = [UIColor whiteColor];
    [bgView addSubview:titleLab];
    
    //随机内文
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(titleLab.x, titleLab.maxY-titleLab.height/4, LFFScreenW-titleLab.x*2, coverView.height-titleLab.height)];
        
       NSString *path =  [[NSBundle mainBundle] pathForResource:@"Tips.plist" ofType:nil];

        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *contentArr = [NSMutableArray array];
        for (int i =0; i<array.count/2; i++) {
            NSString *goodNoti = array[i][@"tips"];
            [contentArr addObject:goodNoti];
        }

    int i = arc4random()%contentArr.count;
    contentLab.text = [NSString stringWithFormat:@"%@",contentArr[i]];
    contentLab.textColor = [UIColor whiteColor];
    contentLab.numberOfLines = 0;
    contentLab.font = LFFFont(14);
    [bgView addSubview:contentLab];
 
    }
   
}
-(void)jumpToMainTabBarcontrol
{
    [self gotoMainTabBarController];
    //点击按钮 跳转 完之后.从父视图删除这个展示图片
    [_showBgVIew removeFromSuperview];
}

@end
