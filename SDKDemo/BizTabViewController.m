//
//  BizTabViewController.m
//  SDKDemo
//
//  Created by 王佳 on 2017/3/17.
//  Copyright © 2017年 bizconf. All rights reserved.
//

#import "BizTabViewController.h"
#import <BizConfSDK/BizConfSDK.h>
#import "AuthViewController.h"
#import "BizViewController.h"
#import "JoinViewController.h"
#import "SettingsViewController.h"

@interface BizTabViewController ()

@end

@implementation BizTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BizViewController *bizView = [[BizViewController alloc] init];
    bizView.title = NSLocalizedString(@"start", nil);
    
    JoinViewController *joinView = [[JoinViewController alloc] init];
    joinView.title = NSLocalizedString(@"join", nil);
    
    SettingsViewController *settingVC = [[SettingsViewController alloc] init];
    settingVC.title = NSLocalizedString(@"Setting", nil);
    
    NSArray *arrayVC = @[bizView, joinView,settingVC];
    NSMutableArray *navArray = [[NSMutableArray alloc] init];
    for (UIViewController *VC in arrayVC) {
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
        [navArray addObject:nav];
    }
//    self.tabBarController = [[BizTabViewController alloc] init];
    self.viewControllers = navArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     if (![[BizConfVideoSDK sharedSDK] isAuthorized]) {
         AuthViewController *authVC = [[AuthViewController alloc] init];
         UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:authVC];
         nav.modalPresentationStyle = UIModalPresentationFormSheet;
         
         [self presentViewController:nav animated:YES completion:NULL];

     }
}

@end
