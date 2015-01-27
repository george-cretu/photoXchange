//
//  RegisterViewController.m
//  Photoapp
//
//  Created by Esolz Technologies on 08/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

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
    UITextField *nametxt, *usernametxt;
}

@end

@implementation RegisterViewController
@synthesize scviewregister;
@synthesize userpassTextField,useremailTextField,usernameTextField,labelpass,labeluseremail,labelusername,imageView,labelphoneno,userphoneTextField,labeltext;

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
    
    UIBarButtonItem *br_btn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-up.png"] landscapeImagePhone:[UIImage imageNamed:@"back-up.png"] style:UIBarButtonItemStyleDone target:self action:@selector(gotoback)];
    
    self.navigationItem.leftBarButtonItem = br_btn;
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
    userphoneTextField.hidden=YES;
    
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
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, 320, 45);
                    headerlabel.frame = CGRectMake(0,10.5, 320, 25);
                    
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         labeltext.frame = CGRectMake(31, 63, 259, 21);
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                    
                case UIDeviceOrientationLandscapeRight:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25);
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         
                                         
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5,[[UIScreen mainScreen]bounds].size.height, 25);
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                    
                    //        case UIDeviceOrientationPortraitUpsideDown:
                    //        {
                    //            buttonusertrouble.frame = CGRectMake(0, 0, 320, 45);
                    //            headerlabel.frame = CGRectMake(0,10.5, 320, 25);
                    //            
                    //            [UIView animateWithDuration:1.0
                    //                             animations:^{
                    //                                labeltext.frame = CGRectMake(31, 63, 259, 21);
                    //                             }
                    //                             completion:^(BOOL finished){ }];
                    //        }
                    //            break;
                    
            };
 
        }
            break;
            case  UIUserInterfaceIdiomPad:
        {
            UIDevice * device = note.object;
            switch(device.orientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, 320, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.width, 25);
                    
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         labeltext.frame = CGRectMake(31, 63, 259, 21);
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                    
                case UIDeviceOrientationLandscapeRight:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25);
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         
                                         
                                     }
                                     completion:^(BOOL finished){ }];
                    
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5,[[UIScreen mainScreen]bounds].size.height, 25);
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         
                                     }
                                     completion:^(BOOL finished){ }];
                    
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
//    else if(![trimmedString4 length]>0)
//    {
//        labelphoneno.font = [UIFont fontWithName:@"Helvetica" size:12];
//        labelphoneno.textColor = [UIColor redColor];
//        userphoneTextField.layer.borderColor = [[UIColor redColor]CGColor];
//        userphoneTextField.layer.masksToBounds=YES;
//        userphoneTextField.layer.borderWidth= 1.0f;
//        labelphoneno.text = @"Phone No Can't be blank";
//        [userphoneTextField becomeFirstResponder];
//        labelphoneno.hidden = NO;
//    }
//    else if (![self validatePhone:userphoneTextField.text]) {
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
        frame.origin  = self.scviewregister.contentOffset;
        if(frame.origin.y>0)
        {
            [userphoneTextField resignFirstResponder];
            [UIView animateWithDuration:1.0 animations:^{
                [self.scviewregister setContentOffset:CGPointZero  animated:NO];} completion:^(BOOL isfinished){
                    [SVProgressHUD showWithStatus:@"Checking Email avability !! Please wait"];
                    NSDictionary *argumentDictionary = [NSDictionary dictionaryWithObjectsAndKeys:trimmedString, @"Object1Key", trimmedString2, @"Object2Key", trimmedString3, @"Object3Key", trimmedString4, @"Object4Key", nil];
                    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(processregister:) object:argumentDictionary];
                    [que addOperation:operation];
                    
                }];
        }
        else
        {
            [SVProgressHUD showWithStatus:@"Checking Email avability !! Please wait"];
            NSDictionary *argumentDictionary = [NSDictionary dictionaryWithObjectsAndKeys:trimmedString, @"Object1Key", trimmedString2, @"Object2Key", trimmedString3, @"Object3Key", trimmedString4, @"Object4Key", nil];
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
    
    NSString *usermane = [argumentDictionary objectForKey:@"Object1Key"];
    NSString *userpassword = [argumentDictionary objectForKey:@"Object2Key"];
    NSString *useremail = [argumentDictionary objectForKey:@"Object3Key"];
    NSString *userphone = [argumentDictionary objectForKey:@"Object4Key"];
    
    NSString *loginstring = [NSString stringWithFormat:@"%@signup.php?name=%@&password=%@&email=%@&phoneno=%@",mydomainurl,[usermane stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[userpassword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[useremail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[userphone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",loginstring);
    
    NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: loginstring ]];
    NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
    
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
    else
    {
        NSLog(@"==================");
        NSLog(@"%@",serverOutput);
        NSLog(@"==================");
        if([serverOutput isEqualToString:@"2"]) {
              [SVProgressHUD dismiss];
            MBAlertView *alert = [MBAlertView alertWithBody:@"Email Already Exists !! Try with different one !!" cancelTitle:@"Cancel" cancelBlock:nil];
            [alert addToDisplayQueue];
        }
        else if([serverOutput isEqualToString:@"3"]) {
              [SVProgressHUD dismiss];
            MBAlertView *alert = [MBAlertView alertWithBody:@"Phone No Already Exists !! Try with different one !!" cancelTitle:@"Cancel" cancelBlock:nil];
            [alert addToDisplayQueue];
        }
        else {
            [SVProgressHUD dismiss];
            MBAlertView *alertss = [MBAlertView alertWithBody:@"Signup Successfull !! Please check email for details" cancelTitle:nil cancelBlock:nil];
            [alertss addButtonWithText:@"Ok" type:MBAlertViewItemTypePositive block:^{
               
                
                CATransition* transition = [CATransition animation];
                transition.duration = 0.5;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                LoginViewController *control1 = [[LoginViewController alloc] init];
                [self.navigationController.view.layer addAnimation:transition forKey:nil];
                [[self navigationController] pushViewController:control1 animated:NO];
            }];
            [alertss addToDisplayQueue];
        }
    }
}
-(IBAction)hideKeyboard:(id)sender {
    [(UITextField*)sender resignFirstResponder];
}
-(IBAction)movetozero:(id)sender
{
    [(UITextField*)sender resignFirstResponder];
    
    [UIView animateWithDuration:1.0 animations:^{
        [self.scviewregister setContentOffset:CGPointZero  animated:NO];
        
    }];
}
-(IBAction)movetotop:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        [self.scviewregister setContentOffset:CGPointMake(0, 150)  animated:NO];
        
    }];
}

//-(IBAction)movetotopone:(id)sender
//{
//    [UIView animateWithDuration:1.0 animations:^{
//        [self.scviewregister setContentOffset:CGPointMake(0, 200) animated:NO];
//        
//    }];
//    
//    
//}
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
   
    if(textField == userpassTextField)
    {
        [UIView animateWithDuration:1.0 animations:^{
            [self.scviewregister setContentOffset:CGPointZero  animated:NO];
            
        }];
        return [textField resignFirstResponder];
        
    }
    else
    {
        NSInteger nextTag = textField.tag + 1;
        // Try to find next responder
        UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
        if (nextResponder) {
            // Found next responder, so set it.
            [nextResponder becomeFirstResponder];
        } else {
            // Not found, so remove keyboard.
            [textField resignFirstResponder];
            
        }
        
    return NO;
    }
}

@end
