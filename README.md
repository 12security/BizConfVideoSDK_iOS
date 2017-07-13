标识： 	密级：版本：V1.1


# BizConf Video SDK使用说明书

iOS


##### 上海会畅通讯股份有限有限公司
###### 二○一六 年 八 月

##### 文档修改记录
|版本号        |修改内容描述              |修改人  |日期          |备注|
| ------------- |:-------------:  | -----:           |      |
|V1.001        |新编                     |Simon   |2016-08-17 |       |
|V1.002        |修改在上传 IPA 文件时报错的BUG |Simon |2016-10-19 ||
|V1.003        |添加参数cuid,更换资源文件包 | Simon |2016-11-09 ||
|V1.010        |添加结束会议回调和三个设置项 |Simon |2017-1-5| |
|V1.011        |更换内核 |Simon |2017-1-25 ||
|V1.100       |适配HTTPS协议 |Simon |2017-3-3 ||
|V1.1.0        |调整demo布局 |Simon |2017-4-24||
|V1.2.0         |增加共享View，电话、H323接口 |Simon | 2017-7-3|||

### 目录
#### BizConf Video SDK使用说明书
#### 文档修改记录
### 第1章  简介
#### 1.1 BizConf Video SDK
#### 1.2 BizConf Video SDK for iOS
#### 1.3 用户须知
### 第2章  入门指南
#### 2.1 SDK Key
#### 2.2 搭建
#### 2.3 示例程序
### 第3章  BizConf Video SDK for iOS-API 使用
#### 3.1 参数说明
#### 3.2 接口说明
#### 3.2.2 开启会议
#### 3.2.3 加入会议
#### 3.2.4设置静音
#### 3.2.5会议结束的回调
#### 3.2.6电话邀请接口
#### 3.2.7硬件邀请接口


### 第1章  简介
#### 1.1 BizConf Video SDK
BizConf Video Video 会畅通讯视频会议，为客户提供基于互联音视频通信，在实时通信和移动对移动通信方面进行特别优化，确保满意的用户体验质量。
##### BizConf Video Video 包含以下 SDK，且 BizConf Video SDK 在程序生成时直接与应用程序建立连接：
-	BizConf Video SDK for Windows
-	BizConf Video SDK for iOS
-   BizConf Video SDK for Android

#### 1.2 BizConf Video SDK for iOS
##### 用于移动设备的BizConf Video SDK，专为智能手机研发，针对移动设备iOS平台进行优化。
#### 1.3 用户须知
##### 1.3.1 搭建项目环境要求
BizConf Video SDK 最低支持 iOS 8 ，支持 ARC。目前 BizConf Video SDK 可以实现启动会议和加入会议，支持 iPad 和 iPhone 开发
##### 1.3.2 所需库

导入 BizConfSDK 和 MobileRTCResources.bundle
### 第2章  入门指南
#### 2.1 SDK Key
使用 SDK 需要先获取 Channel ID 和 SDK Key；
ChannelId:客户标识码      
SDK Key:SDK 认证密码
#### 2.2 搭建项目
-	设置 “Targeted Device Family” 为“iPhone/iPad”;
-	设置“iOS Deployment Target” 为“iOS 8.0”
-	在Build Settings的“Other Linker Flags”里添加“-ObjC”
-	设置“C++ Language Dialect” 为“Compile Default”
-	设置“C++ Standard Library” 为“Compile Default”
-	在 info 里添加 Key：NSLocationAlwaysUsageDescription Value：YES。并且 iOS9 需要设置网络访问权限
-	在 Build Setting--Linking--Runpath Search Paths 里添加“@executable_path/”字段（切记不能掉了“/”）
-	在 info 里添加 key: Privacy - Camera Usage Description, Privacy - Microphone Usage Description, Privacy - Photo Library Usage Description(iOS10 需要添加麦克风,摄像头,照片的权限)

#### 2.3 示例程序
示例 demo 里设置了验证、参会、启会三个按钮，在使用 demo 的时候要首先验证，只有在验证成功后才可以参会和启会，需要注意的是在参会时只需要使用 meetingNo、
userName、uid（非必填）三个参数，在启会时还需要参数 userID、token
### 第3章  BizConf Video SDK for iOS-API 使用
#### 3.1 参数说明
**channelId**:客户标识码   
**key**: SDK认证密码

### 3.2 接口说明
#### 3.2.1 初始化

##### 1、验证SDK
  每一个使用BizConf Video SDK的用户都必须获取授权方可正常的使用，主要通过获
取ChannelID和Key来识别用户身份，该验证方法放在appdelegate里的
didfinishLaunchingwithoptions里实现
例如：

```java
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
```


#### 3.2.2 开启会议
开启会议,该方法可以用于开启一个新的会议，
```java
/**
 该方法用于开启会议
 userId: 收到结果客户端从BizConf Video站点用户帐户。  
 username: 用户名将被用作显示名称的BizConf Video会议。
 Token: 收到结果客户端从BizConf Video站点用户帐户。
 meetingNo: 会议号
 cuid：标记参会人身份
 result:入会错误信息
 */
- (void)startMeeting:(NSString *)userId
userName:(NSString *)userName
userToken:(NSString *)token
meetingNo:(NSString *)meetingNo
cuid:(NSString *)cuid
result:(void (^)(BizSDKMeetError))completion;
```
#### 3.2.3 加入会议
该方法在用户完成验证后调用，调用成功后可直接跳转到参会人界面，其中参数
userName为参会人在会议中的名称，一般默认长度为50个字符，参数meetingNo为要参加会议的会议号
注意：在点击参会时要首先把输入框的的键盘隐藏，否则在入会成功后在会议界面键盘依然存在
例如：


 ```java
/**
 该方法用于计入会议
 userName :参会人的姓名  
 meetingNo: 会议号
 uid:参会人的身份标识(非必填)
 cuid：标记参会人身份
 isAudio:是否自动连接语音（此为新增参数）
 isVideo：是否自动开启摄像头（此为新增参数）
 result:入会错误信息
 */
-(void)joinMeeting:(NSString *) userName
meetingNo:(NSString *)meetingNo
uid:(NSString *)uid
password:(NSString *)password
cuid:(NSString *)cuid
isAudio:(BOOL) audio
isvideo:(BOOL) video
result:(void (^)(BizSDKMeetError))completion;
```

#### 3.2.4设置静音
在SDK里添加了一个用于会议设置的设置类，在这个类里可以判断当前会议是否是静音状态，并且可以设置会议的静音

具体方法如下：

1. 获取加入会议前麦克风静音状态
> -(BOOL)muteAudioWhenJoinMeeting;

2. 麦克风自动静音
> -(void)setMuteAudioWhenJoinMeeting:(BOOL)muted;

#### 3.2.5会议结束的回调
1. 当会议结束的时候会调用代理方法：
>``` -(void)onMeetingEnd;```
可以在这个方法里实现一些必要的操作
2. 邀请的View的回调，返回的是需要共享的View
>``` -(UIView *)viewToShare;```
3. 响应邀请按钮的回调
>``` -(void)onClickedInviteButton:(UIViewController *) parentVC;```
4. 响应共享按钮的回调
>``` -(void)onBizClickedShareButton;```

#### 3.2.6电话邀请接口
 -(BOOL)dialOut:(NSString*)phone withName:(NSString*)username;    
>这个方法用于开始外呼参会人
参数phone是要外呼参会人的电话号码，需要注意的是在电话号码前需要加入国家代码，例如：+86123456789
参数userName是参会人的别名     

回调    
-(void)onBizDialOutStatusChanged:(BizDialOutStatus)status;     
>可以查看外呼的状态

#### 3.2.7硬件邀请接口
1. 邀请码邀请
> -(BOOL)sendPairingCode:(NSString*)code;     
这个方法是通常是通过一个邀请码邀请硬件入会     
回调     
-(void)onBizSendPairingCodeStateChanged:(NSUInteger)state;     
可以查看邀请码入会时的状态
2. 外呼一个硬件会议室
> -(BOOL)callRoomDevice:(BizConfVideoRoomDevice*)device;     
参数是class BizConfVideoRoomDevice包含了属性     
属性1、deviceName 设备 的名称     
属性2、ipAddress ip地址     
属性3、e164num e164码     
属性4、deviceType  设备类型     
属性5、encryptType 设备加密类型        
回调    
-(void)onBizCallRoomDeviceStateChanged:(BizH323CallOutStatus)state;     
可以查看外呼的状态变化


