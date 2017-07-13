//
//  BizViewController.h
//  Bizconfsdk
//
//  Created by bizconf on 16/8/11.
//  Copyright © 2016年 bizconf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BizViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *meetingNum;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *userID;
@property (strong, nonatomic) IBOutlet UITextField *userToken;
@property (strong, nonatomic) IBOutlet UITextField *cuid;
@property (weak, nonatomic) IBOutlet UISwitch *swAppShare;

@end
