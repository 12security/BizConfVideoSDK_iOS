//
//  BizConfVideoRoomDevice.h
//  BizConfSDK
//
//  Created by Colin on 2017/6/8.
//  Copyright © 2017年 bizconf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DeviceType_H323  = 1,
    DeviceType_SIP,
    DeviceType_Both,
}DeviceType;

typedef enum {
    DeviceEncryptType_None   = 0,
    DeviceEncryptType_Encrypt,
    DeviceEncryptType_Auto,
}DeviceEncryptType;

@interface BizConfVideoRoomDevice : NSObject

@property (nonatomic, copy) NSString *deviceName;
@property (nonatomic, copy) NSString *ipAddress;
@property (nonatomic, copy) NSString *e164num;
@property (nonatomic, assign) DeviceType deviceType;
@property (nonatomic, assign) DeviceEncryptType encryptType;

@end
