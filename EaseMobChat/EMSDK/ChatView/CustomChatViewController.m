//
//  KJViewController.m
//  KenJiao_Student
//
//  Created by mac on 16/4/16.
//  Copyright © 2016年 mac. All rights reserved.
//


#import "CustomChatViewController.h"
#import "EaseMessageViewController.h"
#import "CallViewController.h"

@interface CustomChatViewController () <EMCallManagerDelegate>

@end

@implementation CustomChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"聊天";
    
    // 实时通话的代理
    [self registerNotifications];
    
    // 监听发起实时通话的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callOutWithChatter:) name:@"callOutWithChatter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callControllerClose:) name:@"callControllerClose" object:nil];
}


-(void)registerNotifications
{
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    
    [[EaseMob sharedInstance].callManager removeDelegate:self];
}

- (void)dealloc
{
    [self unregisterNotifications];
}

// 发起实时通话
- (void)callOutWithChatter:(NSNotification *)notification
{
    id object = notification.object;
    if ([object isKindOfClass:[NSDictionary class]]) {
        if (![self canRecord]) {
            return;
        }
        
        EMError *error = nil;
        NSString *chatter = [object objectForKey:@"chatter"];
        EMCallSessionType type = [[object objectForKey:@"type"] intValue];
        EMCallSession *callSession = nil;
        if (type == eCallSessionTypeAudio) {
            callSession = [[EaseMob sharedInstance].callManager asyncMakeVoiceCall:chatter timeout:50 error:&error];
        }
        else if (type == eCallSessionTypeVideo){
            if (![CallViewController canVideo]) {
                return;
            }
            callSession = [[EaseMob sharedInstance].callManager asyncMakeVideoCall:chatter timeout:50 error:&error];
        }
        
        if (callSession && !error) {
            [[EaseMob sharedInstance].callManager removeDelegate:self];
            
            CallViewController *callController = [[CallViewController alloc] initWithSession:callSession isIncoming:NO];
            callController.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self presentViewController:callController animated:NO completion:nil];
        }
        
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"error", @"error") message:error.description delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}

#pragma mark - call

- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                bCanRecord = granted;
            }];
        }
    }
    
    if (!bCanRecord) {
        UIAlertView * alt = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"setting.microphoneNoAuthority", @"No microphone permissions") message:NSLocalizedString(@"setting.microphoneAuthority", @"Please open in \"Setting\"-\"Privacy\"-\"Microphone\".") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
        [alt show];
    }
    
    return bCanRecord;
}



#pragma mark - ICallManagerDelegate

// 接收实时通话的回调函数
- (void)callSessionStatusChanged:(EMCallSession *)callSession changeReason:(EMCallStatusChangedReason)reason error:(EMError *)error
{
    if (callSession.status == eCallSessionStatusConnected)
    {
        EMError *error = nil;
        do {
            BOOL isShowPicker = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isShowPicker"] boolValue];
            if (isShowPicker) {
                error = [EMError errorWithCode:EMErrorInitFailure andDescription:NSLocalizedString(@"call.initFailed", @"Establish call failure")];
                break;
            }
            
            if (![self canRecord]) {
                error = [EMError errorWithCode:EMErrorInitFailure andDescription:NSLocalizedString(@"call.initFailed", @"Establish call failure")];
                break;
            }
            
#warning 在后台不能进行视频通话
            if(callSession.type == eCallSessionTypeVideo && ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive || ![CallViewController canVideo])){
                error = [EMError errorWithCode:EMErrorInitFailure andDescription:NSLocalizedString(@"call.initFailed", @"Establish call failure")];
                break;
            }
            
            if (!isShowPicker){
                [[EaseMob sharedInstance].callManager removeDelegate:self];
                CallViewController *callController = [[CallViewController alloc] initWithSession:callSession isIncoming:YES];
                callController.modalPresentationStyle = UIModalPresentationOverFullScreen;
                [self presentViewController:callController animated:NO completion:nil];
                
                // EaseMessageViewController是聊天类，根据自己的聊天类写
                if ([self.navigationController.topViewController isKindOfClass:[EaseMessageViewController class]])
                {
                    EaseMessageViewController *chatVc = (EaseMessageViewController *)self.navigationController.topViewController;
                    chatVc.isViewDidAppear = NO;
                }
            }
        } while (0);
        
        if (error) {
            [[EaseMob sharedInstance].callManager asyncEndCall:callSession.sessionId reason:eCallReasonHangup];
            return;
        }
    }
}


- (void)callControllerClose:(NSNotification *)notification
{
    //    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    //    [audioSession setActive:YES error:nil];
    
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];
}



@end

