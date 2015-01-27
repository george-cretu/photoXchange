//  RegisterViewController.m
//  Photoapp
//  Created by Bhaswar's MacBook Air on 09/04/14.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
#import "RegisterViewController.h"
#import <QuartzCore/CoreAnimation.h>
#import "LoginViewController.h"
#import "MBHUDView.h"
#import "SVProgressHUD.h"
@interface RegisterViewController ()
{
    UIImageView *buttonusertrouble;
    UILabel *headerlabel ;
    UIButton *backButton;
    UIAlertView *alertShow;
}
@end
@implementation RegisterViewController
@synthesize scviewregister;
@synthesize userpassTextField,useremailTextField,usernameTextField,labelpass,labeluseremail,labelusername,imageView,labelphoneno,userphoneTextField,labeltext,signupbutton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
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
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationItem setTitle:@"Signup"];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    labeltext.textColor = [UIColor whiteColor];
    
//    UIBarButtonItem *br_btn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-up1.png"] landscapeImagePhone:[UIImage imageNamed:@"back-up1.png"] style:UIBarButtonItemStyleDone target:self action:@selector(gotoback)];
//    
//    self.navigationItem.leftBarButtonItem = br_btn;
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(gotoback)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
    
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
                    scviewregister.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    scviewregister.contentSize=CGSizeMake(self.view.bounds.size.width, 485);
                    labeltext.frame= CGRectMake(31, 61, scviewregister.bounds.size.width-62, 21);
                    usernameTextField.frame= CGRectMake(31, 101, scviewregister.bounds.size.width-62, 49);
                    useremailTextField.frame= CGRectMake(31, 167, scviewregister.bounds.size.width-62, 49);
                    userpassTextField.frame= CGRectMake(31, 230, scviewregister.bounds.size.width-62, 49);
                    signupbutton.frame= CGRectMake(31, 295, scviewregister.bounds.size.width-62, 44);
                    
                    buttonusertrouble.frame = CGRectMake(0, 0, 320, 45);
                    headerlabel.frame = CGRectMake(0,10.5, 320, 25);
                    
                     if (self.view.bounds.size.height < 500)
                         scviewregister.scrollEnabled=YES;
                }
                    break;
                    
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    scviewregister.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    scviewregister.contentSize=CGSizeMake(self.view.bounds.size.width, 485);
                    labeltext.frame= CGRectMake(31, 61, scviewregister.bounds.size.width-62, 21);
                    usernameTextField.frame= CGRectMake(31, 101, scviewregister.bounds.size.width-62, 49);
                    useremailTextField.frame= CGRectMake(31, 167, scviewregister.bounds.size.width-62, 49);
                    userpassTextField.frame= CGRectMake(31, 230, scviewregister.bounds.size.width-62, 49);
                    signupbutton.frame= CGRectMake(31, 295, scviewregister.bounds.size.width-62, 44);
                    
                    buttonusertrouble.frame = CGRectMake(0, 0, 320, 45);
                    headerlabel.frame = CGRectMake(0,10.5, 320, 25);
                    
                    if (self.view.bounds.size.height < 500)
                        scviewregister.scrollEnabled=YES;
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    scviewregister.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    scviewregister.contentSize=CGSizeMake(self.view.bounds.size.width, 485);
                    scviewregister.scrollEnabled=YES;
                    scviewregister.showsVerticalScrollIndicator=YES;
                    labeltext.frame= CGRectMake(31, 61, self.view.bounds.size.width-62, 21);
                    usernameTextField.frame= CGRectMake(31, 101, self.view.bounds.size.width-62, 49);
                    useremailTextField.frame= CGRectMake(31, 167, self.view.bounds.size.width-62, 49);
                    userpassTextField.frame= CGRectMake(31, 230, self.view.bounds.size.width-62, 49);
                    signupbutton.frame= CGRectMake(31, 295, self.view.bounds.size.width-62, 74);
                    
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25);
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    scviewregister.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    scviewregister.contentSize=CGSizeMake(self.view.bounds.size.width, 485);
                    scviewregister.scrollEnabled=YES;
                    scviewregister.showsVerticalScrollIndicator=YES;
                    labeltext.frame= CGRectMake(31, 61, self.view.bounds.size.width-62, 21);
                    usernameTextField.frame= CGRectMake(31, 101, self.view.bounds.size.width-62, 49);
                    useremailTextField.frame= CGRectMake(31, 167, self.view.bounds.size.width-62, 49);
                    userpassTextField.frame= CGRectMake(31, 230, self.view.bounds.size.width-62, 49);
                    signupbutton.frame= CGRectMake(31, 295, self.view.bounds.size.width-62, 74);
                    
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25);
                }
                    break;
            }
        }
            break;
        case UIUserInterfaceIdiomPad:
        {
            switch (self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    scviewregister.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    scviewregister.contentSize=CGSizeMake(self.view.bounds.size.width, 485);
                    labeltext.frame= CGRectMake(31, 61, self.view.bounds.size.width-62, 21);
                    usernameTextField.frame= CGRectMake(31, 101, self.view.bounds.size.width-62, 49);
                    useremailTextField.frame= CGRectMake(31, 167, self.view.bounds.size.width-62, 49);
                    userpassTextField.frame= CGRectMake(31, 230, self.view.bounds.size.width-62, 49);
                    signupbutton.frame= CGRectMake(31, 295, self.view.bounds.size.width-62, 64);
                    
                    
                    buttonusertrouble.frame = CGRectMake(0, 0, 320, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.width, 25);
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                case UIInterfaceOrientationLandscapeLeft:
                {
                    scviewregister.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    scviewregister.contentSize=CGSizeMake(self.view.bounds.size.width, 485);
                    labeltext.frame= CGRectMake(31, 61, self.view.bounds.size.width-62, 21);
                    usernameTextField.frame= CGRectMake(31, 101, self.view.bounds.size.width-62, 49);
                    useremailTextField.frame= CGRectMake(31, 167, self.view.bounds.size.width-62, 49);
                    userpassTextField.frame= CGRectMake(31, 230, self.view.bounds.size.width-62, 49);
                    signupbutton.frame= CGRectMake(31, 295, self.view.bounds.size.width-62, 74);
                    
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25);
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
    switch ([[UIDevice currentDevice] userInterfaceIdiom])
    {
        case  UIUserInterfaceIdiomPhone:
        {
            UIDevice * device = note.object;
            switch(device.orientation)
            {
                case UIDeviceOrientationPortrait:
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    scviewregister.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    scviewregister.contentSize=CGSizeMake(self.view.bounds.size.width, 485);
                    labeltext.frame= CGRectMake(31, 61, scviewregister.bounds.size.width-62, 21);
                    usernameTextField.frame= CGRectMake(31, 101, scviewregister.bounds.size.width-62, 49);
                    useremailTextField.frame= CGRectMake(31, 167, scviewregister.bounds.size.width-62, 49);
                    userpassTextField.frame= CGRectMake(31, 230, scviewregister.bounds.size.width-62, 49);
                    signupbutton.frame= CGRectMake(31, 295, scviewregister.bounds.size.width-62, 44);
                    
                    buttonusertrouble.frame = CGRectMake(0, 0, 320, 45);
                    headerlabel.frame = CGRectMake(0,10.5, 320, 25);
                    if (self.view.bounds.size.height < 500)
                        scviewregister.scrollEnabled=YES;
                }
                    break;
                case UIDeviceOrientationLandscapeRight:
                {
                    scviewregister.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    scviewregister.contentSize=CGSizeMake(self.view.bounds.size.width, 485);
                    scviewregister.scrollEnabled=YES;
                    scviewregister.showsVerticalScrollIndicator=YES;
                    labeltext.frame= CGRectMake(31, 61, self.view.bounds.size.width-62, 21);
                    usernameTextField.frame= CGRectMake(31, 101, self.view.bounds.size.width-62, 49);
                    useremailTextField.frame= CGRectMake(31, 167, self.view.bounds.size.width-62, 49);
                    userpassTextField.frame= CGRectMake(31, 230, self.view.bounds.size.width-62, 49);
                    signupbutton.frame= CGRectMake(31, 295, self.view.bounds.size.width-62, 74);
                    
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25);
                 }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                {
                    scviewregister.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    scviewregister.scrollEnabled=YES;
                    scviewregister.contentSize=CGSizeMake(self.view.bounds.size.width, 485);
                    labeltext.frame= CGRectMake(31, 61, self.view.bounds.size.width-62, 21);
                    usernameTextField.frame= CGRectMake(31, 101, self.view.bounds.size.width-62, 49);
                    useremailTextField.frame= CGRectMake(31, 167, self.view.bounds.size.width-62, 49);
                    userpassTextField.frame= CGRectMake(31, 230, self.view.bounds.size.width-62, 49);
                    signupbutton.frame= CGRectMake(31, 295, self.view.bounds.size.width-62, 74);
                    
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5,[[UIScreen mainScreen]bounds].size.height, 25);
                }
                    break;
             };
        }
            break;
        case  UIUserInterfaceIdiomPad:
        {
            UIDevice * device = note.object;
            switch(device.orientation)
            {
                case UIDeviceOrientationPortrait:
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    scviewregister.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    scviewregister.contentSize=CGSizeMake(self.view.bounds.size.width, 485);
                    labeltext.frame= CGRectMake(31, 61, self.view.bounds.size.width-62, 21);
                    usernameTextField.frame= CGRectMake(31, 101, self.view.bounds.size.width-62, 49);
                    useremailTextField.frame= CGRectMake(31, 167, self.view.bounds.size.width-62, 49);
                    userpassTextField.frame= CGRectMake(31, 230, self.view.bounds.size.width-62, 49);
                    signupbutton.frame= CGRectMake(31, 295, self.view.bounds.size.width-62, 64);
                    
                    
                    buttonusertrouble.frame = CGRectMake(0, 0, 320, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.width, 25);
                }
                    break;
                    
                case UIDeviceOrientationLandscapeRight:
                {
                    scviewregister.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    scviewregister.contentSize=CGSizeMake(self.view.bounds.size.width, 485);
                    labeltext.frame= CGRectMake(31, 61, self.view.bounds.size.width-62, 21);
                    usernameTextField.frame= CGRectMake(31, 101, self.view.bounds.size.width-62, 49);
                    useremailTextField.frame= CGRectMake(31, 167, self.view.bounds.size.width-62, 49);
                    userpassTextField.frame= CGRectMake(31, 230, self.view.bounds.size.width-62, 49);
                    signupbutton.frame= CGRectMake(31, 295, self.view.bounds.size.width-62, 74);
                    
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25);
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                {
                    scviewregister.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    scviewregister.contentSize=CGSizeMake(self.view.bounds.size.width, 485);
                    labeltext.frame= CGRectMake(31, 61, self.view.bounds.size.width-62, 21);
                    usernameTextField.frame= CGRectMake(31, 101, self.view.bounds.size.width-62, 49);
                    useremailTextField.frame= CGRectMake(31, 167, self.view.bounds.size.width-62, 49);
                    userpassTextField.frame= CGRectMake(31, 230, self.view.bounds.size.width-62, 49);
                    signupbutton.frame= CGRectMake(31, 295, self.view.bounds.size.width-62, 74);
                    
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5,[[UIScreen mainScreen]bounds].size.height, 25);
                }
                    break;
            };
        }
            break;
    }
}

- (IBAction)signup:(id)sender
{
    [useremailTextField resignFirstResponder];
    [self.userpassTextField resignFirstResponder];
    [self.scviewlogin setContentOffset:CGPointZero animated:YES];
    
    trimmedString = [[usernameTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    trimmedString2 = [[userpassTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    trimmedString3 = [[useremailTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    trimmedString4 = [[userphoneTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    labelusername.text = @"";
    labelusername.textColor = UIColorFromRGB(0xe08c31);
    labelpass.text = @"";
    labelpass.textColor = UIColorFromRGB(0xe08c31);
    labeluseremail.text = @"";
    labeluseremail.textColor = UIColorFromRGB(0xe08c31);
    labelphoneno.text = @"";
    labelphoneno.textColor = UIColorFromRGB(0xe08c31);
    
    usernameTextField.layer.borderColor = [[UIColor clearColor]CGColor];
    userpassTextField.layer.borderColor = [[UIColor clearColor]CGColor];
    useremailTextField.layer.borderColor = [[UIColor clearColor]CGColor];
    userphoneTextField.layer.borderColor = [[UIColor clearColor]CGColor];
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789 "] invertedSet];
    setone = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    
    if(![trimmedString length]>0)
    {
        labelusername.font = [UIFont fontWithName:@"Helvetica" size:12];
        labelusername.textColor = [UIColor redColor];
        usernameTextField.layer.borderColor = [[UIColor redColor]CGColor];
        usernameTextField.layer.masksToBounds=YES;
        usernameTextField.layer.borderWidth= 1.0f;
        labelusername.text = @"Name Can't be blank";
        [usernameTextField becomeFirstResponder];
        labelusername.hidden = NO;
        return;
    }
    else if ([trimmedString rangeOfCharacterFromSet:set].location != NSNotFound) {
        labelusername.font = [UIFont fontWithName:@"Helvetica" size:12];
        labelusername.textColor = [UIColor redColor];
        usernameTextField.layer.borderColor = [[UIColor redColor]CGColor];
        usernameTextField.layer.masksToBounds=YES;
        usernameTextField.layer.borderWidth= 1.0f;
        labelusername.text = @"Illegal Character";
        [usernameTextField becomeFirstResponder];
        labelusername.hidden = NO;
        return;
    }
    else if(![trimmedString3 length]>0)
    {
        labeluseremail.font = [UIFont fontWithName:@"Helvetica" size:12];
        labeluseremail.textColor = [UIColor redColor];
        useremailTextField.layer.borderColor = [[UIColor redColor]CGColor];
        useremailTextField.layer.masksToBounds=YES;
        useremailTextField.layer.borderWidth= 1.0f;
        labeluseremail.text = @"Email Can't be blank";
        [useremailTextField becomeFirstResponder];
        labeluseremail.hidden = NO;
        return;
    }
    else if([emailTest evaluateWithObject:useremailTextField.text] == NO)
    {
        labeluseremail.font = [UIFont fontWithName:@"Helvetica" size:12];
        labeluseremail.textColor = [UIColor redColor];
        useremailTextField.layer.borderColor = [[UIColor redColor]CGColor];
        useremailTextField.layer.masksToBounds=YES;
        useremailTextField.layer.borderWidth= 1.0f;
        labeluseremail.text = @"Proper Email Please";
        [useremailTextField becomeFirstResponder];
        labeluseremail.hidden = NO;
        return;
    }
    else if(![trimmedString2 length]>0)
    {
        labelpass.font = [UIFont fontWithName:@"Helvetica" size:12];
        labelpass.textColor = [UIColor redColor];
        userpassTextField.layer.borderColor = [[UIColor redColor]CGColor];
        userpassTextField.layer.masksToBounds=YES;
        userpassTextField.layer.borderWidth= 1.0f;
        labelpass.text = @"Password Can't be blank";
        [userpassTextField becomeFirstResponder];
        labelpass.hidden = NO;
        return;
    }
    else if(![self validatePassword:trimmedString2])
    {
        labelpass.font = [UIFont fontWithName:@"Helvetica" size:12];
        labelpass.textColor = [UIColor redColor];
        userpassTextField.layer.borderColor = [[UIColor redColor]CGColor];
        userpassTextField.layer.masksToBounds=YES;
        userpassTextField.layer.borderWidth= 1.0f;
        labelpass.text = @"Password have to be 6-8 character long";
        [userpassTextField becomeFirstResponder];
        labelpass.hidden = NO;
        return;
    }
    else if ([trimmedString2 rangeOfCharacterFromSet:setone].location != NSNotFound) {
        labelpass.font = [UIFont fontWithName:@"Helvetica" size:12];
        labelpass.textColor = [UIColor redColor];
        userpassTextField.layer.borderColor = [[UIColor redColor]CGColor];
        userpassTextField.layer.masksToBounds=YES;
        userpassTextField.layer.borderWidth= 1.0f;
        labelpass.text = @"Illegal Character";
        [userpassTextField becomeFirstResponder];
        labelpass.hidden = NO;
        return;
    }
    else
    {
        CGRect frame;
        frame.origin  = self.scviewregister.contentOffset;
        if(frame.origin.y>0)
        {
            [userphoneTextField resignFirstResponder];
            [UIView animateWithDuration:1.0 animations:^{
                [self.scviewregister setContentOffset:CGPointZero  animated:NO];} completion:^(BOOL isfinished){
                    [SVProgressHUD showWithStatus:@"Checking Email availability!! Please wait"];
                    NSDictionary *argumentDictionary = [NSDictionary dictionaryWithObjectsAndKeys:trimmedString, @"Object1Key", trimmedString2, @"Object2Key", trimmedString3, @"Object3Key", trimmedString4, @"Object4Key", nil];
                    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(processregister:) object:argumentDictionary];
                    [que addOperation:operation];
                }];
        }
        else
        {
            [SVProgressHUD showWithStatus:@"Checking Email availability!! Please wait"];
            NSDictionary *argumentDictionary = [NSDictionary dictionaryWithObjectsAndKeys:trimmedString, @"Object1Key", trimmedString2, @"Object2Key", trimmedString3, @"Object3Key", trimmedString4, @"Object4Key", nil];
            NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(processregister:) object:argumentDictionary];
            [que addOperation:operation];
        }
    }
}

-(BOOL)validatePhone:(NSString*)phone {
    if ([phone length] < 10) {
        return NO;
    }
    NSString *phoneRegex = @"^[0-9]{3}-[0-9]{3}-[0-9]{4}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return ![test evaluateWithObject:phone];
}
-(BOOL)validatePassword:(NSString*)password {
    if ([password length] < 6 || [password length] > 8) {
        return NO;
    }
    else
    {
        return YES;
    }
}


- (void)processregister:(NSDictionary *)argumentDictionary
{
    @try {
    
    NSString *usermane = [argumentDictionary objectForKey:@"Object1Key"];
    NSString *userpassword = [argumentDictionary objectForKey:@"Object2Key"];
    NSString *useremail = [argumentDictionary objectForKey:@"Object3Key"];
    NSString *userphone = [argumentDictionary objectForKey:@"Object4Key"];
    
    NSString *loginstring = [NSString stringWithFormat:@"%@signup.php?name=%@&password=%@&email=%@&phoneno=%@",mydomainurl,[usermane stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[userpassword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[useremail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[userphone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",loginstring);
    
    NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: loginstring ]];
        
        if (dataURL == nil)
        {
            alertShow = [[UIAlertView alloc] initWithTitle:@"Error in Server Connection!"
                                                   message:nil
                                                  delegate:self
                                         cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
            [alertShow show];
        }
        else
        {
        
    NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
    
    [SVProgressHUD dismiss];
    if([serverOutput isEqualToString:@""])
    {
        UIAlertView *show_alert1;
        show_alert1 = [[UIAlertView alloc] initWithTitle:@"Check Internet Connection !!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [show_alert1 show];
    }
    else if([serverOutput isEqualToString:@"N"])
    {
        UIAlertView *show_alert1;
        show_alert1 = [[UIAlertView alloc] initWithTitle:@"There is some technical Problem!! Try again Later !!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [show_alert1 show];
    }
    else
    {
        NSLog(@"%@",serverOutput);
        NSLog(@"==================");
        if([serverOutput isEqualToString:@"2"]) {
            [SVProgressHUD dismiss];
            UIAlertView *show_alert1;
            show_alert1 = [[UIAlertView alloc] initWithTitle:@"Email Already Exists !! Try with different one !!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
            [show_alert1 show];
        }
        else if([serverOutput isEqualToString:@"3"]) {
            [SVProgressHUD dismiss];
            UIAlertView *show_alert1;
            show_alert1 = [[UIAlertView alloc] initWithTitle:@"Phone No Already Exists !! Try with different one !!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
            [show_alert1 show];
        }
        else {
            [SVProgressHUD dismiss];
            UIAlertView *show_alert1;
            show_alert1 = [[UIAlertView alloc] initWithTitle:@"Signup Successful !! Please check email for details" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
            [show_alert1 show];
            
            CATransition* transition = [CATransition animation];
            transition.duration = 0.5;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionFade;
            LoginViewController *control1 = [[LoginViewController alloc] init];
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            [[self navigationController] pushViewController:control1 animated:NO];
        }
    }
    }
    }
    @catch (NSException *exception) {
        NSLog(@"exception dropbox: %@",exception);
    }
    @finally {
    }
}


-(void)hideKeyboard:(id)sender {
    [(UITextField*)sender resignFirstResponder];
}
-(void)movetozero:(id)sender
{
    [(UITextField*)sender resignFirstResponder];
    
    [UIView animateWithDuration:1.0 animations:^{
        [self.scviewregister setContentOffset:CGPointMake(0, -45)  animated:NO];
    }];
}
-(void)movetotop:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        [self.scviewregister setContentOffset:CGPointMake(0, 150)  animated:NO];
    }];
}

- (void)showWithStatus {
	[SVProgressHUD showWithStatus:@"Please Wait"];
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
-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    if (textField == useremailTextField)
    {
        [userpassTextField becomeFirstResponder];
        [self textFieldShouldBeginEditing:userpassTextField];
    }
    else if (textField == usernameTextField)
    {
        [useremailTextField becomeFirstResponder];
        [self textFieldShouldBeginEditing:useremailTextField];
    }
    else
    {
        [textField resignFirstResponder];
        if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad)
        {
            NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
            if ([[ver objectAtIndex:0] intValue] >= 7)
                self.scviewregister.contentOffset= CGPointMake(0, -65);
            else
                self.scviewregister.contentOffset= CGPointMake(0, 0);
        }
        else
        {
            NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
            
            if ([[ver objectAtIndex:0] intValue] >= 7)
            self.scviewregister.contentOffset= CGPointMake(0, -65);
            
            else
            self.scviewregister.contentOffset= CGPointMake(0, 0);
        }
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"hj");
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    NSLog(@"portrait appear");
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    self.scviewregister.contentOffset= CGPointMake(0, -65);
                    
                    if (self.view.bounds.size.height < 500)
                    {
                        if (textField == usernameTextField)
                            self.scviewregister.contentOffset= CGPointMake(0, 40);
                        if (textField == useremailTextField)
                            self.scviewregister.contentOffset= CGPointMake(0, 100);
                        if (textField == userpassTextField)
                            self.scviewregister.contentOffset= CGPointMake(0, 160);
                    }
                }
                    break;
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    NSLog(@"upside down appear");
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    self.scviewregister.contentOffset= CGPointMake(0, -65);
                    
                    if (self.view.bounds.size.height < 500)
                    {
                        if (textField == usernameTextField)
                            self.scviewregister.contentOffset= CGPointMake(0, 40);
                        if (textField == useremailTextField)
                            self.scviewregister.contentOffset= CGPointMake(0, 100);
                        if (textField == userpassTextField)
                            self.scviewregister.contentOffset= CGPointMake(0, 160);
                    }
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    NSLog(@"appearing right");
                    if (textField == usernameTextField)
                        self.scviewregister.contentOffset= CGPointMake(0, 40);
                    if (textField == useremailTextField)
                        self.scviewregister.contentOffset= CGPointMake(0, 100);
                    if (textField == userpassTextField)
                        self.scviewregister.contentOffset= CGPointMake(0, 160);
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    NSLog(@"appearing left");
                    if (textField == usernameTextField)
                        self.scviewregister.contentOffset= CGPointMake(0, 40);
                    if (textField == useremailTextField)
                        self.scviewregister.contentOffset= CGPointMake(0, 100);
                    if (textField == userpassTextField)
                        self.scviewregister.contentOffset= CGPointMake(0, 160);
                }
                    break;
            }
        }
            break;
        case UIUserInterfaceIdiomPad:
        {
            switch (self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                        self.scviewregister.contentOffset= CGPointMake(0, -65);
                    else
                    self.scviewregister.contentOffset= CGPointMake(0, 0);
                }
                    break;
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                        self.scviewregister.contentOffset= CGPointMake(0, -65);
                    else
                    self.scviewregister.contentOffset= CGPointMake(0, 0);
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                        self.scviewregister.contentOffset= CGPointMake(0, -65);
                    else
                    self.scviewregister.contentOffset= CGPointMake(0, 0);
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                        self.scviewregister.contentOffset= CGPointMake(0, -65);
                    else
                    self.scviewregister.contentOffset= CGPointMake(0, 0);
                }
                    break;
            }
            break;
        }
            break;
    }
    return YES;
}
@end