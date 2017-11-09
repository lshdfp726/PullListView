//
//  PullListView.h
//  PullListView
//
//  Created by fns on 2017/11/9.
//  Copyright © 2017年 lsh726. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullListModel.h"

typedef void(^SelectItemBlock) (PullListModel  *_Nullable model);

@interface PullListView : UIView
@property (nonatomic, strong, nullable) NSArray <PullListModel *>*dataSource; //数据源赋值
@property (nonatomic, copy  , nullable) SelectItemBlock selectAction;//选中某个cell 把model 传出去
@property (nonatomic, strong, readonly , nullable) UITableView *myTableView;
@property (nonatomic, assign) BOOL hiddenStatus;//view的高度为0 的时候为隐藏状态hiddenStatus = YES，否则为显示状态hiddenStatus = NO
@property (nonatomic, copy  , nullable) void(^GestureAction)(void);//点击非tableView 区域收起视图，做一些别的是(如图标箭头旋转之类的)
@property (nonatomic, assign) NSTimeInterval animationTime;//view展示动画时间
/**
 color 为cell字体颜色
 height 为cell高度
 */

- (_Nonnull instancetype)initWithFrame:(CGRect)frame textColor:(UIColor *_Nullable)color height:(CGFloat)height;
- (_Nonnull instancetype)init;


//刷新数据
- (void)reloadData;

//显示View
- (void)showView;

//隐藏View
- (void)hiddenView;
@end
