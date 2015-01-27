//  HomeViewController.m
//  Photoapp
//  Created by Soumalya on 20/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#import "HomeViewController.h"
#import "SVProgressHUD.h"
#import "AccountViewController.h"
#import "ProfileViewController.h"
#import "LibraryViewController.h"
#import "SetViewController.h"
#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "KOAProgressBar.h"
#define kAlbumName @"Saved Photos"
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"
#import "ELCAssetTablePicker.h"
#import "AppDelegate.h"
#import "NewProfileViewController.h"
#import "RootViewController.h"
#import "YLProgressBar.h"
@interface HomeViewController ()
{
    UIScrollView *sv1;
    UIButton *settings;
    UIImageView *logo;
    int timera;
    NSTimer *timerr;
}
@end
@implementation HomeViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)getAllAssets {
    int photoCount;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if([prefs integerForKey:@"numberSavedPhotos"] <= 0) {
        
        photoCount = assets.count;
    } else {
        photoCount = assets.count - [prefs integerForKey:@"numberSavedPhotos"];
    }
    
    [prefs setInteger:assets.count forKey:@"numberSavedPhotos"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)getPhotosFromAlbum {
    if (!assets) {
        assets = [[NSMutableArray alloc] init];
    } else {
        [assets removeAllObjects];
    }
    
    if (!assetsLibrary) {
        assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    if (!groups) {
        groups = [[NSMutableArray alloc] init];
    } else {
        [groups removeAllObjects];
    }
    
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [groups addObject:group];
            assetsGroup = group;
            ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
                
                if (result) {
                    
                    [assets addObject:result];
                }
            };
            
            ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
            [assetsGroup setAssetsFilter:onlyPhotosFilter];
            [assetsGroup enumerateAssetsUsingBlock:assetsEnumerationBlock];
        } else {
            
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        
        NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                errorMessage = @"The user has declined access to it.";
                break;
            default:
                errorMessage = @"Reason unknown.";
                break;
        }
        
    };
    
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:listGroupBlock failureBlock:failureBlock];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isComingFromImageDetail"]) {
//        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isComingFromImageDetail"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//        ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc] initWithNibName: nil bundle: nil];
//        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
//        elcPicker.maximumImagesCount = 20;
//        [albumController setParent:elcPicker];
//        [elcPicker setDelegate:self];
//        
//        [self.navigationController presentViewController:elcPicker animated:NO completion:nil];
//
//        
//    }
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(receiveTestNotification:)
//                                                 name:@"NewFileUploaded"
//                                               object:nil];
//    [self getPhotosFromAlbum];
}
- (void) receiveTestNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"NewFileUploaded"]) {         NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setInteger:([prefs integerForKey:@"numberNewPhoto"] + 1) forKey:@"numberNewPhoto"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [SVProgressHUD dismiss];
    timera=0;
    
    self.navigationController.navigationBarHidden = YES;

    self.view.backgroundColor = [UIColor blackColor];
    if([[UIScreen mainScreen]bounds].size.height<568)
    {
        
        switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
            case UIUserInterfaceIdiomPhone:
            {
                switch (self.interfaceOrientation) {
                    case UIInterfaceOrientationPortraitUpsideDown:
                    case UIDeviceOrientationPortrait:
                    {
                        sv1 = [[UIScrollView alloc] init];
                        sv1.frame = CGRectMake(0, 0, 320, 600);
                        
                        sv1.delegate=self;
                        [self.view addSubview:sv1];
                        
                        logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo@2x.png"]];
                        logo.frame = CGRectMake((320-406/2)/2, 80, 406/2, 182/2);
                        [sv1 addSubview:logo];
                        
                        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
                        
                        galleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        galleryButton.frame = CGRectMake((320-472/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 472/2, 79/2);
                        [galleryButton setBackgroundImage:[UIImage imageNamed:@"library@2x.png"] forState:UIControlStateNormal];
                        [galleryButton setTitle:@"Library" forState:UIControlStateNormal];
                        [galleryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [galleryButton addTarget:self action:@selector(gotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
                        //[self.view addSubview:galleryButton];
                        [sv1 addSubview:galleryButton];
                        
                        
                        importButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        importButton.frame = CGRectMake((320-472/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 472/2, 79/2);
                        [importButton setBackgroundImage:[UIImage imageNamed:@"import@2x.png"] forState:UIControlStateNormal];
                        [importButton addTarget:self action:@selector(importPhotos:) forControlEvents:UIControlEventTouchUpInside];
                        [importButton setTitle:@"Import" forState:UIControlStateNormal];
                        [importButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [sv1 addSubview:importButton];
                        
                        settings = [UIButton buttonWithType:UIButtonTypeCustom];
                        
                        if(IS_OS_7_OR_LATER)
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),20,50/2 ,51/2);
                        }
                        else
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),10,50/2 ,51/2);
                        }
                        
                        //settings.frame=CGRectMake((320-50/2-10),10,50/2 ,51/2);
                        [settings setBackgroundImage:[UIImage imageNamed:@"settings@2x.png"] forState:UIControlStateNormal];
                        [settings addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
                        [settings setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [self.view addSubview:settings];
                        
                        profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        profileButton.frame = CGRectMake((320-472/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 472/2, 79/2);
                        [profileButton setBackgroundImage:[UIImage imageNamed:@"profile-input@2x.png"] forState:UIControlStateNormal];
                        [profileButton addTarget:self action:@selector(gotoprofile:) forControlEvents:UIControlEventTouchUpInside];
                        [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
                        [profileButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        //  [self.view addSubview:profileButton];
                        [sv1 addSubview:profileButton];
                        
                        logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        logoutButton.frame = CGRectMake((320-472/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 472/2, 79/2);
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out1@2x.png"] forState:UIControlStateNormal];
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out@2x.png"] forState:UIControlStateHighlighted];
                        [logoutButton addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
                        //[self.view addSubview:logoutButton];
                        [sv1 addSubview:logoutButton];
                    }
                        break;
                    case UIInterfaceOrientationLandscapeLeft:
                    {
                        sv1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -80, [[UIScreen mainScreen]bounds].size.height, 315+80)];
                        sv1.scrollEnabled=YES;
                        [sv1 setDelegate:self];
                        [self.view addSubview:sv1];
                        
                        logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo@2x.png"]];
                        logo.frame = CGRectMake((sv1.frame.size.width-406/2)/2, 110, 406/2, 182/2);
                        [sv1 addSubview:logo];
                        
                        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
                        
                        galleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        galleryButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 472/2, 79/2);
                        [galleryButton setBackgroundImage:[UIImage imageNamed:@"library@2x.png"] forState:UIControlStateNormal];
                        [galleryButton setTitle:@"Library" forState:UIControlStateNormal];
                        [galleryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [galleryButton addTarget:self action:@selector(gotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
                        [sv1 addSubview:galleryButton];
                        
                        importButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        importButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 472/2, 79/2);
                        [importButton setBackgroundImage:[UIImage imageNamed:@"import@2x.png"] forState:UIControlStateNormal];
                        [importButton addTarget:self action:@selector(importPhotos:) forControlEvents:UIControlEventTouchUpInside];
                        [importButton setTitle:@"Import" forState:UIControlStateNormal];
                        [importButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [sv1 addSubview:importButton];
                        
                        settings = [UIButton buttonWithType:UIButtonTypeCustom];
                        
                        if(IS_OS_7_OR_LATER)
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),20,50/2 ,51/2);
                        }
                        else
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),10,50/2 ,51/2);
                        }
                        
                        //settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),10,50/2 ,51/2);
                        [settings setBackgroundImage:[UIImage imageNamed:@"settings@2x.png"] forState:UIControlStateNormal];
                        [settings addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
                        [settings setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [self.view addSubview:settings];
                        
                        profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        profileButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 472/2, 79/2);
                        [profileButton setBackgroundImage:[UIImage imageNamed:@"profile-input@2x.png"] forState:UIControlStateNormal];
                        [profileButton addTarget:self action:@selector(gotoprofile:) forControlEvents:UIControlEventTouchUpInside];
                        [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
                        [profileButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [sv1 addSubview:profileButton];
                        
                        logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        logoutButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 472/2, 79/2);
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out1@2x.png"] forState:UIControlStateNormal];
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out@2x.png"] forState:UIControlStateHighlighted];
                        [logoutButton addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
                        [sv1 addSubview:logoutButton];
                        
                        [sv1 setContentSize:CGSizeMake([[UIScreen mainScreen]bounds].size.height, 460)];
                        sv1.scrollEnabled=YES;
                        [sv1 scrollRectToVisible:CGRectMake(0, 265, sv1.frame.size.width, sv1.frame.size.height) animated:YES];
                    }
                        break;
                    case UIInterfaceOrientationLandscapeRight:
                    {
                        sv1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -80, [[UIScreen mainScreen]bounds].size.height, 315+80)];
                        sv1.scrollEnabled=YES;
                        [sv1 setDelegate:self];
                        [self.view addSubview:sv1];
                        
                        logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo@2x.png"]];
                        logo.frame = CGRectMake((sv1.frame.size.width-406/2)/2, 110, 406/2, 182/2);
                        [sv1 addSubview:logo];
                        
                        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
                        
                        galleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        galleryButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 472/2, 79/2);
                        [galleryButton setBackgroundImage:[UIImage imageNamed:@"library@2x.png"] forState:UIControlStateNormal];
                        [galleryButton setTitle:@"Library" forState:UIControlStateNormal];
                        [galleryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [galleryButton addTarget:self action:@selector(gotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
                        [sv1 addSubview:galleryButton];
                        
                        
                        importButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        importButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 472/2, 79/2);
                        [importButton setBackgroundImage:[UIImage imageNamed:@"import@2x.png"] forState:UIControlStateNormal];
                        [importButton addTarget:self action:@selector(importPhotos:) forControlEvents:UIControlEventTouchUpInside];
                        [importButton setTitle:@"Import" forState:UIControlStateNormal];
                        [importButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [sv1 addSubview:importButton];
                        
                        settings = [UIButton buttonWithType:UIButtonTypeCustom];
                        if(IS_OS_7_OR_LATER)
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),20,50/2 ,51/2);
                        }
                        else
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),10,50/2 ,51/2);
                        }
                        //settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),10,50/2 ,51/2);
                        [settings setBackgroundImage:[UIImage imageNamed:@"settings@2x.png"] forState:UIControlStateNormal];
                        [settings addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
                        [settings setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [self.view addSubview:settings];
                        
                        profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        profileButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 472/2, 79/2);
                        [profileButton setBackgroundImage:[UIImage imageNamed:@"profile-input@2x.png"] forState:UIControlStateNormal];
                        [profileButton addTarget:self action:@selector(gotoprofile:) forControlEvents:UIControlEventTouchUpInside];
                        [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
                        [profileButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [sv1 addSubview:profileButton];
                        
                        logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        logoutButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 472/2, 79/2);
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out1@2x.png"] forState:UIControlStateNormal];
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out@2x.png"] forState:UIControlStateHighlighted];
                        [logoutButton addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
                        [sv1 addSubview:logoutButton];
                        
                        [sv1 setContentSize:CGSizeMake([[UIScreen mainScreen]bounds].size.height, 460)];
                        sv1.scrollEnabled=YES;
                        [sv1 scrollRectToVisible:CGRectMake(0, 265, sv1.frame.size.width, sv1.frame.size.height) animated:YES];
                    }
                        break;
                }
                break;
            }
        }
    }
    else
    {
        switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
            case UIUserInterfaceIdiomPhone:
            {
                switch (self.interfaceOrientation) {
                        
                    case UIInterfaceOrientationPortraitUpsideDown:
                    case UIDeviceOrientationPortrait:
                    {
                        sv1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 36, 320, 600)];
                        [self.view addSubview:sv1];
                        [sv1 setDelegate:self];
                        
                        logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo@2x.png"]];
                        logo.frame = CGRectMake((sv1.frame.size.width-406/2)/2, 110, 406/2, 182/2);
                        [sv1 addSubview:logo];
                        
                        
                        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
                        
                        galleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        galleryButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 472/2, 79/2);
                        [galleryButton setBackgroundImage:[UIImage imageNamed:@"library@2x.png"] forState:UIControlStateNormal];
                        [galleryButton setTitle:@"Library" forState:UIControlStateNormal];
                        [galleryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [galleryButton addTarget:self action:@selector(gotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [sv1 addSubview:galleryButton];
                        
                        
                        importButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        importButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 472/2, 79/2);
                        [importButton setBackgroundImage:[UIImage imageNamed:@"import@2x.png"] forState:UIControlStateNormal];
                        [importButton addTarget:self action:@selector(importPhotos:) forControlEvents:UIControlEventTouchUpInside];
                        [importButton setTitle:@"Import" forState:UIControlStateNormal];
                        [importButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [sv1 addSubview:importButton];
                        
                        
                        settings = [UIButton buttonWithType:UIButtonTypeCustom];
                        if(IS_OS_7_OR_LATER)
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),20,50/2 ,51/2);
                        }
                        else
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),10,50/2 ,51/2);
                        }
                        
                        [settings setBackgroundImage:[UIImage imageNamed:@"settings@2x.png"] forState:UIControlStateNormal];
                        [settings addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
                        [settings setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [self.view addSubview:settings];
                        
                        profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        profileButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 472/2, 79/2);
                        [profileButton setBackgroundImage:[UIImage imageNamed:@"profile-input@2x.png"] forState:UIControlStateNormal];
                        [profileButton addTarget:self action:@selector(gotoprofile:) forControlEvents:UIControlEventTouchUpInside];
                        [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
                        [profileButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        //[self.view addSubview:profileButton];
                        [sv1 addSubview:profileButton];
                        
                        
                        logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        logoutButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 472/2, 79/2);
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out1@2x.png"] forState:UIControlStateNormal];
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out@2x.png"] forState:UIControlStateHighlighted];
                        [logoutButton addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [sv1 addSubview:logoutButton];
                        
                    }
                        break;
                        
                    case UIInterfaceOrientationLandscapeLeft:
                    {
                        
                        sv1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -80, [[UIScreen mainScreen]bounds].size.height, 315+80)];
                        sv1.scrollEnabled=YES;
                        [sv1 setDelegate:self];
                        [sv1 setContentSize:CGSizeMake([[UIScreen mainScreen]bounds].size.height, 800)];
                        [self.view addSubview:sv1];
                        
                        
                        logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo@2x.png"]];
                        logo.frame = CGRectMake((sv1.frame.size.width-406/2)/2, 110, 406/2, 182/2);
                        //[self.view addSubview:logo];
                        [sv1 addSubview:logo];
                        
                        
                        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
                        
                        
                        galleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        galleryButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 472/2, 79/2);
                        [galleryButton setBackgroundImage:[UIImage imageNamed:@"library@2x.png"] forState:UIControlStateNormal];
                        [galleryButton setTitle:@"Library" forState:UIControlStateNormal];
                        [galleryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [galleryButton addTarget:self action:@selector(gotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
                        //[self.view addSubview:galleryButton];
                        [sv1 addSubview:galleryButton];
                        
                        
                        importButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        importButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 472/2, 79/2);
                        [importButton setBackgroundImage:[UIImage imageNamed:@"import@2x.png"] forState:UIControlStateNormal];
                        [importButton addTarget:self action:@selector(importPhotos:) forControlEvents:UIControlEventTouchUpInside];
                        [importButton setTitle:@"Import" forState:UIControlStateNormal];
                        [importButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        //[self.view addSubview:importButton];
                        [sv1 addSubview:importButton];
                        
                        
                        settings = [UIButton buttonWithType:UIButtonTypeCustom];
                        if(IS_OS_7_OR_LATER)
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),20,50/2 ,51/2);
                        }
                        else
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),10,50/2 ,51/2);
                        }
                        
                        [settings setBackgroundImage:[UIImage imageNamed:@"settings@2x.png"] forState:UIControlStateNormal];
                        [settings addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
                        [settings setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [self.view addSubview:settings];
                        //[sv1 addSubview:settings];
                        
                        
                        
                        profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        profileButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 472/2, 79/2);
                        [profileButton setBackgroundImage:[UIImage imageNamed:@"profile-input@2x.png"] forState:UIControlStateNormal];
                        [profileButton addTarget:self action:@selector(gotoprofile:) forControlEvents:UIControlEventTouchUpInside];
                        [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
                        [profileButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        //[self.view addSubview:profileButton];
                        [sv1 addSubview:profileButton];
                        
                        
                        logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        logoutButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 472/2, 79/2);
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out1@2x.png"] forState:UIControlStateNormal];
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out@2x.png"] forState:UIControlStateHighlighted];
                        [logoutButton addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
                        //[self.view addSubview:logoutButton];
                        [sv1 addSubview:logoutButton];
                        
                        [sv1 setContentSize:CGSizeMake([[UIScreen mainScreen]bounds].size.height, 460)];
                        sv1.scrollEnabled=YES;
                        [sv1 scrollRectToVisible:CGRectMake(0, 265, sv1.frame.size.width, sv1.frame.size.height) animated:YES];
                    }
                        break;
                        
                    case UIInterfaceOrientationLandscapeRight:
                    {
                        sv1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -80, [[UIScreen mainScreen]bounds].size.height, 315+80)];
                        sv1.scrollEnabled=YES;
                        [self.view addSubview:sv1];
                        [sv1 setDelegate:self];
                        [sv1 setContentSize:CGSizeMake([[UIScreen mainScreen]bounds].size.height, 800)];
                        
                        logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo@2x.png"]];
                        logo.frame = CGRectMake((sv1.frame.size.width-406/2)/2, 110, 406/2, 182/2);
                        
                        [sv1 addSubview:logo];
                        
                        
                        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
                        
                        
                        galleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        galleryButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 472/2, 79/2);
                        [galleryButton setBackgroundImage:[UIImage imageNamed:@"library@2x.png"] forState:UIControlStateNormal];
                        [galleryButton setTitle:@"Library" forState:UIControlStateNormal];
                        [galleryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [galleryButton addTarget:self action:@selector(gotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
                        //[self.view addSubview:galleryButton];
                        [sv1 addSubview:galleryButton];
                        
                        
                        importButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        importButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 472/2, 79/2);
                        [importButton setBackgroundImage:[UIImage imageNamed:@"import@2x.png"] forState:UIControlStateNormal];
                        [importButton addTarget:self action:@selector(importPhotos:) forControlEvents:UIControlEventTouchUpInside];
                        [importButton setTitle:@"Import" forState:UIControlStateNormal];
                        [importButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        //[self.view addSubview:importButton];
                        [sv1 addSubview:importButton];
                        
                        
                        settings = [UIButton buttonWithType:UIButtonTypeCustom];
                        
                        if(IS_OS_7_OR_LATER)
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),20,50/2 ,51/2);
                        }
                        else
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),10,50/2 ,51/2);
                        }
                        
                        [settings setBackgroundImage:[UIImage imageNamed:@"settings@2x.png"] forState:UIControlStateNormal];
                        [settings addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
                        [settings setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [self.view addSubview:settings];
                        //[sv1 addSubview:settings];
                        
                        
                        
                        profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        profileButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 472/2, 79/2);
                        [profileButton setBackgroundImage:[UIImage imageNamed:@"profile-input@2x.png"] forState:UIControlStateNormal];
                        [profileButton addTarget:self action:@selector(gotoprofile:) forControlEvents:UIControlEventTouchUpInside];
                        [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
                        [profileButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        //[self.view addSubview:profileButton];
                        [sv1 addSubview:profileButton];
                        
                        
                        logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        logoutButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 472/2, 79/2);
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out1@2x.png"] forState:UIControlStateNormal];
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out@2x.png"] forState:UIControlStateHighlighted];
                        [logoutButton addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
                        //[self.view addSubview:logoutButton];
                        [sv1 addSubview:logoutButton];
                        
                        [sv1 setContentSize:CGSizeMake([[UIScreen mainScreen]bounds].size.height, 460)];
                        sv1.scrollEnabled=YES;
                        [sv1 scrollRectToVisible:CGRectMake(0, 265, sv1.frame.size.width, sv1.frame.size.height) animated:YES];
                        
                    }
                        break;
                    
                }
                break;
            }
            case UIUserInterfaceIdiomPad:
            {
                
                switch (self.interfaceOrientation)
                {
                    case UIInterfaceOrientationPortrait:
                    {
                        
                        sv1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 36, [[UIScreen mainScreen] bounds].size.width, 600)];
                        [self.view addSubview:sv1];
                        [sv1 setDelegate:self];
                        
                        logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo@2x.png"]];
                        logo.frame = CGRectMake((sv1.frame.size.width-406)/2, 110, 406, 182);
                        [sv1 addSubview:logo];
                        
                        
                        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]]];
                        
                        galleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        galleryButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 957/2, 102/2);
                        [galleryButton setBackgroundImage:[UIImage imageNamed:@"library-ipad@2x.png"] forState:UIControlStateNormal];
                        [galleryButton setTitle:@"Library" forState:UIControlStateNormal];
                        [galleryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [galleryButton addTarget:self action:@selector(gotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [sv1 addSubview:galleryButton];
                        
                        
                        importButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        importButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 957/2, 102/2);
                        [importButton setBackgroundImage:[UIImage imageNamed:@"import-ipad@2x.png"] forState:UIControlStateNormal];
                        [importButton addTarget:self action:@selector(importPhotos:) forControlEvents:UIControlEventTouchUpInside];
                        [importButton setTitle:@"Import" forState:UIControlStateNormal];
                        [importButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [sv1 addSubview:importButton];
                        
                        
                        settings = [UIButton buttonWithType:UIButtonTypeCustom];
                        //                            settings.frame=CGRectMake((sv1.frame.size.width-50),10,50 ,51);
                        if(IS_OS_7_OR_LATER)
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50-10),20,50 ,51);
                        }
                        else
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50-10),10,50 ,51);
                        }
                        [settings setBackgroundImage:[UIImage imageNamed:@"settings@2x.png"] forState:UIControlStateNormal];
                        [settings addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
                        [settings setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [self.view addSubview:settings];
                        
                        profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        profileButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 957/2, 102/2);
                        [profileButton setBackgroundImage:[UIImage imageNamed:@"profile-input-ipad@2x.png"] forState:UIControlStateNormal];
                        [profileButton addTarget:self action:@selector(gotoprofile:) forControlEvents:UIControlEventTouchUpInside];
                        [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
                        [profileButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        //[self.view addSubview:profileButton];
                        [sv1 addSubview:profileButton];
                        
                        
                        logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        logoutButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10,957/2, 102/2);
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out1.2.png"] forState:UIControlStateNormal];
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out1.1.png"] forState:UIControlStateHighlighted];
                        [logoutButton addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [sv1 addSubview:logoutButton];
                    }
                        break;
                    case UIInterfaceOrientationLandscapeLeft:
                    {
                        sv1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 36, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width)];
                        sv1.backgroundColor=[UIColor blackColor];
                        sv1.scrollEnabled=YES;
                        [self.view addSubview:sv1];
                        [sv1 setDelegate:self];
                        
                        logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo@2x.png"]];
                        logo.frame = CGRectMake((sv1.frame.size.width-406)/2, 110, 406, 182);
                        
                        [sv1 addSubview:logo];
                        
                        
                        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]]];
                        
                        galleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        galleryButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 957/2, 102/2);
                        [galleryButton setBackgroundImage:[UIImage imageNamed:@"library-ipad@2x.png"] forState:UIControlStateNormal];
                        [galleryButton setTitle:@"Library" forState:UIControlStateNormal];
                        [galleryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [galleryButton addTarget:self action:@selector(gotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
                        //[self.view addSubview:galleryButton];
                        [sv1 addSubview:galleryButton];
                        
                        
                        importButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        importButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 957/2, 102/2);
                        [importButton setBackgroundImage:[UIImage imageNamed:@"import-ipad@2x.png"] forState:UIControlStateNormal];
                        [importButton addTarget:self action:@selector(importPhotos:) forControlEvents:UIControlEventTouchUpInside];
                        [importButton setTitle:@"Import" forState:UIControlStateNormal];
                        [importButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        //[self.view addSubview:importButton];
                        [sv1 addSubview:importButton];
                        
                        
                        settings = [UIButton buttonWithType:UIButtonTypeCustom];
                        //                            settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),10,50/2 ,51/2);
                        if(IS_OS_7_OR_LATER)
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50-10),20,50 ,51);
                        }
                        else
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50-10),10,50 ,51);
                        }
                        [settings setBackgroundImage:[UIImage imageNamed:@"settings@2x.png"] forState:UIControlStateNormal];
                        [settings addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
                        [settings setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [self.view addSubview:settings];
                        //[sv1 addSubview:settings];
                        
                        
                        
                        profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        profileButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 957/2, 102/2);
                        [profileButton setBackgroundImage:[UIImage imageNamed:@"profile-input-ipad@2x.png"] forState:UIControlStateNormal];
                        [profileButton addTarget:self action:@selector(gotoprofile:) forControlEvents:UIControlEventTouchUpInside];
                        [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
                        [profileButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        //[self.view addSubview:profileButton];
                        [sv1 addSubview:profileButton];
                        
                        
                        logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        logoutButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 957/2, 102/2);
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out1.2.png"] forState:UIControlStateNormal];
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out1.1.png"] forState:UIControlStateHighlighted];
                        [logoutButton addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
                        //[self.view addSubview:logoutButton];
                        [sv1 addSubview:logoutButton];
                    }
                        break;
                    case UIInterfaceOrientationLandscapeRight:
                    {
                        sv1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 36, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width)];
                        sv1.backgroundColor=[UIColor blackColor];
                        sv1.scrollEnabled=YES;
                        [self.view addSubview:sv1];
                        [sv1 setDelegate:self];
                        
                        logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo@2x.png"]];
                        logo.frame = CGRectMake((sv1.frame.size.width-406)/2, 110, 406, 182);
                        
                        [sv1 addSubview:logo];
                        
                        
                        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]]];
                        
                        
                        galleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        galleryButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 957/2, 102/2);
                        [galleryButton setBackgroundImage:[UIImage imageNamed:@"library-ipad@2x.png"] forState:UIControlStateNormal];
                        [galleryButton setTitle:@"Library" forState:UIControlStateNormal];
                        [galleryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [galleryButton addTarget:self action:@selector(gotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
                        //[self.view addSubview:galleryButton];
                        [sv1 addSubview:galleryButton];
                        
                        
                        importButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        importButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 957/2, 102/2);
                        [importButton setBackgroundImage:[UIImage imageNamed:@"import-ipad@2x.png"] forState:UIControlStateNormal];
                        [importButton addTarget:self action:@selector(importPhotos:) forControlEvents:UIControlEventTouchUpInside];
                        [importButton setTitle:@"Import" forState:UIControlStateNormal];
                        [importButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        //[self.view addSubview:importButton];
                        [sv1 addSubview:importButton];
                        
                        
                        settings = [UIButton buttonWithType:UIButtonTypeCustom];
                        //                            settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),10,50/2 ,51/2);
                        if(IS_OS_7_OR_LATER)
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50-10),20,50 ,51);
                        }
                        else
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50-10),10,50 ,51);
                        }
                        [settings setBackgroundImage:[UIImage imageNamed:@"settings@2x.png"] forState:UIControlStateNormal];
                        [settings addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
                        [settings setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [self.view addSubview:settings];
                        //[sv1 addSubview:settings];
                        
                        
                        
                        profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        profileButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 957/2, 102/2);
                        [profileButton setBackgroundImage:[UIImage imageNamed:@"profile-input-ipad@2x.png"] forState:UIControlStateNormal];
                        [profileButton addTarget:self action:@selector(gotoprofile:) forControlEvents:UIControlEventTouchUpInside];
                        [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
                        [profileButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        //[self.view addSubview:profileButton];
                        [sv1 addSubview:profileButton];
                        
                        
                        logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        logoutButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 957/2, 102/2);
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out1.2.png"] forState:UIControlStateNormal];
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out1.1.png"] forState:UIControlStateHighlighted];
                        [logoutButton addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
                        //[self.view addSubview:logoutButton];
                        [sv1 addSubview:logoutButton];
                    }
                        break;
                    case UIInterfaceOrientationPortraitUpsideDown:
                    {
                        sv1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 36, [[UIScreen mainScreen]bounds].size.width, 600)];
                        [self.view addSubview:sv1];
                        [sv1 setDelegate:self];
                        
                        logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo@2x.png"]];
                        logo.frame = CGRectMake((sv1.frame.size.width-406)/2, 110, 406, 182);
                        [sv1 addSubview:logo];
                        
                        
                        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]]];
                        
                        galleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        galleryButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 957/2, 102/2);
                        [galleryButton setBackgroundImage:[UIImage imageNamed:@"library-ipad@2x.png"] forState:UIControlStateNormal];
                        [galleryButton setTitle:@"Library" forState:UIControlStateNormal];
                        [galleryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [galleryButton addTarget:self action:@selector(gotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [sv1 addSubview:galleryButton];
                        
                        
                        importButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        importButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 957/2, 102/2);
                        [importButton setBackgroundImage:[UIImage imageNamed:@"import-ipad@2x.png"] forState:UIControlStateNormal];
                        [importButton addTarget:self action:@selector(importPhotos:) forControlEvents:UIControlEventTouchUpInside];
                        [importButton setTitle:@"Import" forState:UIControlStateNormal];
                        [importButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [sv1 addSubview:importButton];
                        
                        
                        settings = [UIButton buttonWithType:UIButtonTypeCustom];
                        //                            settings.frame=CGRectMake((sv1.frame.size.width-50),10,50/2 ,51/2);
                        if(IS_OS_7_OR_LATER)
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50-10),20,50 ,51);
                        }
                        else
                        {
                            settings.frame=CGRectMake((sv1.frame.size.width-50-10),10,50 ,51);
                        }
                        [settings setBackgroundImage:[UIImage imageNamed:@"settings@2x.png"] forState:UIControlStateNormal];
                        [settings addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
                        [settings setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [self.view addSubview:settings];
                        
                        profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        profileButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 957/2, 102/2);
                        [profileButton setBackgroundImage:[UIImage imageNamed:@"profile-input-ipad@2x.png"] forState:UIControlStateNormal];
                        [profileButton addTarget:self action:@selector(gotoprofile:) forControlEvents:UIControlEventTouchUpInside];
                        [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
                        [profileButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        //[self.view addSubview:profileButton];
                        [sv1 addSubview:profileButton];
                        
                        
                        
                        logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        logoutButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 957/2, 102/2);
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out1.2.png"] forState:UIControlStateNormal];
                        [logoutButton setBackgroundImage:[UIImage imageNamed:@"log-out1.1.png"] forState:UIControlStateHighlighted];
                        [logoutButton addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [sv1 addSubview:logoutButton];
                    }
                        break;
                }
                break;
            }
                break;
                
        }
    }
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(delegate.libopen)
    {
//        ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc] initWithNibName: nil bundle: nil];
//        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
//        elcPicker.maximumImagesCount = 20;
//        [albumController setParent:elcPicker];
//        [elcPicker setDelegate:self];
//        
//        [self.navigationController presentViewController:elcPicker animated:YES completion:nil];
    }

//    [self getAllAssets];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    
}

- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(device.orientation)
            {
                    
                case UIDeviceOrientationPortraitUpsideDown:
                case UIDeviceOrientationPortrait:
                {
                    if([[UIScreen mainScreen]bounds].size.height>500)
                    {
                        sv1.frame = CGRectMake(0, 36, 320, 600);
                        
                        [UIView animateWithDuration:1.0
                                         animations:^{
                                             [sv1 setContentOffset:CGPointZero  animated:NO];
                                             sv1.scrollEnabled=NO;
                                             logo.frame = CGRectMake((sv1.frame.size.width-406/2)/2, 110, 406/2, 182/2);
                                           
                                             galleryButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 472/2, 79/2);
                                             
                                             importButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 472/2, 79/2);
                                            
                                             profileButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 472/2, 79/2);
                                             
                                             logoutButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 472/2, 79/2);
                                             if(IS_OS_7_OR_LATER)
                                             {
                                                 settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),20,50/2 ,51/2);
                                             }
                                             else
                                             {
                                                 settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),10,50/2 ,51/2);
                                             }
                                         }
                                         completion:^(BOOL finished){ }];
                    }
                    else
                    {
                        sv1.frame = CGRectMake(0, 0, 320, 600);
                        
                        [UIView animateWithDuration:1.0
                                         animations:^{
                                             [sv1 setContentOffset:CGPointZero  animated:NO];
                                             sv1.scrollEnabled=NO;
                                             logo.frame = CGRectMake((sv1.frame.size.width-406/2)/2, 110, 406/2, 182/2);
                                           
                                             galleryButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 472/2, 79/2);
                                             
                                             importButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 472/2, 79/2);
                                             
                                             profileButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 472/2, 79/2);
                                             
                                             logoutButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 472/2, 79/2);
                                             
                                             settings.frame= CGRectMake((sv1.frame.size.width-50/2-10),10,50/2 ,51/2);
                                         }
                                         completion:^(BOOL finished){ }];
                    }
                    
                    
                    
                    
                    
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                case UIDeviceOrientationLandscapeRight:
                {
                    sv1.frame = CGRectMake(0, -80, [[UIScreen mainScreen]bounds].size.height, 315+80);
                    settings.frame= CGRectMake(([[UIScreen mainScreen]bounds].size.height-50/2-10),10,50/2 ,51/2);
                    
                    [sv1 setContentSize:CGSizeMake([[UIScreen mainScreen]bounds].size.height, 460)];
                    sv1.scrollEnabled=YES;
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         
                                         if([[UIScreen mainScreen]bounds].size.height>500)
                                         {
                                             logo.frame = CGRectMake((sv1.frame.size.width-406/2)/2, 110, 406/2, 182/2);
                                             
                                             galleryButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 472/2, 79/2);
                                             
                                             importButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 472/2, 79/2);
                                             profileButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 472/2, 79/2);
                                             logoutButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 472/2, 79/2);
                                             
                                             [sv1 scrollRectToVisible:CGRectMake(0, 265, sv1.frame.size.width, sv1.frame.size.height) animated:YES];
                                             
                                             if(IS_OS_7_OR_LATER)
                                             {
                                                 settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),20,50/2 ,51/2);
                                             }
                                             else
                                             {
                                                 settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),10,50/2 ,51/2);
                                             }
                                             
                                             
                                         }
                                         else
                                         {
                                             logo.frame = CGRectMake((sv1.frame.size.width-406/2)/2, 110, 406/2, 182/2);
                                             galleryButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 472/2, 79/2);
                                             importButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 472/2, 79/2);
                                             profileButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 472/2, 79/2);
                                          
                                             logoutButton.frame = CGRectMake((sv1.frame.size.width-472/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 472/2, 79/2);
                                             
                                             [sv1 setContentSize:CGSizeMake([[UIScreen mainScreen]bounds].size.height, 500)];
                                             
                                             if(IS_OS_7_OR_LATER)
                                             {
                                                 settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),20,50/2 ,51/2);
                                             }
                                             else
                                             {
                                                 settings.frame=CGRectMake((sv1.frame.size.width-50/2-10),10,50/2 ,51/2);
                                             }
                                         }
                                     }
                                     completion:^(BOOL finished){
                                     }];
                }
                    break;
            };
        }
            break;
        case UIUserInterfaceIdiomPad:
        {
            switch(device.orientation)
            {
                case UIDeviceOrientationUnknown:
                case UIDeviceOrientationFaceDown:
                case UIDeviceOrientationFaceUp:
                case UIDeviceOrientationPortraitUpsideDown:
                case UIDeviceOrientationPortrait:
                {
                    sv1.frame = CGRectMake(0, 36, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
                    //                    settings.frame= CGRectMake((sv1.frame.size.width-50-10),10,50 ,51);
                    if(IS_OS_7_OR_LATER)
                    {
                        settings.frame=CGRectMake((sv1.frame.size.width-50-10),20,50 ,51);
                    }
                    else
                    {
                        settings.frame=CGRectMake((sv1.frame.size.width-50-10),10,50 ,51);
                    }
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         [sv1 setContentOffset:CGPointZero  animated:NO];
                                         sv1.scrollEnabled=NO;
                                         logo.frame = CGRectMake((sv1.frame.size.width-406)/2, 110, 406, 182);
                                         
                                         galleryButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 957/2, 102/2);
                                         importButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 957/2, 102/2);
                                         profileButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 957/2, 102/2);
                                         
                                         logoutButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 957/2, 102/2);
                                         
                                         
                                         
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                case  UIDeviceOrientationLandscapeLeft:
                case UIDeviceOrientationLandscapeRight:
                {
                    sv1.frame = CGRectMake(0, 36, [[UIScreen mainScreen]bounds].size.height, 600);
                    //                    settings.frame= CGRectMake(([[UIScreen mainScreen]bounds].size.height-50-10),10,50 ,51);
                    if(IS_OS_7_OR_LATER)
                    {
                        settings.frame=CGRectMake((sv1.frame.size.width-50-10),20,50 ,51);
                    }
                    else
                    {
                        settings.frame=CGRectMake((sv1.frame.size.width-50-10),10,50 ,51);
                    }
                    
                    [sv1 setContentSize:CGSizeMake([[UIScreen mainScreen]bounds].size.height, 800)];
                    sv1.scrollEnabled=YES;
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         [sv1 setContentOffset:CGPointMake(0, 110)  animated:NO];
                                         logo.frame = CGRectMake((sv1.frame.size.width-406)/2, 110, 406, 182);
                                         
                                         galleryButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, logo.frame.origin.y+logo.frame.size.height+50, 957/2, 102/2);
                                        importButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, galleryButton.frame.origin.y+galleryButton.frame.size.height+10, 957/2, 102/2);
                                         profileButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, importButton.frame.origin.y+importButton.frame.size.height+10, 957/2, 102/2);
                                        logoutButton.frame = CGRectMake((sv1.frame.size.width-957/2)/2, profileButton.frame.origin.y+profileButton.frame.size.height+10, 957/2, 102/2);
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                    
            };
        }
            break;
        default:
            break;
    }
}


- (void)importPhotos:(id)sender {
    
    [self performSelector:@selector(stopTimer) withObject:nil afterDelay:3.1f];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
//    progressBar = [[KOAProgressBar alloc] initWithFrame:CGRectMake(20.0, screenHeight-40, 280.0, 10.0)];
//    [progressBar setMinValue:0.0];
//	[progressBar setMaxValue:1.0];
//	[progressBar setRealProgress:0.25];
//	[progressBar setDisplayedWhenStopped:NO];
//	[progressBar setAnimationDuration:3.5f];
//	[progressBar startAnimation:self];
//    [progressBar setProgress:0];
//      [self.view addSubview:progressBar];
    
//    [sv1 addSubview:progressBar];
    
    //    if (_timer == nil)
    //    {
    //        _timer = [NSTimer scheduledTimerWithTimeInterval:1.5f
    //                                                  target:self
    //                                                selector:@selector(stopTimer)
    //                                                userInfo:nil
    //                                                 repeats:NO];
    //    }
    
    _progressBarRoundedSlim =[[YLProgressBar alloc]init];
    _progressBarRoundedSlim.progressTintColor =[UIColor colorWithRed:98/255.0f green:146/255.0f blue:178/255.0f alpha:1.0f];
    //[UIColor colorWithRed:239/255.0f green:25/255.0f blue:13/255.0f alpha:1.0f];
    _progressBarRoundedSlim.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeTrack;
    _progressBarRoundedSlim.stripesColor             = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.36f];
    [self.view addSubview:_progressBarRoundedSlim];
    _progressBarRoundedSlim.frame=CGRectMake(20.0, self.view.bounds.size.height-40, self.view.bounds.size.width - 40, 10.0);
//    [_progressBarRoundedSlim setProgress:progress animated:animated];
    timerr = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:YES];

}

-(void)targetMethod: (NSTimer *)timer
{
    timera=timera+1;
    [self setProgress:0.33f*timera animated:YES];

}

- (void)setProgress:(CGFloat)progressing animated:(BOOL)animated
{
    [_progressBarRoundedSlim setProgress:progressing animated:animated];
}


- (void)stopTimer
{
    [timerr invalidate];
    //    if (_timer != nil)
    //    {
    //        [_timer invalidate];
    //        _timer = nil;
    //    }
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    AccountViewController *control1 = [[AccountViewController alloc] init];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
}

- (void)_timerFired
{
    progress = (0.1 + progress);
    [progressBar setProgress:progress];
    if (progress >= 1.0f) {
        [self stopTimer];
    }
}
- (void)gotoprofile:(id)sender {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    NewProfileViewController *control1 = [[NewProfileViewController alloc] init];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
}
-(void)set:(id)sender{
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    SetViewController *sss = [[SetViewController alloc] initWithNibName:@"SetViewController" bundle:nil];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:sss animated:NO];
    
}
- (void)logoutUser:(id)sender {
    int index;
    NSArray* arr = [[NSArray alloc] initWithArray:self.navigationController.viewControllers];
    for(int i=0 ; i<[arr count] ; i++)
    {
        if([[arr objectAtIndex:i] isKindOfClass:NSClassFromString(@"LoginViewController")])
        {
            index = i;
        }
    }
    [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"isloggedin"];

    LoginViewController *log = [[LoginViewController alloc] init];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:log animated:YES];
}
- (void)gotoLibrary:(id)sender {
    delegate.libopen = YES;
    //    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    //    self.specialLibrary = library;
    //    NSMutableArray *groups = [NSMutableArray array];
    //    [_specialLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
    //        if (group) {
    //            [groups addObject:group];
    //        } else {
    //            // this is the end
    //            [self displayPickerForGroup:[groups objectAtIndex:0]];
    //        }
    //    } failureBlock:^(NSError *error) {
    //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    //        [alert show];
    //
    //        NSLog(@"A problem occured %@", [error description]);
    //
    //    }];
    
//    ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc] initWithNibName: nil bundle: nil];
//	ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
//    elcPicker.maximumImagesCount = 20;
//    [albumController setParent:elcPicker];
//	[elcPicker setDelegate:self];
//    
//    [self.navigationController presentViewController:elcPicker animated:YES completion:nil];
    
    RootViewController *root = [[RootViewController alloc]init];
    [self.navigationController pushViewController:root animated:NO];
}

- (void)displayPickerForGroup:(ALAssetsGroup *)group
{
//	ELCAssetTablePicker *tablePicker = [[ELCAssetTablePicker alloc] initWithNibName: nil bundle: nil];
//    tablePicker.singleSelection = YES;
//    tablePicker.immediateReturn = YES;
//    
//	ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
//    elcPicker.maximumImagesCount = 1;
//    elcPicker.delegate = self;
//	tablePicker.parent = elcPicker;
//    
//    // Move me
//    tablePicker.assetGroup = group;
//    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];
//    
//    [self presentViewController:elcPicker animated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    }
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
//    if([info count]>0)
//    {
//        delegate.libopen = NO;
//        ImageDetailViewController *image_detail = [[ImageDetailViewController alloc] init];
//        image_detail.image_data_from_library = [NSMutableArray arrayWithCapacity:[info count]];
//        image_detail.url_of_images = [[NSMutableArray alloc] init];
//        
//        for(NSDictionary *dict in info) {
//            UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
//            
//            [image_detail.url_of_images addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:UIImagePickerControllerReferenceURL]]];
//            [image_detail.image_data_from_library addObject:image];
//            
//        }
//        image_detail.imgtypestatic=NO;
//        image_detail.selected_image = [[UIImage alloc] init];
//        image_detail.selected_image = (UIImage *)[image_detail.image_data_from_library objectAtIndex:0];
//        image_detail.url_of_image = [image_detail.url_of_images objectAtIndex:0];
//        image_detail.tag = 0;
//
//        CATransition* transition = [CATransition animation];
//        transition.duration = 0.5;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.type = kCATransitionFade;
//        
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//            [self.navigationController.view.layer addAnimation:transition forKey:nil];
//            [self.navigationController pushViewController:image_detail animated:YES];
//        }];
//    }
//    else
//    {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    //    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
//    [self.view removeFromSuperview];
}
@end