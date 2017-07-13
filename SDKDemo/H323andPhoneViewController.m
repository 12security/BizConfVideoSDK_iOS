//
//  H323andPhoneViewController.m
//  SDKDemo
//
//  Created by bizconf on 17/6/12.
//  Copyright © 2017年 bizconf. All rights reserved.
//

#import "H323andPhoneViewController.h"
#import <BizConfSDK/BizConfSDK.h>
#import "MBProgressHUD.h"
#import "JoinViewController.h"


@interface H323andPhoneViewController ()<BizConfSDKDelegate>
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberText;
@property (strong, nonatomic) IBOutlet UITextField *nametext;
@property (strong, nonatomic)UIBarButtonItem *closeItem;

@end

@implementation H323andPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onDone:)];
    self.closeItem.enabled = YES;
    [self.navigationItem setLeftBarButtonItem:self.closeItem];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)onClickdialOutBtn:(id)sender {
    BizConfVideoSDK *biz = [BizConfVideoSDK sharedSDK];
    
    if (biz) {
        biz.edelegate = self;
        self.closeItem.enabled = NO;
        NSLog(@"%@%@",self.phoneNumberText.text,self.nametext.text);
        if (![self.phoneNumberText.text isEqualToString:@""] && ![self.nametext.text isEqualToString:@""]) {
            [biz dialOut:self.phoneNumberText.text withName:self.nametext.text];
            
        }else{
        
            self.closeItem.enabled = YES;
            MBProgressHUD *hub = [[MBProgressHUD alloc] init];
            hub.labelText = @"姓名或者电话号不能为空";
            
            [self.view addSubview:hub];
            [hub show:YES];
            [hub hide:YES afterDelay:2.0];
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onBizDialOutStatusChanged:(BizDialOutStatus)status{
    
    MBProgressHUD* hub = [[MBProgressHUD alloc] init];
    [self.view addSubview:hub];
    NSString *errorStr = @"未知错误";
    switch (status) {
        case BizDialOutStatus_Calling:
            errorStr = @"呼叫中。。。";
            break;
        case BizDialOutStatus_Ringing:
            errorStr = @"响铃中。。。";
            break;
        case BizDialOutStatus_Accepted:
            errorStr = @"已接听";
            break;
        case BizDialOutStatus_Busy:
            errorStr = @"忙";
            self.closeItem.enabled = YES;
            break;
        case BizDialOutStatus_NotAvailable:
            errorStr = @"不可用";
            self.closeItem.enabled = YES;
            break;
        case BizDialOutStatus_UserHangUp:
            errorStr = @"用户挂断";
            self.closeItem.enabled = YES;
            break;
        case BizDialOutStatus_JoinSuccess:
            errorStr = @"加入成功";
            break;
        case BizDialOutStatus_TimeOut:
            errorStr = @"呼叫超时";
            self.closeItem.enabled = YES;
            break;
        case BizDialOutStatus_BlockNoHost:
            errorStr = @"主持人未入会";
            self.closeItem.enabled = YES;
            break;
        case BizDialOutStatus_NoAnswer:
            errorStr = @"无人接听";
            self.closeItem.enabled = YES;
            break;
        default:
            break;
    }
    hub.labelText = [NSString stringWithFormat:@"DialOutStatus:%@",errorStr];
    [hub show:YES];
    [hub hide:YES afterDelay:2.0];
    if (status == BizDialOutStatus_JoinSuccess) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (void)onDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)dealloc{

//    [BizConfVideoSDK sharedSDK].delegate = nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.phoneNumberText resignFirstResponder];
    [self.nametext resignFirstResponder];
}
@end
