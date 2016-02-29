//
//  HomePageView.m
//  健客
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HomePageView.h"
#import "HomaPageModel.h"
#import "FunctionButton.h"

#import "AdverView.h"
#import "MassageBoxViewController.h"

@interface HomePageView()<UIScrollViewDelegate>
{
    UIScrollView *_backGroundScollView;// 背景滚动视图
    UIView *_adverView; //广告页View
    UIScrollView *_adverScrollView; //广告页滚动视图

    
    UIImageView *_adverIv; //广告页滚动图片
    UIView *_coverView; //装按钮的view
    UIView *_wotrhBuy; //值得买View
    UIView *_couldhelpView; //可能帮到你View
    UIButton *_goodsView; //可能帮到你 商品VIew
    NSMutableArray *_dataArrayImage3; //可能帮到你 数组
    UIPageControl *_pageControl; //可能帮到你 pageControll
    UIScrollView *_couldHelpScrollView; //可能帮到你 滚动视图
    
    UIImageView *_greayRect; //灰色矩形img
    UIView *_sexualHealthView; //两性健康View
    UIView *_chinaWesternMedView; //中西医药View
   
}
@property (nonatomic,strong)NSTimer *timer;

@end
@implementation HomePageView

+(instancetype)homePageWithFrame:(CGRect)frame array:(NSArray*)arr
{
    HomePageView *homeV = [[HomePageView alloc]initWithFrame:frame];
    [homeV addSubviewsWithArray:arr];
    return homeV;
}
#pragma mark - 1创建广告页及滚动视图
-(void)addSubviewsWithArray:(NSArray*)arr
{
    //创建底部滚动视图
    _backGroundScollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_backGroundScollView];
    _backGroundScollView.userInteractionEnabled = YES;
    _backGroundScollView.alwaysBounceVertical = YES;
    _backGroundScollView.showsVerticalScrollIndicator = NO;
    _backGroundScollView.backgroundColor = LFFBGColor;

    
    //1 广告页view
    _adverView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, (LFFScreenH-49-64)*2/3-50)];
    [_backGroundScollView  addSubview:_adverView];
    _adverView.userInteractionEnabled =YES;
    _adverView.backgroundColor = [UIColor whiteColor];
    
    //1.1 广告sollection 创建无限滚动页
   AdverView *adverView = [AdverView createAdverViewWtihFrame:CGRectMake(0, 0, LFFScreenW, _adverView.height*2/5) dataArr:arr];
    
    _adverViewDele  = adverView ;
    
    adverView.userInteractionEnabled = YES;
    [_adverView addSubview:adverView];
    
    
   //1.4 按钮图标
    _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, _adverView.height*2/5, LFFScreenW, _adverView.height*3/5)];
    [_adverView addSubview:_coverView];
    
    NSArray *iamgerArr = @[@"menu_icon_all_category@2x",@"menu_icon_search_medication@2x",@"menu_icon_medication@2x",@"menu_icon_consult@2x",@"menu_icon_shake@2x",@"menu_transport_icon@2x"];
    NSArray *title = @[@"全部分类",@"对症找药",@"药划算",@"用药咨询",@"摇积分",@"我的物流"];
    
    CGFloat btnW = 43;
    CGFloat btnH = 43;
    CGFloat marginH = (LFFScreenW-3*btnW)/4;
    CGFloat marginV = (_coverView.height -2*btnH)/3;
    
    _adverBtnArr = [NSMutableArray array];
    for (int i=0; i<6; i++) {
        int row = i/3;
        int rol = i%3;
        FunctionButton *btn = [[FunctionButton alloc]init];
        btn.frame = CGRectMake(marginH+rol*(marginH+btnW), marginV+row*(marginV+btnH), btnW, btnH);
        [btn setImage:LFFImage(iamgerArr[i]) forState:UIControlStateNormal];
        [btn setTitle:title[i] forState:UIControlStateNormal];
        btn.titleLabel.font = LFFFont(12.0f);
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_coverView addSubview:btn];
        
        [_adverBtnArr addObject:btn];
    
    }
    
//    背景滚动视图尺寸
    _backGroundScollView.contentSize = CGSizeMake(0, LFFScreenW*3);
    
}
#pragma mark - 2值得买页面
-(UIView*)wothBuyWithArray:(NSArray *)arr
{
    
    //2 值得买View
    _wotrhBuy = [[UIView alloc] initWithFrame:CGRectMake(0, _coverView.maxY+10, LFFScreenW, _coverView.height)];
    _wotrhBuy.backgroundColor = [UIColor whiteColor];
    [_backGroundScollView addSubview:_wotrhBuy];
    
    //2.1 值得买
    UILabel *buyLab = [LFFView createLabWithFrame:CGRectMake(5, 5, 100, 15) color:[UIColor blackColor] font:LFFFont(12) text:@"值得买"];
    [_wotrhBuy addSubview:buyLab];
    
    //2.2 line h v
    UIImageView *lineH = [LFFView createLineImageViewWithFrame:CGRectMake(0, buyLab.maxY+5, LFFScreenW, 1) imageName:@"grayLine@2x"];
    [_wotrhBuy addSubview:lineH];
    
    UIImageView *lineV = [LFFView createLineImageViewWithFrame:CGRectMake(lineH.width/2, lineH.maxY, 1, _wotrhBuy.height-lineH.maxY) imageName:@"grayLineVertical@2x"];
    [_wotrhBuy addSubview:lineV];
    
    UIImageView *lineH2 = [LFFView createLineImageViewWithFrame:CGRectMake(lineV.maxX, lineH.maxY+lineV.height/2, LFFScreenW/2, 1) imageName:@"grayLine@2x"];
    [_wotrhBuy addSubview:lineH2];
    
    //2.3 每日抢购 图片
    UIImageView *leftImg = [LFFView createLineImageViewWithFrame:CGRectMake(0, lineH.maxY+1, LFFScreenW/2-1, lineV.height-1) imageName:@"friead_03"];
    [leftImg setImageWithURL:[NSURL URLWithString:[arr[0] img_url]]];
    [_wotrhBuy addSubview:leftImg];
    leftImg.tag = 1001;
    _leftImg = leftImg;
    _leftImg.userInteractionEnabled = YES;
    
    //
    UIImageView *rightUpImg = [LFFView createLineImageViewWithFrame:CGRectMake(lineV.maxX+1, lineH.maxY+1, LFFScreenW/2-1, lineV.height/2-1) imageName:@"friead_03"];
    [rightUpImg setImageWithURL:[NSURL URLWithString:[arr[1] img_url]]];
    [_wotrhBuy addSubview:rightUpImg];
    rightUpImg.tag = 1002;
    _rightUpImg = rightUpImg;
    _rightUpImg.userInteractionEnabled = YES;
    
    //
    UIImageView *rightDoewImg = [LFFView createLineImageViewWithFrame:CGRectMake(lineV.maxX+1, lineH2.maxY+1, LFFScreenW/2-1, lineV.height/2-1) imageName:@"friead_03"];
    [_wotrhBuy addSubview:rightDoewImg];
    [rightDoewImg setImageWithURL:[NSURL URLWithString:[arr[2] img_url]]];
    rightDoewImg.tag = 1003;
    _rightDownImg = rightDoewImg;
    _rightDownImg.userInteractionEnabled = YES;
    
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1:)];
//    [leftImg addGestureRecognizer:tap1];
//    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2:)];
//    [rightUpImg addGestureRecognizer:tap2];
//    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3:)];
//    [rightDoewImg addGestureRecognizer:tap3];
 
    return _wotrhBuy;

}

#pragma mark - 3可能帮到你View
-(UIView*)couldhelpWithArray:(NSArray *)arr
{
    //3
    _couldhelpView = [[UIView alloc] initWithFrame:CGRectMake(0, _wotrhBuy.maxY+10, LFFScreenW, _wotrhBuy.height)];
    _couldhelpView.userInteractionEnabled = YES;
    _couldhelpView.backgroundColor = [UIColor whiteColor];
    [_backGroundScollView addSubview:_couldhelpView];
    
    //3.1
    UILabel *couldLab = [LFFView createLabWithFrame:CGRectMake(5, 5, 100, 15) color:[UIColor blackColor] font:LFFFont(12.0) text:@"可能帮到你"];
    [_couldhelpView addSubview:couldLab];
    
    //3.2 line
    UIImageView *lineH = [LFFView createLineImageViewWithFrame:CGRectMake(0, couldLab.maxY+5, LFFScreenW, 1) imageName:@"grayLine@2x"];
    [_couldhelpView addSubview:lineH];
    
    //3.3 9图滚动Scrollview
   _couldHelpScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, lineH.maxY+1, LFFScreenW, _couldhelpView.height-(couldLab.maxY+6))];
    [_couldhelpView addSubview:_couldHelpScrollView];
    _couldHelpScrollView.backgroundColor = [UIColor whiteColor];
    _couldHelpScrollView.bounces = NO;
    _couldHelpScrollView.pagingEnabled = YES;
    _couldHelpScrollView.userInteractionEnabled = YES;
    _couldHelpScrollView.showsHorizontalScrollIndicator = NO;
    _couldHelpScrollView.alwaysBounceHorizontal = YES;
    
    
    _dataArrayImage3 = [NSMutableArray array];
    _couleHelpArr = [NSMutableArray array];
    for (int i= 0; i<arr.count; i++) {
        _goodsView = [UIButton buttonWithType:UIButtonTypeCustom];
        _goodsView.frame = CGRectMake(LFFScreenW/3*i, 0, LFFScreenW/3, _couldHelpScrollView.height);
        
        _goodsView.backgroundColor = [UIColor whiteColor];
        _goodsView.userInteractionEnabled = YES;
        [_dataArrayImage3 addObject:_goodsView]; // 把imgvi 撞到数组里区
        [_couleHelpArr addObject:_goodsView];
        
        
        UIImageView *lineV = [LFFView createLineImageViewWithFrame:CGRectMake(LFFScreenW/3*i-1, lineH.x+1,1, _couldHelpScrollView.height) imageName:@"grayLineVertical@2x"];
        [_couldHelpScrollView addSubview:lineV];
        [_couldHelpScrollView addSubview:_goodsView];
        
        //3.4为每个goodsView添加图片以及label
        UIImageView *goodsImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, _goodsView.width*0.8, (_goodsView.height*2/3)*0.8)];
        goodsImgView.image = LFFImage(@"friead_03");
        [goodsImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.jianke.net%@",[arr[i] productImageUrl]]]];
        [_goodsView addSubview:goodsImgView];
        
        //3.4 商品名&介绍
        UILabel *nameLab = [LFFView createLabWithFrame:CGRectMake(0, goodsImgView.maxY/0.8-10, goodsImgView.width/0.8, (goodsImgView.height*2/3)/2/0.8) color:[UIColor blackColor] font:LFFFont(14) text:@"商品名字"];
        nameLab.text = [arr[i] productName];
        nameLab.textAlignment = NSTextAlignmentCenter;
        [_goodsView addSubview:nameLab];
        
        UILabel *introduceLab = [LFFView createLabWithFrame:CGRectMake(0, nameLab.maxY-5, goodsImgView.width/0.8, (goodsImgView.height*2/3)/4/0.8) color:[UIColor darkGrayColor] font:LFFFont(10) text:@"介绍文字介绍文字"];
        introduceLab.textAlignment = NSTextAlignmentCenter;
        introduceLab.text = [arr[i] productEffect];
        [_goodsView addSubview:introduceLab];
    }
    
    //3.5 pageController 添加滚动点
    _greayRect = [LFFView createLineImageViewWithFrame:CGRectMake(0, _couldhelpView.maxY, LFFScreenW, 17) imageName:@"grayRect@2x"];
    [_backGroundScollView addSubview:_greayRect];
    _greayRect.userInteractionEnabled = YES;
    
    _pageControl = [LFFView createPageControllerWithFrame:CGRectMake(0, 0, LFFScreenW/6, 17/2) pageNumberOfPages:(int)arr.count/3 currentPage:0 currentPageIndicatorTinColor:[[UIColor alloc]initWithRed:0/255.0 green:133/255.0 blue:235/255.0 alpha:1.0] PageIndicatorTinColor:[UIColor darkGrayColor]];
    _pageControl.center = CGPointMake(LFFScreenW/2, 17/2);
    [_greayRect addSubview:_pageControl];
    _couldHelpScrollView.delegate = self;

    _couldHelpScrollView.contentSize = CGSizeMake(LFFScreenW/3*arr.count, 0);
    return _couldhelpView;
}
#pragma mark scrollerview 代理
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGPoint pt = scrollView.contentOffset;
    NSInteger indext = pt.x/LFFScreenW;
    _pageControl.currentPage = indext+1;
    
}

#pragma mark 定时器 -----
-(void)addtimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)nextImage
{
    
    
}

#pragma mark - 4两性健康View
-(UIView*)sexualHealthWithArray:(NSArray *)arr
{
    //4 两性健康背景View
    _sexualHealthView = [[UIView alloc]initWithFrame:CGRectMake(0, _greayRect.maxY, LFFScreenW, _wotrhBuy.height)];
    [_backGroundScollView addSubview:_sexualHealthView];
    _sexualHealthView.backgroundColor = [UIColor whiteColor];
    
    //4.1 两性健康Lab
    UILabel *sexHelLab = [LFFView createLabWithFrame:CGRectMake(5, 5, 100, 15) color:[UIColor blackColor] font:LFFFont(12) text:@"两性健康"];
    [_sexualHealthView addSubview:sexHelLab];
    
    //4.2 更多Btn
    UIButton *moreBtn = [LFFView createBtnWithFrame:CGRectMake(LFFScreenW*0.9-10, 5, 50, 15) imageName:nil text:@"更多" target:self sel:@selector(jumpSexHealth:) textFont:LFFFont(10) textColor:[UIColor blackColor]];
    [_sexualHealthView addSubview:moreBtn];
    
    //4.2 line h v
    UIImageView *lineH = [LFFView createLineImageViewWithFrame:CGRectMake(0, sexHelLab.maxY+5, LFFScreenW, 1) imageName:@"grayLine@2x"];
    [_sexualHealthView addSubview:lineH];
    
    UIImageView *lineV = [LFFView createLineImageViewWithFrame:CGRectMake(lineH.width/2, lineH.maxY, 1, _wotrhBuy.height-lineH.maxY) imageName:@"grayLineVertical@2x"];
    [_sexualHealthView addSubview:lineV];
    
    UIImageView *lineH2 = [LFFView createLineImageViewWithFrame:CGRectMake(lineV.maxX, lineH.maxY+lineV.height/2, LFFScreenW/2, 1) imageName:@"grayLine@2x"];
    [_sexualHealthView addSubview:lineH2];
    
    //4.3 BGView
    UIView *leftBgV = [LFFView createBackgroundViewWithFrame:CGRectMake(0, lineH.maxY+1, LFFScreenW/2-1, lineV.height-1) color:[UIColor whiteColor]];
    _leftImg1 = leftBgV;
    [_sexualHealthView addSubview:leftBgV];
    
    UIView *rightUpBgV = [LFFView createBackgroundViewWithFrame:CGRectMake(lineV.maxX+1, leftBgV.y, LFFScreenW/2-1, lineV.height/2-1) color:[UIColor whiteColor]];
    _rightUpImg1 = rightUpBgV;
    [_sexualHealthView addSubview:rightUpBgV];
    
    UIView *rightDownBgV = [LFFView createBackgroundViewWithFrame:CGRectMake(lineV.maxX+1, lineH2.maxY+1, LFFScreenW/2-1, lineV.height/2-1) color:[UIColor whiteColor]];
    _rightDownImg1 = rightDownBgV;
    [_sexualHealthView addSubview:rightDownBgV];
    
    
    //4.4 (金戈)商品名Lab + ImageView
    //***leftBgV
    UILabel *nameLab = [LFFView createLabWithFrame:CGRectMake(0, 0, leftBgV.width, leftBgV.height/5) color:[UIColor blackColor] font:LFFFont(14) text:@"商品名"];
    nameLab.text = [arr[0] productName];
    nameLab.textAlignment = NSTextAlignmentCenter;
    [leftBgV addSubview:nameLab];
    UILabel *introduceLab = [LFFView createLabWithFrame:CGRectMake(0, nameLab.maxY-5, nameLab.width, nameLab.height*2/3) color:[UIColor darkGrayColor] font:LFFFont(10) text:@"商品信息商品信息"];
    introduceLab.text = [arr[0] productEffect];
    introduceLab.textAlignment = NSTextAlignmentCenter;
    [leftBgV addSubview:introduceLab];
    
    UIImageView *goodsImg = [LFFView createLineImageViewWithFrame:CGRectMake(0, 0, leftBgV.width*2/3, leftBgV.height*3/5) imageName:@"friead_03"];
    [goodsImg setImageWithURL:[NSURL URLWithString:[arr[0] productImageUrl]]];
    goodsImg.center = CGPointMake(leftBgV.width/2, leftBgV.height*3/5);
    [leftBgV addSubview:goodsImg];
    
    
    //***rightUpBgV
    UILabel *nameLab1 = [LFFView createLabWithFrame:CGRectMake(0, rightUpBgV.height/3, rightUpBgV.width/2, leftBgV.height/5) color:[UIColor blackColor] font:LFFFont(14) text:@"商品名"];
    [rightUpBgV addSubview:nameLab1];
    nameLab1.text = [arr[1] productName];
    nameLab1.textAlignment = NSTextAlignmentCenter;
    UILabel *introduceLab1 = [LFFView createLabWithFrame:CGRectMake(0,nameLab1.maxY-5, nameLab1.width, nameLab1.height*2/3) color:[UIColor darkGrayColor] font:LFFFont(10) text:@"商品信息商品信息"];
    introduceLab1.text = [arr[1] productEffect];
    introduceLab1.textAlignment  = NSTextAlignmentCenter;
    [rightUpBgV addSubview:introduceLab1];
    
    UIImageView *goodsImg1 = [LFFView createLineImageViewWithFrame:CGRectMake(nameLab1.maxX+nameLab1.width/4, nameLab1.y, nameLab1.width*2/3, nameLab1.height*1.5) imageName:@"friead_03"];
    [goodsImg1 setImageWithURL:[NSURL URLWithString:[arr[1] productImageUrl]]];
    [rightUpBgV addSubview:goodsImg1];
    
    
    //***rightDownBgV
    UIImageView *goodsImg2 = [LFFView createLineImageViewWithFrame:CGRectMake(5, rightDownBgV.height/4, rightDownBgV.width/3, rightDownBgV.height*2/3) imageName:@"friead_03"];
    [goodsImg2 setImageWithURL:[NSURL URLWithString:[arr[2] productImageUrl]]];
    [rightDownBgV addSubview:goodsImg2];
    
    UILabel *nameLab2 = [LFFView createLabWithFrame:CGRectMake(rightDownBgV.width/2, goodsImg2.y, rightDownBgV.width/2, leftBgV.height/5) color:[UIColor blackColor] font:LFFFont(14) text:@"商品名"];
    nameLab2.text = [arr[2] productName];
    nameLab2.textAlignment = NSTextAlignmentCenter;
    [rightDownBgV addSubview:nameLab2];
    
    UILabel *introduceLab2 = [LFFView createLabWithFrame:CGRectMake(rightDownBgV.width/2, nameLab2.maxY-5, nameLab2.width, nameLab2.height*2/3) color:[UIColor lightGrayColor] font:LFFFont(10) text:@"商品介绍商品介绍"];
    introduceLab2.text = [arr[2] productEffect];
    introduceLab2.textAlignment = NSTextAlignmentCenter;
    [rightDownBgV addSubview:introduceLab2];
    return _sexualHealthView;
}
#pragma mark - 5中西医药
-(UIView*)chinaWesternMedicineWithArray:(NSArray *)arr
{
    _eastWestArr = [NSMutableArray arrayWithCapacity:0];
    
    //5
    _chinaWesternMedView = [[UIView alloc]initWithFrame:CGRectMake(0, _sexualHealthView.maxY+10, LFFScreenW, _wotrhBuy.height)];
    _chinaWesternMedView.userInteractionEnabled = YES;
    _chinaWesternMedView.backgroundColor = [UIColor whiteColor];
    [_backGroundScollView addSubview:_chinaWesternMedView];
    
    //5.1 中西医药
    UILabel *chineseWestMed = [LFFView createLabWithFrame:CGRectMake(5, 5, 100, 15) color:[UIColor blackColor] font:LFFFont(12) text:@"中西医药"];
    [_chinaWesternMedView addSubview:chineseWestMed];
    
    //5.2 更多
    UIButton *moreBtn = [LFFView createBtnWithFrame:CGRectMake(LFFScreenW*0.9-10, 5, 50, 15) imageName:nil text:@"更多" target:self sel:@selector(jumpChineseWest:) textFont:LFFFont(10) textColor:[UIColor blackColor]];
    [_chinaWesternMedView addSubview:moreBtn];
    
    //5.3 line h v
    UIImageView *lineH = [LFFView createLineImageViewWithFrame:CGRectMake(0, chineseWestMed.maxY+5, LFFScreenW, 1) imageName:@"grayLine@2x"];
    [_chinaWesternMedView addSubview:lineH];
    
    //5.4 BgVIew & lineV
    
    for (int i = 0; i<arr.count; i++) {
        UIImageView *ImgBgV = [LFFView createLineImageViewWithFrame:CGRectMake(i*LFFScreenW/3, lineH.maxY, LFFScreenW/3, _chinaWesternMedView.height-lineH.maxY) imageName:nil];
        ImgBgV.backgroundColor = [UIColor whiteColor];
        [_chinaWesternMedView addSubview:ImgBgV];
        
        UIImageView *lineV = [LFFView createLineImageViewWithFrame:CGRectMake(LFFScreenW/3*i-1, lineH.maxY+1,1, ImgBgV.height) imageName:@"grayLineVertical@2x"];
        [_chinaWesternMedView addSubview:lineV];
        
        
        //5.4为每个goodsView添加图片以及label
        UIImageView *goodsImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, ImgBgV.width*0.8, (ImgBgV.height*2/3)*0.8)];
        goodsImgView.image = LFFImage(@"friead_03");
        [goodsImgView setImageWithURL:[NSURL URLWithString:[arr[i] productImageUrl]]];
        [ImgBgV addSubview:goodsImgView];
        
        //5.5 商品名&介绍
        UILabel *nameLab = [LFFView createLabWithFrame:CGRectMake(0, goodsImgView.maxY/0.8-10, goodsImgView.width/0.8, (goodsImgView.height*2/3)/2/0.8) color:[UIColor blackColor] font:LFFFont(14) text:@"商品名字"];
        nameLab.text = [arr[i] productName];
        nameLab.textAlignment = NSTextAlignmentCenter;
        [ImgBgV addSubview:nameLab];

        UILabel *introduceLab = [LFFView createLabWithFrame:CGRectMake(0, nameLab.maxY-5, goodsImgView.width/0.8, (goodsImgView.height*2/3)/4/0.8) color:[UIColor darkGrayColor] font:LFFFont(10) text:@"介绍文字介绍文字"];
        introduceLab.text = [arr[i] productEffect];
        introduceLab.textAlignment = NSTextAlignmentCenter;
        [ImgBgV addSubview:introduceLab];
        
        
        _eastWestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _eastWestBtn.frame = CGRectMake(i*LFFScreenW/3, lineH.maxY, LFFScreenW/3, _chinaWesternMedView.height-lineH.maxY);

        [_chinaWesternMedView addSubview:_eastWestBtn];
        [_eastWestArr addObject:_eastWestBtn];
        
    }
    
    
    //重置背景滚动视图contentsize
    _backGroundScollView.contentSize = CGSizeMake(0, _chinaWesternMedView.maxY);
    return _chinaWesternMedView;
}


#pragma mark - 跳转两性健康页(跟多)
-(void)jumpSexHealth:(UIButton*)btn
{
    LFFLog(@"跳转两性健康更多页");
}
-(void)jumpChineseWest:(UIButton*)btn
{
    LFFLog(@"跳转中西医药更多页");
}

@end
