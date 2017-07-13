//
//  AuthViewController.m
//  SDKDemo
//
//  Created by bizconf on 17/3/16.
//  Copyright © 2017年 bizconf. All rights reserved.
//

#import "AuthViewController.h"
#import "MBProgressHUD.h"
#import <BizConfSDK/BizConfSDK.h>

@interface AuthViewController ()
@property (strong, nonatomic) IBOutlet UITextField *channelIDtextField;
@property (strong, nonatomic) IBOutlet UITextField *keytextField;

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证";
}

- (IBAction)onClickAuthBtn:(id)sender {
    [self.channelIDtextField resignFirstResponder];
    [self.keytextField resignFirstResponder];
    
    if ([self.channelIDtextField.text isEqualToString:@""] || [self.keytextField.text isEqualToString:@""]) {
        MBProgressHUD* hub = [[MBProgressHUD alloc] init];
        [self.view addSubview:hub];
        hub.labelText =@"channelID和key不能为空";
        [hub show:YES];
        [hub hide:YES afterDelay:1.0];
    }else{
        
        [[BizConfVideoSDK sharedSDK]authSdk:self.channelIDtextField.text withKey:self.keytextField.text withTarget:self resultWithDetail:^(BizSDKAuthError authErrorCode, NSURLResponse *response, NSError *error)  {
            //通过auth判断验证结果
            if (authErrorCode == BizSDKAuthError_Success) {
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    MBProgressHUD* hub = [[MBProgressHUD alloc] init];
                    [self.view addSubview:hub];
                    hub.labelText =@"验证失败。。。";
                    [hub show:YES];
                    [hub hide:YES afterDelay:1.0];
                });
            }
        }];
    }    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.channelIDtextField resignFirstResponder];
    [self.keytextField resignFirstResponder];

}


@end
