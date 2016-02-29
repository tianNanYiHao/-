//
//  AdverView.m
//  健客
//
//  Created by 刘斐斐 on 15/10/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AdverView.h"
#import "AdverViewCell.h"


@interface AdverView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_dataArray1;
    CGFloat _height;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation AdverView



#pragma mark 创建滚动Collection
+(instancetype)createAdverViewWtihFrame:(CGRect)frame dataArr:(NSArray *)arr
{
    AdverView *adverview = [[AdverView alloc] initWithFrame:frame];
    
    adverview.scollectionItemheight = frame.size.height; //传值工作放在方法里 一起写好
    
    [adverview createCollectionViewWithFrame:frame arr:arr];
    
    [adverview createPageControllerWithFrame:frame];
    
    //创建好滚动视图之后 立马开启定时器
    [adverview addTimer];

    return adverview;
}
//创建滚动Collection 实现方法
-(void)createCollectionViewWithFrame:(CGRect)frame arr:(NSArray*)arr
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //开启水平方向滑动
    flowLayout.minimumInteritemSpacing = 0 ; //间距
    flowLayout.minimumLineSpacing = 0; //间距
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    _dataArray1 = [NSMutableArray array];
    _dataArray1 = (NSMutableArray*)arr;

    
    
    //注册cell
    [_collectionView registerClass:[AdverViewCell class] forCellWithReuseIdentifier:[AdverViewCell indetifier]];

    //实现无限滚动 (设置itme位置在4000个的中间)
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:LFFDefaulItems inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];

    
    
}
#pragma mark - 创建PageController
-(void)createPageControllerWithFrame:(CGRect)frame
{
    //创建pageController
    _pageControl =[LFFView createPageControllerWithFrame:CGRectMake(LFFScreenW*0.8, frame.size.height-frame.size.height/5, frame.size.width/8, frame.size.height/5) pageNumberOfPages:(int)_dataArray1.count currentPage:0 currentPageIndicatorTinColor:[UIColor orangeColor] PageIndicatorTinColor:[UIColor whiteColor]];
    [self addSubview:_pageControl];

}
#pragma mark 拖拽 cell 改变pageController位置
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *visiablePath = [[_collectionView indexPathsForVisibleItems] firstObject];
    self.pageControl.currentPage = visiablePath.item%_dataArray1.count;
}

#pragma mark - collection方法代理
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return LFFToalItemsInSection; //一组 但是有4000个cell (大部分为复用) _dataArray1.count*4000
}
#pragma mark 填充cell 实现无限滚动
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AdverViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AdverViewCell indetifier] forIndexPath:indexPath];
    
    cell.homePagemodel = _dataArray1[indexPath.item % self.dataArray1.count];
    return cell;
}


#pragma mark  设置sollection 的 Item大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //_scollectionItemheight 传递
    return CGSizeMake(LFFScreenW, _scollectionItemheight);    
}

#pragma mark - 广告页WebView代理方法 传给控制器!
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
        if ([_delegate respondsToSelector:@selector(sentAdverView:withUrl:)]) {
            [_delegate sentAdverView:self withUrl:[NSString stringWithFormat:@"%@",[_dataArray1[indexPath.item%self.dataArray1.count] url]]];
        }
    
         LFFLog(@"%@",[_dataArray1[indexPath.item%self.dataArray1.count] url]);
}

#pragma mark - 定时器 ---------------
#pragma mark 滚动视图减速设置 (添加定时器)
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self addTimer];
}

#pragma mark  当滚动视图被拖拽 (停止定时器)
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

//增加定时器
-(void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextItem) userInfo:nil repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}
//定时器方法
-(void)nextItem
{
    NSIndexPath *visiablePath = [[_collectionView indexPathsForVisibleItems] firstObject];
    NSInteger visiableItem = visiablePath.item;
    if (visiablePath.item %_dataArray1.count == 0) { //第零张图
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:LFFDefaulItems inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        visiableItem = LFFDefaulItems;
    }
    NSInteger nextItem = visiableItem+1;
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

//移除定时器
-(void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}




@end
