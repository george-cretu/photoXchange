//
//  imageViewerViewController.m
//  Photoapp
//
//  Created by Soumalya on 13/06/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import "imageViewerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "SVProgressHUD.h"
#import <DropboxSDK/DropboxSDK.h>
#import <stdlib.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import <Twitter/Twitter.h>
#import "AppDelegate.h"

@interface imageViewerViewController ()<GPPShareDelegate,GPPDeepLinkDelegate,UIAlertViewDelegate>
{
    UIImageView *buttonusertrouble;
    UILabel *headerlabel;
    UIButton *backButton;
    UIScrollView *parent_scroll;
    UIImageView *bar_white;
    UIButton *copy_folder_btn;
    UIButton *share_folder_btn;
    UIButton *move_folder_btn;
    UIButton *delete_folder_btn;
    UIButton *share_btn;
    NSString *returnString_gimg;
    UIAlertView *alert;
}

@end
@implementation imageViewerViewController

@synthesize fullImage = _fullImage;
@synthesize image_data_from_library,imgtypestatic,pics_data;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"yo yo imageviewer class");
    
    screenRect = [[UIScreen mainScreen] bounds];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    
    
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
                    [self.view addSubview:buttonusertrouble];
                    
                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10.5, 320, 25)];
                    [headerlabel setTextColor:[UIColor whiteColor]];
                    [headerlabel setBackgroundColor:[UIColor clearColor]];
                    [headerlabel setText:@"Image Detail"];
                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
                    headerlabel.textAlignment = NSTextAlignmentCenter;
                    [self.view addSubview:headerlabel];
                    
                    backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
                    [backButton addSubview:arrow_img];
                    [backButton addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:backButton];
                    
                    share_btn = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-90, 10.75, 110, 20)];
                    [share_btn setTitle:@"Share" forState:UIControlStateNormal];
                    [share_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [share_btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateSelected];
                    [share_btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
                    // [share_btn setBackgroundImage:[UIImage imageNamed:@"back-up@2x.png"] forState:UIControlStateNormal];
                    [share_btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:share_btn];
                    
                    parent_scroll  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, 320, [[UIScreen mainScreen] bounds].size.height-45)];
                    parent_scroll.delegate=self;
                    parent_scroll.backgroundColor = [UIColor clearColor];
                    parent_scroll.scrollEnabled=NO;
                    [self.view addSubview:parent_scroll];
                    
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 45)];
                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
                    [self.view addSubview:buttonusertrouble];
                    
                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10.5, [[UIScreen mainScreen] bounds].size.height, 25)];
                    [headerlabel setTextColor:[UIColor whiteColor]];
                    [headerlabel setBackgroundColor:[UIColor clearColor]];
                    [headerlabel setText:@"Image Detail"];
                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
                    headerlabel.textAlignment = NSTextAlignmentCenter;
                    [self.view addSubview:headerlabel];
                    
                    backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
                    [backButton addSubview:arrow_img];
                    [backButton addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:backButton];
                    
                    share_btn = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-90, 10.75, 110, 20)];
                    [share_btn setTitle:@"Share" forState:UIControlStateNormal];
                    [share_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [share_btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateSelected];
                    [share_btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
                    [share_btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:share_btn];
                    
                    parent_scroll  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-45)];
                    parent_scroll.delegate=self;
                    parent_scroll.backgroundColor = [UIColor clearColor];
                    parent_scroll.scrollEnabled=YES;
                    [parent_scroll setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width+300)];
                    [self.view addSubview:parent_scroll];
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 45)];
                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
                    [self.view addSubview:buttonusertrouble];
                    
                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10.5, [[UIScreen mainScreen] bounds].size.height, 25)];
                    [headerlabel setTextColor:[UIColor whiteColor]];
                    [headerlabel setBackgroundColor:[UIColor clearColor]];
                    [headerlabel setText:@"Image Detail"];
                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
                    headerlabel.textAlignment = NSTextAlignmentCenter;
                    [self.view addSubview:headerlabel];
                    
                    backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
                    [backButton addSubview:arrow_img];
                    [backButton addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:backButton];
                    
                    share_btn = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-90, 10.75, 110, 20)];
                    [share_btn setTitle:@"Share" forState:UIControlStateNormal];
                    [share_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [share_btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateSelected];
                    [share_btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
                    [share_btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:share_btn];
                    
                    parent_scroll  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-45)];
                    parent_scroll.delegate=self;
                    parent_scroll.backgroundColor = [UIColor clearColor];
                    parent_scroll.scrollEnabled=YES;
                    [parent_scroll setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width+300)];
                    [self.view addSubview:parent_scroll];
                    
                }
                    break;
            }
        }
        case UIUserInterfaceIdiomPad:
        {
            switch (self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 45)];
                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar@2x.png"];
                    [self.view addSubview:buttonusertrouble];
                    
                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10.5, [[UIScreen mainScreen] bounds].size.width, 25)];
                    [headerlabel setTextColor:[UIColor whiteColor]];
                    [headerlabel setBackgroundColor:[UIColor clearColor]];
                    [headerlabel setText:@"Image Detail"];
                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
                    headerlabel.textAlignment = NSTextAlignmentCenter;
                    [self.view addSubview:headerlabel];
                    
                    backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
                    [backButton addSubview:arrow_img];
                    [backButton addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:backButton];
                    
                    share_btn = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-90, 10.75, 110, 20)];
                    [share_btn setTitle:@"Share" forState:UIControlStateNormal];
                    [share_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [share_btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateSelected];
                    [share_btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
                    // [share_btn setBackgroundImage:[UIImage imageNamed:@"back-up@2x.png"] forState:UIControlStateNormal];
                    [share_btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:share_btn];
                    
                    parent_scroll  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-45)];
                    parent_scroll.delegate=self;
                    parent_scroll.backgroundColor = [UIColor clearColor];
                    parent_scroll.scrollEnabled=NO;
                    [self.view addSubview:parent_scroll];
                    
                }
                    break;
                    
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 45)];
                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar@2x.png"];
                    [self.view addSubview:buttonusertrouble];
                    
                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10.5, [[UIScreen mainScreen] bounds].size.width, 25)];
                    [headerlabel setTextColor:[UIColor whiteColor]];
                    [headerlabel setBackgroundColor:[UIColor clearColor]];
                    [headerlabel setText:@"Image Detail"];
                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
                    headerlabel.textAlignment = NSTextAlignmentCenter;
                    [self.view addSubview:headerlabel];
                    
                    backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
                    [backButton addSubview:arrow_img];
                    [backButton addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:backButton];
                    
                    share_btn = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-90, 10.75, 110, 20)];
                    [share_btn setTitle:@"Share" forState:UIControlStateNormal];
                    [share_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [share_btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateSelected];
                    [share_btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
                    // [share_btn setBackgroundImage:[UIImage imageNamed:@"back-up@2x.png"] forState:UIControlStateNormal];
                    [share_btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:share_btn];
                    
                    parent_scroll  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-45)];
                    parent_scroll.delegate=self;
                    parent_scroll.backgroundColor = [UIColor clearColor];
                    parent_scroll.scrollEnabled=NO;
                    [self.view addSubview:parent_scroll];
                    
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 45)];
                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
                    [self.view addSubview:buttonusertrouble];
                    
                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10.5, [[UIScreen mainScreen] bounds].size.height, 25)];
                    [headerlabel setTextColor:[UIColor whiteColor]];
                    [headerlabel setBackgroundColor:[UIColor clearColor]];
                    [headerlabel setText:@"Image Detail"];
                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
                    headerlabel.textAlignment = NSTextAlignmentCenter;
                    [self.view addSubview:headerlabel];
                    
                    backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
                    [backButton addSubview:arrow_img];
                    [backButton addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:backButton];
                    
                    share_btn = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.height-90, 10.75, 110, 20)];
                    [share_btn setTitle:@"Share" forState:UIControlStateNormal];
                    [share_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [share_btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateSelected];
                    [share_btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
                    [share_btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:share_btn];
                    
                    parent_scroll  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-45)];
                    parent_scroll.delegate=self;
                    parent_scroll.backgroundColor = [UIColor clearColor];
                    parent_scroll.scrollEnabled=YES;
                    [parent_scroll setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width+300)];
                    [self.view addSubview:parent_scroll];
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 45)];
                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
                    [self.view addSubview:buttonusertrouble];
                    
                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10.5, [[UIScreen mainScreen] bounds].size.height, 25)];
                    [headerlabel setTextColor:[UIColor whiteColor]];
                    [headerlabel setBackgroundColor:[UIColor clearColor]];
                    [headerlabel setText:@"Image Detail"];
                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
                    headerlabel.textAlignment = NSTextAlignmentCenter;
                    [self.view addSubview:headerlabel];
                    
                    backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
                    [backButton addSubview:arrow_img];
                    [backButton addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:backButton];
                    
                    share_btn = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.height-90, 10.75, 110, 20)];
                    [share_btn setTitle:@"Share" forState:UIControlStateNormal];
                    [share_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [share_btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateSelected];
                    [share_btn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
                    [share_btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:share_btn];
                    
                    parent_scroll  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-45)];
                    parent_scroll.delegate=self;
                    parent_scroll.backgroundColor = [UIColor clearColor];
                    parent_scroll.scrollEnabled=YES;
                    [parent_scroll setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width+300)];
                    [self.view addSubview:parent_scroll];
                    
                }
                    break;
            }
        }
            break;
    }
    shareviadropbox = NO;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
    
}

- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch ([[UIDevice currentDevice] userInterfaceIdiom])
    {
        case UIUserInterfaceIdiomPhone:
        {
            switch(device.orientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, 320, 45);
                    headerlabel.frame = CGRectMake(90,10.5, 170, 25);
                    parent_scroll.frame = CGRectMake(0, 45, 320, [[UIScreen mainScreen] bounds].size.height-45);
                    share_btn.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width-90, 10.75, 110, 20);
                    parent_scroll.scrollEnabled=NO;
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         imageContainer.backgroundColor = [UIColor clearColor];
                                         imageContainer.frame = CGRectMake(0, 0, 320, 250);
                                         [parent_scroll setContentOffset:CGPointZero  animated:NO];
                                         imageContainer.contentMode=UIViewContentModeScaleAspectFit;
                                         pic_scroll.frame= CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+114/2, [[UIScreen mainScreen] bounds].size.height,150);
                                         //                                 nav_bar.frame = CGRectMake(0, imageContainer.frame.size.height+imageContainer.frame.origin.y, [[UIScreen mainScreen] bounds].size.width, 114/2);
                                         //                                 bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 114/2);
                                         //                                 copy_folder_btn.frame =CGRectMake(0, 0, 75, 114/2);
                                         //                                 share_folder_btn.frame = CGRectMake(80.5, 0, 75, 114/2);
                                         //                                 move_folder_btn.frame = CGRectMake(80.5*2, 0, 75, 114/2);
                                         //                                 delete_folder_btn.frame = CGRectMake(80.5*3, 0, 75, 114/2);
                                         
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                    
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, 320, 45);
                    headerlabel.frame = CGRectMake(90,10.5, 170, 25);
                    parent_scroll.frame = CGRectMake(0, 45, 320, [[UIScreen mainScreen] bounds].size.height-45);
                    share_btn.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width-90, 10.75, 110, 20);
                    parent_scroll.scrollEnabled=NO;
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         imageContainer.backgroundColor = [UIColor clearColor];
                                         imageContainer.frame = CGRectMake(0, 0, 320, 250);
                                         [parent_scroll setContentOffset:CGPointZero  animated:NO];
                                         imageContainer.contentMode=UIViewContentModeScaleAspectFit;
                                         pic_scroll.frame= CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+114/2, [[UIScreen mainScreen] bounds].size.height,150);
                                         //                                 nav_bar.frame = CGRectMake(0, imageContainer.frame.size.height+imageContainer.frame.origin.y, [[UIScreen mainScreen] bounds].size.width, 114/2);
                                         //                                 bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 114/2);
                                         //                                 copy_folder_btn.frame =CGRectMake(0, 0, 75, 114/2);
                                         //                                 share_folder_btn.frame = CGRectMake(80.5, 0, 75, 114/2);
                                         //                                 move_folder_btn.frame = CGRectMake(80.5*2, 0, 75, 114/2);
                                         //                                 delete_folder_btn.frame = CGRectMake(80.5*3, 0, 75, 114/2);
                                         
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                    
                case UIDeviceOrientationLandscapeRight:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake([[UIScreen mainScreen]bounds].size.height-350,10.5, 170, 25);
                    parent_scroll.frame = CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-45);
                    [parent_scroll setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width+150)];
                    share_btn.frame = CGRectMake([[UIScreen mainScreen] bounds].size.height-110, 10.75, 110, 20);
                    parent_scroll.scrollEnabled=YES;
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         imageContainer.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-250)/2+70, 0, 300, 250);
                                         [parent_scroll setContentOffset:CGPointZero  animated:NO];
                                         //                                 nav_bar.frame = CGRectMake(0, imageContainer.frame.size.height+imageContainer.frame.origin.y, [[UIScreen mainScreen] bounds].size.height, 114/2);
                                         pic_scroll.frame= CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+114/2, [[UIScreen mainScreen] bounds].size.height,150);
                                         //                                 bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 114/2);
                                         //                                 copy_folder_btn.frame =CGRectMake(20, 0, 75, 114/2);
                                         //                                 share_folder_btn.frame = CGRectMake(80.5+90, 0, 75, 114/2);
                                         //                                 move_folder_btn.frame = CGRectMake(80.5*2+150, 0, 75, 114/2);
                                         //                                 delete_folder_btn.frame = CGRectMake(80.5*3+210, 0, 75, 114/2);
                                         //                                 //imageContainer.contentMode=UIViewContentModeCenter;
                                         
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake([[UIScreen mainScreen]bounds].size.height-350,10.5, 170, 25);
                    parent_scroll.frame = CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-45);
                    [parent_scroll setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width+150)];
                    share_btn.frame = CGRectMake([[UIScreen mainScreen] bounds].size.height-110, 10.75, 110, 20);
                    parent_scroll.scrollEnabled=YES;
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         imageContainer.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-300)/2+70, 0, 300, 250);
                                         [parent_scroll setContentOffset:CGPointZero  animated:NO];
                                         //                                 nav_bar.frame = CGRectMake(0, imageContainer.frame.size.height+imageContainer.frame.origin.y, [[UIScreen mainScreen] bounds].size.height, 114/2);
                                         pic_scroll.frame= CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+114/2, [[UIScreen mainScreen] bounds].size.height,150);
                                         //                                 bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 114/2);
                                         //                                 copy_folder_btn.frame =CGRectMake(20, 0, 75, 114/2);
                                         //                                 share_folder_btn.frame = CGRectMake(80.5+90, 0, 75, 114/2);
                                         //                                 move_folder_btn.frame = CGRectMake(80.5*2+150, 0, 75, 114/2);
                                         //                                 delete_folder_btn.frame = CGRectMake(80.5*3+210, 0, 75, 114/2);
                                         // imageContainer.contentMode=UIViewContentModeCenter;
                                         
                                         
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                    
            };
            
        }
            break;
            
        case UIUserInterfaceIdiomPad:
        {
            switch(device.orientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [UIScreen mainScreen].bounds.size.width, 25);
                    parent_scroll.frame = CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-45);
                    share_btn.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width-90, 10.75, 110, 20);
                    parent_scroll.scrollEnabled=NO;
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         imageContainer.backgroundColor = [UIColor clearColor];
                                         imageContainer.frame = CGRectMake(20, 0, parent_scroll.frame.size.width-40, (parent_scroll.frame.size.height - 250.0f));
                                         [parent_scroll setContentOffset:CGPointZero  animated:NO];
                                         imageContainer.contentMode=UIViewContentModeScaleAspectFit;
                                         pic_scroll.frame= CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width,150);
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [UIScreen mainScreen].bounds.size.width, 25);
                    parent_scroll.frame = CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-45);
                    share_btn.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width-90, 10.75, 110, 20);
                    parent_scroll.scrollEnabled=NO;
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         imageContainer.backgroundColor = [UIColor clearColor];
                                         imageContainer.frame = CGRectMake(20, 0, parent_scroll.frame.size.width-40, (parent_scroll.frame.size.height - 250.0f));
                                         [parent_scroll setContentOffset:CGPointZero  animated:NO];
                                         imageContainer.contentMode=UIViewContentModeScaleAspectFit;
                                         pic_scroll.frame= CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width,150);
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                    
                    
                case UIDeviceOrientationLandscapeRight:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25);
                    parent_scroll.frame = CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-45);
                    [parent_scroll setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width+150)];
                    share_btn.frame = CGRectMake([[UIScreen mainScreen] bounds].size.height-110, 10.75, 110, 20);
                    parent_scroll.scrollEnabled=YES;
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         imageContainer.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-300)/2+70, 0, 300, (parent_scroll.frame.size.height - 250.0f));
                                         [parent_scroll setContentOffset:CGPointZero  animated:NO];
                                         //                                 nav_bar.frame = CGRectMake(0, imageContainer.frame.size.height+imageContainer.frame.origin.y, [[UIScreen mainScreen] bounds].size.height, 114/2);
                                         pic_scroll.frame= CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+114/2, [[UIScreen mainScreen] bounds].size.height,150);
                                         //                                 bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 114/2);
                                         //                                 copy_folder_btn.frame =CGRectMake(20, 0, 75, 114/2);
                                         //                                 share_folder_btn.frame = CGRectMake(80.5+90, 0, 75, 114/2);
                                         //                                 move_folder_btn.frame = CGRectMake(80.5*2+150, 0, 75, 114/2);
                                         //                                 delete_folder_btn.frame = CGRectMake(80.5*3+210, 0, 75, 114/2);
                                         //                                 //imageContainer.contentMode=UIViewContentModeCenter;
                                         
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25);
                    parent_scroll.frame = CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-45);
                    [parent_scroll setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width+150)];
                    share_btn.frame = CGRectMake([[UIScreen mainScreen] bounds].size.height-110, 10.75, 110, 20);
                    parent_scroll.scrollEnabled=YES;
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         imageContainer.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-300)/2+70, 0, 300, (parent_scroll.frame.size.height - 250.0f));
                                         [parent_scroll setContentOffset:CGPointZero  animated:NO];
                                         //                                 nav_bar.frame = CGRectMake(0, imageContainer.frame.size.height+imageContainer.frame.origin.y, [[UIScreen mainScreen] bounds].size.height, 114/2);
                                         pic_scroll.frame= CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+114/2, [[UIScreen mainScreen] bounds].size.height,150);
                                         //                                 bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 114/2);
                                         //                                 copy_folder_btn.frame =CGRectMake(20, 0, 75, 114/2);
                                         //                                 share_folder_btn.frame = CGRectMake(80.5+90, 0, 75, 114/2);
                                         //                                 move_folder_btn.frame = CGRectMake(80.5*2+150, 0, 75, 114/2);
                                         //                                 delete_folder_btn.frame = CGRectMake(80.5*3+210, 0, 75, 114/2);
                                         // imageContainer.contentMode=UIViewContentModeCenter;
                                         
                                         
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                    
            };
            
        }
            break;
    }
}
-(void)share:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share the Picture"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel Button"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Facebook", @"Twitter",@"DropBox",@"Google+",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            ACAccountStore *accountStore = [[ACAccountStore alloc] init];
            __block ACAccount *facebookAccount = nil;
            
            ACAccountType *facebookAccountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
            
            // Specify App ID and permissions
            NSArray * permissions = @[@"email"];
            
            NSDictionary * options = @{ACFacebookAppIdKey :@"499628990128561", ACFacebookPermissionsKey : permissions, ACFacebookAudienceKey : ACFacebookAudienceOnlyMe};
            
            [accountStore requestAccessToAccountsWithType:facebookAccountType
                                                  options:options completion:^(BOOL granted, NSError *e)
             {
                 if (granted) {
                     // Now that you have publish permissions execute the request
                     NSDictionary *options2 = @{
                                                ACFacebookAppIdKey: @"499628990128561",
                                                ACFacebookPermissionsKey: @[@"publish_stream", @"publish_actions"],
                                                ACFacebookAudienceKey: ACFacebookAudienceFriends
                                                };
                     [accountStore requestAccessToAccountsWithType:facebookAccountType options:options2 completion:^(BOOL granted, NSError *error) {
                         if (granted) {
                             NSArray *accounts = [accountStore accountsWithAccountType:facebookAccountType];
                             
                             facebookAccount = [accounts lastObject];
                             
                             //NSDictionary *parameters = @{@"message": [NSString stringWithFormat:@"%@",tagg]};
                             
                             NSURL *feedURL = [NSURL URLWithString:@"https://graph.facebook.com/me/photos"];
                             
                             SLRequest *feedRequest = [SLRequest
                                                       requestForServiceType:SLServiceTypeFacebook
                                                       requestMethod:SLRequestMethodPOST
                                                       URL:feedURL
                                                       parameters:nil];
                             [feedRequest addMultipartData:UIImageJPEGRepresentation(_fullImage, 1)
                                                  withName:@"source"
                                                      type:@"multipart/form-data"
                                                  filename:@"TestImage"];
                             
                             
                             
                             [feedRequest setAccount:facebookAccount];
                             
                             [feedRequest performRequestWithHandler:^(NSData *responseData,
                                                                      NSHTTPURLResponse *urlResponse, NSError *error)
                              {
                                  // Handle response
                                  NSLog(@"%@%@", error,urlResponse);
                                  
                                  NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
                                  
                                  NSLog(@"Facebook Response : %@",response);
                                  
                                  [NSThread detachNewThreadSelector:@selector(showsts:) toTarget:self withObject:@"Successfully shared on facebook"];
                                  
                              }];
                             
                             
                             
                         }
                         else {
                             NSLog(@"Access denied 2");
                             NSLog(@"%@", [error description]);
                         }
                     }];
                 } else {
                     NSLog(@"Error: %@", [e description]);
                     NSLog(@"Access denied");
                 }
             }];
            
        }
            break;
        case 1:
        {
            //            ACAccountStore *accountStore = [[ACAccountStore alloc] init];
            //            ACAccountType *twitterType =
            //            [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
            //
            //            SLRequestHandler requestHandler =
            //            ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
            //                if (responseData) {
            //                    NSInteger statusCode = urlResponse.statusCode;
            //                    if (statusCode >= 200 && statusCode < 300) {
            //                        NSDictionary *postResponseData =
            //                        [NSJSONSerialization JSONObjectWithData:responseData
            //                                                        options:NSJSONReadingMutableContainers
            //                                                          error:NULL];
            //                        NSLog(@"[SUCCESS!] Created Tweet with ID: %@", postResponseData[@"id_str"]);
            //
            //                        [NSThread detachNewThreadSelector:@selector(showsts:) toTarget:self withObject:@"Successfully shared on twitter"];
            //                    }
            //                    else {
            //                        NSLog(@"[ERROR] Server responded: status code %d %@", statusCode,
            //                              [NSHTTPURLResponse localizedStringForStatusCode:statusCode]);
            //                    }
            //                }
            //                else {
            //                    [SVProgressHUD showErrorWithStatus:@" There was an error while posting"];
            //                    NSLog(@"[ERROR] An error occurred while posting: %@", [error localizedDescription]);
            //                }
            //            };
            //
            //            ACAccountStoreRequestAccessCompletionHandler accountStoreHandler =
            //            ^(BOOL granted, NSError *error) {
            //                if (granted) {
            //                    NSArray *accounts = [accountStore accountsWithAccountType:twitterType];
            //                    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com"
            //                                  @"/1.1/statuses/update_with_media.json"];
            //                    // NSDictionary *params = @{@"status" : [NSString stringWithFormat:@"%@",tagg]};
            //                    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
            //                                                            requestMethod:SLRequestMethodPOST
            //                                                                      URL:url
            //                                                               parameters:nil];
            //                    [request addMultipartData:UIImageJPEGRepresentation(_fullImage, 1)
            //                                     withName:@"media[]"
            //                                         type:@"image/jpeg"
            //                                     filename:@"image.jpg"];
            //                    [request setAccount:[accounts lastObject]];
            //                    [request performRequestWithHandler:requestHandler];
            //                }
            //                else {
            //                    NSLog(@"[ERROR] An error occurred while asking for user authorization: %@",
            //                          [error localizedDescription]);
            //                }
            //            };
            //
            //            [accountStore requestAccessToAccountsWithType:twitterType
            //                                                  options:NULL
            //                                               completion:accountStoreHandler];
            
            if ([TWTweetComposeViewController canSendTweet])
            {
                TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
                [tweetSheet setInitialText:@"PhotoXchange"];
                
                //        if (self.imageString)
                //        {
                [tweetSheet addImage:_fullImage];
                //        }
                
                //        if (self.urlString)
                //        {
                //[tweetSheet addURL:[NSURL URLWithString:self.urlString]];
                //        }
                
                [self presentModalViewController:tweetSheet animated:YES];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                                    message:@"No Account Found in Settings!!"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
            
        }
            break;
        case 2:
        {
            
            if( [[DBSession sharedSession] isLinked])
            {
                restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
                restClient.delegate = self;
                
                NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
                NSMutableString *randomString = [NSMutableString stringWithCapacity: 12];
                for (int i=0; i<12; i++)
                {
                    [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
                }
                NSString *filename = [NSString stringWithFormat:@"%@.png",randomString];
                NSString *tmpPngFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Temp.png"];
                [UIImagePNGRepresentation(_fullImage) writeToFile:tmpPngFile atomically:NO];
                
                NSString *destDir = @"/pXc Photos";
                [restClient uploadFile:filename toPath:destDir
                         withParentRev:nil fromPath:tmpPngFile];
                
                
            }
            else
            {
                shareviadropbox = YES;
                AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                delegate.imgvwr = @"yes";
                
                NSString *tmpPngFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Temp.png"];
                [UIImagePNGRepresentation(_fullImage) writeToFile:tmpPngFile atomically:NO];
                [[NSUserDefaults standardUserDefaults] setObject:tmpPngFile forKey:@"whatwesaved"];
                [[DBSession sharedSession] linkFromController:self];
                
            }
        }
            break;
        case 3:
        {
            //            NSString *urlString = [NSString stringWithFormat:@"%@upload_img_for_google.php",mydomainurl];
            //            NSURL* requestURL = [NSURL URLWithString:urlString];
            //            NSLog(@"%@", urlString);
            //
            //
            //            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            //            [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
            //            [request setHTTPShouldHandleCookies:NO];
            //            [request setURL:requestURL];
            //            [request setTimeoutInterval:30];
            //            [request setHTTPMethod:@"POST"];
            //            NSURLResponse *response = nil;
            //            NSError *error;
            //
            //            NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
            //            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
            //            [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
            //
            //            NSMutableData *body = [NSMutableData data];
            //            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            //            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image_upload\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            //            [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            //            [body appendData:[NSData dataWithData:UIImageJPEGRepresentation(_fullImage, 1.0)]];
            //            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            //            [request setHTTPBody:body];
            //
            //            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            //            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            //            NSLog(@" return String - %@",returnString);
            //
            //            if([[returnString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@"failed"])
            //            {
            //                [SVProgressHUD showErrorWithStatus:@" Error while saving the image for share"];
            //                return;
            //            }
            //            else
            //            {
            //
            //                id<GPPShareBuilder> shareBuilder = [[GPPShare sharedInstance] shareDialog];
            //                [shareBuilder setTitle:@"PhotoXchange"
            //                           description:@""
            //                          thumbnailURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mydomainurl,returnString]]];
            //
            //                [shareBuilder setContentDeepLinkID:@"PhotoXchange"];
            //
            //                [shareBuilder open];
            //            }
            
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSString *strurl = [NSString stringWithFormat:@"%@image_upload.php",mydomainurl];
                NSLog(@"url ta dichhe: %@",strurl);
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                
                [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
                
                [request setHTTPShouldHandleCookies:NO];
                
                [request setURL:[NSURL URLWithString:strurl]];
                
                [request setTimeoutInterval:10];
                
                [request setHTTPMethod:@"POST"];
                
                
                NSCharacterSet *whitespace;
                NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
                
                NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
                
                [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
                
                NSMutableData *body = [NSMutableData data];
                
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"share_pic\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [body appendData:[NSData dataWithData:UIImageJPEGRepresentation(_fullImage, 1)]];
                
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [request setHTTPBody:body];
                
                
                NSURLResponse *response = nil;
                NSError *error = nil;
                NSData *returnData1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                NSLog(@"data returned: %@",returnData1);
                if(error)
                {
                    [SVProgressHUD dismiss];
                    NSLog(@"Please check your internet connectivity %@",error);
                    alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Failed to Connect, Please Try Again"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    
                    //                    return ;
                }else{
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
                    
                    returnString_gimg = [[[NSString alloc] initWithData:returnData1 encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:whitespace];
                    NSLog(@"etar pore return korlo: %@",returnString_gimg);
                    
                    //                    alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Connecting to Google Plus"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    //                    [alert show];
                    alert.tag=2;
                    [SVProgressHUD showSuccessWithStatus:@"Connecting to Google Plus"];
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI UPDATION 1
                    //                    if([returnString_gimg isEqualToString:@"success"])
                    //                    {
                    self.view.userInteractionEnabled=YES;
                    
                    [SVProgressHUD dismiss];
                    
                    if([[GPPSignIn sharedInstance]hasAuthInKeychain])
                    {
                        id<GPPShareBuilder> shareBuilder = [[GPPShare sharedInstance] shareDialog];
                        
                        // This line will fill out the title, description, and thumbnail of the item
                        // you're sharing based on the URL you included.
                        [shareBuilder setURLToShare:[NSURL URLWithString:returnString_gimg]];//
                        
                        [shareBuilder setPrefillText:@"Shared via PhotoXchange"];
                        // if somebody opens the link on a supported mobile device
                        [shareBuilder setContentDeepLinkID:@"rest=1234567"];
                        
                        [shareBuilder open];
                    }
                    else
                    {
                        GPPSignIn *signIn = [GPPSignIn sharedInstance];
                        // You previously set kClientID in the "Initialize the Google+ client" step
                        signIn.clientID = @"536735755870-1bcqgtc3splihm9mgu008oojtrjvgffd.apps.googleusercontent.com";
                        signIn.scopes = [NSArray arrayWithObjects:
                                         kGTLAuthScopePlusLogin,kGTLAuthScopePlusMe,
                                         nil]; //// defined in GTLPlusConstants.h
                        
                        signIn.delegate = self;
                        [signIn authenticate];
                    }
                    
                    //                    }
                    
                });
            });
            
        }
            break;
    }
}
- (void)finishedSharing: (BOOL)shared {
    if (shared) {
        [SVProgressHUD showSuccessWithStatus:@"Successfully shared to Google+"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"User didn't share."];
        
    }
}
- (DBRestClient*)restClient {
    if (restClient == nil) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}
-(void)showsts:(NSString *)status
{
    [SVProgressHUD showSuccessWithStatus:status];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:YES];
    
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    NSLog(@" ekhane ");
                    //                    imageContainer = [[UIImageView alloc] initWithImage:_fullImage];
                    //                    imageContainer.frame = CGRectMake(0, 0, parent_scroll.frame.size.width, (parent_scroll.frame.size.height - 250.0f));
                    //                    imageContainer.contentMode=UIViewContentModeScaleAspectFit;
                    //                    [parent_scroll addSubview:imageContainer];
                    //
                    //                    //-------------------------- White Navigation Bar -------------------------------------------------
                    //                    nav_bar = [[UIView alloc] initWithFrame:CGRectMake(0, imageContainer.frame.size.height+imageContainer.frame.origin.y, 320, 114/2)];
                    //                    [parent_scroll addSubview:nav_bar];
                    //
                    //                    bar_white = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar@2x.png"]];
                    //                    bar_white.frame = CGRectMake(0, 0, 320, 114/2);
                    //                    [nav_bar addSubview:bar_white];
                    //
                    //                    //------------------------- pics_scrollView ---------------------------------------------------------
                    pic_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+114/2, 320,150)];
                    pic_scroll.backgroundColor = [UIColor clearColor];
                    pic_scroll.delegate=self;
                    pic_scroll.showsVerticalScrollIndicator = NO;
                    pic_scroll.showsHorizontalScrollIndicator = NO;
                    [parent_scroll addSubview:pic_scroll];
                    //
                    //                    //---------------- Copy Button and it's subviews -------------------------------------
                    //                    copy_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    //                    copy_folder_btn.frame =CGRectMake(0, 0, 75, 114/2);
                    //                    copy_folder_btn.backgroundColor = [UIColor clearColor];
                    //                    copy_folder_btn.tag=1;
                    //                    [copy_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    //                    [nav_bar addSubview:copy_folder_btn];
                    //
                    //                    UIImageView *copy_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copy-icon@2x.png"]];
                    //                    copy_fol.frame = CGRectMake(27, 10, 44/2, 56/2);
                    //                    [copy_folder_btn addSubview:copy_fol];
                    //
                    //                    UILabel *copy_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 80, 20)];
                    //                    copy_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    //                    copy_fol_lbl.text=@"Copy";
                    //                    copy_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    //                    copy_fol_lbl.backgroundColor = [UIColor clearColor];
                    //                    copy_fol_lbl.textColor=[UIColor darkGrayColor];
                    //                    [copy_folder_btn addSubview:copy_fol_lbl];
                    //
                    //                    //--------------------- Share Folder Button and it's subviews------------------------
                    //                    share_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    //                    share_folder_btn.frame =CGRectMake(80.5, 0, 75, 114/2);
                    //                    share_folder_btn.backgroundColor = [UIColor clearColor];
                    //                    share_folder_btn.tag=2;
                    //                    [share_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    //                    [nav_bar addSubview:share_folder_btn];
                    //
                    //                    UIImageView *ren_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share@2x.png"]];
                    //                    ren_fol.frame = CGRectMake(24.5, 10, 53/2, 52/2);
                    //                    [share_folder_btn addSubview:ren_fol];
                    //
                    //                    UILabel *share_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(1, 35, 80, 20)];
                    //                    share_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    //                    share_fol_lbl.text=@"Share";
                    //                    share_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    //                    share_fol_lbl.backgroundColor = [UIColor clearColor];
                    //                    share_fol_lbl.textColor=[UIColor darkGrayColor];
                    //                    [share_folder_btn addSubview:share_fol_lbl];
                    //
                    //                    //--------------------- Move Folder Button and it's subviews------------------------
                    //                    move_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    //                    move_folder_btn.frame =CGRectMake(80.5*2, 0, 75, 114/2);
                    //                    move_folder_btn.backgroundColor = [UIColor clearColor];
                    //                    move_folder_btn.tag=3;
                    //                    [move_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    //                    [nav_bar addSubview:move_folder_btn];
                    //
                    //                    UIImageView *mov_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"move@2x.png"]];
                    //                    mov_fol.frame = CGRectMake(24.5f, 10, 59/2, 19);
                    //                    [move_folder_btn addSubview:mov_fol];
                    //
                    //                    UILabel *move_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    //                    move_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    //                    move_fol_lbl.text=@"Move Folder";
                    //                    move_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    //                    move_fol_lbl.backgroundColor = [UIColor clearColor];
                    //                    move_fol_lbl.textColor=[UIColor darkGrayColor];
                    //                    [move_folder_btn addSubview:move_fol_lbl];
                    //
                    //                    //--------------------- Delete Folder Button and it's subviews------------------------
                    //                    delete_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    //                    delete_folder_btn.frame =CGRectMake(80.5f*3, 0, 75, 114/2);
                    //                    delete_folder_btn.backgroundColor = [UIColor clearColor];
                    //                    delete_folder_btn.tag=4;
                    //                    [delete_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    //                    [nav_bar addSubview:delete_folder_btn];
                    //
                    //                    UIImageView *del_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete@2x.png"]];
                    //                    del_fol.frame = CGRectMake(26.0f, 7.5f, 48/2, 49/2);
                    //                    [delete_folder_btn addSubview:del_fol];
                    //
                    //                    UILabel *del_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    //                    del_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    //                    del_fol_lbl.text=@"Delete Folder";
                    //                    del_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    //                    del_fol_lbl.backgroundColor = [UIColor clearColor];
                    //                    del_fol_lbl.textColor=[UIColor darkGrayColor];
                    //                    [delete_folder_btn addSubview:del_fol_lbl];
                    
                    [self reloadscroll];
                }
                    break;
                    //                case UIInterfaceOrientationPortraitUpsideDown:
                    //                {
                    //                    imageContainer = [[UIImageView alloc] initWithImage:_fullImage];
                    //                    imageContainer.frame = CGRectMake(0, 0, parent_scroll.frame.size.width, (parent_scroll.frame.size.height - 250.0f));
                    //                    imageContainer.contentMode=UIViewContentModeScaleAspectFit;
                    //                    [parent_scroll addSubview:imageContainer];
                    //
                    //                    pic_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+114/2, 320,150)];
                    //                    pic_scroll.backgroundColor = [UIColor clearColor];
                    //                    pic_scroll.delegate=self;
                    //                    pic_scroll.showsVerticalScrollIndicator = NO;
                    //                    pic_scroll.showsHorizontalScrollIndicator = NO;
                    //                    [parent_scroll addSubview:pic_scroll];
                    //
                    //
                    //                    [self reloadscroll];
                    //                }
                    //                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    imageContainer = [[UIImageView alloc] initWithImage:_fullImage];
                    imageContainer.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-300)/2+70, 0, 300, 250);
                    imageContainer.contentMode=UIViewContentModeScaleAspectFit;
                    [parent_scroll addSubview:imageContainer];
                    //
                    //                    //-------------------------- White Navigation Bar -------------------------------------------------
                    //                    nav_bar = [[UIView alloc] initWithFrame:CGRectMake(0, imageContainer.frame.size.height+imageContainer.frame.origin.y, [[UIScreen mainScreen] bounds].size.height, 114/2)];
                    //                    [parent_scroll addSubview:nav_bar];
                    //
                    //                    bar_white = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar@2x.png"]];
                    //                    bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 114/2);
                    //                    [nav_bar addSubview:bar_white];
                    //
                    //                    //------------------------- pics_scrollView ---------------------------------------------------------
                    pic_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+114/2, [[UIScreen mainScreen] bounds].size.height,150)];
                    pic_scroll.backgroundColor = [UIColor clearColor];
                    pic_scroll.delegate=self;
                    pic_scroll.showsVerticalScrollIndicator = NO;
                    pic_scroll.showsHorizontalScrollIndicator = NO;
                    [parent_scroll addSubview:pic_scroll];
                    //
                    //                    //---------------- Copy Button and it's subviews -------------------------------------
                    //                    copy_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    //                    copy_folder_btn.frame =CGRectMake(20, 0, 75, 114/2);
                    //                    copy_folder_btn.backgroundColor = [UIColor clearColor];
                    //                    copy_folder_btn.tag=1;
                    //                    [copy_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    //                    [nav_bar addSubview:copy_folder_btn];
                    //
                    //                    UIImageView *copy_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copy-icon@2x.png"]];
                    //                    copy_fol.frame = CGRectMake(27, 10, 44/2, 56/2);
                    //                    [copy_folder_btn addSubview:copy_fol];
                    //
                    //                    UILabel *copy_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 80, 20)];
                    //                    copy_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    //                    copy_fol_lbl.text=@"Copy";
                    //                    copy_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    //                    copy_fol_lbl.backgroundColor = [UIColor clearColor];
                    //                    copy_fol_lbl.textColor=[UIColor darkGrayColor];
                    //                    [copy_folder_btn addSubview:copy_fol_lbl];
                    //
                    //                    //--------------------- Share Folder Button and it's subviews------------------------
                    //                    share_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    //                    share_folder_btn.frame =CGRectMake(80.5+90, 0, 75, 114/2);
                    //                    share_folder_btn.backgroundColor = [UIColor clearColor];
                    //                    share_folder_btn.tag=2;
                    //                    [share_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    //                    [nav_bar addSubview:share_folder_btn];
                    //
                    //                    UIImageView *ren_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share@2x.png"]];
                    //                    ren_fol.frame = CGRectMake(24.5, 10, 53/2, 52/2);
                    //                    [share_folder_btn addSubview:ren_fol];
                    //
                    //                    UILabel *share_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(1, 35, 80, 20)];
                    //                    share_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    //                    share_fol_lbl.text=@"Share";
                    //                    share_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    //                    share_fol_lbl.backgroundColor = [UIColor clearColor];
                    //                    share_fol_lbl.textColor=[UIColor darkGrayColor];
                    //                    [share_folder_btn addSubview:share_fol_lbl];
                    //
                    //                    //--------------------- Move Folder Button and it's subviews------------------------
                    //                    move_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    //                    move_folder_btn.frame =CGRectMake(80.5*2+150, 0, 75, 114/2);
                    //                    move_folder_btn.backgroundColor = [UIColor clearColor];
                    //                    move_folder_btn.tag=3;
                    //                    [move_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    //                    [nav_bar addSubview:move_folder_btn];
                    //
                    //                    UIImageView *mov_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"move@2x.png"]];
                    //                    mov_fol.frame = CGRectMake(24.5f, 10, 59/2, 19);
                    //                    [move_folder_btn addSubview:mov_fol];
                    //
                    //                    UILabel *move_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    //                    move_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    //                    move_fol_lbl.text=@"Move Folder";
                    //                    move_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    //                    move_fol_lbl.backgroundColor = [UIColor clearColor];
                    //                    move_fol_lbl.textColor=[UIColor darkGrayColor];
                    //                    [move_folder_btn addSubview:move_fol_lbl];
                    //
                    //                    //--------------------- Delete Folder Button and it's subviews------------------------
                    //                    delete_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    //                    delete_folder_btn.frame =CGRectMake(80.5f*3+210, 0, 75, 114/2);
                    //                    delete_folder_btn.backgroundColor = [UIColor clearColor];
                    //                    delete_folder_btn.tag=4;
                    //                    [delete_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    //                    [nav_bar addSubview:delete_folder_btn];
                    //
                    //                    UIImageView *del_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete@2x.png"]];
                    //                    del_fol.frame = CGRectMake(26.0f, 7.5f, 48/2, 49/2);
                    //                    [delete_folder_btn addSubview:del_fol];
                    //
                    //                    UILabel *del_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    //                    del_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    //                    del_fol_lbl.text=@"Delete Folder";
                    //                    del_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    //                    del_fol_lbl.backgroundColor = [UIColor clearColor];
                    //                    del_fol_lbl.textColor=[UIColor darkGrayColor];
                    //                    [delete_folder_btn addSubview:del_fol_lbl];
                    
                    [self reloadscroll];
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    imageContainer = [[UIImageView alloc] initWithImage:_fullImage];
                    imageContainer.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-300)/2+70, 0, 300, 250);
                    imageContainer.contentMode=UIViewContentModeScaleAspectFit;
                    [parent_scroll addSubview:imageContainer];
                    //
                    //                    //-------------------------- White Navigation Bar -------------------------------------------------
                    //                    nav_bar = [[UIView alloc] initWithFrame:CGRectMake(0, imageContainer.frame.size.height+imageContainer.frame.origin.y, [[UIScreen mainScreen] bounds].size.height, 114/2)];
                    //                    [parent_scroll addSubview:nav_bar];
                    //
                    //                    bar_white = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar@2x.png"]];
                    //                    bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 114/2);
                    //                    [nav_bar addSubview:bar_white];
                    //
                    //                    //------------------------- pics_scrollView ---------------------------------------------------------
                    pic_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+114/2, [[UIScreen mainScreen] bounds].size.height,150)];
                    pic_scroll.backgroundColor = [UIColor clearColor];
                    pic_scroll.delegate=self;
                    pic_scroll.showsVerticalScrollIndicator = NO;
                    pic_scroll.showsHorizontalScrollIndicator = NO;
                    [parent_scroll addSubview:pic_scroll];
                    //
                    //                    //---------------- Copy Button and it's subviews -------------------------------------
                    //                    copy_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    //                    copy_folder_btn.frame =CGRectMake(20, 0, 75, 114/2);
                    //                    copy_folder_btn.backgroundColor = [UIColor clearColor];
                    //                    copy_folder_btn.tag=1;
                    //                    [copy_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    //                    [nav_bar addSubview:copy_folder_btn];
                    //
                    //                    UIImageView *copy_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copy-icon@2x.png"]];
                    //                    copy_fol.frame = CGRectMake(27, 10, 44/2, 56/2);
                    //                    [copy_folder_btn addSubview:copy_fol];
                    //
                    //                    UILabel *copy_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 80, 20)];
                    //                    copy_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    //                    copy_fol_lbl.text=@"Copy";
                    //                    copy_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    //                    copy_fol_lbl.backgroundColor = [UIColor clearColor];
                    //                    copy_fol_lbl.textColor=[UIColor darkGrayColor];
                    //                    [copy_folder_btn addSubview:copy_fol_lbl];
                    //
                    //                    //--------------------- Share Folder Button and it's subviews------------------------
                    //                    share_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    //                    share_folder_btn.frame =CGRectMake(80.5+90, 0, 75, 114/2);
                    //                    share_folder_btn.backgroundColor = [UIColor clearColor];
                    //                    share_folder_btn.tag=2;
                    //                    [share_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    //                    [nav_bar addSubview:share_folder_btn];
                    //
                    //                    UIImageView *ren_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share@2x.png"]];
                    //                    ren_fol.frame = CGRectMake(24.5, 10, 53/2, 52/2);
                    //                    [share_folder_btn addSubview:ren_fol];
                    //
                    //                    UILabel *share_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(1, 35, 80, 20)];
                    //                    share_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    //                    share_fol_lbl.text=@"Share";
                    //                    share_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    //                    share_fol_lbl.backgroundColor = [UIColor clearColor];
                    //                    share_fol_lbl.textColor=[UIColor darkGrayColor];
                    //                    [share_folder_btn addSubview:share_fol_lbl];
                    //
                    //                    //--------------------- Move Folder Button and it's subviews------------------------
                    //                    move_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    //                    move_folder_btn.frame =CGRectMake(80.5*2+150, 0, 75, 114/2);
                    //                    move_folder_btn.backgroundColor = [UIColor clearColor];
                    //                    move_folder_btn.tag=3;
                    //                    [move_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    //                    [nav_bar addSubview:move_folder_btn];
                    //
                    //                    UIImageView *mov_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"move@2x.png"]];
                    //                    mov_fol.frame = CGRectMake(24.5f, 10, 59/2, 19);
                    //                    [move_folder_btn addSubview:mov_fol];
                    //
                    //                    UILabel *move_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    //                    move_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    //                    move_fol_lbl.text=@"Move Folder";
                    //                    move_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    //                    move_fol_lbl.backgroundColor = [UIColor clearColor];
                    //                    move_fol_lbl.textColor=[UIColor darkGrayColor];
                    //                    [move_folder_btn addSubview:move_fol_lbl];
                    //
                    //                    //--------------------- Delete Folder Button and it's subviews------------------------
                    //                    delete_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    //                    delete_folder_btn.frame =CGRectMake(80.5f*3+210, 0, 75, 114/2);
                    //                    delete_folder_btn.backgroundColor = [UIColor clearColor];
                    //                    delete_folder_btn.tag=4;
                    //                    [delete_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    //                    [nav_bar addSubview:delete_folder_btn];
                    //
                    //                    UIImageView *del_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete@2x.png"]];
                    //                    del_fol.frame = CGRectMake(26.0f, 7.5f, 48/2, 49/2);
                    //                    [delete_folder_btn addSubview:del_fol];
                    //
                    //                    UILabel *del_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    //                    del_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    //                    del_fol_lbl.text=@"Delete Folder";
                    //                    del_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    //                    del_fol_lbl.backgroundColor = [UIColor clearColor];
                    //                    del_fol_lbl.textColor=[UIColor darkGrayColor];
                    //                    [delete_folder_btn addSubview:del_fol_lbl];
                    
                    [self reloadscroll];
                }
                    break;
            }
            
        }
        case UIUserInterfaceIdiomPad:
        {
            switch(self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    
                    imageContainer = [[UIImageView alloc] initWithImage:_fullImage];
                    imageContainer.frame = CGRectMake(20, 0, parent_scroll.frame.size.width-40, (parent_scroll.frame.size.height - 250.0f));
                    imageContainer.contentMode=UIViewContentModeScaleAspectFit;
                    [parent_scroll addSubview:imageContainer];
                    
                    pic_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+114/2, [[UIScreen mainScreen] bounds].size.width,150)];
                    pic_scroll.backgroundColor = [UIColor clearColor];
                    pic_scroll.delegate=self;
                    pic_scroll.showsVerticalScrollIndicator = NO;
                    pic_scroll.showsHorizontalScrollIndicator = NO;
                    [parent_scroll addSubview:pic_scroll];
                    
                    
                    [self reloadscroll];
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                    imageContainer = [[UIImageView alloc] initWithImage:_fullImage];
                    imageContainer.frame = CGRectMake(20, 0, parent_scroll.frame.size.width-40, (parent_scroll.frame.size.height - 250.0f));
                    imageContainer.contentMode=UIViewContentModeScaleAspectFit;
                    [parent_scroll addSubview:imageContainer];
                    
                    pic_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width,150)];
                    pic_scroll.backgroundColor = [UIColor clearColor];
                    pic_scroll.delegate=self;
                    pic_scroll.showsVerticalScrollIndicator = NO;
                    pic_scroll.showsHorizontalScrollIndicator = NO;
                    [parent_scroll addSubview:pic_scroll];
                    
                    
                    
                    [self reloadscroll];
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    imageContainer = [[UIImageView alloc] initWithImage:_fullImage];
                    imageContainer.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.height-300)/2+70, 0, 300, (parent_scroll.frame.size.height - 250.0f));
                    imageContainer.contentMode=UIViewContentModeScaleAspectFit;
                    [parent_scroll addSubview:imageContainer];
                    
                    pic_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.height,150)];
                    pic_scroll.backgroundColor = [UIColor clearColor];
                    pic_scroll.delegate=self;
                    pic_scroll.showsVerticalScrollIndicator = NO;
                    pic_scroll.showsHorizontalScrollIndicator = NO;
                    [parent_scroll addSubview:pic_scroll];
                    
                    
                    [self reloadscroll];
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    imageContainer = [[UIImageView alloc] initWithImage:_fullImage];
                    imageContainer.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.height-300)/2+70, 0, 300, (parent_scroll.frame.size.height - 250.0f));
                    imageContainer.contentMode=UIViewContentModeScaleAspectFit;
                    [parent_scroll addSubview:imageContainer];
                    
                    pic_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,imageContainer.frame.size.height+imageContainer.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.height,150)];
                    pic_scroll.backgroundColor = [UIColor clearColor];
                    pic_scroll.delegate=self;
                    pic_scroll.showsVerticalScrollIndicator = NO;
                    pic_scroll.showsHorizontalScrollIndicator = NO;
                    [parent_scroll addSubview:pic_scroll];
                    
                    
                    [self reloadscroll];
                }
                    break;
            }
            
        }
            break;
    }
    
}
- (void)saveImageToAlbum:(id)sender {
    UIImageWriteToSavedPhotosAlbum(_fullImage,
                                   self,
                                   @selector(image:finishedSavingWithError:contextInfo:),
                                   nil);
}
-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo

{
    
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Save failed"
                                                        message: @"Failed to save image"
                                                       delegate: nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    } else {
        UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@""
                                                               message:@"Image has been saved successfully!"
                                                              delegate:self
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles:nil];
        [successAlert show];
    }
    
}
- (void)goBack:(id)sender {
    
    if ([[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] unlinkAll];
    }
    
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
    
    
}
- (void)reloadscroll
{
    pics_data = [[NSMutableArray alloc] initWithCapacity:[image_data_from_library count]-1];
    int count =0;
    for(int i=0;i<=[image_data_from_library count]-1;i++)
    {
        UIImage *compared_img = [[UIImage alloc] init];
        switch (imgtypestatic)
        {
            case 1:
            {
                compared_img = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[image_data_from_library objectAtIndex:i]]];
            }
                break;
                
            case 0:
            {
                ALAsset *asset = [image_data_from_library objectAtIndex:i];
                CGImageRef thumbnailImageRef = [asset thumbnail];
                compared_img= [UIImage imageWithCGImage:thumbnailImageRef];
            }
                break;
        }
        if(compared_img!=_fullImage)
        {
            float padLeft = (20 * (count + 1)) + (count * 80);
            
            UIImageView *img_from_lib = [[UIImageView alloc] initWithFrame:CGRectMake(padLeft, 25, 80, 80)];
            img_from_lib.alpha=0.5;
            img_from_lib.image = compared_img;
            [pics_data addObject:img_from_lib.image];
            
            img_from_lib.layer.borderColor = [[UIColor whiteColor]CGColor];
            img_from_lib.layer.borderWidth=1.5f;
            img_from_lib.userInteractionEnabled=YES;
            img_from_lib.contentMode=UIViewContentModeScaleAspectFit;
            img_from_lib.tag = count;
            [pic_scroll addSubview:img_from_lib];
            
            [UIView beginAnimations:@"animation" context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDuration:0.0];
            img_from_lib.alpha=1;
            [UIView commitAnimations];
            
            UITapGestureRecognizer *tapaction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectnewimage:)];
            tapaction.numberOfTapsRequired=1;
            [img_from_lib addGestureRecognizer:tapaction];
            
            count++;
        }
        
    }
    
    pic_scroll.contentSize=CGSizeMake((20 * (count + 1)) + (count * 80), 80);
    [pic_scroll setNeedsDisplay];
    
}

-(void)selectnewimage:(UITapGestureRecognizer *)recog
{
    UIImageView *imageView = (UIImageView *)recog.view;
    _fullImage = (UIImage *)[pics_data objectAtIndex:imageView.tag];
    
    [UIView transitionWithView: imageContainer
                      duration: 1.00f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void){
                        imageContainer.image = _fullImage;
                        
                        [UIView transitionWithView: pic_scroll
                                          duration: 0.0f
                                           options: UIViewAnimationOptionTransitionCrossDissolve
                                        animations: ^(void){
                                            [self reloadscroll];
                                        }
                                        completion: ^(BOOL isFinished){
                                        }];
                    }
                    completion: ^(BOOL isFinished){
                        
                    }];
}
//-(void)navbaractions:(UIButton *)sender
//{
//    switch (sender.tag)
//    {
//        case 1:
//            break;
//        case 2:
//            break;
//        case 3:
//            break;
//        case 4:
//            break;
//        default:
//            break;
//    }
//}
- (void)setFullImage:(UIImage *)fullImageInstance {
    
    _fullImage = fullImageInstance;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath
              from:(NSString*)srcPath metadata:(DBMetadata*)metadata {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"whatwesaved"];
    [SVProgressHUD showSuccessWithStatus:@"Successfully uploaded to the pXc Photos folder of your Dropbox"];
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error {
    //  [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"File upload failed with error - %@", error]];
    NSLog(@"File upload failed with error - %@", error);
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error
{
    NSLog(@"Received error %@ and auth object %@",error, auth);
    
    if (error) {
        
        
    }
    
    else{
        
        id<GPPShareBuilder> shareBuilder = [[GPPShare sharedInstance] shareDialog];
        
        // This line will fill out the title, description, and thumbnail of the item
        // you're sharing based on the URL you included.
        [shareBuilder setURLToShare:[NSURL URLWithString:returnString_gimg]];//
        
        [shareBuilder setPrefillText:@"Shared via PhotoXchange"];
        // if somebody opens the link on a supported mobile device
        [shareBuilder setContentDeepLinkID:@"rest=1234567"];
        
        [shareBuilder open];
        
        //        id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
        //
        //        // This line will fill out the title, description, and thumbnail from
        //        // the URL that you are sharing and includes a link to that URL.
        ////        [shareBuilder setURLToShare:[NSURL URLWithString:@"https://www.example.com/restaurant/sf/1234567/"]];
        //        [shareBuilder setPrefillText:@"PhotoXchange"];
        //
        //        [shareBuilder attachImage:self.fullImage];
        //
        //        [shareBuilder open];
    }
}

@end
