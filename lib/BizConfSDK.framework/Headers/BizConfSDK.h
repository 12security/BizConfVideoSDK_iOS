//
//  BizConfSDK.h
//  BizConfSDK
//
//  Created by bizconf on 17/6/19.
//  Copyright © 2017年 bizconf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    //Success
    SDKMeetError_Success                    = 0,
    //Not Authorized
    SDKMeetError_NotAuthorized,
    //Incorrect meeting number
    SDKMeetError_IncorrectMeetingNumber,
    //Meeting Timeout
    SDKMeetError_MeetingTimeout,
    //Network Unavailable
    SDKMeetError_NetworkUnavailable,
    //Client Version Incompatible
    SDKMeetError_MeetingClientIncompatible,
    //User is Full
    SDKMeetError_UserFull,
    //Meeting is over
    SDKMeetError_MeetingOver,
    //Meeting does not exist
    SDKMeetError_MeetingNotExist,
    //Meeting has been locked
    SDKMeetError_MeetingLocked,
    //Meeting Restricted
    SDKMeetError_MeetingRestricted,
    //JBH Meeting Restricted
    SDKMeetError_MeetingJBHRestricted,
    
    //Invalid Arguments
    SDKMeetError_InvalidArguments,
    SDKMeetError_InvalidUserType,
    //Already In another ongoing meeting
    SDKMeetError_InAnotherMeeting,
    //Unknown error
    SDKMeetError_Unknown,
    
}BizSDKMeetError;

typedef enum {
    BizDialOutStatus_Unknown  = 0,
    BizDialOutStatus_Calling,
    BizDialOutStatus_Ringing,
    BizDialOutStatus_Accepted,
    BizDialOutStatus_Busy,
    BizDialOutStatus_NotAvailable,
    BizDialOutStatus_UserHangUp,
    BizDialOutStatus_OtherFail,
    BizDialOutStatus_JoinSuccess,
    BizDialOutStatus_TimeOut,  //For client not get response, maybe network reason
    BizDialOutStatus_StartCancelCall,
    BizDialOutStatus_CallCanceled,
    BizDialOutStatus_CancelCallFail,
    BizDialOutStatus_NoAnswer,  //Indicate the phone ring but no-one answer
    BizDialOutStatus_BlockNoHost,  //JBH case, disable international callout before host join
    BizDialOutStatus_BlockHighRate,  //The price of callout phone number is too expensive which has been blocked by system
    BizDialOutStatus_BlockTooFrequent,  //Invite by phone with pressONE required, but invitee frequently does NOT press one then timeout
}BizDialOutStatus;

typedef enum {
    //Auth Success
    BizSDKAuthError_Success                 = 200,
    //Invalid channelID
    BizSDKAuthError_InvalidChannelID,
    //Key or Secret is empty
    BizSDKAuthError_KeyOrChannelIDEmpty,
    //Network or Server problem
    BizSDKAuthError_ConnectionError,
    //Auth Unknown error
    BizSDKAuthError_Unknown
}BizSDKAuthError;

typedef enum {
    BizH323CallOutStatus_OK        = 0,
    BizH323CallOutStatus_Calling,
    BizH323CallOutStatus_Busy,
    BizH323CallOutStatus_Failed,
}BizH323CallOutStatus;

#import <BizConfSDK/BizConfVideoSDK.h>

#import <BizConfSDK/BizConfVideoSDKSettings.h>

#import <BizConfSDK/BizConfVideoRoomDevice.h>

@interface BizConfSDK : NSObject

@end
