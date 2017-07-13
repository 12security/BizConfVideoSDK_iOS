//
//  BizTabBarViewController.m
//  SDKDemo
//
//  Created by bizconf on 16/9/26.
//  Copyright © 2016年 bizconf. All rights reserved.
//

#import "BizTabBarViewController.h"
#import "BizViewController.h"
#import "BizNavController.h"

@interface BizTabBarViewController ()

@end

@implementation BizTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BizViewController *bizView = [[BizViewController alloc] init];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor orangeColor];
    BizNavController *bizNa = [[BizNavController alloc] initWithRootViewController:bizView];
    bizNa.navigationBarHidden = YES;
    BizNavController *VcNa = [[BizNavController alloc] initWithRootViewController:vc];
    
    bizNa.title = @"首页";
    VcNa.title = @"我的";
    NSArray *viewController = [NSArray arrayWithObjects:bizNa,VcNa,nil];
    self.viewControllers = viewController;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
