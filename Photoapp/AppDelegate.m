//
//  AppDelegate.m
//  Photoapp
//
//  Created by Esolz Technologies on 08/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import <QuartzCore/CoreAnimation.h>
#import "ViewController.h"
#import "LoginViewController.h"
#import "HTTPServer.h"
#import "MyHTTPConnection.h"
#import "localhostAddresses.h"
#import "SVProgressHUD.h"
#import <GooglePlus/GooglePlus.h>
#import "HomeViewController.h"
#import "ImageFromFTPViewController.h"
//static NSString * const kClientID = @"26424456948.apps.googleusercontent.com";
static NSString * const kClientID = @"536735755870-1bcqgtc3splihm9mgu008oojtrjvgffd.apps.googleusercontent.com";
@interface AppDelegate () <DBSessionDelegate, DBNetworkRequestDelegate>
{
    NSString *filename;
    NSTimer *timera;
}
@end

@implementation AppDelegate

@synthesize navigationController,tabbarController, timer, viewController,libopen,dropboxarr,imgvwr;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    NSString* appKey = @"kfvjdtm1xazgih4";
	NSString* appSecret = @"oa11p2vnpkvrqu5";
	NSString *root_path = kDBRootDropbox;
    
    NSString* errorMsg = nil;
	if ([appKey rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
		errorMsg = @"Make sure you set the app key correctly in DBRouletteAppDelegate.m";
	} else if ([appSecret rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
		errorMsg = @"Make sure you set the app secret correctly in DBRouletteAppDelegate.m";
	} else if ([root_path length] == 0) {
		errorMsg = @"Set your root to use either App Folder of full Dropbox";
	} else {
		NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
		NSData *plistData = [NSData dataWithContentsOfFile:plistPath];
		NSDictionary *loadedPlist =
        [NSPropertyListSerialization
         propertyListFromData:plistData mutabilityOption:0 format:NULL errorDescription:NULL];
		NSString *scheme = [[[[loadedPlist objectForKey:@"CFBundleURLTypes"] objectAtIndex:0] objectForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
		if ([scheme isEqual:@"db-APP_KEY"]) {
			errorMsg = @"Set your URL scheme correctly in DBRoulette-Info.plist";
		}
	}
	
    [GPPSignIn sharedInstance].clientID = kClientID;
	DBSession* session =
    [[DBSession alloc] initWithAppKey:appKey appSecret:appSecret root:root_path];
	session.delegate = self; // DBSessionDelegate methods allow you to handle re-authenticating
	[DBSession setSharedSession:session];
    
    [DBRequest setNetworkRequestDelegate:self];
    
	if (errorMsg != nil) {
		[[[UIAlertView alloc]
          initWithTitle:@"Error Configuring Session" message:errorMsg
          delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
		 show];
	}
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    NSString *root = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
	
	httpServer = [HTTPServer new];
	[httpServer setType:@"_http._tcp."];
	[httpServer setConnectionClass:[MyHTTPConnection class]];
	[httpServer setDocumentRoot:[NSURL fileURLWithPath:root]];
	[httpServer stop];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayInfoUpdate:) name:@"LocalhostAdressesResolved" object:nil];
    
	[localhostAddresses performSelectorInBackground:@selector(list) withObject:nil];
    
    [self startStopServer];
    
    
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs integerForKey:@"numberNewPhoto"] <= 0) {
        [prefs setInteger:0 forKey:@"numberNewPhoto"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if([prefs integerForKey:@"numberSavedPhotos"] <= 0) {
        [prefs setInteger:0 forKey:@"numberSavedPhotos"];
    }
    
    navigationController = [[UINavigationController alloc] init];
    
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom])
    {
    case UIUserInterfaceIdiomPhone:
        {
            
            self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
            [navigationController pushViewController:self.viewController animated:YES];
        }
        break;
    case UIUserInterfaceIdiomPad:
        {
            self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
            [navigationController pushViewController:self.viewController animated:YES];
            
        }
        break;
    }
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        //        self.window.clipsToBounds =YES;
        //        self.window.frame = CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
        
    }
    
    
    
    self.window.backgroundColor = UIColorFromRGB(0xe1e1e1);
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(pullnextview) userInfo:nil repeats:YES];
    
    
    NSURL *launchURL = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
	NSInteger majorVersion =
    [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] integerValue];
	if (launchURL && majorVersion < 4) {
        [self application:application handleOpenURL:launchURL];
		return NO;
	}
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    //    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    //    NSArray *fontNames;
    //    NSInteger indFamily, indFont;
    //    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    //    {
    //        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
    //        fontNames = [[NSArray alloc] initWithArray:
    //                     [UIFont fontNamesForFamilyName:
    //                      [familyNames objectAtIndex:indFamily]]];
    //        for (indFont=0; indFont<[fontNames count]; ++indFont)
    //        {
    //            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
    //        }
    //    }
    
    [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"started"];
    return YES;
}

-(void)pullnextview
{
    [self.viewController.view removeFromSuperview];
    [self.timer invalidate];
    self.timer = nil;
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    //   ImageFromFTPViewController *control1 = [[ImageFromFTPViewController alloc] init];
    LoginViewController *control1 = [[LoginViewController alloc] init];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
}
- (void)startStopServer
{
    BOOL sender = YES;
	if (sender)
	{
        
		NSError *error;
		if(![httpServer start:&error])
		{
			NSLog(@"Error starting HTTP Server: %@", error);
		}
        
		[self displayInfoUpdate:nil];
	}
	else
	{
		[httpServer stop];
	}
}
- (void)displayInfoUpdate:(NSNotification *) notification
{
    
	if(notification)
	{
		addresses = [[notification object] copy];
		//NSLog(@"addresses: %@", addresses);
	}
    
	if(addresses == nil)
	{
		return;
	}
	
	NSString *info;
	UInt16 port = [httpServer port];
	
	NSString *localIP = nil;
	
	localIP = [addresses objectForKey:@"en0"];
	
	if (!localIP)
	{
		localIP = [addresses objectForKey:@"en1"];
	}
    
	if (!localIP)
		info = @"Wifi: No Connection!\n";
	else {
		info = [NSString stringWithFormat:@"http://iphone.local:%d		http://%@:%d\n", port, localIP, port];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:[NSString stringWithFormat:@"http://%@:%d",localIP, port] forKey:@"address"];
        
    }
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:[NSString stringWithFormat:@"http://%@:%d\n", localIP, port] forKey:@"IPndPort"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
	NSString *wwwIP = [addresses objectForKey:@"www"];
    
	if (wwwIP)
		info = [info stringByAppendingFormat:@"Web: %@:%d\n", wwwIP, port];
	else
		info = [info stringByAppendingString:@"Web: Unable to determine external IP\n"];
    // NSLog(@"%@", info);
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if(libopen)
    {
//        CATransition* transition = [CATransition animation];
//        transition.duration = 0.5;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.type = kCATransitionFade;
//        HomeViewController *home = [[HomeViewController alloc] init];
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
//        [[self navigationController] pushViewController:home animated:NO];
    }
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([[url scheme] hasPrefix:@"fb"]) {
        return  [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
        
    }
    if ([[DBSession sharedSession] handleOpenURL:url]) {
		if ([[DBSession sharedSession] isLinked]) {
            
			restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
            restClient.delegate = self;
            if ([imgvwr isEqualToString:@"yes"])
            {
                NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
                NSMutableString *randomString = [NSMutableString stringWithCapacity: 4];
                for (int i=0; i<4; i++) {
                    [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
                }
                NSString *filename1 = [NSString stringWithFormat:@"%@.png",randomString];
                
                NSString *tmpPngFile = [[NSUserDefaults standardUserDefaults] objectForKey:@"whatwesaved"];
                if ([DBSession sharedSession].root == kDBRootDropbox) {
                    NSString *destDir = @"/pXc Photos";
                    NSLog(@"the filename is:  %@",filename1);
                    [restClient uploadFile:filename1 toPath:destDir
                             withParentRev:nil fromPath:tmpPngFile];
                }
            }
            else
            {
            ALAssetsLibrary *library_of_phone = [[ALAssetsLibrary alloc] init];
                
//                NSMutableArray *newimgarr = [[NSMutableArray alloc]init];
//                if ([dropboxarr count]> 5)
//                {
//                    NSLog(@"pach er beshi %d",[dropboxarr count]);
//                    for (int imgno= 0; imgno< 5; imgno++)
//                    {
//                        [newimgarr addObject:[dropboxarr objectAtIndex:imgno]];
//                    }
//                    
//                    NSLog(@"first tym count: %d",[newimgarr count]);
//                    
////                    if( [[DBSession sharedSession] isLinked])
////                    {
////                        NSLog(@"in dropbox if");
//                        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
//                        restClient.delegate = self;
//                        ALAssetsLibrary *library_of_phone = [[ALAssetsLibrary alloc] init];
//                        for (NSString *yourImagePath in newimgarr )
//                        {
//                            NSLog(@"called once");
//                            [library_of_phone assetForURL:[NSURL URLWithString:yourImagePath] resultBlock:^(ALAsset *asset)
//                             {
//                                 NSString* originalFileName = [[asset defaultRepresentation] filename];
//                                 
//                                 NSLog(@"filename tulche: %@",originalFileName);
//                                 NSArray* foo = [originalFileName componentsSeparatedByString: @"."];
//                                 NSString* originalfn = [foo objectAtIndex: 0];
//                                 
//                                 NSDateFormatter *formatter;
//                                 NSString        *dateString;
//                                 
//                                 formatter = [[NSDateFormatter alloc] init];
//                                 [formatter setDateFormat:@"dd-MM-yyyyHH:mm:ss"];
//                                 
//                                 dateString = [formatter stringFromDate:[NSDate date]];
//                                 NSLog(@"datestring gives: %@",dateString);
//                                 
//                                 
//                                 
//                                 NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:1.0 orientation:[[asset defaultRepresentation] orientation]], 1.0);
//                                 
//                                 UIImage *newimage = [UIImage imageWithData:imageData];
//                                 
//                                 //                     NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//                                 //                     NSMutableString *randomString = [NSMutableString stringWithCapacity: 12];
//                                 //                     for (int i=0; i<12; i++)
//                                 //                     {
//                                 //                         [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
//                                 //                     }
//                                 NSString *upldstr= [NSString stringWithFormat:@"%@%@",originalfn,dateString];
//                                 NSLog(@"upldstr --------- %@",upldstr);
//                                 
//                                 filename = [NSString stringWithFormat:@"%@.png",upldstr];
//                                 NSString *tmpPngFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Temp.png"];
//                                 
//                                 
//                                 [UIImagePNGRepresentation(newimage) writeToFile:tmpPngFile atomically:YES];
//                                 
//                                 //                NSString *destDir = @"/";
//                                 NSString *destDir = @"/pXc Photos";
//                                 [restClient uploadFile:filename toPath:destDir
//                                          withParentRev:nil fromPath:tmpPngFile];
//                                 
//                             } failureBlock:^(NSError *error) {}];
//                        }
//                        
//                        //       [SVProgressHUD showSuccessWithStatus:@"Image has been successfully uploaded to the Photos folder of your Dropbox"];
//                        
//                        timera = [NSTimer scheduledTimerWithTimeInterval:30.0
//                                                                  target:self
//                                                                selector:@selector(targetMethod)
//                                                                userInfo:nil
//                                                                 repeats:NO];
//                        
////                    }
//
//                }
//                
//                
//                
//           else
//           {
            for (NSString *yourImagePath in dropboxarr)
            {
                @try {
                    [library_of_phone assetForURL:[NSURL URLWithString:yourImagePath] resultBlock:^(ALAsset *asset)
                 {
                     NSString* originalFileName = [[asset defaultRepresentation] filename];
                     
                     NSLog(@"filename tulche: %@",originalFileName);
                     NSArray* foo = [originalFileName componentsSeparatedByString: @"."];
                     NSString* originalfn = [foo objectAtIndex: 0];
                     
                     NSDateFormatter *formatter;
                     NSString        *dateString;
                     
                     formatter = [[NSDateFormatter alloc] init];
                     [formatter setDateFormat:@"dd-MM-yyyy-HH:mm:ss"];
                     
                     dateString = [formatter stringFromDate:[NSDate date]];
                     NSLog(@"datestring gives: %@",dateString);

                     
                     NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:1.0 orientation:[[asset defaultRepresentation] orientation]], 1.0);
                     
                     UIImage *newimage = [UIImage imageWithData:imageData];
                     
//                     NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//                     NSMutableString *randomString = [NSMutableString stringWithCapacity: 12];
//                     for (int i=0; i<12; i++)
//                     {
//                         [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
//                     }
                     
                     NSString *upldstr= [NSString stringWithFormat:@"%@-%@",originalfn,dateString];
                     NSLog(@"upldstr --------- %@",upldstr);
                     
                     filename = [NSString stringWithFormat:@"%@.png",upldstr];

//                     NSString *filename1 = [NSString stringWithFormat:@"%@.png",randomString];
                     NSString *tmpPngFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Temp.png"];
                     
                     
                     
                     [UIImagePNGRepresentation(newimage) writeToFile:tmpPngFile atomically:YES];
                     
                     //                NSString *destDir = @"/";
                     NSString *destDir = @"/pXc Photos";
                     [restClient uploadFile:filename toPath:destDir
                              withParentRev:nil fromPath:tmpPngFile];
                     
                 } failureBlock:^(NSError *error) {}];
                    
                }
                @catch (NSException *exception) {
                    NSLog(@"exception %@",exception);
                }
                @finally {
                }

            }
//        }
            }
            
            //       [SVProgressHUD showSuccessWithStatus:@"Image has been successfully uploaded to the Photos folder of your Dropbox"];
//            [NSThread detachNewThreadSelector:@selector(showsts:) toTarget:self withObject:@"Image has been successfully uploaded to the Photos folder of your Dropbox"];
            
		}
		return YES;
	}
    return [GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation];
    
    
}

#pragma mark -
#pragma mark DBSessionDelegate methods

- (void)sessionDidReceiveAuthorizationFailure:(DBSession*)session userId:(NSString *)userId {
	relinkUserId = userId;
	[[[UIAlertView alloc]
      initWithTitle:@"Dropbox Session Ended" message:@"Do you want to relink?" delegate:self
      cancelButtonTitle:@"Cancel" otherButtonTitles:@"Relink", nil]
	 show];
}


#pragma mark -
#pragma mark UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)index {
	if (index != alertView.cancelButtonIndex) {
		NSLog(@" Cancel kor");
	}
	relinkUserId = nil;
}
#pragma mark -
#pragma mark DBNetworkRequestDelegate methods

static int outstandingRequests;

- (void)networkRequestStarted {
	outstandingRequests++;
	if (outstandingRequests == 1) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	}
}

- (void)networkRequestStopped {
	outstandingRequests--;
	if (outstandingRequests == 0) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
}

- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath
              from:(NSString*)srcPath metadata:(DBMetadata*)metadata {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"whatwesaved"];
    [SVProgressHUD showSuccessWithStatus:@"Successfully uploaded to the pXc Photos folder of your Dropbox"];
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error {
 //   [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"File upload failed with error - %@", error]];
    NSLog(@"File upload failed with error - %@", error);
}



//-(void)targetMethod
//{
//    NSLog(@"now etay dhuklo");
//    NSMutableArray *second_array = [[NSMutableArray alloc]init];
//    for (int imgnos= 5; imgnos< [dropboxarr count]; imgnos++)
//    {
//        [second_array addObject:[dropboxarr objectAtIndex:imgnos]];
//    }
//    NSLog(@"now etay dhuklo %d",[second_array count]);
//    
//    if( [[DBSession sharedSession] isLinked])
//    {
//        NSLog(@"in dropbox if");
//        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
//        restClient.delegate = self;
//        ALAssetsLibrary *library_of_phone = [[ALAssetsLibrary alloc] init];
//        for (NSString *yourImagePath in second_array)
//        {
//            NSLog(@"called once");
//            [library_of_phone assetForURL:[NSURL URLWithString:yourImagePath] resultBlock:^(ALAsset *asset)
//             {
//                 NSString* originalFileName = [[asset defaultRepresentation] filename];
//                 
//                 NSLog(@"filename tulche: %@",originalFileName);
//                 NSArray* foo = [originalFileName componentsSeparatedByString: @"."];
//                 NSString* originalfn = [foo objectAtIndex: 0];
//                 
//                 NSDateFormatter *formatter;
//                 NSString        *dateString;
//                 
//                 formatter = [[NSDateFormatter alloc] init];
//                 [formatter setDateFormat:@"dd-MM-yyyyHH:mm:ss"];
//                 
//                 dateString = [formatter stringFromDate:[NSDate date]];
//                 NSLog(@"datestring gives: %@",dateString);
//                 
//                 
//                 
//                 NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:1.0 orientation:[[asset defaultRepresentation] orientation]], 1.0);
//                 
//                 UIImage *newimage = [UIImage imageWithData:imageData];
//                 
//                 //                     NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//                 //                     NSMutableString *randomString = [NSMutableString stringWithCapacity: 12];
//                 //                     for (int i=0; i<12; i++)
//                 //                     {
//                 //                         [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
//                 //                     }
//                 NSString *upldstr= [NSString stringWithFormat:@"%@%@",originalfn,dateString];
//                 NSLog(@"upldstr --------- %@",upldstr);
//                 
//                 filename = [NSString stringWithFormat:@"%@.png",upldstr];
//                 NSString *tmpPngFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Temp.png"];
//                 
//                 
//                 [UIImagePNGRepresentation(newimage) writeToFile:tmpPngFile atomically:YES];
//                 
//                 //                NSString *destDir = @"/";
//                 NSString *destDir = @"/pXc Photos";
//                 [restClient uploadFile:filename toPath:destDir
//                          withParentRev:nil fromPath:tmpPngFile];
//                 
//                 [NSThread detachNewThreadSelector:@selector(showsts:) toTarget:self withObject:@"Image has been successfully uploaded to the pXc Photos folder of your Dropbox"];
//             } failureBlock:^(NSError *error) {}];
//        }
//    }
//    [timera invalidate];
//}
@end
