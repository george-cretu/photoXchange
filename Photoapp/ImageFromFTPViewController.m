//
//  ImageFromFTPViewController.m
//  Photoapp
//
//  Created by Iphone_1 on 23/11/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import "ImageFromFTPViewController.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "FTPListingViewController.h"
@interface ImageFromFTPViewController ()
{
    int screen_width,screen_height;
    UIView *top_view;
    UIImageView *full_image;
    NSString *to_go_back_url;
    UIButton *button;
}
@end

@implementation ImageFromFTPViewController
@synthesize url,folder_path_fromprev;
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
    NSLog(@"image from ftp view BM");
    [super viewDidLoad];
    
    UIButton *add_button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [[add_button titleLabel] setTextAlignment:NSTextAlignmentCenter];
    [[add_button titleLabel] setNumberOfLines:3];
    [[add_button titleLabel] setFont:[UIFont systemFontOfSize:13]];
    [[add_button titleLabel] setTextAlignment:NSTextAlignmentCenter];
    [add_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [add_button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [add_button addTarget:self action:@selector(copyThisUrl:)forControlEvents:UIControlEventTouchUpInside];
    [add_button setFrame:CGRectMake(0, 0,32, 25/2)];
    [add_button setTitle:@"Copy Url" forState:UIControlStateNormal];
    UIBarButtonItem *actionbarButton = [[UIBarButtonItem alloc] initWithCustomView:add_button];
    self.navigationItem.rightBarButtonItem = actionbarButton;

    
    screen_height = 0;
    screen_width = 0;
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIInterfaceOrientationLandscapeLeft:
                {
                    screen_width = [[UIScreen mainScreen] bounds].size.height;
                    screen_height = [[UIScreen mainScreen] bounds].size.width;
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    screen_width = [[UIScreen mainScreen] bounds].size.height;
                    screen_height = [[UIScreen mainScreen] bounds].size.width;
                }
                    break;
                case UIInterfaceOrientationPortrait:
                {
                    screen_width = [[UIScreen mainScreen] bounds].size.width;
                    screen_height =[[UIScreen mainScreen] bounds].size.height;
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                    screen_width = [[UIScreen mainScreen] bounds].size.width;
                    screen_height =[[UIScreen mainScreen] bounds].size.height;
                }
                    break;
            }
            break;
        }
            break;
        case UIUserInterfaceIdiomPad:
        {
            switch(self.interfaceOrientation)
            {
                case UIInterfaceOrientationLandscapeLeft:
                {
                    screen_width = [[UIScreen mainScreen] bounds].size.height;
                    screen_height = [[UIScreen mainScreen] bounds].size.width;
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    screen_width = [[UIScreen mainScreen] bounds].size.height;
                    screen_height = [[UIScreen mainScreen] bounds].size.width;
                }
                    break;
                case UIInterfaceOrientationPortrait:
                {
                    screen_width = [[UIScreen mainScreen] bounds].size.width;
                    screen_height =[[UIScreen mainScreen] bounds].size.height;
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                    screen_width = [[UIScreen mainScreen] bounds].size.width;
                    screen_height =[[UIScreen mainScreen] bounds].size.height;
                }
                    break;
            }
            break;
        }
            break;
    }
   
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar@2x.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBarHidden = NO;
        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars=NO;
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bar.png"] forBarMetrics:nil];
    }
    
   
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationItem setTitle:@"Image Detail"];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                           UITextAttributeFont: [UIFont fontWithName:@"MyriadPro-Bold" size:18.5],
                                                           }];
    
    button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(goBackAgain:)forControlEvents:UIControlEventTouchUpInside];
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPad:
        {
            [button setImage:[UIImage imageNamed:@"back-up1.png"] forState:UIControlStateNormal];
            [button setFrame:CGRectMake(0, 0,32, 25)];
        }
            break;
        case UIUserInterfaceIdiomPhone:
        {
            [button setImage:[UIImage imageNamed:@"back-up@2x.png"] forState:UIControlStateNormal];
            [button setFrame:CGRectMake(0, 0,32/2, 25/2)];
        }
            break;
    }

    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
    to_go_back_url = url;
    url = [url stringByReplacingOccurrencesOfString:@"../" withString:@"http://192.254.152.111/~photoxch/"];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"url image detail from ftp: %@",url);
    
    [self.view addSubview:top_view];
    full_image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, screen_width-20, screen_height-(self.navigationController.navigationBar.frame.size.height+25))];
    [SVProgressHUD showWithStatus:@"Loading your image"];
    full_image.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:full_image];
    dispatch_queue_t taskQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(taskQ, ^{
                NSLog(@"imagefromftp single click: %@",url);
//                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
                dispatch_sync(dispatch_get_main_queue(), ^{
//                    if(image!=nil)
//                    {
                        [SVProgressHUD dismiss];
//                        full_image.image=image;
                        [full_image setImageWithURL:[NSURL URLWithString:url]
                                          placeholderImage:[UIImage imageNamed:@"splash screen.png"] options:SDWebImageProgressiveDownload];
                        [full_image setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
                        [full_image setContentMode:UIViewContentModeScaleAspectFit];

//                    }
//                    else
//                    {
//                        [SVProgressHUD showErrorWithStatus:@"Please check your internet connectivity"];
//                    }
                });
        });
    
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}
- (void) orientationChanged:(NSNotification *)note
{
     UIDevice * device = note.object;
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(device.orientation)
            {
                case UIInterfaceOrientationLandscapeLeft:
                {
                    screen_width = [[UIScreen mainScreen] bounds].size.height;
                    screen_height = [[UIScreen mainScreen] bounds].size.width;
                   
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    screen_width = [[UIScreen mainScreen] bounds].size.height;
                    screen_height = [[UIScreen mainScreen] bounds].size.width;
                   
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                case UIDeviceOrientationUnknown:
                case UIDeviceOrientationFaceUp:
                case UIDeviceOrientationFaceDown:
                case UIInterfaceOrientationPortrait:
                {
                    screen_width = [[UIScreen mainScreen] bounds].size.width;
                    screen_height =[[UIScreen mainScreen] bounds].size.height;
                    
                }
                    break;
               
            }
            break;
        }
            break;
        case UIUserInterfaceIdiomPad:
        {
            switch(device.orientation)
            {
                case UIInterfaceOrientationLandscapeLeft:
                {
                    screen_width = [[UIScreen mainScreen] bounds].size.height;
                    screen_height = [[UIScreen mainScreen] bounds].size.width;
                    
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    screen_width = [[UIScreen mainScreen] bounds].size.height;
                    screen_height = [[UIScreen mainScreen] bounds].size.width;
                    
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                case UIDeviceOrientationUnknown:
                case UIDeviceOrientationFaceUp:
                case UIDeviceOrientationFaceDown:
                case UIInterfaceOrientationPortrait:
                {
                    screen_width = [[UIScreen mainScreen] bounds].size.width;
                    screen_height =[[UIScreen mainScreen] bounds].size.height;
                    
                }
                    break;

            }
            break;
        }
            break;
    }

    full_image.frame = CGRectMake(10, 5, screen_width-20, screen_height-(self.navigationController.navigationBar.frame.size.height+15));
    
}
-(void)goBackAgain:(UIButton *)sender
{
  
//    FTPListingViewController *list = [[FTPListingViewController alloc] init];
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.25;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromBottom;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//    list.director_string = [to_go_back_url stringByDeletingLastPathComponent];
//    [[self navigationController]pushViewController:list animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)copyThisUrl:(UIButton *)sender
{
        [self copyAlertShow];
}

-(void)copyAlertShow
{
    UIAlertView *alert_confirm = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Do you want to copy this url?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    alert_confirm.tag=100;
    [alert_confirm show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if(alertView.tag ==100)
    {
        switch (buttonIndex) {
            case 0:
            {
                NSLog(@"cancel clicked");
            }
                break;
                
            case 1:
            {
                NSLog(@"ok clicked");
                NSString *selected_path=@"";
                    selected_path = url;
                
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
                {
                    NSString *copy_url = selected_path;
                    copy_url = [copy_url stringByReplacingOccurrencesOfString:@".." withString:@""];
                    
                    UIPasteboard *pb = [UIPasteboard generalPasteboard];
                    [pb setString:[copy_url stringByReplacingOccurrencesOfString:@".." withString:@""]];
                }
                else
                {
                    NSString *copy_url = selected_path;
                    copy_url = [copy_url stringByReplacingOccurrencesOfString:@".." withString:@""];
                    
                    UIPasteboard *pb = [UIPasteboard generalPasteboard];
                    [pb setString:[copy_url stringByReplacingOccurrencesOfString:@".." withString:@""]];
                    
                }
            }
                break;
        }
    }

}

@end
