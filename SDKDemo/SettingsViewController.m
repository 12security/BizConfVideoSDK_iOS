//
//  SettingsViewController.m
//  SDKDemo
//
//  Created by bizconf on 16/12/26.
//  Copyright © 2016年 bizconf. All rights reserved.
//

#import "SettingsViewController.h"
#import <BizConfSDK/BizConfSDK.h>

@interface SettingsViewController ()

@property (retain, nonatomic)UITableViewCell *muteAudioCell;
@property (retain, nonatomic)NSArray *itemArray;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Setting", nil);
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@[[self muteAudioCell]]];
    self.itemArray = array;
    
}
-(UITableViewCell *)muteAudioCell{

    BizConfVideoSDKSettings *settings = [[BizConfVideoSDKSettings alloc] init];
    if (!settings)
        return nil;
    
    BOOL isMuted = [settings muteAudioWhenJoinMeeting];
    
    if (!_muteAudioCell)
    {
        _muteAudioCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _muteAudioCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _muteAudioCell.textLabel.text = @"麦克风自动静音";
        
        UISwitch *sv = [[UISwitch alloc] initWithFrame:CGRectZero];
        [sv setOn:isMuted animated:NO];
        [sv addTarget:self action:@selector(onMuteAudio:) forControlEvents:UIControlEventValueChanged];
        _muteAudioCell.accessoryView = sv;
    }
    
    return _muteAudioCell;

}

- (void)onMuteAudio:(id)sender
{
    UISwitch *sv = (UISwitch*)sender;
    [[BizConfVideoSDKSettings shared] setMuteAudioWhenJoinMeeting:sv.on];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.itemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *arr = self.itemArray[section];
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    UITableViewCell *cell = self.itemArray[indexPath.section][indexPath.row];
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{

    switch (section) {
        case 0:
            return @"当使用互联网音频加入会议时，我的麦克风自动静音";
            break;
        default:
            break;
    }
    return nil;
}
@end
