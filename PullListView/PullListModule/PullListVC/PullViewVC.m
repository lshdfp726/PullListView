//
//  PullViewVC.m
//  PullListView
//
//  Created by fns on 2017/11/9.
//  Copyright © 2017年 lsh726. All rights reserved.
//

#import "PullViewVC.h"
#import "PullListView.h"
#import "PullListModel.h"

@interface PullViewVC ()
@property (nonatomic, strong, nonnull) PullListView *mainView;
@property (nonatomic, strong, nonnull) UILabel *selectLabel;//被选中的label
@end

@implementation PullViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self congig];
    [self setUpView];
    [self requestData];
}


- (void)congig {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"下拉列表";
}


- (void)setUpView {
    UILabel *selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100 , 150.0, 40)];
    selectLabel.text = @"点击选择内容";
    selectLabel.textColor = [UIColor blackColor];
    [self.view addSubview:selectLabel];
    self.selectLabel = selectLabel;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100 , 150.0, 40)];
    [btn addTarget:self action:@selector(pullList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    PullListView *view = [[PullListView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame), self.view.frame.size.width, 0.0) textColor:[UIColor redColor] height:55.0];
    [self.view addSubview:view];
    self.mainView = view;
    
    view.selectAction = ^(PullListModel * _Nullable model) {
        //选择商户
        selectLabel.text = model.name;
    };
    
    
    view.GestureAction = ^{
        //点击非tableView 区域收起view的动作
    };
    
}


- (void)pullList:(id)sender {
    [self.mainView showView];
}


- (void)requestData {
    NSMutableArray *temp = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i ++) {
        PullListModel *model = [[PullListModel alloc] initWithName:[NSString stringWithFormat:@"第%ld个",i] extension:[NSString stringWithFormat:@"%ld",i]];
        [temp addObject:model];
    }
    self.mainView.dataSource = [NSArray arrayWithArray:temp];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    NSLog(@"释放了");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
