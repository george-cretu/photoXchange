//
//  AppDelegate.h
//  Photoapp
//
//  Created by Esolz Technologies on 08/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>
#import "imageViewerViewController.h"
@class   HTTPServer;

@class ViewController;

@class GTMOAuth2Authentication;
@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate,DBSessionDelegate, DBNetworkRequestDelegate,DBRestClientDelegate>
{
    UINavigationController *navigationController;
    NSArray *viewsArray;
    HTTPServer *httpServer;
	NSDictionary *addresses;
    NSString *relinkUserId;
    DBRestClient* restClient;
}
@property (nonatomic,assign) BOOL libopen;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) imageViewerViewController *img_view_controller;
@property (nonatomic, retain) UITabBarController *tabbarController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSArray *dropboxarr;
@property (strong, nonatomic) NSString *imgvwr;
@end


//// PhotoApp 6 --> changing on this
// http://photo-xchange.com/user_guideline.php