//
//  H323ViewController.m
//  SDKDemo
//
//  Created by bizconf on 17/6/12.
//  Copyright © 2017年 bizconf. All rights reserved.
//

#import "H323ViewController.h"
#import <BizConfSDK/BizConfSDK.h>
#import "MBProgressHUD.h"

@interface H323ViewController ()<BizConfSDKDelegate>
@property (strong, nonatomic) IBOutlet UILabel *ipLable;
@property (strong, nonatomic) IBOutlet UILabel *meetingNumLable;
@property (strong, nonatomic) IBOutlet UILabel *pwdLable;
@property (strong, nonatomic) IBOutlet UITextField *pairingCodeText;
@property (strong, nonatomic) IBOutlet UITextField *calloutIPtext;

@end

@implementation H323ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onDone:)];
    [self.navigationItem setLeftBarButtonItem:closeItem];
    
    BizConfVideoSDK *biz = [BizConfVideoSDK sharedSDK];
    NSArray *ipArr = [biz getIPAddressList];
    NSLog(@"-------------%@",ipArr[0]);
    self.ipLable.text = ipArr[0];
    if ([biz getH323MeetingPassword]) {
        self.pwdLable.text = [biz getH323MeetingPassword];
    }else{
    
        self.pwdLable.text = @"密码为空";
    }
    self.meetingNumLable.text = biz.meetingID;
    
}
- (IBAction)onClickInviteBtn:(id)sender {
    BizConfVideoSDK *biz = [BizConfVideoSDK sharedSDK];
    if (biz) {
        
        biz.edelegate = self;
        [biz sendPairingCode:self.pairingCodeText.text];
    }
}
- (IBAction)onClickCallout:(id)sender {
    BizConfVideoRoomDevice *roomDevice = [[BizConfVideoRoomDevice alloc] init];
    roomDevice.deviceName = @"";
    roomDevice.ipAddress = self.calloutIPtext.text;
    roomDevice.deviceType = DeviceType_H323;
    roomDevice.encryptType = DeviceEncryptType_None;
    BizConfVideoSDK *biz = [BizConfVideoSDK sharedSDK];
    if (biz) {
        
        biz.edelegate = self;
        [biz callRoomDevice:roomDevice];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)onBizCallRoomDeviceStateChanged:(BizH323CallOutStatus)state{
    
    MBProgressHUD* hub = [[MBProgressHUD alloc] init];
    [self.view addSubview:hub];
    NSString *callOutState = @"";
    switch (state) {
        case BizH323CallOutStatus_OK:
            callOutState = @"外呼成功";
            break;
        case BizH323CallOutStatus_Calling:
            callOutState = @"正在外呼。。。";
            break;
        case BizH323CallOutStatus_Busy:
            callOutState = @"忙。。。";
            break;
        default:
            callOutState = @"外呼失败";
            break;
    }
    hub.labelText = callOutState;
    [hub show:YES];
    [hub hide:YES afterDelay:2.0];
    if (state == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (void)onBizSendPairingCodeStateChanged:(NSUInteger)state{
    
    MBProgressHUD* hub = [[MBProgressHUD alloc] init];
    [self.view addSubview:hub];
    hub.labelText = [NSString stringWithFormat:@"PairingCodeState:%lu",(unsigned long)state];
    [hub show:YES];
    [hub hide:YES afterDelay:2.0];
    
    if (state == 0) {
        [self dismissViewControllerAnimated:YES completion:^{
            
//            [BizConfVideoSDK sharedSDK].delegate = nil;
        }];
    }
}
- (void)onDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
