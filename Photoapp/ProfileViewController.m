//
//  ProfileViewController.m
//  Photoapp
//
//  Created by Soumalya on 23/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import "ProfileViewController.h"
#import <QuartzCore/CoreAnimation.h>
#import "HomeViewController.h"
#import "MBHUDView.h"
#import "SVProgressHUD.h"

@interface ProfileViewController ()
{
    UIImageView *buttonusertrouble;
    UILabel *headerlabel;
    UIButton *backButton;
    UIAlertView *alertShow;
    UIButton *button;
}
@end

@implementation ProfileViewController
@synthesize scviewprofile;
@synthesize userpassTextField,userconfpassTextField,usernameTextField,useremail,labelpass,labeluserconfpass,labelusername,labelphoneno,userphoneTextField,labeltext;

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


-(void)orientationChangedProfile:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
        {
            scviewprofile.frame = CGRectMake(25, -10, 269,[[UIScreen mainScreen]bounds].size.height);
            [labeltext setTextColor:UIColorFromRGB(0xf79a28)];
            [labeltext setBackgroundColor:[UIColor clearColor]];
            [labeltext setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:16.5]];
            scviewprofile.contentSize=CGSizeMake(269,[[UIScreen mainScreen]bounds].size.height);
        }
            break;
        case UIDeviceOrientationLandscapeLeft:
        {
                NSLog(@"appearing left");
                scviewprofile.contentSize=CGSizeMake(260, [[UIScreen mainScreen]bounds].size.width+50);
                scviewprofile.backgroundColor=[UIColor clearColor];
                scviewprofile.frame = CGRectMake(150, -10, 269, [[UIScreen mainScreen]bounds].size.width);
                [editbt removeFromSuperview];
                editbt= [[UIButton alloc]initWithFrame:CGRectMake(0, 320, 269, 44)];
                [scviewprofile addSubview:editbt];
                editbt.backgroundColor=[UIColor colorWithRed:105.0f/255.0f green:164.0f/255.0f blue:194.0f/255.0f alpha:1];
                NSString *titleForButton = [NSString stringWithFormat: @"Save Profile"];
                [editbt setTitle:titleForButton forState:UIControlStateNormal];
                editbt.titleLabel.font = [UIFont systemFontOfSize:17.0f];
                [editbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [editbt addTarget:self action:@selector(processregister:) forControlEvents:UIControlEventTouchUpInside];
        }
          break;

        case UIDeviceOrientationLandscapeRight:
        {
            NSLog(@"appearing here");
            scviewprofile.contentSize=CGSizeMake(260, [[UIScreen mainScreen]bounds].size.width+50);
            scviewprofile.backgroundColor=[UIColor clearColor];
            scviewprofile.frame = CGRectMake(150, -10, 269, [[UIScreen mainScreen]bounds].size.width);
            [editbt removeFromSuperview];
            editbt= [[UIButton alloc]initWithFrame:CGRectMake(0, 320, 269, 44)];
            [scviewprofile addSubview:editbt];
            editbt.backgroundColor=[UIColor colorWithRed:105.0f/255.0f green:164.0f/255.0f blue:194.0f/255.0f alpha:1];
            NSString *titleForButton = [NSString stringWithFormat: @"Save Profile"];
            [editbt setTitle:titleForButton forState:UIControlStateNormal];
            editbt.titleLabel.font = [UIFont systemFontOfSize:17.0f];
            [editbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [editbt addTarget:self action:@selector(processregister:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case UIDeviceOrientationUnknown:
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
            break;
            
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
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    scviewprofile.frame = CGRectMake(25, -10, 269,[[UIScreen mainScreen]bounds].size.height);
                    [labeltext setTextColor:UIColorFromRGB(0xf79a28)];
                    [labeltext setBackgroundColor:[UIColor clearColor]];
                    [labeltext setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:16.5]];
                    scviewprofile.contentSize=CGSizeMake(269,[[UIScreen mainScreen]bounds].size.height);
                    
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                    {
                        NSLog(@"appearing left");
                        scviewprofile.contentSize=CGSizeMake(260, [[UIScreen mainScreen]bounds].size.width+50);
                        scviewprofile.backgroundColor=[UIColor clearColor];
                        scviewprofile.frame = CGRectMake(150, -10, 269, [[UIScreen mainScreen]bounds].size.width);
                        [editbt removeFromSuperview];
                        editbt= [[UIButton alloc]initWithFrame:CGRectMake(0, 320, 269, 44)];
                        [scviewprofile addSubview:editbt];
                        editbt.backgroundColor=[UIColor colorWithRed:105.0f/255.0f green:164.0f/255.0f blue:194.0f/255.0f alpha:1];
                        NSString *titleForButton = [NSString stringWithFormat: @"Save Profile"];
                        [editbt setTitle:titleForButton forState:UIControlStateNormal];
                        editbt.titleLabel.font = [UIFont systemFontOfSize:17.0f];
                        [editbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [editbt addTarget:self action:@selector(processregister:) forControlEvents:UIControlEventTouchUpInside];
                        
                    }
                    break;

                case UIInterfaceOrientationLandscapeLeft:
                {
//                    scviewprofile.backgroundColor=[UIColor yellowColor];
//                    scviewprofile.frame = CGRectMake(200, -10, 260, [[UIScreen mainScreen]bounds].size.width);
//                    
//                    [labeltext setTextColor:UIColorFromRGB(0xf79a28)];
//                    [labeltext setBackgroundColor:[UIColor clearColor]];
//                    [labeltext setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:16.5]];
//                    editbt.frame= CGRectMake(-100, 372, 80, 44);
//                    scviewprofile.contentSize=CGSizeMake(260, [[UIScreen mainScreen]bounds].size.width);
                    
                    NSLog(@"appearing here");
                    scviewprofile.contentSize=CGSizeMake(260, [[UIScreen mainScreen]bounds].size.width+50);
                    scviewprofile.backgroundColor=[UIColor clearColor];
                    scviewprofile.frame = CGRectMake(150, -10, 269, [[UIScreen mainScreen]bounds].size.width);
                    [editbt removeFromSuperview];
                    editbt= [[UIButton alloc]initWithFrame:CGRectMake(0, 320, 269, 44)];
                    [scviewprofile addSubview:editbt];
                    editbt.backgroundColor=[UIColor colorWithRed:105.0f/255.0f green:164.0f/255.0f blue:194.0f/255.0f alpha:1];
                    NSString *titleForButton = [NSString stringWithFormat: @"Save Profile"];
                    [editbt setTitle:titleForButton forState:UIControlStateNormal];
                    editbt.titleLabel.font = [UIFont systemFontOfSize:17.0f];
                    [editbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [editbt addTarget:self action:@selector(processregister:) forControlEvents:UIControlEventTouchUpInside];

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
                    [labeltext setTextColor:UIColorFromRGB(0xf79a28)];
                    [labeltext setBackgroundColor:[UIColor clearColor]];
                    [labeltext setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:16.5]];
                    scviewprofile.contentSize=CGSizeMake([[UIScreen mainScreen]bounds].size.width,260);
                    
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                case UIInterfaceOrientationLandscapeLeft:
                {
                    
                    [labeltext setTextColor:UIColorFromRGB(0xf79a28)];
                    [labeltext setBackgroundColor:[UIColor clearColor]];
                    [labeltext setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:16.5]];
                    editbt.frame= CGRectMake(200, 372, 80, 44);
                    scviewprofile.contentSize=CGSizeMake([[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width);
                    
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                    break;
            }
            break;
        }
            break;
    }
    userphoneTextField.hidden = YES;
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChangedProfile:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}


-(void)populatefield:(NSString *)string
{
    NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: string ]];
    NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
    usernameTextField.text =  [[serverOutput componentsSeparatedByString: @"##"] objectAtIndex:0];
    userphoneTextField.text = [[serverOutput componentsSeparatedByString: @"##"] objectAtIndex:1];
    userpassTextField.text = [[serverOutput componentsSeparatedByString: @"##"] objectAtIndex:2];
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
//        labelusername.font = [UIFont fontWithName:@"Helvetica" size:12];
//        labelusername.textColor = [UIColor redColor];
//        usernameTextField.layer.borderColor = [[UIColor redColor]CGColor];
//        usernameTextField.layer.masksToBounds=YES;
//        usernameTextField.layer.borderWidth= 1.0f;
//        labelusername.text = @"Name Can't be blank";
//        [usernameTextField becomeFirstResponder];
//        labelusername.hidden = NO;
        UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Name Can't be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    else if ([trimmedString rangeOfCharacterFromSet:set].location != NSNotFound) {
//        labelusername.font = [UIFont fontWithName:@"Helvetica" size:12];
//        labelusername.textColor = [UIColor redColor];
//        usernameTextField.layer.borderColor = [[UIColor redColor]CGColor];
//        usernameTextField.layer.masksToBounds=YES;
//        usernameTextField.layer.borderWidth= 1.0f;
//        labelusername.text = @"Illegal Character";
//        [usernameTextField becomeFirstResponder];
//        labelusername.hidden = NO;
        UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Illegal Character" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [alert show];
        return;
    }
    else if(![self NSStringIsValidEmail:useremail.text])
    {
        useremail.text =nil;
        [useremail becomeFirstResponder];
        UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Email Id is Invalid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //  alert.tag=1;
        
        [alert show];
        return;
    }

    else if(![trimmedString2 length]>0)
    {
//        labelpass.font = [UIFont fontWithName:@"Helvetica" size:12];
//        labelpass.textColor = [UIColor redColor];
//        userpassTextField.layer.borderColor = [[UIColor redColor]CGColor];
//        userpassTextField.layer.masksToBounds=YES;
//        userpassTextField.layer.borderWidth= 1.0f;
//        labelpass.text = @"Password Can't be blank";
//        [userpassTextField becomeFirstResponder];
//        labelpass.hidden = NO;
        UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Password Can't be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [alert show];
        return;
    }
    else if(![self validatePassword:trimmedString2])
    {
//        labelpass.font = [UIFont fontWithName:@"Helvetica" size:12];
//        labelpass.textColor = [UIColor redColor];
//        userpassTextField.layer.borderColor = [[UIColor redColor]CGColor];
//        userpassTextField.layer.masksToBounds=YES;
//        userpassTextField.layer.borderWidth= 1.0f;
//        labelpass.text = @"Password have to be 6-8 character long";
//        [userpassTextField becomeFirstResponder];
//        labelpass.hidden = NO;
        UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Password have to be 6-8 characters long" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

        return;
    }
    else if ([trimmedString2 rangeOfCharacterFromSet:setone].location != NSNotFound)
    {
//        labelpass.font = [UIFont fontWithName:@"Helvetica" size:12];
//        labelpass.textColor = [UIColor redColor];
//        userpassTextField.layer.borderColor = [[UIColor redColor]CGColor];
//        userpassTextField.layer.masksToBounds=YES;
//        userpassTextField.layer.borderWidth= 1.0f;
//        labelpass.text = @"Illegal Character";
//        [userpassTextField becomeFirstResponder];
//        labelpass.hidden = NO;
        
        UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Illegal character" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

        return;
    }
    else if (![trimmedString2 isEqualToString:trimmedString3])
    {
//        labeluserconfpass.font = [UIFont fontWithName:@"Helvetica" size:12];
//        labeluserconfpass.textColor = [UIColor redColor];
//        userconfpassTextField.layer.borderColor = [[UIColor redColor]CGColor];
//        userconfpassTextField.layer.masksToBounds=YES;
//        userconfpassTextField.layer.borderWidth= 1.0f;
//        labeluserconfpass.text = @"Password and confirm password donot match";
//        [userconfpassTextField becomeFirstResponder];
//        labeluserconfpass.hidden = NO;
        UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Password and confirm password do not match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

        return;
    }
//    else if (![self validatePhone:userphoneTextField.text])
//    {
//        labelphoneno.font = [UIFont fontWithName:@"Helvetica" size:12];
//        labelphoneno.textColor = [UIColor redColor];
//        userphoneTextField.layer.borderColor = [[UIColor redColor]CGColor];
//        userphoneTextField.layer.masksToBounds=YES;
//        userphoneTextField.layer.borderWidth= 1.0f;
//        labelphoneno.text = @"Valied Phone Number please";
//        [userphoneTextField becomeFirstResponder];
//        labelphoneno.hidden = NO;
//        return;
//    }
    
  
    else
    {
        CGRect frame;
        frame.origin  = self.scviewprofile.contentOffset;
        if(frame.origin.y>0)
        {
            [userphoneTextField resignFirstResponder];
            [UIView animateWithDuration:1.0 animations:^{
                [self.scviewprofile setContentOffset:CGPointZero  animated:NO];} completion:^(BOOL isfinished){
                    [SVProgressHUD showWithStatus:@"Updating your profile !! Please wait"];
                    NSDictionary *argumentDictionary = [NSDictionary dictionaryWithObjectsAndKeys:trimmedString, @"Object1Key", trimmedString2, @"Object2Key", trimmedString4, @"Object3Key", nil];
                    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(processregister:) object:argumentDictionary];
                    [que addOperation:operation];
                    
                }];
        }
        else
        {
            [SVProgressHUD showWithStatus:@"Updating your profile !! Please wait"];
            NSDictionary *argumentDictionary = [NSDictionary dictionaryWithObjectsAndKeys:trimmedString, @"Object1Key", trimmedString2, @"Object2Key", trimmedString4, @"Object3Key", nil];
            NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(processregister:) object:argumentDictionary];
            [que addOperation:operation];
        }

        
    }
}


//-(BOOL)validatePhone:(NSString*)phone {
//    if ([phone length] < 10) {
//        return NO;
//    }
//    NSString *phoneRegex = @"^[0-9]{3}-[0-9]{3}-[0-9]{4}$";
//    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
//    return ![test evaluateWithObject:phone];
//}

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
    @try{
     NSString *usermane = [argumentDictionary objectForKey:@"Object1Key"];
     NSString *userpassword = [argumentDictionary objectForKey:@"Object2Key"];
     NSString *userphone = [argumentDictionary objectForKey:@"Object3Key"];
    
    NSString *loginstring = [NSString stringWithFormat:@"%@edit_profile.php?name=%@&password=%@&id=%@&phoneno=%@&email=%@",mydomainurl,[usermane stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[userpassword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"],[userphone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[useremail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
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
    
    NSLog(@"%@",serverOutput);
    [SVProgressHUD dismiss];
    if([serverOutput isEqualToString:@""])
    {
        MBAlertView *alertone = [MBAlertView alertWithBody:@"Check Internet Connection !!" cancelTitle:@"Cancel" cancelBlock:nil];
        [alertone addToDisplayQueue];
    }
    else if([serverOutput isEqualToString:@"N"])
    {
        MBAlertView *alert = [MBAlertView alertWithBody:@"There is some technical Problem !! Try again Later !!" cancelTitle:@"Cancel" cancelBlock:nil];
        [alert addToDisplayQueue];
    }
    else if ([serverOutput isEqualToString:@"Y"])
    {
        [SVProgressHUD dismiss];
        [SVProgressHUD setAnimationDidStopSelector:nil];
        [[NSUserDefaults standardUserDefaults] setObject:userpassword forKey:@"passwordsave"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        NSLog(@" data saved %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"passwordsave"]);
        
            MBAlertView *alertss = [MBAlertView alertWithBody:@"Profile has been updated with new details" cancelTitle:nil cancelBlock:nil];
            [alertss addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
                [SVProgressHUD dismiss];
               
            }];
            [alertss addToDisplayQueue];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:serverOutput];
    }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception dropbox: %@",exception);
    }
    @finally {
    }

}

//- (void)processregister:(NSDictionary *)argumentDictionary
//{
//    
//    NSString *usermane = [argumentDictionary objectForKey:@"Object1Key"];
//    NSString *userpassword = [argumentDictionary objectForKey:@"Object2Key"];
//    NSString *useremail = [argumentDictionary objectForKey:@"Object3Key"];
//    NSString *userphone = [argumentDictionary objectForKey:@"Object4Key"];
//    
//    NSString *loginstring = [NSString stringWithFormat:@"%@signup.php?name=%@&password=%@&email=%@&phoneno=%@",mydomainurl,[usermane stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[userpassword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[useremail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[userphone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSLog(@"%@",loginstring);
//
//    NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: loginstring ]];
//    NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
//    
//    [SVProgressHUD dismiss];
//    if([serverOutput isEqualToString:@""])
//    {
//        MBAlertView *alertone = [MBAlertView alertWithBody:@"Check Internet Connection !!" cancelTitle:@"Cancel" cancelBlock:nil];
//        [alertone addToDisplayQueue];
//    }
//    else if([serverOutput isEqualToString:@"N"])
//    {
//        MBAlertView *alert = [MBAlertView alertWithBody:@"There is some technical Problem !! Try again Later !!" cancelTitle:@"Cancel" cancelBlock:nil];
//        [alert addToDisplayQueue];
//    }
//    else
//    {
//        NSLog(@"==================");
//        NSLog(@"%@",serverOutput);
//        NSLog(@"==================");
//        if([serverOutput isEqualToString:@"2"]) {
//            MBAlertView *alert = [MBAlertView alertWithBody:@"Email Already Exists !! Try with different one !!" cancelTitle:@"Cancel" cancelBlock:nil];
//            [alert addToDisplayQueue];
//        }
//        else if([serverOutput isEqualToString:@"3"]) {
//            MBAlertView *alert = [MBAlertView alertWithBody:@"Phone No Already Exists !! Try with different one !!" cancelTitle:@"Cancel" cancelBlock:nil];
//            [alert addToDisplayQueue];
//        }
//        else {
//            [SVProgressHUD dismiss];
//            MBAlertView *alertss = [MBAlertView alertWithBody:@"Signup Successfull !! Please check email for details" cancelTitle:nil cancelBlock:nil];
//            [alertss addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
//                [SVProgressHUD dismiss];
//                CATransition* transition = [CATransition animation];
//                transition.duration = 0.5;
//                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//                transition.type = kCATransitionFade;
//                HomeViewController *control1 = [[HomeViewController alloc] init];
//                [self.navigationController.view.layer addAnimation:transition forKey:nil];
//                [[self navigationController] pushViewController:control1 animated:NO];
//            }];
//            [alertss addToDisplayQueue];
//        }
//    }
//}
-(IBAction)hideKeyboard:(id)sender {
    [(UITextField*)sender resignFirstResponder];
}
-(IBAction)movetozero:(id)sender
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
-(IBAction)movetotop:(id)sender
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
