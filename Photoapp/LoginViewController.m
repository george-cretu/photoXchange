//
//  LoginViewController.m
//  Photoapp
//
//  Created by Esolz Technologies on 08/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/CoreAnimation.h>
#import "SVProgressHUD.h"
#import "MBHUDView.h"
#import "AccountViewController.h"
#import "ForgetpasswordViewController.h"
#import "RegisterViewController.h"
#import "HomeViewController.h"
#include<unistd.h>
#include<netdb.h>
#import "NewRegisterViewController.h"

@interface LoginViewController ()
{
    UIImageView *buttonusertrouble;
    UILabel *headerlabel;
    UIImageView *boxBG;
    UILabel *welcomelbl;
    UILabel *to_lbl;
    UILabel *Photo_lbl;
    UIButton *signupbutton;
    UILabel *divider;
    UIAlertView *alertv;
}

@end

@implementation LoginViewController

@synthesize scviewlogin,labelpass,labelusername,usernameTextField,userpassTextField,loginbutton,facebookloginbutton,registerbutton,forgetpassbutton,loginloader,allerttext,labelappname,labelwelcome,labelname,labelremember, timer, remcheck;

@synthesize library = _library;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //    UILabel *addressLb = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 270, 20)];
    //    [addressLb setBackgroundColor:[UIColor clearColor]];
    //    [addressLb setText:[prefs objectForKey:@"address"]];
    //    [addressLb setTextColor:[UIColor whiteColor]];
    //    [addressLb setContentMode:UIViewContentModeCenter];
    //    [scviewlogin addSubview:addressLb];
    //    NSLog(@"%@",[prefs objectForKey:@"address"]);
}
-(void)viewDidDisappear:(BOOL)animated
{
    //    [self viewDidDisappear:NO];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    que = [NSOperationQueue new];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar@2x.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bar.png"] forBarMetrics:nil];
    }
    [self.navigationItem setTitle:@"Login"];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                           UITextAttributeFont: [UIFont fontWithName:@"MyriadPro-Bold" size:18.5],
                                                           }];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    remember = @"N";
    
    NSLog(@"autologin: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"]);
    NSLog(@"isloggedin: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"isloggedin"]);
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"isloggedin"] isEqualToString:@"yes"])
    {
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        HomeViewController *control1 = [[HomeViewController alloc] init];
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [[self navigationController] pushViewController:control1 animated:NO];
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    albumName = [mainBundle objectForInfoDictionaryKey:@"albumName"];
    
    UIFont *placeholderfont = [UIFont fontWithName:@"SourceSansPro-Regular" size:14.5f];
    
    self.library = [[ALAssetsLibrary alloc] init];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
                    
                    if([[UIScreen mainScreen] bounds].size.height<568)
                    {
                        scviewlogin = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -80, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height+40)];
                    }
                    else
                    {
                        scviewlogin = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
                    }
                    [scviewlogin setDelegate:self];
                    [scviewlogin setScrollEnabled:NO];
                    scviewlogin.backgroundColor = [UIColor clearColor];
                    [scviewlogin setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+300)];
                    [self.view addSubview:scviewlogin];
                    
                    [self.navigationController setNavigationBarHidden:YES];
                    
                    
                    boxBG = [[UIImageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-225.0f)/2, 155.0f, 225.0f, 175)];
                    [boxBG setImage:[UIImage imageNamed:@"input-box-with-bg.png"]];
                    [scviewlogin addSubview:boxBG];
                    
                    welcomelbl = [[UILabel alloc] initWithFrame:CGRectMake(54, 160, 200, 30)];
                    welcomelbl.backgroundColor = [UIColor clearColor];
                    welcomelbl.font = [UIFont fontWithName:@"SourceSansPro-Semibold" size:15.5f];
                    welcomelbl.text=@"Welcome";
                    [scviewlogin addSubview:welcomelbl];
                    
                    to_lbl = [[UILabel alloc] initWithFrame:CGRectMake(119, 160, 200, 30)];
                    to_lbl.backgroundColor = [UIColor clearColor];
                    to_lbl.textColor = [UIColor blackColor];
                    to_lbl.text = @"to";
                    to_lbl.font = [UIFont fontWithName:@"SourceSansPro-Light" size:15.5f];
                    [scviewlogin addSubview:to_lbl];
                    
                    Photo_lbl = [[UILabel alloc] initWithFrame:CGRectMake(135, 160, 200, 30)];
                    Photo_lbl.backgroundColor = [UIColor clearColor];
                    Photo_lbl.textColor = [UIColor whiteColor];
                    Photo_lbl.text=@"PhotoXchange";
                    Photo_lbl.font =[UIFont fontWithName:@"SourceSansPro-Light" size:15.5f];
                    [scviewlogin addSubview:Photo_lbl];
                    
                    
                    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 204.5f, 213, 34)];
                    usernameTextField.textColor=[UIColor blackColor];
                    usernameTextField.font=placeholderfont;
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
                        usernameTextField.text=@""; //[prefs objectForKey:@"usernamesave"];
                    else
                        usernameTextField.text=@"";
                    usernameTextField.placeholder=@"Email";
                    [usernameTextField setValue:[UIColor colorWithRed:(52/255) green:(40/255)blue:(44/255) alpha:1]
                                     forKeyPath:@"_placeholderLabel.textColor"];
                    [usernameTextField setDelegate:self];
                    [usernameTextField setUserInteractionEnabled:YES];
                    usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
                    [scviewlogin addSubview:usernameTextField];
                    [scviewlogin bringSubviewToFront:usernameTextField];
                    
                    userpassTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 248.5f, 213, 34)];
                    userpassTextField.textColor=[UIColor blackColor];
                    userpassTextField.font=placeholderfont;
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
                        userpassTextField.text=@""; //[prefs objectForKey:@"passwordsave"];
                    else
                        userpassTextField.text=@"";
                    userpassTextField.placeholder=@"Password";
                    [userpassTextField setValue:[UIColor colorWithRed:(52/255) green:(40/255)blue:(44/255) alpha:1]
                                     forKeyPath:@"_placeholderLabel.textColor"];
                    [userpassTextField setDelegate:self];
                    [userpassTextField setSecureTextEntry:YES];
                    [userpassTextField setUserInteractionEnabled:YES];
                    [scviewlogin addSubview:userpassTextField];
                    [scviewlogin bringSubviewToFront:userpassTextField];
                    
                    forgetpassbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    forgetpassbutton.frame = CGRectMake(54, 297, 110, 20);
                    forgetpassbutton.titleLabel.font = [UIFont fontWithName:@"SourceSansPro-Semibold" size:12.5];
                    forgetpassbutton.titleLabel.textColor = UIColorFromRGB(0xc4c4c4);
                    [forgetpassbutton setTitle:@"Forgot password" forState:UIControlStateNormal];
                    [forgetpassbutton addTarget:self action:@selector(forgotpassword:) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:forgetpassbutton];
                    
                    UIImage *selected_image = [UIImage imageNamed:@"22222222.png"];
                    UIImage *un_selected_image = [UIImage imageNamed:@"1111111.png"];
                    remcheck = [UIButton buttonWithType:UIButtonTypeCustom];
                    remcheck.frame = CGRectMake(160, 295.5f, 200, 20);
//                    if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
//                    {
                        [remcheck setImage:un_selected_image forState:UIControlStateNormal];
//                    }
//                    else
//                    {
//                        [remcheck setImage:selected_image forState:UIControlStateNormal];
//                    }
                    
                    remcheck.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                    [remcheck setTitle:@"Remember Me" forState:UIControlStateNormal];
                    remcheck.titleLabel.font=[UIFont fontWithName:@"SourceSansPro-Semibold" size:12.5];
                    remcheck.titleEdgeInsets = UIEdgeInsetsMake(3.5f, 9, 0, 0);
                    remcheck.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    [remcheck addTarget:self action:@selector(rembercheck)forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:remcheck];
                    
                    loginbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    loginbutton.frame = CGRectMake(47.5f, 350, 225, 37.5);
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in.png"] forState:UIControlStateNormal];
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in1.png"] forState:UIControlStateSelected];
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in1.png"] forState:UIControlStateHighlighted];
                    [loginbutton addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:loginbutton];
                    
                    signupbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    signupbutton.frame = CGRectMake(47.5f, 397.5, 225, 37.5);
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign up.png"] forState:UIControlStateNormal];
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign up.png"] forState:UIControlStateSelected];
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign up.png"] forState:UIControlStateHighlighted];
                    [signupbutton addTarget:self action:@selector(signup:) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:signupbutton];
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                case UIInterfaceOrientationLandscapeLeft:
                {
                    
                    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
                    
                    scviewlogin = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -5, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width)];
                    [scviewlogin setDelegate:self];
                    [scviewlogin setScrollEnabled:YES];
                    scviewlogin.backgroundColor = [UIColor clearColor];
                    scviewlogin.userInteractionEnabled=YES;
                    [scviewlogin setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height-200)];
                    [self.view addSubview:scviewlogin];
                    
                    [self.navigationController setNavigationBarHidden:YES];
                    
                    
                    boxBG = [[UIImageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.height-225*2)/2, 105.0f-35, 225*2, 175)];
                    [boxBG setImage:[UIImage imageNamed:@"input-box-with-bg.png"]];
                    [scviewlogin addSubview:boxBG];
                    
                    welcomelbl = [[UILabel alloc] initWithFrame:CGRectMake(boxBG.frame.origin.x+6.5f, 110-35, 200, 30)];
                    welcomelbl.backgroundColor = [UIColor clearColor];
                    welcomelbl.font = [UIFont fontWithName:@"SourceSansPro-Semibold" size:15.5f];
                    welcomelbl.text=@"Welcome";
                    [scviewlogin addSubview:welcomelbl];
                    
                    to_lbl = [[UILabel alloc] initWithFrame:CGRectMake(welcomelbl.frame.origin.x+65, 110-35, 200, 30)];
                    to_lbl.backgroundColor = [UIColor clearColor];
                    to_lbl.textColor = [UIColor blackColor];
                    to_lbl.text = @"to";
                    to_lbl.font = [UIFont fontWithName:@"SourceSansPro-Light" size:15.5f];
                    [scviewlogin addSubview:to_lbl];
                    
                    Photo_lbl = [[UILabel alloc] initWithFrame:CGRectMake(to_lbl.frame.origin.x+14, 110-35, 200, 30)];
                    Photo_lbl.backgroundColor = [UIColor clearColor];
                    Photo_lbl.textColor = [UIColor whiteColor];
                    Photo_lbl.text=@"PhotoXchange";
                    Photo_lbl.font =[UIFont fontWithName:@"SourceSansPro-Light" size:15.5f];
                    [scviewlogin addSubview:Photo_lbl];
                    
                    
                    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(welcomelbl.frame.origin.x+16, 204.5f-85, 213, 34)];
                    usernameTextField.textColor=[UIColor blackColor];
                    usernameTextField.font=placeholderfont;
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
                        usernameTextField.text=@""; //[prefs objectForKey:@"usernamesave"];
                    else
                        usernameTextField.text=@"";
                    usernameTextField.placeholder=@"Email";
                    [usernameTextField setValue:[UIColor colorWithRed:(52/255) green:(40/255)blue:(44/255) alpha:1]
                                     forKeyPath:@"_placeholderLabel.textColor"];
                    [usernameTextField setDelegate:self];
                    [usernameTextField setUserInteractionEnabled:YES];
                    usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
                    [scviewlogin addSubview:usernameTextField];
                    [scviewlogin bringSubviewToFront:usernameTextField];
                    
                    
                    userpassTextField = [[UITextField alloc] initWithFrame:CGRectMake(welcomelbl.frame.origin.x+16, 248.5f-85, 213, 34)];
                    userpassTextField.textColor=[UIColor blackColor];
                    userpassTextField.font=placeholderfont;
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
                        userpassTextField.text=@""; //[prefs objectForKey:@"passwordsave"];
                    else
                        userpassTextField.text=@"";
                    userpassTextField.placeholder=@"Password";
                    [userpassTextField setValue:[UIColor colorWithRed:(52/255) green:(40/255)blue:(44/255) alpha:1]
                                     forKeyPath:@"_placeholderLabel.textColor"];
                    [userpassTextField setDelegate:self];
                    [userpassTextField setSecureTextEntry:YES];
                    [userpassTextField setUserInteractionEnabled:YES];
                    [userpassTextField addTarget:self
                                          action:@selector(textFieldFinished:)
                                forControlEvents:UIControlEventEditingDidEndOnExit];
                    [scviewlogin addSubview:userpassTextField];
                    [scviewlogin bringSubviewToFront:userpassTextField];
                    
                    forgetpassbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    forgetpassbutton.frame = CGRectMake(welcomelbl.frame.origin.x+41, 209, 110, 20);
                    forgetpassbutton.titleLabel.font = [UIFont fontWithName:@"SourceSansPro-Semibold" size:12.5];
                    forgetpassbutton.titleLabel.textColor = UIColorFromRGB(0xc4c4c4);
                    [forgetpassbutton setTitle:@"Forgot password" forState:UIControlStateNormal];
                    [forgetpassbutton addTarget:self action:@selector(forgotpassword:) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:forgetpassbutton];
                    
                    UIImage *selected_image = [UIImage imageNamed:@"22222222.png"];
                    UIImage *un_selected_image = [UIImage imageNamed:@"1111111.png"];
                    remcheck = [UIButton buttonWithType:UIButtonTypeCustom];
                    
//                    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
//                    {
                        [remcheck setImage:un_selected_image forState:UIControlStateNormal];
//                    }
//                    else
//                    {
//                        [remcheck setImage:selected_image forState:UIControlStateNormal];
//                    }
                    
                    remcheck.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                    [remcheck setTitle:@"Remember Me" forState:UIControlStateNormal];
                    remcheck.titleLabel.font=[UIFont fontWithName:@"SourceSansPro-Semibold" size:12.5];
                    remcheck.titleEdgeInsets = UIEdgeInsetsMake(3.5f, 9, 0, 0);
                    remcheck.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    [remcheck addTarget:self action:@selector(rembercheck)forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:remcheck];
                    
                    loginbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    loginbutton.frame = CGRectMake(boxBG.frame.origin.x+1, 350-95, boxBG.frame.size.width/2-1, 37.5);
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in.png"] forState:UIControlStateNormal];
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in1.png"] forState:UIControlStateSelected];
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in1.png"] forState:UIControlStateHighlighted];
                    [loginbutton addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:loginbutton];
                    
                    divider = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.height/2, 350-95, 1, 37.5)];
                    [divider setBackgroundColor:[UIColor colorWithRed:(56/225) green:(97/225) blue:(117/225) alpha:1]];
                    [scviewlogin addSubview:divider];
                    
                    remcheck.frame = CGRectMake(divider.frame.origin.x+41, 209, 200, 20);
                    
                    signupbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    signupbutton.frame = CGRectMake(divider.frame.origin.x+1, 350-95,boxBG.frame.size.width/2-1, 37.5);
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign up.png"] forState:UIControlStateNormal];
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign up.png"] forState:UIControlStateSelected];
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign up.png"] forState:UIControlStateHighlighted];
                    [signupbutton addTarget:self action:@selector(signup:) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:signupbutton];
                }
                    break;
            };
        }
            break;
        case UIUserInterfaceIdiomPad:
        {
            switch (self.interfaceOrientation) {
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]];
                    scviewlogin = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
                    [scviewlogin setDelegate:self];
                    [scviewlogin setScrollEnabled:NO];
                    scviewlogin.backgroundColor = [UIColor clearColor];
                    scviewlogin.userInteractionEnabled=YES;
                    [scviewlogin setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+300)];
                    [self.view addSubview:scviewlogin];
                    
                    boxBG = [[UIImageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width-1034/2)/2, 200, 1034/2, 608/2)];
                    [boxBG setImage:[UIImage imageNamed:@"input-box-with-bg-ipad@2x.png"]];
                    [scviewlogin addSubview:boxBG];
                    
                    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width-1034/2)/2+40, 305, 420, 40)];
                    usernameTextField.textColor=[UIColor blackColor];
                    usernameTextField.font=placeholderfont;
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
                        usernameTextField.text=@""; //[prefs objectForKey:@"usernamesave"];
                    else
                        usernameTextField.text=@"";
                    usernameTextField.placeholder=@"Email";
                    [usernameTextField setValue:[UIColor colorWithRed:(52/255) green:(40/255)blue:(44/255) alpha:1]
                                     forKeyPath:@"_placeholderLabel.textColor"];
                    [usernameTextField setDelegate:self];
                    [usernameTextField setUserInteractionEnabled:YES];
                    usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
                    [scviewlogin addSubview:usernameTextField];
                    [scviewlogin bringSubviewToFront:usernameTextField];
                    
                    
                    userpassTextField = [[UITextField alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width-1034/2)/2+40,390, 420, 40)];
                    userpassTextField.textColor=[UIColor blackColor];
                    userpassTextField.font=placeholderfont;
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
                        userpassTextField.text=@""; //[prefs objectForKey:@"passwordsave"];
                    else
                        userpassTextField.text=@"";
                    userpassTextField.placeholder=@"Password";
                    [userpassTextField setValue:[UIColor colorWithRed:(52/255) green:(40/255)blue:(44/255) alpha:1]
                                     forKeyPath:@"_placeholderLabel.textColor"];
                    [userpassTextField setDelegate:self];
                    [userpassTextField setSecureTextEntry:YES];
                    [userpassTextField setUserInteractionEnabled:YES];
                    [scviewlogin addSubview:userpassTextField];
                    [scviewlogin bringSubviewToFront:userpassTextField];
                    
                    forgetpassbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    forgetpassbutton.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-1034/2)/2+40, 460, 190, 20);
                    forgetpassbutton.titleLabel.font = [UIFont fontWithName:@"SourceSansPro-Semibold" size:17.5];
                    forgetpassbutton.titleLabel.textColor = UIColorFromRGB(0xc4c4c4);
                    [forgetpassbutton setTitle:@"Forgot password" forState:UIControlStateNormal];
                    [forgetpassbutton addTarget:self action:@selector(forgotpassword:) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:forgetpassbutton];
                    
                    UIImage *selected_image = [UIImage imageNamed:@"22222222.png"];
                    UIImage *un_selected_image = [UIImage imageNamed:@"1111111.png"];
                    remcheck = [UIButton buttonWithType:UIButtonTypeCustom];
                    
//                    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
//                    {
                        [remcheck setImage:un_selected_image forState:UIControlStateNormal];
//                    }
//                    else
//                    {
//                        [remcheck setImage:selected_image forState:UIControlStateNormal];
//                    }
                    remcheck.frame = CGRectMake(forgetpassbutton.frame.origin.x+forgetpassbutton.frame.size.width+1,460, 250, 20);
                    remcheck.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                    [remcheck setTitle:@"Remember Me" forState:UIControlStateNormal];
                    remcheck.titleLabel.font=[UIFont fontWithName:@"SourceSansPro-Semibold" size:17.5];
                    remcheck.titleEdgeInsets = UIEdgeInsetsMake(3.5f, 9, 0, 0);
                    remcheck.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    [remcheck addTarget:self action:@selector(rembercheck)forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:remcheck];
                    
                    loginbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    loginbutton.frame = CGRectMake(boxBG.frame.origin.x+1, boxBG.frame.origin.y+boxBG.frame.size.height+15, 517/2,119/2);
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in-ipad@2x.png"] forState:UIControlStateNormal];
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in-selected-ipad@2x.png"] forState:UIControlStateSelected];
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in-selected-ipad@2x.png"] forState:UIControlStateHighlighted];
                    [loginbutton addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:loginbutton];
                    
                    
                    signupbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    signupbutton.frame = CGRectMake(loginbutton.frame.origin.x+loginbutton.frame.size.width+1, boxBG.frame.origin.y+boxBG.frame.size.height+15,517/2, 119/2);
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign-up-ipad@2x.png"] forState:UIControlStateNormal];
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign-up-selected-ipad@2x.png"] forState:UIControlStateSelected];
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign-up-selected-ipad@2x.png"] forState:UIControlStateHighlighted];
                    [signupbutton addTarget:self action:@selector(signup:) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:signupbutton];
                }
                    break;
                case UIInterfaceOrientationPortrait:
                {
                    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]];
                    
                    scviewlogin = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
                    [scviewlogin setDelegate:self];
                    [scviewlogin setScrollEnabled:NO];
                    scviewlogin.backgroundColor = [UIColor clearColor];
                    scviewlogin.userInteractionEnabled=YES;
                    [scviewlogin setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+300)];
                    [self.view addSubview:scviewlogin];
                    
                    boxBG = [[UIImageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width-1034/2)/2, 200, 1034/2, 608/2)];
                    [boxBG setImage:[UIImage imageNamed:@"input-box-with-bg-ipad@2x.png"]];
                    [scviewlogin addSubview:boxBG];
                    
                    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width-1034/2)/2+40, 305, 420, 40)];
                    usernameTextField.textColor=[UIColor blackColor];
                    usernameTextField.font=placeholderfont;
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
                        usernameTextField.text=@""; //[prefs objectForKey:@"usernamesave"];
                    else
                        usernameTextField.text=@"";
                    usernameTextField.placeholder=@"Email";
                    [usernameTextField setValue:[UIColor colorWithRed:(52/255) green:(40/255)blue:(44/255) alpha:1]
                                     forKeyPath:@"_placeholderLabel.textColor"];
                    [usernameTextField setDelegate:self];
                    [usernameTextField setUserInteractionEnabled:YES];
                    usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
                    [scviewlogin addSubview:usernameTextField];
                    [scviewlogin bringSubviewToFront:usernameTextField];
                    
                    
                    userpassTextField = [[UITextField alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width-1034/2)/2+40,390, 420, 40)];
                    userpassTextField.textColor=[UIColor blackColor];
                    userpassTextField.font=placeholderfont;
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
                        userpassTextField.text=@""; //[prefs objectForKey:@"passwordsave"];
                    else
                        userpassTextField.text=@"";
                    userpassTextField.placeholder=@"Password";
                    [userpassTextField setValue:[UIColor colorWithRed:(52/255) green:(40/255)blue:(44/255) alpha:1]
                                     forKeyPath:@"_placeholderLabel.textColor"];
                    [userpassTextField setDelegate:self];
                    [userpassTextField setSecureTextEntry:YES];
                    [userpassTextField setUserInteractionEnabled:YES];
                    [scviewlogin addSubview:userpassTextField];
                    [scviewlogin bringSubviewToFront:userpassTextField];
                    
                    forgetpassbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    forgetpassbutton.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-1034/2)/2+40, 460, 190, 20);
                    forgetpassbutton.titleLabel.font = [UIFont fontWithName:@"SourceSansPro-Semibold" size:17.5];
                    forgetpassbutton.titleLabel.textColor = UIColorFromRGB(0xc4c4c4);
                    [forgetpassbutton setTitle:@"Forgot password" forState:UIControlStateNormal];
                    [forgetpassbutton addTarget:self action:@selector(forgotpassword:) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:forgetpassbutton];
                    
                    UIImage *selected_image = [UIImage imageNamed:@"22222222.png"];
                    UIImage *un_selected_image = [UIImage imageNamed:@"1111111.png"];
                    remcheck = [UIButton buttonWithType:UIButtonTypeCustom];
                    
//                    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
//                    {
                        [remcheck setImage:un_selected_image forState:UIControlStateNormal];
//                    }
//                    else
//                    {
//                        [remcheck setImage:selected_image forState:UIControlStateNormal];
//                    }
                    remcheck.frame = CGRectMake(forgetpassbutton.frame.origin.x+forgetpassbutton.frame.size.width+1,460, 250, 20);
                    remcheck.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                    [remcheck setTitle:@"Remember Me" forState:UIControlStateNormal];
                    remcheck.titleLabel.font=[UIFont fontWithName:@"SourceSansPro-Semibold" size:17.5];
                    remcheck.titleEdgeInsets = UIEdgeInsetsMake(3.5f, 9, 0, 0);
                    remcheck.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    [remcheck addTarget:self action:@selector(rembercheck)forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:remcheck];
                    
                    loginbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    loginbutton.frame = CGRectMake(boxBG.frame.origin.x+1, boxBG.frame.origin.y+boxBG.frame.size.height+15, 517/2,119/2);
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in-ipad@2x.png"] forState:UIControlStateNormal];
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in-selected-ipad@2x.png"] forState:UIControlStateSelected];
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in-selected-ipad@2x.png"] forState:UIControlStateHighlighted];
                    [loginbutton addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:loginbutton];
                    
                    
                    signupbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    signupbutton.frame = CGRectMake(loginbutton.frame.origin.x+loginbutton.frame.size.width+1, boxBG.frame.origin.y+boxBG.frame.size.height+15,517/2, 119/2);
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign-up-ipad@2x.png"] forState:UIControlStateNormal];
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign-up-selected-ipad@2x.png"] forState:UIControlStateSelected];
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign-up-selected-ipad@2x.png"] forState:UIControlStateHighlighted];
                    [signupbutton addTarget:self action:@selector(signup:) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:signupbutton];
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                case UIInterfaceOrientationLandscapeLeft:
                {
                    
                    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]];
                    
                    scviewlogin = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width)];
                    [scviewlogin setDelegate:self];
                    [scviewlogin setScrollEnabled:YES];
                    scviewlogin.backgroundColor = [UIColor clearColor];
                    scviewlogin.userInteractionEnabled=YES;
                    [scviewlogin setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+300)];
                    [self.view addSubview:scviewlogin];
                    
                    boxBG = [[UIImageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.height-1034/2)/2, 200, 1034/2, 608/2)];
                    [boxBG setImage:[UIImage imageNamed:@"input-box-with-bg-ipad@2x.png"]];
                    [scviewlogin addSubview:boxBG];
                    
                    
                    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.height-1034/2)/2+40, 305, [[UIScreen mainScreen] bounds].size.height-348, 40)];
                    usernameTextField.textColor=[UIColor blackColor];
                    usernameTextField.font=placeholderfont;
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
                        usernameTextField.text=@""; //[prefs objectForKey:@"usernamesave"];
                    else
                        usernameTextField.text=@"";
                    usernameTextField.placeholder=@"Email";
                    [usernameTextField setValue:[UIColor colorWithRed:(52/255) green:(40/255)blue:(44/255) alpha:1]
                                     forKeyPath:@"_placeholderLabel.textColor"];
                    [usernameTextField setDelegate:self];
                    [usernameTextField setUserInteractionEnabled:YES];
                    usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
                    [scviewlogin addSubview:usernameTextField];
                    [scviewlogin bringSubviewToFront:usernameTextField];
                    
                    
                    userpassTextField = [[UITextField alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.height-1034/2)/2+40, 390, [[UIScreen mainScreen] bounds].size.height-348, 40)];
                    userpassTextField.textColor=[UIColor blackColor];
                    userpassTextField.font=placeholderfont;
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
                        userpassTextField.text=@""; //[prefs objectForKey:@"passwordsave"];
                    else
                        userpassTextField.text=@"";
                    userpassTextField.placeholder=@"Password";
                    [userpassTextField setValue:[UIColor colorWithRed:(52/255) green:(40/255)blue:(44/255) alpha:1]
                                     forKeyPath:@"_placeholderLabel.textColor"];
                    [userpassTextField setDelegate:self];
                    [userpassTextField setSecureTextEntry:YES];
                    [userpassTextField setUserInteractionEnabled:YES];
                    userpassTextField.returnKeyType = UIReturnKeyDone;
                    [scviewlogin addSubview:userpassTextField];
                    [scviewlogin bringSubviewToFront:userpassTextField];
                    
                    
                    forgetpassbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    forgetpassbutton.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.height-1034/2)/2+40, 450, 190, 20);
                    forgetpassbutton.titleLabel.font = [UIFont fontWithName:@"SourceSansPro-Semibold" size:17.5];
                    forgetpassbutton.titleLabel.textColor = UIColorFromRGB(0xc4c4c4);
                    [forgetpassbutton setTitle:@"Forgot password" forState:UIControlStateNormal];
                    [forgetpassbutton addTarget:self action:@selector(forgotpassword:) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:forgetpassbutton];
                    
                    UIImage *selected_image = [UIImage imageNamed:@"22222222.png"];
                    UIImage *un_selected_image = [UIImage imageNamed:@"1111111.png"];
                    remcheck = [UIButton buttonWithType:UIButtonTypeCustom];
                    
//                    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"autologin"] isEqualToString:@"yes"])
//                    {
                        [remcheck setImage:un_selected_image forState:UIControlStateNormal];
//                    }
//                    else
//                    {
//                        [remcheck setImage:selected_image forState:UIControlStateNormal];
//                    }
                    remcheck.frame = CGRectMake(forgetpassbutton.frame.origin.x+forgetpassbutton.frame.size.width+1,450, 200, 20);
                    remcheck.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                    [remcheck setTitle:@"Remember Me" forState:UIControlStateNormal];
                    remcheck.titleLabel.font=[UIFont fontWithName:@"SourceSansPro-Semibold" size:12.5];
                    remcheck.titleEdgeInsets = UIEdgeInsetsMake(3.5f, 9, 0, 0);
                    remcheck.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    [remcheck addTarget:self action:@selector(rembercheck)forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:remcheck];
                    
                    loginbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    loginbutton.frame = CGRectMake(boxBG.frame.origin.x+1, boxBG.frame.origin.y+boxBG.frame.size.height+15, 517/2,119/2);
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in-ipad@2x.png"] forState:UIControlStateNormal];
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in-selected-ipad@2x.png"] forState:UIControlStateSelected];
                    [loginbutton setBackgroundImage:[UIImage imageNamed:@"sign-in-selected-ipad@2x.png"] forState:UIControlStateHighlighted];
                    [loginbutton addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:loginbutton];
                    
                    signupbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                    signupbutton.frame = CGRectMake(loginbutton.frame.origin.x+loginbutton.frame.size.width+1, boxBG.frame.origin.y+boxBG.frame.size.height+15,517/2, 119/2);
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign-up-ipad@2x.png"] forState:UIControlStateNormal];
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign-up-selected-ipad@2x.png"] forState:UIControlStateSelected];
                    [signupbutton setBackgroundImage:[UIImage imageNamed:@"sign-up-selected-ipad@2x.png"] forState:UIControlStateHighlighted];
                    [signupbutton addTarget:self action:@selector(signup:) forControlEvents:UIControlEventTouchUpInside];
                    [scviewlogin addSubview:signupbutton];
                }
                    break;
            }
            break;
        }
            break;
    }
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
}
- (void) orientationChanged:(NSNotification *)note
{
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        UIDevice * device = note.object;
        switch(device.orientation)
        {
            case UIDeviceOrientationPortrait:
            {
                [UIView animateWithDuration:1.0
                                 animations:^{
                                     
                                     scviewlogin.scrollEnabled = NO;
                                     if([[UIScreen mainScreen] bounds].size.height<568)
                                     {
                                         scviewlogin.frame = CGRectMake(0, -60, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height+40);
                                         boxBG.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-225.0f)/2, 155.0f, 225.0f, 175);
                                         welcomelbl.frame = CGRectMake(54, 160, 200, 30);
                                         to_lbl.frame = CGRectMake(119, 160, 200, 30);
                                         Photo_lbl.frame = CGRectMake(135, 160, 200, 30);
                                         usernameTextField.frame =CGRectMake(60, 204.5f, 213, 34);
                                         userpassTextField.frame = CGRectMake(60, 248.5f, 213, 34);
                                         forgetpassbutton.frame = CGRectMake(welcomelbl.frame.origin.x, 297, 110, 20);
                                         remcheck.frame = CGRectMake(160, 295.5f, 200, 20);
                                         signupbutton.frame = CGRectMake(47.5f, 397.5, 225, 37.5);
                                         loginbutton.frame = CGRectMake(47.5f, 350, 225, 37.5);
                                     }
                                     else
                                     {
                                         scviewlogin.frame = CGRectMake(0, -20, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
                                         boxBG.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-225.0f)/2, 155.0f, 225.0f, 175);
                                         welcomelbl.frame = CGRectMake(54, 160, 200, 30);
                                         to_lbl.frame = CGRectMake(119, 160, 200, 30);
                                         Photo_lbl.frame = CGRectMake(135, 160, 200, 30);
                                         usernameTextField.frame =CGRectMake(60, 204.5f, 213, 34);
                                         userpassTextField.frame = CGRectMake(60, 248.5f, 213, 34);
                                         forgetpassbutton.frame = CGRectMake(welcomelbl.frame.origin.x, 297, 110, 20);
                                         remcheck.frame = CGRectMake(160, 295.5f, 200, 20);
                                         signupbutton.frame = CGRectMake(47.5f, 397.5, 225, 37.5);
                                         loginbutton.frame = CGRectMake(47.5f, 350, 225, 37.5);
                                         
                                     }
                                     if(!divider.hidden)
                                     {
                                         divider.hidden=YES;
                                     }
                                     
                                 }
                                 completion:^(BOOL finished){ }];
                
            }
                break;
            case UIDeviceOrientationLandscapeLeft:
            case UIDeviceOrientationLandscapeRight:
            {
                [UIView animateWithDuration:1.0
                                 animations:^{
                                     BOOL present_divider = NO;
                                     for(UIView *sub in scviewlogin.subviews)
                                     {
                                         if(sub==divider)
                                         {
                                             if(divider.hidden)
                                             {
                                                 divider.hidden=NO;
                                             }
                                             present_divider = YES;
                                         }
                                     }
                                     if(!present_divider)
                                     {
                                         divider = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.height/2, 350-95, 1, 37.5)];
                                         [divider setBackgroundColor:[UIColor colorWithRed:(56/225) green:(97/225) blue:(117/225) alpha:1]];
                                         [scviewlogin addSubview:divider];
                                     }
                                     
                                     if([[UIScreen mainScreen] bounds].size.height<568)
                                     {
                                         scviewlogin.frame = CGRectMake(0, -20, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width);
                                     }
                                     else
                                     {
                                         scviewlogin.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width);
                                     }
                                     
                                     scviewlogin.userInteractionEnabled=YES;
                                     [scviewlogin setScrollEnabled:YES];
                                     boxBG.frame= CGRectMake(([[UIScreen mainScreen]bounds].size.height-225*2)/2, 105.0f-35, 225*2, 175);
                                     welcomelbl.frame = CGRectMake(boxBG.frame.origin.x+6.5f, 110-35, 200, 30);
                                     to_lbl.frame = CGRectMake(welcomelbl.frame.origin.x+65, 110-35, 200, 30);
                                     Photo_lbl.frame = CGRectMake(to_lbl.frame.origin.x+14, 110-35, 200, 30);
                                     usernameTextField.frame = CGRectMake(welcomelbl.frame.origin.x+16, 204.5f-85, 213, 34);
                                     userpassTextField.frame = CGRectMake(welcomelbl.frame.origin.x+16, 248.5f-85, 213, 34);
                                     forgetpassbutton.frame = CGRectMake(welcomelbl.frame.origin.x+41, 209, 110, 20);
                                     remcheck.frame = CGRectMake(divider.frame.origin.x+41, 209, 200, 20);
                                     loginbutton.frame = CGRectMake(boxBG.frame.origin.x+1, 350-95, boxBG.frame.size.width/2-1, 37.5);
                                     signupbutton.frame = CGRectMake(divider.frame.origin.x+1, 350-95,boxBG.frame.size.width/2-1, 37.5);
                                     
                                     if([[UIScreen mainScreen] bounds].size.height<568||self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft||self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
                                     {
                                         [UIView animateWithDuration:1.0 animations:^{
                                             [scviewlogin setContentOffset:CGPointZero animated:NO];
                                         }];
                                     }
                                     
                                 }
                                 completion:^(BOOL finished){ }];
            }
                break;
        };
    }
    else
    {
        UIDevice * device = note.object;
        switch(device.orientation)
        {
            case UIDeviceOrientationPortrait:
            {
                scviewlogin.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
                scviewlogin.scrollEnabled=NO;
                boxBG.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-1034/2)/2,200,1034/2,608/2);
                
                usernameTextField.frame =CGRectMake(([[UIScreen mainScreen]bounds].size.width-1034/2)/2+40, 305, 420, 40);
                userpassTextField.frame =CGRectMake(([[UIScreen mainScreen]bounds].size.width-1034/2)/2+40,390, 420, 40);
                forgetpassbutton.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-1034/2)/2+40, 460, 190, 20);
                remcheck.frame = CGRectMake(forgetpassbutton.frame.origin.x+forgetpassbutton.frame.size.width+1, 460, 200, 20);
                loginbutton.frame = CGRectMake(boxBG.frame.origin.x+1,boxBG.frame.origin.y+boxBG.frame.size.height+15, 517/2,119/2);
                signupbutton.frame = CGRectMake(loginbutton.frame.origin.x+loginbutton.frame.size.width+1,boxBG.frame.origin.y+boxBG.frame.size.height+15,517/2, 119/2);
                
                
            }
                break;
            case UIDeviceOrientationPortraitUpsideDown:
            {
                scviewlogin.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
                scviewlogin.scrollEnabled=NO;
                boxBG.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-1034/2)/2,200,1034/2,608/2);
                
                usernameTextField.frame =CGRectMake(([[UIScreen mainScreen]bounds].size.width-1034/2)/2+40, 305, 420, 40);
                userpassTextField.frame =CGRectMake(([[UIScreen mainScreen]bounds].size.width-1034/2)/2+40,390, 420, 40);
                forgetpassbutton.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-1034/2)/2+40, 460, 190, 20);
                remcheck.frame = CGRectMake(forgetpassbutton.frame.origin.x+forgetpassbutton.frame.size.width+1, 460, 200, 20);
                loginbutton.frame = CGRectMake(boxBG.frame.origin.x+1,boxBG.frame.origin.y+boxBG.frame.size.height+15, 517/2,119/2);
                signupbutton.frame = CGRectMake(loginbutton.frame.origin.x+loginbutton.frame.size.width+1,boxBG.frame.origin.y+boxBG.frame.size.height+15,517/2, 119/2);
                
                
            }
                break;
                
            case UIDeviceOrientationLandscapeRight:
            {
                [scviewlogin setScrollEnabled:YES];
                boxBG.frame= CGRectMake(([[UIScreen mainScreen]bounds].size.height-1034/2)/2, 200, 1034/2, 608/2);
                usernameTextField.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.height-1034/2)/2+40, 305, [[UIScreen mainScreen] bounds].size.height-348, 40);
                userpassTextField.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.height-1034/2)/2+40, 390, [[UIScreen mainScreen] bounds].size.height-348, 40);
                forgetpassbutton.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.height-1034/2)/2+40, 460, 190, 20);
                remcheck.frame = CGRectMake(forgetpassbutton.frame.origin.x+forgetpassbutton.frame.size.width+1, 460, 200, 20);
                loginbutton.frame = CGRectMake(boxBG.frame.origin.x+1,boxBG.frame.origin.y+boxBG.frame.size.height+15, 517/2,119/2);
                signupbutton.frame = CGRectMake(loginbutton.frame.origin.x+loginbutton.frame.size.width+1,boxBG.frame.origin.y+boxBG.frame.size.height+15,517/2, 119/2);
                
                
            }
                break;
            case UIDeviceOrientationLandscapeLeft:
            {
                scviewlogin.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width);
                [scviewlogin setScrollEnabled:YES];
                boxBG.frame= CGRectMake(([[UIScreen mainScreen]bounds].size.height-1034/2)/2, 200, 1034/2, 608/2);
                usernameTextField.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.height-1034/2)/2+40, 305, [[UIScreen mainScreen] bounds].size.height-348, 40);
                userpassTextField.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.height-1034/2)/2+40, 390, [[UIScreen mainScreen] bounds].size.height-348, 40);
                forgetpassbutton.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.height-1034/2)/2+40, 460, 190, 20);
                remcheck.frame = CGRectMake(forgetpassbutton.frame.origin.x+forgetpassbutton.frame.size.width+1, 460, 200, 20);
                loginbutton.frame = CGRectMake(boxBG.frame.origin.x+1,boxBG.frame.origin.y+boxBG.frame.size.height+15, 517/2,119/2);
                signupbutton.frame = CGRectMake(loginbutton.frame.origin.x+loginbutton.frame.size.width+1,boxBG.frame.origin.y+boxBG.frame.size.height+15,517/2, 119/2);
                
            }
                break;
                
        };
        
    }
}
-(void)rembercheck
{
    UIImage *selected_image = [UIImage imageNamed:@"22222222.png"];
    UIImage *un_selected_image = [UIImage imageNamed:@"1111111.png"];
    
    if([remember isEqualToString:@"N"])
    {
        NSLog(@"hello here");
        remember = @"Y";
        [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"autologin"];
        [remcheck setImage:selected_image forState:UIControlStateNormal];
    }
    else
    {
        remember = @"N";
        [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"autologin"];
        [remcheck setImage:un_selected_image forState:UIControlStateNormal];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.interfaceOrientation==UIDeviceOrientationPortrait && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
            scviewlogin.contentOffset = CGPointMake(0, 30);
        } completion:^(BOOL finished) {
            
        }];
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"called");
    if(self.interfaceOrientation==UIDeviceOrientationPortrait && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
            scviewlogin.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
    if (textField == usernameTextField)
    {
        [usernameTextField resignFirstResponder];
        [userpassTextField becomeFirstResponder];
    }
    else
    {
        [userpassTextField resignFirstResponder];
        [self signin];
    }
    return YES;
}


- (void)signin
{
    allerttext.text = @"";
    [userpassTextField resignFirstResponder];
    [usernameTextField resignFirstResponder];
    
    trimmedString = [[usernameTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    trimmedString2 = [[userpassTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    labelusername.text = @"";
    labelusername.textColor = UIColorFromRGB(0xe08c31);
    
    labelpass.text = @"";
    labelpass.textColor = UIColorFromRGB(0xe08c31);
    
    usernameTextField.layer.borderColor = [[UIColor whiteColor]CGColor];
    userpassTextField.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    
    if(![trimmedString length]>0)
    {
        labelusername.font = [UIFont fontWithName:@"Helvetica" size:12];
        labelusername.textColor = [UIColor redColor];
//        usernameTextField.layer.borderColor = [[UIColor redColor]CGColor];
//        usernameTextField.layer.masksToBounds=YES;
//        usernameTextField.layer.borderWidth= 1.0f;
//        labelusername.text = @"Email Can't be blank";
        alertv = [[UIAlertView alloc] initWithTitle:@"Email Can't be blank!"
                                           message:Nil
                                          delegate:self
                                 cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
        [alertv show];

        [usernameTextField becomeFirstResponder];
        labelusername.hidden = NO;
    }
    else if([emailTest evaluateWithObject:usernameTextField.text] == NO)
    {
        labelusername.font = [UIFont fontWithName:@"Helvetica" size:12];
        labelusername.textColor = [UIColor redColor];
//        usernameTextField.layer.borderColor = [[UIColor redColor]CGColor];
//        usernameTextField.layer.masksToBounds=YES;
//        usernameTextField.layer.borderWidth= 1.0f;
        [usernameTextField becomeFirstResponder];
//        labelusername.text = @"Proper email please";
        alertv = [[UIAlertView alloc] initWithTitle:@"Proper email please!"
                                            message:Nil
                                           delegate:self
                                  cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
        [alertv show];
        labelusername.hidden = NO;
    }
    else if(![trimmedString2 length]>0)
    {
        labelpass.font = [UIFont fontWithName:@"Helvetica" size:12];
        labelpass.textColor = [UIColor redColor];
//        userpassTextField.layer.borderColor = [[UIColor redColor]CGColor];
//        userpassTextField.layer.masksToBounds=YES;
//        userpassTextField.layer.borderWidth= 1.0f;
//        labelpass.text = @"Password Can't be blank";
        [userpassTextField becomeFirstResponder];
        alertv = [[UIAlertView alloc] initWithTitle:@"Password Can't be blank!"
                                            message:Nil
                                           delegate:self
                                  cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
        [alertv show];
        labelpass.hidden = NO;
    }
    else if ([trimmedString2 rangeOfCharacterFromSet:set].location != NSNotFound) {
        labelpass.font = [UIFont fontWithName:@"Helvetica" size:12];
        labelpass.textColor = [UIColor redColor];
//        userpassTextField.layer.borderColor = [[UIColor redColor]CGColor];
//        userpassTextField.layer.masksToBounds=YES;
//        userpassTextField.layer.borderWidth= 1.0f;
//        labelpass.text = @"Illegal Character";
        [userpassTextField becomeFirstResponder];
        alertv = [[UIAlertView alloc] initWithTitle:@"Illegal Character!"
                                            message:Nil
                                           delegate:self
                                  cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
        [alertv show];
        labelpass.hidden = NO;
    }
    else
    {
        [SVProgressHUD showWithStatus:@"Logging in, Please wait"];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        if([remember isEqualToString:@"Y"]) {
            [prefs setObject:trimmedString forKey:@"usernamesave"];
            [prefs setObject:trimmedString2 forKey:@"passwordsave"];
        } else if([remember isEqualToString:@"N"]) {
            [prefs setObject:@"" forKey:@"username"];
            [prefs setObject:@"" forKey:@"password"];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSDictionary *argumentDictionary = [NSDictionary dictionaryWithObjectsAndKeys:trimmedString, @"Object1Key", trimmedString2, @"Object2Key", nil];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(processlogin:) object:argumentDictionary];
        [que addOperation:operation];
        
    }
}
- (void)processlogin:(NSDictionary *)argumentDictionary
{
    if([self isNetworkAvailable])
    {
        NSString *useremail = [argumentDictionary objectForKey:@"Object1Key"];
        NSString *userpassword = [argumentDictionary objectForKey:@"Object2Key"];
        
        NSString *loginstring = [NSString stringWithFormat:@"%@login.php?USERNAME=%@&PASSWORD=%@",mydomainurl,[useremail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[userpassword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"%@",loginstring);
        
        NSError *localErr;
        
        NSData *dataURL =  [NSData dataWithContentsOfURL:[NSURL URLWithString:loginstring] options:NSDataReadingUncached error:&localErr];
        if(localErr!=nil)
        {
            NSLog(@" nil");
        }
        NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
        
        NSLog(@"serveroutput: %@",serverOutput);
        [SVProgressHUD dismiss];
        //        MBAlertView *aler = [[MBAlertView alloc] init];
        if([serverOutput isEqualToString:@""])
        {
            //            aler = [MBAlertView alertWithBody:@"Check Internet Connection" cancelTitle:@"Ok" cancelBlock:nil];
            //            [aler addToDisplayQueue];
            UIAlertView *show_alert1;
            show_alert1 = [[UIAlertView alloc] initWithTitle:@"Check Internet Connection !!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
            [show_alert1 show];
        }
        
        else
        {
            NSArray *arr = [serverOutput componentsSeparatedByString: @"||"];
            NSString *arra = [arr objectAtIndex:0];
            NSString *arraone = [arr objectAtIndex:1];
            if([arra isEqualToString:@"N"])
            {
                if([arraone isEqualToString:@"E"])
                {
                    //                    aler = [MBAlertView alertWithBody:@"Email not found" cancelTitle:@"Ok" cancelBlock:nil];
                    //                    [aler addToDisplayQueue];
                    UIAlertView *show_alert1;
                    show_alert1 = [[UIAlertView alloc] initWithTitle:@"Email not found !!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
                    [show_alert1 show];
                    
                }
                else if ([arraone isEqualToString:@"0"])
                {
                    //                    aler = [MBAlertView alertWithBody:@"Email/Password did not match" cancelTitle:@"Ok" cancelBlock:nil];
                    //                    [aler addToDisplayQueue];
                    UIAlertView *show_alert1;
                    show_alert1 = [[UIAlertView alloc] initWithTitle:@"Email/Password did not match !!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
                    [show_alert1 show];
                }
                else if ([arraone isEqualToString:@"not active"])
                {
                    //                    aler = [MBAlertView alertWithBody:@"Email/Password did not match" cancelTitle:@"Ok" cancelBlock:nil];
                    //                    [aler addToDisplayQueue];
                    UIAlertView *show_alert1;
                    show_alert1 = [[UIAlertView alloc] initWithTitle:@"Please Click on the Activation Link in Your Email to Activate the Profile !!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
                    [show_alert1 show];
                }

            }
            else
            {
                [SVProgressHUD dismiss];
                NSLog(@" arr is %d",[[arr objectAtIndex:4] length]);
                
                NSString *ftp_user,*ftp_path,*ftp_pass;
                NSString *userid = [arr objectAtIndex:1];
                NSString *username = [arr objectAtIndex:2];
                NSString *useremail = [arr objectAtIndex:3];
                if([[arr objectAtIndex:4] length]>0)
                {
                    NSLog(@"ciming ifffff");
                    ftp_user = [arr objectAtIndex:2];
                    ftp_path = [arr objectAtIndex:6];
                    ftp_pass = [arr objectAtIndex:5];
                }
                else
                {
                    NSLog(@"ciming elseeee");
                    ftp_user = [arr objectAtIndex:6];
                    ftp_path = ftp_user;
                    ftp_pass = userpassword;
                }
                
                
                
                [[NSUserDefaults standardUserDefaults] setObject:userid forKey:@"userid"];
                [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
                [[NSUserDefaults standardUserDefaults] setObject:useremail forKey:@"useremail"];
                [[NSUserDefaults standardUserDefaults] setObject:ftp_user forKey:@"ftp_user_name"];
                [[NSUserDefaults standardUserDefaults] setObject:ftp_pass forKey:@"ftp_user_pass"];
                [[NSUserDefaults standardUserDefaults] setObject:ftp_path forKey:@"ftp_path"];
                [[NSUserDefaults standardUserDefaults] setObject:userpassword forKey:@"userpassword"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                NSLog(@"userid: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]);
                NSLog(@"username: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"username"]);
                NSLog(@"useremail: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"useremail"]);
                NSLog(@"ftp_user_name: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_user_name"]);
                NSLog(@"ftp_user_pass: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_user_pass"]);
                NSLog(@"ftp_path: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]);
                NSLog(@"userpassword: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"userpassword"]);
                
                
                [self performSelectorOnMainThread:@selector(pullnextview) withObject:nil waitUntilDone:YES];
            }
        }
    }
    else
    {
        NSLog(@"-> no connection!\n");
        
    }
    
}

-(BOOL)isNetworkAvailable
{
    char *hostname;
    struct hostent *hostinfo;
    hostname = "google.com";
    hostinfo = gethostbyname (hostname);
    if (hostinfo == NULL)
    {
        [SVProgressHUD showErrorWithStatus:@"There is an issue with your internet connectivity. Please Check"];
        
        return NO;
    }
    else{
        NSLog(@"-> connection established!\n");
        return YES;
    }
}

-(void)pullnextview
{
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"isloggedin"];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    HomeViewController *control1 = [[HomeViewController alloc] init];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([[UIScreen mainScreen] bounds].size.height<568)
    {
        [UIView animateWithDuration:1.0 animations:^{
            [scviewlogin setContentOffset:CGPointMake(0, 150) animated:NO];
        }];
    }
    if(self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft||self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
    {
        [UIView animateWithDuration:1.0 animations:^{
            [scviewlogin setContentOffset:CGPointMake(0, 80) animated:NO];
        }];
    }
    if (textField ==userpassTextField)
        userpassTextField.returnKeyType = UIReturnKeyDone;
    return YES;
}
//-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    NSLog(@"called fg");
//    if (textField == usernameTextField)
//    {
//        [textField resignFirstResponder];
//        [userpassTextField becomeFirstResponder];
//    }
//    if (textField == userpassTextField)
//        [userpassTextField resignFirstResponder];
//    [textField resignFirstResponder];
//    if([[UIScreen mainScreen] bounds].size.height<568||self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft||self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
//    {
//        [UIView animateWithDuration:1.0 animations:^{
//            [scviewlogin setContentOffset:CGPointZero animated:NO];
//        }];
//    }
//        return YES;
//}


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//        if ([string isEqualToString:@"\n"]) {
//        [textField resignFirstResponder];
//    }
//    return YES;
//}

- (void)signup:(id)sender
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    RegisterViewController *control1 = [[RegisterViewController alloc] init];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
}
- (void)forgotpassword:(id)sender
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    ForgetpasswordViewController *control1 = [[ForgetpasswordViewController alloc] init];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)textFieldFinished:(id)sender
{
    [sender resignFirstResponder];
}

@end