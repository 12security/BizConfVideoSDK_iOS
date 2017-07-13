//
//  BizConfVideoSDK.h
//  Bizconfsdk
//
//  Created by bizconf on 16/8/8.
//  Copyright © 2016年 bizconf. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BizConfSDK.h"
#import "BizConfVideoSDKSettings.h"
#import "BizConfVideoRoomDevice.h"



@protocol BizConfVideoSDKDelegate <NSObject>

@optional

-(void)onMeetingEnd;
-(UIView *)viewToShare;
-(void)onClickedInviteButton:(UIViewController *) parentVC;
-(void)onBizClickedShareButton;
@end

@protocol BizConfSDKDelegate <NSObject>

@optional

- (void)onBizDialOutStatusChanged:(BizDialOutStatus)status;
/**
 * Designated for Send pairing code state change.
 *
 * @param state tell client the status of sending pairing code to Room Device.
 *
 */
- (void)onBizSendPairingCodeStateChanged:(NSUInteger)state;

/**
 * Designated for Call Room Device state change.
 *
 * @param state tell client the status of calling Room Device.
 *
 */
- (void)onBizCallRoomDeviceStateChanged:(BizH323CallOutStatus)state;


@end

@interface BizConfVideoSDK : NSObject

@property (copy, nonatomic) NSString *meetingID;
@property (assign, nonatomic) id<BizConfVideoSDKDelegate> delegate;
@property (assign, nonatomic)id <BizConfSDKDelegate>edelegate;

+ (instancetype)sharedSDK;

-(BOOL)isAuthorized;
/**
 该方法用于验证用户信息
 channelId:客户授权码
 key:客户的识别码
 target:用于验证调用代理方法,默认为appdelegate里的self
 result:认证的结果
 */
- (void)authSdk:(NSString *)channelId
        withKey:(NSString *)key
     withTarget:(id) target
         result:(void (^)(BizSDKAuthError))completion;

- (void)authSdk:(NSString *)channelId
        withKey:(NSString *)key
     withTarget:(id) target
resultWithDetail:(void (^)(BizSDKAuthError authErrorCode
                           ,NSURLResponse * response
                           ,NSError * error))completion;

/**
 该方法用于计入会议
 userName :参会人的姓名
 meetingNum: 会议号
 uid:参会人的身份标识(非必填，可以为空)
 */
- (void)joinMeeting:(NSString *) userName
          meetingNo:(NSString *)meetingNo
                uid:(NSString *)uid
           password:(NSString *)password
               cuid:(NSString *)cuid
            isAudio:(BOOL) audio
            isvideo:(BOOL) video
             result:(void (^)(BizSDKMeetError))completion;

/**
 该方法用于开启会议
 userId 收到结果客户端从bizconf站点用户帐户。
 userName 用户名将被用作显示名称的bizconf会议。
 Token 收到结果客户端从bizconf站点用户帐户。
 meetingNo 会议号
 */
- (void)startMeeting:(NSString *)userId
            userName:(NSString *)userName
           userToken:(NSString *)token
           meetingNo:(NSString *)meetingNo
                cuid:(NSString *)cuid
            shareScreen:(BOOL)isShareScreen
              result:(void (^)(BizSDKMeetError))completion;
/* Previous Version */
- (void)startMeeting:(NSString *)userId
            userName:(NSString *)userName
           userToken:(NSString *)token
           meetingNo:(NSString *)meetingNo
                cuid:(NSString *)cuid
              result:(void (^)(BizSDKMeetError))completion;


/**
 * Sets the client root navigation controller
 *
 * @param nav: A root navigation controller for pushing meeting UI.
 *
 * *Note*: This method is optional, If the window's rootViewController of the app is a UINavigationController, you can call this method, or just ignore it.
 */
- (void)setNavC:(UINavigationController *) nav;

- (void)stopSharingScreen;
/**
 * This method is used to start a dial out.
 *
 * @param phone, the phone number used to dial out, the phone number should add country code at first, such as "+86123456789".
 * @param username, the display name for invite other by phone. If parameter "me" is YES, the param can be ignored.
 */
- (BOOL)dialOut:(NSString*)phone withName:(NSString*)username;

/**
 * This method is used to cancel dial out.
 */
- (BOOL)cancelDialOut;
/**
 * This method is used to check whether there exists a dial out in process.
 */
- (BOOL)isDialOutInProgress;


/**
 * This method is used to check whether there exists a call room device in process.
 */
- (BOOL)isCallingRoomDevice;

/**
 * This method is used to cancel call room device.
 */
- (BOOL)cancelCallRoomDevice;
/**
 * This method will return an array of IP Addresses for Call in a room device.
 *
 * *Note*: return nil, if there does not exist any IP Address.
 */
- (NSArray*)getIPAddressList;

/**
 * This method will return a meeting password for call in a room device.
 *
 * *Note*: return nil, means that user can call in a room device directly.
 */
- (NSString*)getH323MeetingPassword;
/**
 * This method will return an array of room devices.
 */
- (NSArray*)getRoomDeviceList;

/**
 * This method is used to call in a room device with pairing code.
 */
- (BOOL)sendPairingCode:(NSString*)code;

/**
 * This method is used to call out a room device.
 */
- (BOOL)callRoomDevice:(BizConfVideoRoomDevice*)device;

@end










