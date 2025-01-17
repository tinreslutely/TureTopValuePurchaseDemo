//
//  MultilevelMenu.h
//  MultilevelMenu
//
//  Created by gitBurning on 15/3/13.
//  Copyright (c) 2015年 BR. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLeftWidth 100


@interface rightMeun : NSObject

/**
 *  菜单图片名
 */
@property(copy,nonatomic) NSString * urlName;
/**
 *  菜单名
 */
@property(copy,nonatomic) NSString * meunName;
/**
 *  菜单ID
 */
@property(copy,nonatomic) NSString * ID;

/**
 *  下一级菜单
 */
@property(strong,nonatomic) NSArray * nextArray;

/**
 *  菜单层数
 */
@property(assign,nonatomic) NSInteger meunNumber;

@property(assign,nonatomic) float offsetScorller;



@end

@protocol MultilvevlMenuDelegate <NSObject>

@required
//tableview选择后触发
-(void)multilvevlMenu:(id)menu tableSelectedWithTableView:(UITableView*)tableView collectionView:(UICollectionView*)collectionView selectIndex:(int)index;
//collectionview选择后触发
-(void)multilvevlMenu:(id)menu collectionSelectedWithCollectionView:(UICollectionView*)collectionView rightMeun:(rightMeun*)rightMeun;
//设置右边的数据源
-(NSArray*)multilvevlMenu:(id)menu dataSourceWithRightCollection:(UICollectionView*)rightCollection;

@optional

@end

@interface MultilevelMenu : UIView<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

//@property(strong,nonatomic,readonly) NSArray * allData;

@property(strong,nonatomic) NSMutableArray * tableData;

@property(strong,nonatomic) NSMutableArray * collectionData;

@property(assign,nonatomic) BOOL isRefreshData;

//@property(copy,nonatomic,readonly) id block;

/**
 *  是否 记录滑动位置
 */
@property(assign,nonatomic) BOOL isRecordLastScroll;
/**
 *   记录滑动位置 是否需要 动画
 */
@property(assign,nonatomic) BOOL isRecordLastScrollAnimated;

@property(assign,nonatomic,readonly) NSInteger selectIndex;

/**
 *  为了 不修改原来的，因此增加了一个属性，选中指定 行数
 */
@property(assign,nonatomic) NSInteger needToScorllerIndex;
/**
 *  颜色属性配置
 */

/**
 *  左边背景颜色
 */
@property(strong,nonatomic) UIColor * leftBgColor;
/**
 *  左边点中文字颜色
 */
@property(strong,nonatomic) UIColor * leftSelectColor;
/**
 *  左边点中背景颜色
 */
@property(strong,nonatomic) UIColor * leftSelectBgColor;

/**
 *  左边未点中文字颜色
 */

@property(strong,nonatomic) UIColor * leftUnSelectColor;
/**
 *  左边未点中背景颜色
 */
@property(strong,nonatomic) UIColor * leftUnSelectBgColor;
/**
 *  tablew 的分割线
 */
@property(strong,nonatomic) UIColor * leftSeparatorColor;

@property(assign,nonatomic) id<MultilvevlMenuDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame tableData:(NSArray *)tableData collectionData:(NSArray*)collectionData;
-(void)reloadData;
@end


