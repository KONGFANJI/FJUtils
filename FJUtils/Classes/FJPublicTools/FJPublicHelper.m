//
//  FJPublicHelper.m
//  FJPublicTools
//
//  Created by XY on 2017/3/15.
//  Copyright © 2017年 KFJ. All rights reserved.
//

#import "FJPublicHelper.h"
#import <StoreKit/StoreKit.h>
#import "FJAppInfoUtils.h"
#import "DAAppsViewController.h"

@interface FJPublicHelper()<SKStoreProductViewControllerDelegate,MFMailComposeViewControllerDelegate,UIDocumentInteractionControllerDelegate>

@property (nonatomic,assign) EmailResultBlock resultBlock;
@property (nonatomic,strong) UIDocumentInteractionController *documentInteraction;

@end

@implementation FJPublicHelper

+(instancetype)shareInstance{
    static FJPublicHelper *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[FJPublicHelper alloc] init];
    });
    
    return store;
}


- (void)sendEmailWithViewCotroller:(UIViewController *)vc result:(EmailResultBlock)resultBlock{
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc]init];
    mail.mailComposeDelegate = self;
    
    if (_subject && _subject.length > 0) {
        [mail setSubject:_subject];
    }
    
    NSString *version = [NSString stringWithFormat:@"版本号码：%@",[FJAppInfoUtils appVersion]];
    NSString *appName = [NSString stringWithFormat:@"APP名称：%@",[FJAppInfoUtils appName]];
    NSString *device = [NSString stringWithFormat:@"设备名称：%@",[FJAppInfoUtils machineName]];
    NSString *iOSVersion = [NSString stringWithFormat:@"系统版本：%@",[FJAppInfoUtils systermVersion]];
    
    NSString *infoString = [NSString stringWithFormat:@"\n\n\n\n\n\n基本信息：\n%@\n%@\n%@\n%@",appName,version,device,iOSVersion];
    
    _body = infoString;
    
    if (_body && _body.length > 0 && _isShowAppInfo) {
        [mail setMessageBody:_body isHTML:_isHTML];
    }
    
    if (_ccRecipients.count > 0) {
        [mail setCcRecipients:_ccRecipients];
    }
    
    if (_toRecipients.count > 0) {
        [mail setToRecipients:_toRecipients];
    }
    
    if (_bccRecipients.count > 0) {
        [mail setBccRecipients:_bccRecipients];
    }
    
    if ([MFMailComposeViewController canSendMail]) {
        [vc presentViewController:mail animated:YES completion:nil];
    }
    
    self.resultBlock = resultBlock;
    
}

#pragma mark MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    self.resultBlock(result,error);
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

//------------------------我是分割线------------------------

- (void)openAppWithIdentifier:(NSString *)appId andVC:(UIViewController *)vc {
    
    if ([SKStoreProductViewController class]) {
        [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
        
        NSString *itunesItemIdentifier = [NSString stringWithFormat:@"%@",  appId];
        NSMutableDictionary *appParameters = [@{SKStoreProductParameterITunesItemIdentifier: itunesItemIdentifier} mutableCopy];
        
        SKStoreProductViewController *productViewController = [[SKStoreProductViewController alloc] init];
        [productViewController setDelegate:self];
        [productViewController loadProductWithParameters:appParameters completionBlock:nil];
        [vc presentViewController:productViewController
                         animated:YES
                       completion:nil];
    } else {
        NSString *appUrlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?mt=8", appId];
        NSURL *appURL = [[NSURL alloc] initWithString:appUrlString];
        [[UIApplication sharedApplication] openURL:appURL];
    }
    
}

#pragma mark SKStoreProductViewControllerDelegate
-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:^{
        //do something
    }];
}




//------------------------我是分割线------------------------

- (void)openAppWithArtistId:(NSInteger)artistId andNavigationCotroller:(UINavigationController *)naviController completionBlock:(ApplistResultBlock)block {
    
    DAAppsViewController *appsViewController = [[DAAppsViewController alloc] init];
    appsViewController.view.backgroundColor = [UIColor whiteColor];
    [appsViewController loadAppsWithArtistId:artistId completionBlock:^(BOOL result, NSError *error) {
        block(result,error);
    }];
    
    [naviController pushViewController:appsViewController animated:YES];
}



//------------------------我是分割线------------------------

-(UIActivityViewController *)createActivityViewController:(NSArray *)activityItems andExcludedActivityTypes:(NSArray *)typesArray withVC:(UIViewController *)vc{
    UIActivityViewController *activitiViewCotroller = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:typesArray];
    
    [activitiViewCotroller setCompletionHandler:^(NSString *activityType, BOOL completed) {
        
    }];
    
    // iOS 8 - Set the Anchor Point for the popover
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0) {
        activitiViewCotroller.popoverPresentationController.sourceView = vc.view;
    }
    
    [vc presentViewController:activitiViewCotroller animated:YES completion:nil];
    
    return activitiViewCotroller;
}

//------------------------我是分割线------------------------

- (void)exportFileWithUrl:(NSURL *)url andView:(UIView *)view{
    _documentInteraction = [UIDocumentInteractionController interactionControllerWithURL:url];
    
    _documentInteraction.delegate = self; // UIDocumentInteractionControllerDelegate
    
    [_documentInteraction presentOpenInMenuFromRect:view.bounds inView:view animated:YES];
    
}

#pragma mark - UIDocumentInteractionControllerDelegate methods

- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller
{
    _documentInteraction = nil;
}


//------------------------我是分割线------------------------










//------------------------我是分割线------------------------




@end
