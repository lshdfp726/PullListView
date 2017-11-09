//
//  PullListView.m
//  PullListView
//
//  Created by fns on 2017/11/9.
//  Copyright © 2017年 lsh726. All rights reserved.
//

#import "PullListView.h"

/**typeof()  识别()里面变量的类型 */

#define CELLID NSStringFromClass([self class])

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self

#define MAINSCREENFRAME [UIScreen mainScreen].bounds

@interface PullListView ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate> {
    UIColor *_textColor;//cell字体颜色
    CGFloat _cellHeight;//cell高度
}
@property (nonatomic, strong, nullable) UITableView *myTableView;
@end

@implementation PullListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    return [self initWithFrame:CGRectMake(MAINSCREENFRAME.origin.x,MAINSCREENFRAME.origin.y, MAINSCREENFRAME.size.width, 0.0)];
}


- (_Nonnull instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame textColor:nil height:50.0];
}


- (_Nonnull instancetype)initWithFrame:(CGRect)frame textColor:(UIColor *)color height:(CGFloat)height {
    self = [super initWithFrame:frame];
    if (self) {
        _cellHeight = height;
        _textColor = color;
        self.hiddenStatus = YES;
        [self config];
        [self setUpView];
    }
    return self;
}


- (void)config {
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    UITapGestureRecognizer *reg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestTap:)];
    reg.delegate = self;
    reg.cancelsTouchesInView = NO;//让响应链响应
    [self addGestureRecognizer:reg];
    
    _animationTime = 0.25;
}


- (void)gestTap:(UITapGestureRecognizer *)reg {
    CGPoint clickPoint = [reg locationInView:reg.view];
    BOOL contain = CGRectContainsPoint(self.myTableView.frame, clickPoint);
    if (!contain) {
        if (self.GestureAction) {
            [self hiddenView];//隐藏视图
            self.GestureAction();
        }
    }
}


#pragma mark - 手势代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    CGPoint clickPoint = [gestureRecognizer locationInView:gestureRecognizer.view];
    //    NSLog(@"进入手势");
    BOOL contain = CGRectContainsPoint(self.myTableView.frame, clickPoint);
    if (contain) {//返回 YES,父类和子类同时响应手势，解决了点击cell立刻放开，cell不能响应的问题
        return YES;
    }
    return NO;//父类和子类不同时响应手势，
}


#pragma mark - 设置View
- (void)setUpView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, 0.0, self.frame.size.width==0?MAINSCREENFRAME.size.width: self.frame.size.width, 0.0) style:UITableViewStylePlain];
    [self addSubview:tableView];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELLID];
    tableView.estimatedRowHeight = 0.0;
    tableView.estimatedSectionFooterHeight = 0.0;
    tableView.estimatedSectionHeaderHeight = 0.0;
    self.myTableView = tableView;
}


#pragma mark - tableViewDataSoruce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.textLabel.text = [self.dataSource[indexPath.row] name];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor = _textColor;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundView = tableView.backgroundView;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    if (self.selectAction) {
        weakSelf.selectAction(weakSelf.dataSource[indexPath.row]);
        [self hiddenView];
    }
}


#pragma mark - 刷新数据
- (void)reloadData {
    [self.myTableView reloadData];
}


- (void)setDataSource:(NSArray<PullListModel *> *)dataSource {
    _dataSource = dataSource;
    if (_dataSource.count == 1) {
        _cellHeight = 85.0;
    }
}


//隐藏View
- (void)hiddenView {
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0.0)];
    [UIView animateWithDuration:_animationTime animations:^{
        [self.myTableView setFrame:CGRectMake(self.frame.origin.x, 0.0, self.frame.size.width, 0.0)];
    }];
    self.hiddenStatus = YES;
}


//显示
- (void)showView {
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, MAINSCREENFRAME.size.height)];
    //高度随着数据变化，大于4条数据只显示4条
    [UIView animateWithDuration:_animationTime animations:^{
        [self.myTableView setFrame:CGRectMake(self.frame.origin.x, 0.0, self.frame.size.width, _dataSource.count > 4?_cellHeight * 4:_cellHeight * _dataSource.count)];
    }];
    self.hiddenStatus = NO;
}
@end
