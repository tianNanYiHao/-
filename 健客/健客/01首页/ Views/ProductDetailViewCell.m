//
//  ProductDetailViewCell.m
//  健客
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ProductDetailViewCell.h"
#import "ProductDetailModel.h"
#import "AboutProductViewCell.h"
#import "AboutProductModel.h"
#import "DBManger.h"

@interface ProductDetailViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UILabel *_titleNameLab;
    UIImageView *_ziyinView;
    
    UILabel *_infoLab;
    UILabel *_ourPriceLab;
    UILabel *_markPricLab;
    UILabel *_packingLab;
    
    UIButton *_guigeLab1;

    
    UIButton *_massBtn;
    UIButton *_addBtn;
    UILabel  *_intLab;
    int _intStr;
    
    UIButton *_lastHeightBtn; //高亮按钮保存
    NSString *_currentStr; //当前的文字
    NSString *_currentCode; //当前的Code (id)
    
    UICollectionView *_collection;
    NSMutableArray *_dataArray;
    
    ProductDetailModel *_guiGeModel;
    
    
    UIButton *_shouCangBtn;
    UIButton *_fenXiangBtn;
    

    

    
    
  
}
@end

@implementation ProductDetailViewCell


+(instancetype)cellWithTableView:(UITableView *)tableview withIndexPath:(NSIndexPath *)Indexpath
{
   static NSString *ID = @"id";
    ProductDetailViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ProductDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
       }
    return cell;
}

-(void)setModel:(ProductDetailModel *)model withIndexPath:(NSIndexPath *)Indexpath
{
    //删除 防止重复加载 复用
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
      _model = model;
    
    [self addSubviewswithIndexPath:Indexpath];
    

    //1
    if (Indexpath.section == 0) {
        if (Indexpath.row == 0) {
            _titleNameLab.text = model.productName;
            
            //计算标题文本的文字宽度

            CGFloat titleNameLabW = [self labelAutoCalculateRectWith:model.productName Font:LFFFont(14) MaxSize:CGSizeMake(CGFLOAT_MAX, 20)].width;
            //重置宽度
            _titleNameLab.width = titleNameLabW;
            //重置自营图片 位置
            _ziyinView.x = _titleNameLab.width+20;

        }
        if (Indexpath.row == 1) {
            CGFloat infoLabHeight = [model.productEffect boundingRectWithSize:CGSizeMake(LFFScreenW-10, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:LFFFont(12)} context:nil].size.height;
            
            _infoLab.height = infoLabHeight;
            _infoLab.text = model.productEffect;
            model.cellHeight2= infoLabHeight+20;

        }
    }
    //2
    if (Indexpath.section == 1) {
        if (Indexpath.row == 0) {
            _ourPriceLab.text = [NSString stringWithFormat:@"￥%.2f",[model.ourPrice floatValue]/100];
            _markPricLab.text = [NSString stringWithFormat:@"市场价:￥%.2f",[model.marketPrice floatValue]/100];
        }
        if (Indexpath.row == 2) {
            
            //判断 存在packings
            if (_model.packings.count) {
                _currentStr = _model.packings[0][@"packing"];   //初始化当前名字 和 code
                _currentCode = _model.packings[0][@"productCode"];
                
            }
        }
    }
    //7
    if (Indexpath.section == 6) {
        if (Indexpath.row == 0) {
            
            _dataArray  = [NSMutableArray arrayWithCapacity:0];
            NSArray *arr = _model.relatedRecommend;
            
            for (NSDictionary *dict in arr) {
                AboutProductModel *model = [[AboutProductModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [_dataArray addObject:model];
            }
            [_collection reloadData];
            
        }
    }
}

-(void)addSubviewswithIndexPath:(NSIndexPath *)Indexpath
{

    //1
    if (Indexpath.section == 0) {
        if (Indexpath.row == 0) {
            _titleNameLab = [LFFView createLabWithFrame:CGRectMake(10, 10, LFFScreenW*2/3.0, 20) color:[UIColor blackColor] font:LFFFont(14) text:nil];
            [self.contentView addSubview:_titleNameLab];
            _ziyinView = [LFFView createLineImageViewWithFrame:CGRectMake(LFFScreenW/3, 13, 55/2, 25/2) imageName:@"self_sale_icon@2x"];
            [self.contentView addSubview:_ziyinView];
            

       
            //收藏
            _shouCangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _shouCangBtn.frame = CGRectMake(_titleNameLab.maxX, 10, 15, 15);
            [_shouCangBtn setBackgroundImage:LFFImage(@"collectionIcon@2x") forState:UIControlStateNormal];
            [_shouCangBtn setBackgroundImage:LFFImage(@"collectionSel@2x") forState:UIControlStateSelected];
            [self.contentView addSubview:_shouCangBtn];
            [_shouCangBtn addTarget:self action:@selector(shoucangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            //判断 查询
            BOOL isSuccess = [[DBManger sharManger] selectOneDatawithproductCode:_model.productCode];
            _shouCangBtn.selected = isSuccess?YES:NO;

            UILabel *label = [LFFView createLabWithFrame:CGRectMake(_shouCangBtn.x-3, _shouCangBtn.maxY, 30, 30) color:[UIColor blackColor] font:LFFFont(11) text:@"收藏"];
            [self.contentView addSubview:label];
            
            //分享
            UIImageView *fenxiangView = [LFFView createLineImageViewWithFrame:CGRectMake(_shouCangBtn.maxX+30, 10, 15, 15) imageName:@"share@2x"];
            [self.contentView addSubview:fenxiangView];
            UILabel *label2 = [LFFView createLabWithFrame:CGRectMake(fenxiangView.x-3, fenxiangView.maxY, 30, 30) color:[UIColor blackColor] font:LFFFont(11) text:@"分享"];
            [self.contentView addSubview:label2];
            _fenXiangBtn = [LFFView createBtnWithFrame:CGRectMake(fenxiangView.x, fenxiangView.y, fenxiangView.width, label2.maxY) imageName:nil text:nil target:self sel:@selector(fenxiangBtnClick:) textFont:nil textColor:nil];
            [self.contentView addSubview:_fenXiangBtn];
        }
        
        if (Indexpath.row == 1) {
            
            _infoLab = [LFFView createLabWithFrame:CGRectMake(10, 10, LFFScreenW-20, 100) color:[UIColor blackColor] font:LFFFont(12) text:nil];
            [self.contentView addSubview:_infoLab];
            _infoLab.numberOfLines = 0;
        }
    }
    //2
    if (Indexpath.section ==  1) {
        if (Indexpath.row == 0) {
            
            UIImageView *cuxiaoView = [LFFView createLineImageViewWithFrame:CGRectMake(10, 10, 16, 16) imageName:@"cuxiao@2x"];
            [self.contentView addSubview:cuxiaoView];
            _ourPriceLab = [LFFView createLabWithFrame:CGRectMake(cuxiaoView.maxX+10, 10, LFFScreenW/5, 20) color:[UIColor redColor] font:LFFFont(15) text:nil];
            [self.contentView addSubview:_ourPriceLab];
            _markPricLab = [LFFView createLabWithFrame:CGRectMake(_ourPriceLab.maxX+10, 10, LFFScreenW-_ourPriceLab.maxX, 18) color:[UIColor lightGrayColor] font:LFFFont(12) text:nil];
            [self.contentView addSubview:_markPricLab];
        }if (Indexpath.row == 1) {
            UILabel *kucunLab = [LFFView createLabWithFrame:CGRectMake(10, 10, 50, 20) color:[UIColor blackColor] font:LFFFont(12) text:@"库存:"];
            [self.contentView addSubview:kucunLab];
            UILabel *youhuoLab = [LFFView createLabWithFrame:CGRectMake(kucunLab.maxX, 10, 100, 20) color:[UIColor blackColor] font:LFFFont(12) text:@"【有货】"];
            [self.contentView addSubview:youhuoLab];
            
        }if (Indexpath.row == 2) {
            UILabel *guigeLab = [LFFView createLabWithFrame:CGRectMake(10, 10, 50, 20) color:[UIColor blackColor] font:LFFFont(12) text:@"规格:"];
            [self.contentView addSubview:guigeLab];
            
            
            /********///根据数组创建lab⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️⬇️
            CGRect lastBtnFrame = CGRectMake(guigeLab.maxX-10, guigeLab.y, 0, 0);
      
            //1.如果:由于数据问题 判断 如果packings为空! 就传正常的model.packing为值!!
           if (_model.packings.count == 0) {
           //计算每个lab的宽度
              CGFloat guigeLabW = [self labelAutoCalculateRectWith:_model.packing Font:LFFFont(10) MaxSize:CGSizeMake(CGFLOAT_MAX, 20)].width;
            
              _guigeLab1 = [LFFView createBtnWithFrame:CGRectMake(guigeLab.maxX+5, guigeLab.y,guigeLabW , 20) imageName:nil text:_model.packing target:self sel:nil textFont:LFFFont(10) textColor:[UIColor redColor]];
               _guigeLab1.width = guigeLabW+10;
               
               //返回cell的高度
               _model.cellSection1Row2height = _guigeLab1.maxY+10;

              [self.contentView addSubview:_guigeLab1];
               
               [_guigeLab1 setTitle:_model.packing forState:UIControlStateNormal];
               [_guigeLab1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
               _guigeLab1.layer.borderColor = [UIColor redColor].CGColor;
               _guigeLab1.layer.borderWidth = 0.8;
               _guigeLab1.layer.cornerRadius = 2;
            }
            
 
            //2.如果 packings数组字典 不为空!! 就传字典里的内容!! 动态计算按钮的 数量 位置!!
            
            for (int i = 0; i<_model.packings.count; i++) {
                //取出每个lab的文字
                NSDictionary *dict = _model.packings[i];
                _model.packing = dict[@"packing"];
                

                  //计算每个lab的宽度
                CGFloat guigeLabW = [self labelAutoCalculateRectWith:dict[@"packing"] Font:LFFFont(10) MaxSize:CGSizeMake(CGFLOAT_MAX, 20)].width;
                _guigeLab1 =[[UIButton alloc] init];
                _guigeLab1.titleLabel.font = LFFFont(10); //别忘记设置按钮的字体 额外设置
                
                 [self.contentView addSubview:_guigeLab1];
                
                if (5+CGRectGetMaxX(lastBtnFrame)+guigeLabW+10<=self.frame.size.width-guigeLab.width-10) {
                    _guigeLab1.frame = CGRectMake(10+CGRectGetMaxX(lastBtnFrame), lastBtnFrame.origin.y, guigeLabW+10, 20);
                    //重置section1 row2 下的cell高度
                }
                
                else
                {
                    _guigeLab1.frame =CGRectMake(guigeLab.maxX,CGRectGetMaxY(lastBtnFrame)+8,guigeLabW+10,20);
                }
                
                //重置section1 row2 下的cell高度
                _model.cellSection1Row2height = _guigeLab1.maxY+10;
                
                [_guigeLab1 setTitle:_model.packing forState:UIControlStateNormal];
                [_guigeLab1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                _guigeLab1.layer.borderColor = [UIColor lightGrayColor].CGColor;
                _guigeLab1.layer.borderWidth = 0.8;
                _guigeLab1.layer.cornerRadius = 2;
                _guigeLab1.tag = [dict[@"productCode"] floatValue];
  
                //在循环最后 都要将最新的colorBtn.fram赋值给lastBtnFram 以保证每次x左边改变都能判断
                lastBtnFrame = _guigeLab1.frame;
                if ([_currentStr isEqualToString:_model.packing]) {
                    
                    _guigeLab1.layer.borderColor = [UIColor redColor].CGColor;
                    _lastHeightBtn = _guigeLab1;
                }else
                {
                    _guigeLab1.layer.borderColor = [UIColor lightGrayColor].CGColor;
                  
                }
                
                [_guigeLab1 addTarget:self action:@selector(changeLayerColor:) forControlEvents:UIControlEventTouchUpInside];
             }
            
            /********///over⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️
            
        }if (Indexpath.row == 3) {
            UILabel *buylab = [LFFView createLabWithFrame:CGRectMake(10, 10, 50, 20) color:[UIColor blackColor] font:LFFFont(12) text:@"我要买:"];
            [self.contentView addSubview:buylab];
            
            _massBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _massBtn.frame = CGRectMake(buylab.maxX, 10, 25, 25);
            [_massBtn setBackgroundImage:LFFImage(@"sub_normal@2x") forState:UIControlStateNormal];
            [_massBtn setBackgroundImage:LFFImage(@"sub_highlighted@2x") forState:UIControlStateHighlighted];
            [_massBtn addTarget:self action:@selector(massBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_massBtn];
            
            _intStr = 1;
            _intLab = [LFFView createLabWithFrame:CGRectMake(_massBtn.maxX, 10, 50, 25) color:[UIColor blackColor] font:LFFFont(15) text:[NSString stringWithFormat:@"%d",_intStr]];
            _intLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
            _intLab.layer.borderWidth = 0.8;
            _intLab.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:_intLab];
            
            _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _addBtn.frame = CGRectMake(_intLab.maxX, 10, 25, 25);
            [_addBtn setBackgroundImage:LFFImage(@"add_normal@2x") forState:UIControlStateNormal];
            [_addBtn setBackgroundImage:LFFImage(@"add_highlighted@2x") forState:UIControlStateHighlighted];
            [_addBtn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_addBtn];
        }
    }
    //3
    if (Indexpath.section == 2 ) {
        if (Indexpath.row == 0) {
            UIImageView *naozhongV = [LFFView createLineImageViewWithFrame:CGRectMake(30, 10, 15, 13) imageName:@"notice@2x"];
            [self.contentView addSubview:naozhongV];
            
            UIButton * addMdeicBtn = [LFFView createBtnWithFrame:CGRectMake(naozhongV.maxX, 5, 100, 20) imageName:nil text:@"添加用药提醒" target:self sel:nil textFont:LFFFont(12) textColor:[UIColor blackColor]];
            [self.contentView addSubview:addMdeicBtn];
            
            UIImageView *zixunV = [LFFView createLineImageViewWithFrame:CGRectMake(addMdeicBtn.maxX+30 , 10, 15, 13) imageName:@"comment@2x"];
            [self.contentView addSubview:zixunV];
            
            UIButton * zixunBtn = [LFFView createBtnWithFrame:CGRectMake(zixunV.maxX-10, 5, 100, 20) imageName:nil text:@"用药咨询" target:self sel:nil textFont:LFFFont(12) textColor:[UIColor blackColor]];
            [self.contentView addSubview:zixunBtn];
            
        }
    }
    //4
    if (Indexpath.section == 3) {
        if (Indexpath.row == 0) {
            UIImageView *phonev = [LFFView createLineImageViewWithFrame:CGRectMake(50 , (25-11)/2, 11, 11) imageName:@"call_icon@2x"];
            [self.contentView addSubview:phonev];
             UIButton * phoneBtn = [LFFView createBtnWithFrame:CGRectMake(0, (25-11)/2, LFFScreenW, 20) imageName:nil text:@"药师咨询热线:400-666-800" target:self sel:nil textFont:LFFFont(10) textColor:[[UIColor alloc] initWithRed:0/255.0 green:130/255.0 blue:240/255.0 alpha:1.0]];
            phoneBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            phoneBtn.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:phoneBtn];
          
//            [self setFrame:CGRectMake(20, 0, LFFScreenW*2/3, 25)];
//            self.contentView.layer.cornerRadius = 2;
//            self.contentView.layer.masksToBounds = YES;
    
            

        }
    }
    //5
    if (Indexpath.section == 4) {
        if (Indexpath.row == 0) {
            UIImageView *shuomingV = [LFFView createLineImageViewWithFrame:CGRectMake((44-14)/2 , (44-14)/2, 14, 14) imageName:@"productIntroduction@2x"];
            [self.contentView addSubview:shuomingV];
            UILabel *shoumingLab = [LFFView createLabWithFrame:CGRectMake(shuomingV.maxX+10, 10, LFFScreenW/2, 20) color:[UIColor blackColor] font:LFFFont(15) text:@"产品说明书"];
            [self.contentView addSubview:shoumingLab];
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, 20)];
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
            
        }
    }
    //6
    if (Indexpath.section == 5) {
        if (Indexpath.row == 0) {
            UIImageView *pinglun = [LFFView createLineImageViewWithFrame:CGRectMake((44-14)/2  , (44-14)/2 , 14, 14) imageName:@"userComment@2x"];
            [self.contentView addSubview:pinglun];
            UILabel *pinglunLab = [LFFView createLabWithFrame:CGRectMake(pinglun.maxX+10, 10 , LFFScreenW/2, 20) color:[UIColor blackColor] font:LFFFont(15) text:[NSString stringWithFormat:@"用户评论(%@)",_model.userEvaluateNum]];
            [self.contentView addSubview:pinglunLab];
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, LFFScreenW, 20)];
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
            
        }
    }
    //7
    if (Indexpath.section == 6) {
        if (Indexpath.row == 0) {
            
            //icon
            UIImageView *icon = [LFFView createLineImageViewWithFrame:CGRectMake((44-14)/2 , (44-14)/2 , 14, 14) imageName:@"item@2x"];
            [self.contentView addSubview:icon];
            UILabel *iconLab = [LFFView createLabWithFrame:CGRectMake(icon.maxY+10, 10, LFFScreenW/2, 20) color:[UIColor blackColor] font:LFFFont(15) text:@"相关推荐"];
            [self.contentView addSubview:iconLab];
            
            //
            
            UICollectionViewFlowLayout *lay = [[UICollectionViewFlowLayout alloc] init];
            lay.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            lay.minimumInteritemSpacing = 0;
            lay.minimumLineSpacing = 0;
            
            _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, iconLab.maxY, LFFScreenW, 220) collectionViewLayout:lay];
            _collection.delegate = self;
            _collection.dataSource = self;
            _collection.pagingEnabled = YES;
            
            _collection.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:_collection];

            [_collection registerClass:[AboutProductViewCell class] forCellWithReuseIdentifier:[AboutProductViewCell identif]];
    
        }
    }
}
#pragma mark - collection代理
#pragma mark 组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _model.relatedRecommend.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AboutProductViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AboutProductViewCell identif] forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.item];
    
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(LFFScreenW/3,200);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {


    // Configure the view for the selected state
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}


#pragma mark - 按钮点击方法
-(void)changeLayerColor:(UIButton*)btn
{
    if (_lastHeightBtn != btn) {
        _lastHeightBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _lastHeightBtn = btn;
        _lastHeightBtn.layer.borderColor = [UIColor redColor].CGColor;
        
        if ([_delegate respondsToSelector:@selector(sendGuiGeBtn:ProductCode:)]) {
            [_delegate sendGuiGeBtn:nil ProductCode:[NSString stringWithFormat:@"%ld",_lastHeightBtn.tag]];
        }
    }
    
}
-(void)massBtn:(UIButton*)btn
{
    if (_intStr>1) {
        _intStr --;
        _intLab.text = [NSString stringWithFormat:@"%d",_intStr];
    }
}

-(void)addBtn:(UIButton*)btn
{
    if (_intStr<99) {
        _intStr++;
        _intLab.text = [NSString stringWithFormat:@"%d",_intStr];
    }
}

#pragma mark - 收藏 按钮
-(void)shoucangBtnClick:(UIButton*)btn
{
    if (btn.selected == NO) {
        [[DBManger sharManger] insertDataWithProductDetailModel:_model];
        btn.selected = YES;
    }else
    {
        [[DBManger sharManger] deleteDataWithProductCode:_model.productCode];
        btn.selected = NO;
    }

   
}
#pragma mark - 分享 按钮
-(void)fenxiangBtnClick:(UIButton*)btn
{
    if ([_delegate respondsToSelector:@selector(sendFenXiangBtn:productEffect:)]) {
        [_delegate sendFenXiangBtn:btn productEffect:_model.productEffect];
    }
}

#pragma mark - 计算传递的文字的宽度
/**
 *  根据文字算出文字所占区域大小
 *
 *  @param text    文字内容
 *  @param font    字体
 *  @param maxSize 最大尺寸
 *
 *  @return 实际尺寸
 */
- (CGSize)labelAutoCalculateRectWith:(NSString*)text Font:(UIFont*)font MaxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary* attributes =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    labelSize.height=ceil(labelSize.height);
    labelSize.width=ceil(labelSize.width);
    return labelSize;
}
@end
