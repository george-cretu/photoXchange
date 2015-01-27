//
//  ForgetpasswordViewController.m
//  Photoapp
//
//  Created by Esolz Technologies on 08/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import "ForgetpasswordViewController.h"
#import <QuartzCore/CoreAnimation.h>
#import "LoginViewController.h"
#import "MBHUDView.h"
#import "SVProgressHUD.h"

@interface ForgetpasswordViewController ()
{
    UIImageView *buttonusertrouble ;
    UILabel *headerlabel;
    UIButton *buttonusertrouble2;
    UIButton *button;
}

@end

@implementation ForgetpasswordViewController
@synthesize buttonlogin,emailTextField;

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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                {
//                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
//                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
//                    [self.view addSubview:buttonusertrouble];
//                    
//                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10.5, 320, 25)];
//                    [headerlabel setBackgroundColor:[UIColor clearColor]];
//                    [headerlabel setText:@"Forget password"];
//                    [headerlabel setTextColor:[UIColor whiteColor]];
//                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
//                    [headerlabel setTextAlignment:NSTextAlignmentCenter];
//                    [self.view addSubview:headerlabel];
//                    
//                    buttonusertrouble2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
//                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
//                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
//                    [buttonusertrouble2 addSubview:arrow_img];
//                    [buttonusertrouble2 addTarget:self action:@selector(gotoback)forControlEvents:UIControlEventTouchUpInside];
//                    [self.view addSubview:buttonusertrouble2];
                    
                    frgt_scrll_view.scrollEnabled= NO;
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft :
                {
//                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45)];
//                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
//                    [self.view addSubview:buttonusertrouble];
//                    
//                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25)];
//                    [headerlabel setBackgroundColor:[UIColor clearColor]];
//                    [headerlabel setText:@"Forget password"];
//                    [headerlabel setTextColor:[UIColor whiteColor]];
//                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
//                     [headerlabel setTextAlignment:NSTextAlignmentCenter];
//                    [self.view addSubview:headerlabel];
//                    
//                    buttonusertrouble2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
//                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
//                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
//                    [buttonusertrouble2 addSubview:arrow_img];
//                    [buttonusertrouble2 addTarget:self action:@selector(gotoback)forControlEvents:UIControlEventTouchUpInside];
//                    [self.view addSubview:buttonusertrouble2];
                    
                    [UIView animateWithDuration:1.0 animations:^{
                        [frgt_scrll_view setContentOffset:CGPointMake(0, 50)  animated:NO];
                        
                    }];
                    frgt_scrll_view.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.height, 600);
                }
                    break;
                case UIInterfaceOrientationLandscapeRight :
                {
//                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45)];
//                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
//                    [self.view addSubview:buttonusertrouble];
//                    
//                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25)];
//                    [headerlabel setBackgroundColor:[UIColor clearColor]];
//                    [headerlabel setText:@"Forget password"];
//                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
//                    [headerlabel setTextColor:[UIColor whiteColor]];
//                    [headerlabel setTextAlignment:NSTextAlignmentCenter];
//                    [self.view addSubview:headerlabel];
//                    
//                    
//                    buttonusertrouble2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
//                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
//                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
//                    [buttonusertrouble2 addSubview:arrow_img];
//                    [buttonusertrouble2 addTarget:self action:@selector(gotoback)forControlEvents:UIControlEventTouchUpInside];
//                    [self.view addSubview:buttonusertrouble2];
                    
                    [UIView animateWithDuration:1.0 animations:^{
                        [frgt_scrll_view setContentOffset:CGPointMake(0, 50)  animated:NO];
                        
                    }];
                    frgt_scrll_view.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.height, 600);
                }
                    break;
            }
        }
            break;
        case UIUserInterfaceIdiomPad:
        {
            switch (self.interfaceOrientation) {
                case UIInterfaceOrientationPortrait:
                {
//                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 45)];
//                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar@2x.png"];
//                    [self.view addSubview:buttonusertrouble];
//                    
//                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.width, 25)];
//                    [headerlabel setBackgroundColor:[UIColor clearColor]];
//                    [headerlabel setText:@"Forget password"];
//                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
//                    [headerlabel setTextColor:[UIColor whiteColor]];
//                    [headerlabel setTextAlignment:NSTextAlignmentCenter];
//                    [self.view addSubview:headerlabel];
//                    
//                    buttonusertrouble2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
//                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
//                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
//                    [buttonusertrouble2 addSubview:arrow_img];
//                    [buttonusertrouble2 addTarget:self action:@selector(gotoback)forControlEvents:UIControlEventTouchUpInside];
//                    [self.view addSubview:buttonusertrouble2];
                    emailTextField.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-236)/2, 189, 236, 46);
                     buttonlogin.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-251)/2, 275, 251, 44);
                }
                break;
                case UIInterfaceOrientationLandscapeLeft:
                {
//                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45)];
//                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar@2x.png"];
//                    [self.view addSubview:buttonusertrouble];
//                    
//                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25)];
//                    [headerlabel setBackgroundColor:[UIColor clearColor]];
//                    [headerlabel setText:@"Forget password"];
//                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
//                    [headerlabel setTextColor:[UIColor whiteColor]];
//                    [headerlabel setTextAlignment:NSTextAlignmentCenter];
//                    [self.view addSubview:headerlabel];
//                    
//                    buttonusertrouble2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
//                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
//                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
//                    [buttonusertrouble2 addSubview:arrow_img];
//                    [buttonusertrouble2 addTarget:self action:@selector(gotoback)forControlEvents:UIControlEventTouchUpInside];
//                    [self.view addSubview:buttonusertrouble2];
                    
                    emailTextField.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.height-236)/2, 189, 236, 46);
                    buttonlogin.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.height-251)/2, 275, 251, 44);
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
//                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45)];
//                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar@2x.png"];
//                    [self.view addSubview:buttonusertrouble];
//                    
//                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25)];
//                    [headerlabel setBackgroundColor:[UIColor clearColor]];
//                    [headerlabel setText:@"Forget password"];
//                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
//                    [headerlabel setTextColor:[UIColor whiteColor]];
//                    [headerlabel setTextAlignment:NSTextAlignmentCenter];
//                    [self.view addSubview:headerlabel];
//                    
//                    
//                    buttonusertrouble2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
//                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
//                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
//                    [buttonusertrouble2 addSubview:arrow_img];
//                    [buttonusertrouble2 addTarget:self action:@selector(gotoback)forControlEvents:UIControlEventTouchUpInside];
//                    [self.view addSubview:buttonusertrouble2];
                    
                    emailTextField.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.height-236)/2, 189, 236, 46);
                     buttonlogin.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.height-251)/2, 275, 251, 44);
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                {
//                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 45)];
//                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar@2x.png"];
//                    [self.view addSubview:buttonusertrouble];
//                    
//                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.width, 25)];
//                    [headerlabel setBackgroundColor:[UIColor clearColor]];
//                    [headerlabel setText:@"Forget password"];
//                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
//                    [headerlabel setTextColor:[UIColor whiteColor]];
//                    [headerlabel setTextAlignment:NSTextAlignmentCenter];
//                    [self.view addSubview:headerlabel];
//                    
//            
//                    buttonusertrouble2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
//                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
//                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
//                    [buttonusertrouble2 addSubview:arrow_img];
//                    [buttonusertrouble2 addTarget:self action:@selector(gotoback)forControlEvents:UIControlEventTouchUpInside];
//                    [self.view addSubview:buttonusertrouble2];
                    
                    emailTextField.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-236)/2, 189, 236, 46);
                     buttonlogin.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-251)/2, 275, 251, 44);
                }
                default:
                    break;
            }
        }
            break;
    }
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar@2x.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars=NO;
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bar.png"] forBarMetrics:nil];
    }
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationItem setTitle:@"Forget Password"];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                           UITextAttributeFont: [UIFont fontWithName:@"MyriadPro-Bold" size:18.5],
                                                           }];
    
    button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(gotoback)forControlEvents:UIControlEventTouchUpInside];
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
    
    
    self.navigationController.navigationBarHidden = NO;
    
    
    
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
                   
                    
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         emailTextField.frame = CGRectMake(34, 65, 251, 49);
                                         buttonlogin.frame = CGRectMake(34, 154, 251, 44);
                                         
                                         [UIView animateWithDuration:1.0 animations:^{
                                             frgt_scrll_view.frame = CGRectMake(0, 150, 320, [[UIScreen mainScreen] bounds].size.height);
                                             [frgt_scrll_view setContentOffset:CGPointZero  animated:NO];
                                             
                                         } completion:^(BOOL isFinished){ frgt_scrll_view.scrollEnabled = NO;}];
                                     }completion:^(BOOL finished){ }];
                    
                }
                    break;
                case UIDeviceOrientationLandscapeRight:
                case UIDeviceOrientationLandscapeLeft:
                {
                  
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         emailTextField.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.height-251)/2, 65, 251, 49);
                                         buttonlogin.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.height-251)/2, 154, 251, 44);
                                         [UIView animateWithDuration:1.0 animations:^{
                                             
                                             frgt_scrll_view.frame = CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
                                             [frgt_scrll_view setContentOffset:CGPointMake(0, 50)  animated:NO];
                                             frgt_scrll_view.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.height, 600);
                                         } completion:^(BOOL isFinished){frgt_scrll_view.scrollEnabled = YES;}];
                                     }
                                     completion:^(BOOL completion){ }];
                }
                    break;
               
            }

        }
            break;
        case UIUserInterfaceIdiomPad:
        {
            switch(device.orientation)
            {
                case UIDeviceOrientationPortraitUpsideDown:
                case UIDeviceOrientationPortrait:
                {
                    
                    emailTextField.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-236)/2, 189, 236, 46);
                    buttonlogin.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-251)/2, 275, 251, 44);
                }
                    break;
                case UIDeviceOrientationLandscapeRight:
                case UIDeviceOrientationLandscapeLeft:
                {
                   
                    emailTextField.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.height-236)/2, 189, 236, 46);
                    buttonlogin.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.height-251)/2, 275, 251, 44);
                }
                    break;
               
            }

        }
            break;
            
        default:
            break;
    }
}
- (void)gotoback
{
   
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    LoginViewController *control1 = [[LoginViewController alloc] init];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)forgotpass:(id)sender
{
    trimmedString = [[emailTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    labelusermail.text = @"Seems perfect";
//    labelusermail.textColor = UIColorFromRGB(0xe08c31);
    emailTextField.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if(![trimmedString length]>0)
    {
//        labelusermail.font = [UIFont fontWithName:@"Helvetica" size:12];
//        labelusermail.textColor = [UIColor redColor];
        emailTextField.layer.borderColor = [[UIColor redColor]CGColor];
        emailTextField.layer.masksToBounds=YES;
        emailTextField.layer.borderWidth= 1.0f;
       // labelusermail.text = @"Email Can't be blank";
        [emailTextField becomeFirstResponder];
        //labelusermail.hidden = NO;
    }
    else if([emailTest evaluateWithObject:emailTextField.text] == NO)
    {
//        labelusermail.font = [UIFont fontWithName:@"Helvetica" size:12];
//        labelusermail.textColor = [UIColor redColor];
        emailTextField.layer.borderColor = [[UIColor redColor]CGColor];
        emailTextField.layer.masksToBounds=YES;
        emailTextField.layer.borderWidth= 1.0f;
        [emailTextField becomeFirstResponder];
//        labelusermail.text = @"Proper email please";
//        labelusermail.hidden = NO;
    }
    else
    {
        NSString *loginstring = [NSString stringWithFormat:@"%@forgotpassword.php?email=%@",mydomainurl,[trimmedString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"%@",loginstring);
        [SVProgressHUD showWithStatus:@"Please Wait !!"];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: loginstring ]];
            NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
            [NSThread sleepForTimeInterval:1.0f];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"==================");
                NSLog(@"%@",serverOutput);
                NSLog(@"==================");
                [SVProgressHUD dismiss];
                if([serverOutput isEqualToString:@""])
                {
//                    MBAlertView *alertone = [MBAlertView alertWithBody:@"Check Internet Connection !!" cancelTitle:@"Cancel" cancelBlock:nil];
//                    [alertone addToDisplayQueue];
                    UIAlertView *show_alert1;
                    show_alert1 = [[UIAlertView alloc] initWithTitle:@"Check Internet Connection !!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
                    [show_alert1 show];

                }
                else if([serverOutput isEqualToString:@"0"])
                {
//                    MBAlertView *alert = [MBAlertView alertWithBody:@"Email not found!!" cancelTitle:@"Cancel" cancelBlock:nil];
//                    [alert addToDisplayQueue];
                    UIAlertView *show_alert1;
                    show_alert1 = [[UIAlertView alloc] initWithTitle:@"Email not found!!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
                    [show_alert1 show];

                }
                else {
//                    MBAlertView *alertss = [MBAlertView alertWithBody:@"Please check email for password" cancelTitle:nil cancelBlock:nil];
//                    [alertss addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
                    UIAlertView *show_alert1;
                    show_alert1 = [[UIAlertView alloc] initWithTitle:@"Please check email for password" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
                    [show_alert1 show];

                        CATransition* transition = [CATransition animation];
                        transition.duration = 0.5;
                        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                        transition.type = kCATransitionFade;
                        LoginViewController *control1 = [[LoginViewController alloc] init];
                        [self.navigationController.view.layer addAnimation:transition forKey:nil];
                        [[self navigationController] pushViewController:control1 animated:NO];
//                    }];
//                    [alertss addToDisplayQueue];
                }
            });
        });
        
    }
    
}
-(IBAction)hideKeyboard:(id)sender {
    [(UITextField*)sender resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
