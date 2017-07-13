//
//  JoinViewController.m
//  SDKDemo
//
//  Created by bizconf on 17/1/5.
//  Copyright © 2017年 bizconf. All rights reserved.
//

#import "JoinViewController.h"
#import "MBProgressHUD.h"
#import <BizConfSDK/BizConfSDK.h>
#import "AuthViewController.h"
#import "H323ViewController.h"
#import "H323andPhoneViewController.h"

@interface JoinViewController ()<BizConfVideoSDKDelegate>
@property (strong, nonatomic) IBOutlet UITextField *meetingNum;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *passWord;
@property (strong, nonatomic) IBOutlet UITextField *uid;
@property (strong, nonatomic) IBOutlet UITextField *cuid;
@property (strong, nonatomic) IBOutlet UISwitch *isAuido;
@property (strong, nonatomic) IBOutlet UISwitch *isVideo;

@end

@implementation JoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabBarItem.title = @"join";
    
}
- (void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    [BizConfVideoSDK sharedSDK].delegate = self;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)joinMeetingBtnClick:(id)sender {
    [self.meetingNum resignFirstResponder];
    [self.userName resignFirstResponder];
    [self.cuid resignFirstResponder];

    [self.passWord resignFirstResponder];
    [self.uid resignFirstResponder];
    if ([[BizConfVideoSDK sharedSDK] isAuthorized]) {
        if ([self.userName.text isEqualToString:@""]) {
            MBProgressHUD* hub = [[MBProgressHUD alloc] init];
            [self.view addSubview:hub];
            hub.labelText =@"请输入参会人姓名";
            [hub show:YES];
            [hub hide:YES afterDelay:2.0];
        }else{
            BizConfVideoSDK *ms = [BizConfVideoSDK sharedSDK];
            if (ms) {
                ms.delegate = self;
                [ms joinMeeting:self.userName.text meetingNo:self.meetingNum.text uid:self.uid.text password:self.passWord.text cuid:self.cuid.text isAudio:!self.isAuido.on isvideo:!self.isVideo.on result:^(BizSDKMeetError result) {
                    
                    NSLog(@"会议的错误信息%u",result);
                    [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    }];
                }];
            }
        }
    }else{
        
        AuthViewController *authVC = [[AuthViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:authVC];
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [self presentViewController:nav animated:YES completion:NULL];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.meetingNum resignFirstResponder];
    [self.userName resignFirstResponder];
    [self.uid resignFirstResponder];
    [self.passWord resignFirstResponder];
    [self.cuid resignFirstResponder];

}
#pragma mark - BizConfVideoDelegate方法 会议结束的回调
-(void)onMeetingEnd{
    MBProgressHUD* hub = [[MBProgressHUD alloc] init];
    [self.view addSubview:hub];
    hub.labelText =@"会议结束";
    [hub show:YES];
    [hub hide:YES afterDelay:2.0];

    
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
    
    BizConfVideoSDK *biz = [BizConfVideoSDK sharedSDK];
    NSArray *ipArr = [biz getIPAddressList];
    if (![ipArr[0] isEqualToString:@""] ) {
        
        [alert addAction:actionH323];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //cancel
    }]];
    [parentVC presentViewController:alert animated:YES completion:^{
        
    }];
    
}
#endif
@end
