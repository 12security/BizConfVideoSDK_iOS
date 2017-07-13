//
//  BizViewController.m
//  Bizconfsdk
//
//  Created by bizconf on 16/8/11.
//  Copyright © 2016年 bizconf. All rights reserved.
//

#import "BizViewController.h"
#import <BizConfSDK/BizConfVideoSDK.h>
#import "BizNavController.h"
#import "MBProgressHUD.h"
#import "AuthViewController.h"
#import "ToShareViewController.h"
#import "H323andPhoneViewController.h"
#import "H323ViewController.h"

@interface BizViewController ()<BizConfVideoSDKDelegate>

@property (strong, nonatomic) BizNavController *nav;
@property (copy, nonatomic) NSString *libPath;
@property (strong, nonatomic) ToShareViewController * shareVC;
@end

@implementation BizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [BizConfVideoSDK sharedSDK].delegate = self;
    
    
    
}

- (IBAction)startButton:(id)sender {
    
    //在进入会议的时候需要提前让所有的输入框失去第一响应，隐藏键盘，否则在进入会议后键盘会挡住会议界面
    [self.userID resignFirstResponder];
    [self.meetingNum resignFirstResponder];
    [self.userName resignFirstResponder];
    [self.cuid resignFirstResponder];
    [self.userToken resignFirstResponder];
    if ([[BizConfVideoSDK sharedSDK] isAuthorized]) {
        BizConfVideoSDK *ms = [BizConfVideoSDK sharedSDK];
        if (ms) {
            ms.delegate = self;
            [ms startMeeting:self.userID.text
                    userName:self.userName.text
                   userToken:self.userToken.text
                   meetingNo:self.meetingNum.text
                        cuid:self.cuid.text
                    shareScreen:self.swAppShare.on
                      result:^(BizSDKMeetError result) {
                // result为启会的结果，用于判断会议的错误信息
                NSLog(@"会议错误信息%d",result);
                          if (result == SDKMeetError_Success) {
                              
                              if (self.swAppShare.on) {
                                  //启会的同时，显示要分享的页面。此时，在会中点击共享按钮后，会议视频界面就会隐藏。
                                  [self showShareVC];
                              }
                          }
            }];
            
        }
    }else{
    
        AuthViewController *authVC = [[AuthViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:authVC];
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [self presentViewController:nav animated:YES completion:NULL];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.userID resignFirstResponder];
    [self.meetingNum resignFirstResponder];
    [self.userName resignFirstResponder];
    [self.cuid resignFirstResponder];
    [self.userToken resignFirstResponder];

}
#pragma mark - BizConfVideoDelegate方法 会议结束的回调
-(void)onMeetingEnd{

    MBProgressHUD* hub = [[MBProgressHUD alloc] init];
    [self.view addSubview:hub];
    hub.labelText =@"会议结束";
    [hub show:YES];
    [hub hide:YES afterDelay:2.0];
    
   
    [self.shareVC dismissViewControllerAnimated:YES completion:^{
        self.shareVC = nil;
    }];
    
}
//- (void)onBizClickedShareButton{
//
//    if (self.swAppShare.on) {
//        //启会的同时，显示要分享的页面。此时，在会中点击共享按钮后，会议视频界面就会隐藏。
//    
//        [self showShareVC];
//    }
//    
//}
-(UIView *)viewToShare{
    return self.shareVC.view;
}
#if 0
-(void)onClickedInviteButton:(UIViewController *) parentVC{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"invite" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * actionTel = [UIAlertAction actionWithTitle:@"phone" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //phone
        H323andPhoneViewController *phone = [[H323andPhoneViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:phone];
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
        [parentVC presentViewController:nav animated:YES completion:nil];
    }];
    UIAlertAction *actionH323 = [UIAlertAction actionWithTitle:@"H323" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        H323ViewController *h323 = [[H323ViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:h323];
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
        [parentVC presentViewController:nav animated:YES completion:^{
            
        }];
    }];
    [alert addAction:actionTel];
    [alert addAction:actionH323];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //cancel
    }]];
    [parentVC presentViewController:alert animated:YES completion:^{
        
    }];

}
#endif
- (void)onBizDialOutStatusChanged:(BizDialOutStatus)status{

    NSLog(@"status=%u",status);
}

#pragma mark - common
-(void)showShareVC{
    ToShareViewController *vc = [ToShareViewController new];
    self.shareVC = vc;
//    [self addChildViewController:self.shareVC];
//    [self.view insertSubview:self.shareVC.view atIndex:0];
//    [self.shareVC didMoveToParentViewController:self];
    self.shareVC.view.frame = self.view.bounds;
    [self presentViewController:self.shareVC animated:NO completion:^{
        
    }];
}

@end

