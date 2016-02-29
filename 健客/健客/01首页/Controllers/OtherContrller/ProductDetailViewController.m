//
//  ProductDetailViewController.m
//  健客
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductDetailModel.h"
#import "ProductDetailViewCell.h"

#import "ProductdDetCollectionViewCell.h"
#import "ShuoMinViewController.h"
#import "PinLunViewController.h"

#import "AboutProductViewCell.h"


#import "UMSocial.h"// 友盟社会版



@interface ProductDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *_bgScrollview; //背景滚动视图
    
    
    NSMutableArray *_dataADArray; //广告页数据源 (collection做)
    
    NSMutableArray *_dataInfoArray1; //商品详情 数据源 (tableView做)

    NSMutableArray *_dataRecommendedArray; //相关推荐 (collection做)
    
    UICollectionView *_collectionADView; //广告页collecitonView
    
    UIPageControl *_pageControl; //页数控制
    
    NSTimer *_timer;
    
    
    UITableView *_tableView; //
    BOOL _isRemoveAll;
   
 
}

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LFFBGColor;
    self.title = @"产品详情";
    
    [self createBarButtonItem]; //继承父类方法
    
    
    [self initDataArr];//初始化数组
    
    [self initNetWorkData];//请求网络数据
   
}

-(void)initDataArr
{
    _dataADArray = [NSMutableArray arrayWithCapacity:0];
    _dataInfoArray1 = [NSMutableArray arrayWithCapacity:0];

    
    _dataRecommendedArray = [NSMutableArray arrayWithCapacity:0];
    
}
-(void)createBaseView
{


}

#pragma mark 请求网络数据
-(void)initNetWorkData
{
    NSString *url = [NSString stringWithFormat:ProductDetailURL,_productCode];
    [LFFView showHUDWithText:@"正在载入商品详情..." toView:self.view];

    [LFFTool sendGETWtihURL:url parameters:nil SuccessBlock:^(id responserData) {
        [LFFView hiddenHUDWithText:nil toView:self.view];
        
        if (_isRemoveAll) {
            [_dataADArray removeAllObjects];
            [_dataInfoArray1 removeAllObjects];
            [_dataRecommendedArray removeAllObjects];
        }
        
        id backData = [NSJSONSerialization JSONObjectWithData:responserData options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dictAll = backData[@"info"];
        
        //1广告数据源
        NSArray *dictADarr = dictAll[@"imgList"];
        for (NSDictionary *dictAD in dictADarr) {
            ProductDetailModel *model = [[ProductDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dictAD];
            [_dataADArray addObject: model];
        }
        
        //2商品详情section1
        NSDictionary *dictInfo1 = dictAll[@"productInfo"];
            ProductDetailModel *modelInfo = [[ProductDetailModel alloc] init];
            [modelInfo setValuesForKeysWithDictionary:dictInfo1];
     
        //判断 如果没有图片 就随便存个啥吧 ``` 要把后台数据库的人吊起来打!
        if (_dataADArray.count == 0) {
            modelInfo.head_img = @"111"; //为了个人收藏有图片  所以在后来 往商品详情数据中加入一个广告页图片
        }
        else
        {
             modelInfo.head_img = [_dataADArray[0] head_img]; //为了个人收藏有图片  所以在后来 往商品详情数据中加入一个广告页图片
        }
            [_dataInfoArray1 addObject:modelInfo];
        
        
        //3相关推荐
        modelInfo.relatedRecommend = dictAll[@"relatedRecommend"];
        [_dataRecommendedArray addObject:modelInfo];


        //1获得数据之后 创建广告页
        //创建广告页collection
        [self createADcollectionView];
        
       //2创建商品详情tableview
        [self createTabelView];
        
 
       // 刷新数据
        [_tableView reloadData];
        [_collectionADView reloadData];
        
    } ErrorBlock:^(NSError *error) {
         [LFFView hiddenHUDWithText:nil toView:self.view];
    }];
    
}

#pragma mark - 创建AD广告页
-(void)createADcollectionView
{
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal; //开启水平方向滚动
    layOut.minimumInteritemSpacing = 0;
    layOut.minimumLineSpacing = 0;
    
    _collectionADView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, (LFFScreenH-64)/3) collectionViewLayout:layOut];
    _collectionADView.delegate = self;
    _collectionADView.dataSource = self;
    _collectionADView.pagingEnabled = YES;
    _collectionADView.showsHorizontalScrollIndicator = NO;
    _collectionADView.backgroundColor = [UIColor whiteColor];

    
    
    //注册cell
    [_collectionADView registerClass:[ProductdDetCollectionViewCell class] forCellWithReuseIdentifier:[ProductdDetCollectionViewCell indentifr]];
    
//    实现无限滚动 (设置itme位置在400个的中间)
    if (_dataADArray.count) { //判断 广告页数组 不为空!! 才执行滚动
        [_collectionADView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_dataADArray.count*100/2 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
  
    
}
#pragma mark - 创建商品详情
-(void)createTabelView
{
    for (UIView *VIew  in self.view.subviews) {
        [VIew removeFromSuperview];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, LFFScreenH-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = LFFBGColor;
    _tableView.alwaysBounceVertical = NO;

    _tableView.tableHeaderView = _collectionADView;
    [self.view addSubview:_tableView];
    
    
    //创建图标
    UIImageView *rx = [LFFView createLineImageViewWithFrame:CGRectMake(LFFScreenW-LFFScreenW/7, 20, 35, 34/2) imageName:@"rx"];
    [_tableView addSubview:rx];
    
    //创建pageController
    _pageControl = [LFFView createPageControllerWithFrame:CGRectMake(LFFScreenW-LFFScreenW/6, _collectionADView.height*3/4.0, LFFScreenW/9, 20) pageNumberOfPages:(int)_dataADArray.count currentPage:0 currentPageIndicatorTinColor:[[UIColor alloc] initWithRed:0/255.0 green:130/255.0 blue:240/255.0 alpha:1.0] PageIndicatorTinColor:[UIColor lightGrayColor]];
    [_tableView addSubview:_pageControl];
    
    [self addTimer];

   
}

#pragma mark - tableView代理方法!
#pragma mark 调整组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


#pragma mark 组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}
#pragma mark 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
           return 50;
        }if (indexPath.row == 1) {
            return 0 == [_dataInfoArray1[indexPath.row-1] cellHeight2]?44:[_dataInfoArray1[indexPath.row-1] cellHeight2];
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 38;
        }
        if (indexPath.row == 1) {
            return 38;
        }
        if (indexPath.row == 2) {
            return 0 == [_dataInfoArray1[indexPath.row-2] cellSection1Row2height]?44:[_dataInfoArray1[indexPath.row-2] cellSection1Row2height];
        }
        if (indexPath.row == 3) {
            return 38;
        }
        }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
             return 28;
        }
        }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
              return 28;
        }
        }
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
             return 44;
        }
        }
    if (indexPath.section == 5) {
        if (indexPath.row == 0) {
            return 44;
        }
        }
    if (indexPath.section == 6) {
        if (indexPath.row == 0) {
            return 250;
        }
    }

    return 0;
    
}
#pragma mark 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 4;
    }
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        return 1;
    }
    if (section == 4) {
        return 1;
    }
    if (section == 5) {
        return 1;
    }
    if (section == 6) {
        return 1;
    }
    return 0;
}
#pragma mark 填充cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailViewCell *cell = [ProductDetailViewCell cellWithTableView:tableView withIndexPath:indexPath];
    cell.delegate = self; //设置cell的代理
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell setModel:_dataInfoArray1[indexPath.row] withIndexPath:indexPath];
            return cell;
        }
        if (indexPath.row == 1) {
            //当(indexPath.row == 1)  数据源里面的数据可能越界!! 这里必须保证数据源还是第0个
            [cell setModel:_dataInfoArray1[indexPath.row-1] withIndexPath:indexPath];
            return cell;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [cell setModel:_dataInfoArray1[indexPath.row] withIndexPath:indexPath];
            return cell;
        }if (indexPath.row == 1) {
            [cell setModel:nil withIndexPath:indexPath];
            return cell;
        }if (indexPath.row == 2) {
            [cell setModel:_dataInfoArray1[indexPath.row-2] withIndexPath:indexPath];
            return cell;
        }if (indexPath.row == 3) {
            [cell setModel:nil withIndexPath:indexPath];
            return cell;
        }
    }
    if (indexPath.section == 2) {
        [cell setModel:nil withIndexPath:indexPath];
        return cell;
    }if (indexPath.section == 3) {
        [cell setModel:nil withIndexPath:indexPath];
        return cell;
    }if (indexPath.section == 4) {
        [cell setModel:nil withIndexPath:indexPath];
        //设置 cell 右边小箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }if (indexPath.section == 5) {
        [cell setModel:_dataInfoArray1[indexPath.row]  withIndexPath:indexPath];
        //设置 cell 右边小箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }if (indexPath.section == 6) {
        [cell setModel:_dataRecommendedArray[indexPath.row] withIndexPath:indexPath];
        return cell;
    }
    else
        return nil;
}

#pragma mark 点击cell方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    //打电话
    
    if (indexPath.section == 3) {
        //打电话
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:400666800"]];
    }
    //点击产品说明cell
    if (indexPath.section == 4) {
        ShuoMinViewController *shoumin = [[ShuoMinViewController alloc] init];
        shoumin.productDescription = [_dataInfoArray1[indexPath.row] productDescription];
        [self.navigationController pushViewController:shoumin animated:YES];
        
        
    }
     //点击进入评论页
    if (indexPath.section == 5) {
    
        PinLunViewController *pinglun = [[PinLunViewController alloc] init];
        pinglun.priductID = [_dataInfoArray1[indexPath.row] productCode];
    
        [self.navigationController pushViewController:pinglun animated:YES];
    
    }
    

}



#pragma mark - 广告页Collection代理集合
#pragma mark 返回组数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}
#pragma mark 返回collection 项数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
 
    return _dataADArray.count*200;
}

#pragma mark 填充Collection 的 cell
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

        ProductdDetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ProductdDetCollectionViewCell indentifr] forIndexPath:indexPath];
        cell.model = _dataADArray[indexPath.item % _dataADArray.count];
    return cell;
 
}
#pragma mark 设置item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(LFFScreenW, ((LFFScreenH-64)/3));
}

#pragma mark - pageController拖拽方法
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *visible = [[_collectionADView indexPathsForVisibleItems] firstObject];
    _pageControl.currentPage = visible.item%_dataADArray.count;
    
}
#pragma mark 滚动视图开始减速  添加定时器
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self addTimer];
    
}
-(void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}
-(void)nextTimer
{
    NSIndexPath *visiblePath = [[_collectionADView indexPathsForVisibleItems] firstObject];
    NSInteger visibleItem = visiblePath.item;
    
    //首先!如果存在才能滚动 !
    if (!visiblePath.item) return;
   
        //如果是第0张图
        if ((visiblePath.item % _dataADArray.count == 0)) {
            [_collectionADView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_dataADArray.count*100/2 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            visibleItem = _dataADArray.count*100/2;
        }
        NSInteger nextItem = visibleItem+1;
        [_collectionADView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark 滚动视图开始拖拽 删除定时器
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self removeTimer];
}
-(void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - 实现ProductDetailViewCellDelegate 代理
-(void)sendGuiGeBtn:(UIButton *)btn ProductCode:(NSString *)code
{
    
    LFFLog(@"code::::%@",code);
    
    _productCode  = code;
    _isRemoveAll = YES;
    [self removeTimer]; //停止定时器 等刷新好了 定时器会被调研再开!!!
    [self initNetWorkData];
}
#pragma mark - 分享收藏 代理
-(void)sendFenXiangBtn:(UIButton *)btn productEffect:(NSString *)productEffect
{

    NSString *strUrl = [NSString stringWithFormat:@"http://img.jianke.net%@",[_dataInfoArray1[0] head_img]];
    
    //设置新浪 // 人人
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"54dda2f6fd98c5ec680008aa" shareText:@"分享测试!!!" shareImage:LFFImage(strUrl) shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToSina,UMShareToQzone,UMShareToWechatSession,UMShareToTencent, nil] delegate:nil];

}

@end
