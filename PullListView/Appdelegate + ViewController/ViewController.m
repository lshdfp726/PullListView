//
//  ViewController.m
//  PullListView
//
//  Created by fns on 2017/11/9.
//  Copyright © 2017年 lsh726. All rights reserved.
//

#import "ViewController.h"
#import "PullViewVC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100.0,40)];
    btn.center = self.view.center;
    [btn setTitle:@"进入PullListVC" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)jump {
    PullViewVC *vc = [[PullViewVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
