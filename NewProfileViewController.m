//
//  NewProfileViewController.m
//  Photoapp
//
//  Created by Bhaswar's MacBook Air on 08/04/14.
//  Copyright (c) 2014 Esolz Technologies Pvt Ltd. All rights reserved.
#import "NewProfileViewController.h"
#import <QuartzCore/CoreAnimation.h>
#import "HomeViewController.h"
#import "MBHUDView.h"
#import "SVProgressHUD.h"

@interface NewProfileViewController ()
{
    UIImageView *buttonusertrouble;
    UILabel *headerlabel;
    UIButton *backButton;
    UIButton *button;
    NSString *passprev;
}
@end

@implementation NewProfileViewController
@synthesize scviewprofile;
@synthesize userpassTextField,userconfpassTextField,usernameTextField,useremail,labelpass,labeluserconfpass,labelusername,labelphoneno,userphoneTextField,labeltext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    scviewprofile.userInteractionEnabled=YES;
    que = [NSOperationQueue new];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar@2x.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bar.png"] forBarMetrics:nil];
    }
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationItem setTitle:@"Profile Details"];
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
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    scviewprofile= [[UIScrollView alloc]init];
    [self.view addSubview:scviewprofile];
    scviewprofile.backgroundColor=[UIColor clearColor];
    scviewprofile.frame = CGRectMake(25.5f, 45, self.view.bounds.size.width-51,[[UIScreen mainScreen]bounds].size.height);
    scviewprofile.contentSize=CGSizeMake(269,[[UIScreen mainScreen]bounds].size.height);
    scviewprofile.showsVerticalScrollIndicator=NO;
    scviewprofile.showsHorizontalScrollIndicator=NO;
}


-(void)orientationChangedProfile:(NSNotification *)note
{
    NSLog(@"ashchhe");
    UIDevice * device = note.object;
    switch(device.orientation)
    {
            //            switch(self.interfaceOrientation)
            //        {
        case UIDeviceOrientationPortrait:
        {
            NSLog(@"portrait orient");
            scviewprofile.frame = CGRectMake(25.5f, 45, self.view.bounds.size.width-51,[[UIScreen mainScreen]bounds].size.height);
            [editbt addTarget:self action:@selector(edit_prof:) forControlEvents:UIControlEventTouchUpInside];
            
            labeltext.frame =CGRectMake(0, 20, scviewprofile.bounds.size.width, 44);
            usernameTextField.frame = CGRectMake(0, 60, scviewprofile.bounds.size.width, 44);
            useremail.frame = CGRectMake(0, 115, scviewprofile.bounds.size.width, 44);
            userpassTextField.frame = CGRectMake(0, 170, scviewprofile.bounds.size.width, 44);
            userconfpassTextField.frame = CGRectMake(0, 225, scviewprofile.bounds.size.width, 44);
            editbt.frame = CGRectMake(0, 280, scviewprofile.bounds.size.width, 44);
        }
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
        {
            NSLog(@"upside down orient");
            scviewprofile.frame = CGRectMake(25.5f, 45, self.view.bounds.size.width-51,[[UIScreen mainScreen]bounds].size.height);
            [editbt addTarget:self action:@selector(edit_prof:) forControlEvents:UIControlEventTouchUpInside];
            
            labeltext.frame =CGRectMake(0, 20, scviewprofile.bounds.size.width, 44);
            usernameTextField.frame = CGRectMake(0, 60, scviewprofile.bounds.size.width, 44);
            useremail.frame = CGRectMake(0, 115, scviewprofile.bounds.size.width, 44);
            userpassTextField.frame = CGRectMake(0, 170, scviewprofile.bounds.size.width, 44);
            userconfpassTextField.frame = CGRectMake(0, 225, scviewprofile.bounds.size.width, 44);
            editbt.frame = CGRectMake(0, 280, scviewprofile.bounds.size.width, 44);
        }
            break;
        case UIInterfaceOrientationLandscapeRight:
        {
            NSLog(@"appearing orient");
            scviewprofile.frame = CGRectMake(25.5f, 30, self.view.bounds.size.width-51, [[UIScreen mainScreen]bounds].size.width);
            [editbt addTarget:self action:@selector(edit_prof:) forControlEvents:UIControlEventTouchUpInside];
            
            labeltext.frame =CGRectMake(0, 20, scviewprofile.bounds.size.width, 44);
            usernameTextField.frame = CGRectMake(0, 60, scviewprofile.bounds.size.width, 44);
            useremail.frame = CGRectMake(0, 115, scviewprofile.bounds.size.width, 44);
            userpassTextField.frame = CGRectMake(0, 170, scviewprofile.bounds.size.width, 44);
            userconfpassTextField.frame = CGRectMake(0, 225, scviewprofile.bounds.size.width, 44);
            editbt.frame = CGRectMake(0, 280, scviewprofile.bounds.size.width, 44);
        }
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
        {
            NSLog(@"appearing orient");
            scviewprofile.frame = CGRectMake(25.5f, 30, self.view.bounds.size.width-51, [[UIScreen mainScreen]bounds].size.width);
            [editbt addTarget:self action:@selector(edit_prof:) forControlEvents:UIControlEventTouchUpInside];
            
            labeltext.frame =CGRectMake(0, 20, scviewprofile.bounds.size.width, 44);
            usernameTextField.frame = CGRectMake(0, 60, scviewprofile.bounds.size.width, 44);
            useremail.frame = CGRectMake(0, 115, scviewprofile.bounds.size.width, 44);
            userpassTextField.frame = CGRectMake(0, 170, scviewprofile.bounds.size.width, 44);
            userconfpassTextField.frame = CGRectMake(0, 225, scviewprofile.bounds.size.width, 44);
            editbt.frame = CGRectMake(0, 280, scviewprofile.bounds.size.width, 44);
        }
            break;
            //        }
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    NSString *populate_string = [NSString stringWithFormat:@"%@gather_profile_details.php?id=%@",mydomainurl,[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]];
    NSLog(@" %@",populate_string);
    [NSThread detachNewThreadSelector:@selector(populatefield:) toTarget:self withObject:populate_string];
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    NSLog(@"portrait appear");
                    scviewprofile.frame = CGRectMake(25.5f, 45, self.view.bounds.size.width-51,[[UIScreen mainScreen]bounds].size.height);
                    [editbt addTarget:self action:@selector(edit_prof:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                    
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    NSLog(@"upside down appear");
                    scviewprofile.frame = CGRectMake(25.5f, 45, self.view.bounds.size.width-51,[[UIScreen mainScreen]bounds].size.height);
                    [editbt addTarget:self action:@selector(edit_prof:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    NSLog(@"appearing right");
                    scviewprofile.frame = CGRectMake(25.5f, 30, self.view.bounds.size.width-51, [[UIScreen mainScreen]bounds].size.width);
                    [editbt addTarget:self action:@selector(edit_prof:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    NSLog(@"appearing left");
                    scviewprofile.frame = CGRectMake(25.5f, 30, self.view.bounds.size.width-51, [[UIScreen mainScreen]bounds].size.width);
                    [editbt addTarget:self action:@selector(edit_prof:) forControlEvents:UIControlEventTouchUpInside];
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
                    NSLog(@"portrait appear");
                    scviewprofile.frame = CGRectMake(25.5f, 45, self.view.bounds.size.width-51,[[UIScreen mainScreen]bounds].size.height);
                    [editbt addTarget:self action:@selector(edit_prof:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                    
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    NSLog(@"upside down appear");
                    scviewprofile.frame = CGRectMake(25.5f, 45, self.view.bounds.size.width-51,[[UIScreen mainScreen]bounds].size.height);
                    [editbt addTarget:self action:@selector(edit_prof:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    NSLog(@"appearing left");
                    scviewprofile.frame = CGRectMake(25.5f, 45, self.view.bounds.size.width-51, [[UIScreen mainScreen]bounds].size.width);
                    [editbt addTarget:self action:@selector(edit_prof:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    NSLog(@"appearing left");
                    scviewprofile.frame = CGRectMake(25.5f, 45, self.view.bounds.size.width-51, [[UIScreen mainScreen]bounds].size.width);
                    [editbt addTarget:self action:@selector(edit_prof:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
            }
            break;
        }
            break;
    }
    userphoneTextField.hidden = YES;
    
    
    
    
    labeltext=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, scviewprofile.bounds.size.width, 44)];
    [scviewprofile addSubview:labeltext];
    labeltext.backgroundColor=[UIColor clearColor];
    labeltext.textAlignment=NSTextAlignmentCenter;
    labeltext.text =@"Edit Your Profile";
    labeltext.textColor=UIColorFromRGB(0xf79a28);
    
    usernameTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 60, scviewprofile.bounds.size.width, 44)];
    [scviewprofile addSubview:usernameTextField];
    usernameTextField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bar-1.png"]];
    usernameTextField.placeholder=@"Name";
    usernameTextField.textColor=[UIColor blackColor];
    usernameTextField.textAlignment=NSTextAlignmentCenter;
    usernameTextField.delegate=self;
    
    useremail = [[UITextField alloc]initWithFrame:CGRectMake(0, 115, scviewprofile.bounds.size.width, 44)];
    [scviewprofile addSubview:useremail];
    useremail.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bar-1.png"]];
    useremail.placeholder=@"Email";
    useremail.textColor=[UIColor blackColor];
    useremail.textAlignment=NSTextAlignmentCenter;
    useremail.delegate=self;
    
    userpassTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 170, scviewprofile.bounds.size.width, 44)];
    [scviewprofile addSubview:userpassTextField];
    userpassTextField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bar-1.png"]];
    userpassTextField.placeholder=@"Password";
    userpassTextField.textColor=[UIColor blackColor];
    userpassTextField.textAlignment=NSTextAlignmentCenter;
    userpassTextField.delegate=self;
    userpassTextField.secureTextEntry=YES;
    
    userconfpassTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 225, scviewprofile.bounds.size.width, 44)];
    [scviewprofile addSubview:userconfpassTextField];
    userconfpassTextField.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bar-1.png"]];
    userconfpassTextField.placeholder=@"Confirm Password";
    userconfpassTextField.textColor=[UIColor blackColor];
    userconfpassTextField.textAlignment=NSTextAlignmentCenter;
    userconfpassTextField.delegate=self;
    userconfpassTextField.secureTextEntry=YES;
    
    editbt= [[UIButton alloc]initWithFrame:CGRectMake(0, 280, scviewprofile.bounds.size.width, 44)];
    [scviewprofile addSubview:editbt];
    editbt.backgroundColor=[UIColor colorWithRed:105.0f/255.0f green:164.0f/255.0f blue:194.0f/255.0f alpha:1];
    NSString *titleForButton = [NSString stringWithFormat: @"Save Profile"];
    [editbt setTitle:titleForButton forState:UIControlStateNormal];
    editbt.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [editbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editbt addTarget:self action:@selector(edit_prof:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChangedProfile:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
    //    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //    [[NSNotificationCenter defaultCenter]
    //     addObserver:self selector:@selector(orientationChangedProfile:)
    //     name:UIDeviceOrientationDidChangeNotification
    //     object:[UIDevice currentDevice]];
}


-(void)populatefield:(NSString *)string
{
    NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: string ]];
    NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
    usernameTextField.text =  [[serverOutput componentsSeparatedByString: @"##"] objectAtIndex:0];
    userphoneTextField.text = [[serverOutput componentsSeparatedByString: @"##"] objectAtIndex:1];
//    userpassTextField.text = [[serverOutput componentsSeparatedByString: @"##"] objectAtIndex:2];
    passprev = [[serverOutput componentsSeparatedByString: @"##"] objectAtIndex:2];
    useremail.text = [[serverOutput componentsSeparatedByString: @"##"] objectAtIndex:3];
}
-(void)edit_prof:(id)sender
{
    trimmedString = [[usernameTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    trimmedString2 = [[userpassTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    trimmedString3 = [[userconfpassTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    trimmedString4 = [[userphoneTextField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    setone = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789 "] invertedSet];
    
    labelusername.text = @"";
    labelusername.textColor = UIColorFromRGB(0xe08c31);
    
    labelpass.text = @"";
    labelpass.textColor = UIColorFromRGB(0xe08c31);
    
    labeluserconfpass.text = @"";
    labeluserconfpass.textColor = UIColorFromRGB(0xe08c31);
    
    labelphoneno.text = @"";
    labelphoneno.textColor = UIColorFromRGB(0xe08c31);
    
    if(![trimmedString length]>0)
    {
        UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Name Can't be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    else if ([trimmedString rangeOfCharacterFromSet:set].location != NSNotFound) {
        UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Illegal Character" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    else if(![self NSStringIsValidEmail:useremail.text])
    {
        [useremail becomeFirstResponder];
        UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Email Id is Invalid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    else if(([trimmedString2 length]>0 || [trimmedString3 length] > 0) && ![self validatePassword:trimmedString2])
    {
        
            UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Password have to be 6-8 characters long" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            return;
    }
    else if(([trimmedString2 length]>0 || [trimmedString3 length] > 0) && ![self validatePassword:trimmedString3])
    {
        
        UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Confirm Password have to be 6-8 characters long" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return;
    }

    else if (([trimmedString2 length]>0 || [trimmedString3 length] > 0) && [trimmedString2 rangeOfCharacterFromSet:setone].location != NSNotFound)
        {
            UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Illegal character" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            return;
        }
    else if (([trimmedString2 length]>0 || [trimmedString3 length] > 0) && ![trimmedString2 isEqualToString:trimmedString3])
        {
            UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Password and confirm password do not match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            return;
        }
        else if (([trimmedString2 length]>0 || [trimmedString3 length] > 0) && [trimmedString2 isEqualToString:passprev])
        {
            UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"You have entered your old password, Please Update with a New Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            return;
        }

    else
    {
        if ([trimmedString2 length] == 0)
        {
            trimmedString2 = passprev;
            trimmedString3 = passprev;
        }
        CGRect frame;
        frame.origin  = self.scviewprofile.contentOffset;
        if(frame.origin.y>0)
        {
            [userphoneTextField resignFirstResponder];
            [UIView animateWithDuration:1.0 animations:^{
                [self.scviewprofile setContentOffset:CGPointZero  animated:NO];} completion:^(BOOL isfinished){
//                    [SVProgressHUD showWithStatus:@"Updating your profile !! Please wait"];
//                    NSDictionary *argumentDictionary = [NSDictionary dictionaryWithObjectsAndKeys:trimmedString, @"Object1Key", trimmedString2, @"Object2Key", trimmedString4, @"Object3Key", nil];
//                    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(processregister:) object:argumentDictionary];
//                    [que addOperation:operation];
                }];
        }
       
            [SVProgressHUD showWithStatus:@"Updating your profile !! Please wait"];
            NSDictionary *argumentDictionary = [NSDictionary dictionaryWithObjectsAndKeys:trimmedString, @"Object1Key", trimmedString2, @"Object2Key", trimmedString4, @"Object3Key", nil];
//            NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(processregister:) object:argumentDictionary];
//            [que addOperation:operation];
            
            dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(q, ^{
                
                NSString *usermane = [argumentDictionary objectForKey:@"Object1Key"];
                NSString *userpassword = [argumentDictionary objectForKey:@"Object2Key"];
                NSString *userphone = [argumentDictionary objectForKey:@"Object3Key"];
                
                NSString *loginstring = [NSString stringWithFormat:@"%@edit_profile.php?name=%@&password=%@&id=%@&phoneno=%@&email=%@",mydomainurl,[usermane stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[userpassword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"],[userphone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[useremail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
                NSLog(@"%@",loginstring);
                
                NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: loginstring ]];
                NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
                
                NSLog(@"%@",serverOutput);
                
                [SVProgressHUD dismiss];
                if([serverOutput isEqualToString:@""])
                {
                    //        MBAlertView *alertone = [MBAlertView alertWithBody:@"Check Internet Connection !!" cancelTitle:@"Cancel" cancelBlock:nil];
                    //        [alertone addToDisplayQueue];
                    [self performSelectorOnMainThread:@selector(checknet) withObject:nil waitUntilDone:YES];
                }
                else if([serverOutput isEqualToString:@"N"])
                {
                    //        MBAlertView *alert = [MBAlertView alertWithBody:@"There is some technical Problem !! Try again Later !!" cancelTitle:@"Cancel" cancelBlock:nil];
                    //        [alert addToDisplayQueue];
                    
                    [self performSelectorOnMainThread:@selector(techproblem) withObject:nil waitUntilDone:YES];
                }
                else if ([serverOutput isEqualToString:@"Y"])
                {
                    [SVProgressHUD dismiss];
                    //        [SVProgressHUD setAnimationDidStopSelector:nil];
                    //        [SVProgressHUD dismiss];
                    
                    //        MBAlertView *alertss = [MBAlertView alertWithBody:@"Profile has been updated with new details" cancelTitle:nil cancelBlock:nil];
                    //        [alertss addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
                    
                    [self performSelectorOnMainThread:@selector(yesSuccess) withObject:nil waitUntilDone:YES];
                    
                    
                    //        }];
                    //        [alertss addToDisplayQueue];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:userpassword forKey:@"passwordsave"];
                    NSLog(@" data saved %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"passwordsave"]);
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:serverOutput];
                }

                dispatch_async(dispatch_get_main_queue(), ^{
                     [SVProgressHUD dismiss];
                });
            });
        }
}


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
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
}


-(void)hideKeyboard:(id)sender {
    [(UITextField*)sender resignFirstResponder];
}

-(void)movetozero:(id)sender
{
    [(UITextField*)sender resignFirstResponder];
    switch (self.interfaceOrientation)
    {
        case UIInterfaceOrientationPortrait:
        {
            [UIView animateWithDuration:1.0 animations:^{
                [self.scviewprofile setContentOffset:CGPointMake(0, -20) animated:NO];
            }];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            [UIView animateWithDuration:1.0 animations:^{
                [self.scviewprofile setContentOffset:CGPointMake(0, 90) animated:NO];
            }];
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            break;
    }
}

-(void)movetotop:(id)sender
{
    CGPoint new_point = (CGPoint){.x=0,.y=0};
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            new_point = (CGPoint){.x=0,.y=150};
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            new_point = (CGPoint){.x=0,.y=180};
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            break;
    }
    [UIView animateWithDuration:1.0 animations:^{
        [self.scviewprofile setContentOffset:new_point animated:NO];
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
    HomeViewController *control1 = [[HomeViewController alloc] init];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == usernameTextField)
    {
        [useremail becomeFirstResponder];
        [self textFieldShouldBeginEditing:useremail];
    }
    
    else if (textField == useremail)
    {
        [userpassTextField becomeFirstResponder];
        [self textFieldShouldBeginEditing:userpassTextField];
    }
    
    else if (textField == userpassTextField)
    {
        [userconfpassTextField becomeFirstResponder];
        [self textFieldShouldBeginEditing:userconfpassTextField];
    }
    else
    {
        [textField resignFirstResponder];
        if (self.view.bounds.size.height <= 568)
        {
            scviewprofile.contentOffset= CGPointMake(0, 0);
        }
        if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad)
        {
            if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
                scviewprofile.contentOffset= CGPointMake(0, -65);
            else
                scviewprofile.contentOffset= CGPointMake(0, 0);
        }
        else
            scviewprofile.contentOffset= CGPointMake(0, -65);
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //    if (self.view.frame.size.height == 480)
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    NSLog(@"portrait appear");
                    
                    if (self.view.bounds.size.height <= 568)
                    {
                        if (textField == userpassTextField)
                            scviewprofile.contentOffset= CGPointMake(0, 40);
                        if (textField == userconfpassTextField)
                            scviewprofile.contentOffset= CGPointMake(0, 100);
                        else
                            scviewprofile.contentOffset= CGPointMake(0, 0);
                    }
                    else
                        scviewprofile.contentOffset= CGPointMake(0, -65);
                }
                    break;
                    
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    NSLog(@"upside down appear");
                    
                    if (self.view.bounds.size.height <= 568)
                    {
                        if (textField == userpassTextField)
                            scviewprofile.contentOffset= CGPointMake(0, 40);
                        if (textField == userconfpassTextField)
                            scviewprofile.contentOffset= CGPointMake(0, 100);
                        else
                            scviewprofile.contentOffset= CGPointMake(0, 0);
                    }
                    else
                        scviewprofile.contentOffset= CGPointMake(0, -65);
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    NSLog(@"appearing right");
                    if (textField == useremail)
                        scviewprofile.contentOffset= CGPointMake(0, 40);
                    if (textField == userpassTextField)
                        scviewprofile.contentOffset= CGPointMake(0, 100);
                    if (textField == userconfpassTextField)
                        scviewprofile.contentOffset= CGPointMake(0, 160);
                    
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    NSLog(@"appearing left");
                    if (textField == useremail)
                        scviewprofile.contentOffset= CGPointMake(0, 40);
                    if (textField == userpassTextField)
                        scviewprofile.contentOffset= CGPointMake(0, 100);
                    if (textField == userconfpassTextField)
                        scviewprofile.contentOffset= CGPointMake(0, 160);
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
                    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
                        scviewprofile.contentOffset= CGPointMake(0, -65);
                }
                    break;
                    
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
                        scviewprofile.contentOffset= CGPointMake(0, -65);
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
                        scviewprofile.contentOffset= CGPointMake(0, -65);
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
                        scviewprofile.contentOffset= CGPointMake(0, -65);
                }
                    break;
            }
            break;
        }
            break;
    }
    
    return YES;
}


-(void)yesSuccess
{
    UIAlertView *show_alert1;
    show_alert1 = [[UIAlertView alloc] initWithTitle:@"Profile has been updated with new details" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
    [show_alert1 show];
    
    NewProfileViewController *new = [[NewProfileViewController alloc]init];
    [self.navigationController pushViewController:new animated:NO];
}

-(void)checknet
{
UIAlertView *show_alert1;
show_alert1 = [[UIAlertView alloc] initWithTitle:@"Check Internet Connection !!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
[show_alert1 show];
}

-(void)techproblem
{
    UIAlertView *show_alert1;
    show_alert1 = [[UIAlertView alloc] initWithTitle:@"There is some technical Problem !! Try again Later !!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
    [show_alert1 show];
}
@end