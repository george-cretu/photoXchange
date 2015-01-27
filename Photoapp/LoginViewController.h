//
//  LoginViewController.h
//  Photoapp
//
//  Created by Esolz Technologies on 08/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyHTTPConnection.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface LoginViewController : UIViewController <UIScrollViewAccessibilityDelegate,UIScrollViewDelegate, UITextFieldDelegate,UIAlertViewDelegate>
{
    NSCharacterSet * set;
    NSString *trimmedString;
    NSString *trimmedString2;
    NSOperationQueue *que;
    UIButton *remcheck;
    NSString *remember;
    
    NSString *albumName;
    ALAssetsLibrary *_library;
}
- (void)signup:(id)sender;
- (void)signin:(id)sender;
- (void)forgotpassword:(id)sender;
//- (void)hideKeyboard:(id)sender;

@property (strong, atomic) ALAssetsLibrary* library;
@property (nonatomic,retain) IBOutlet UITextField  *usernameTextField;
@property (nonatomic,retain) IBOutlet UITextField *userpassTextField;
@property (nonatomic,retain) IBOutlet UILabel *labelusername;
@property (nonatomic,retain) IBOutlet UILabel *labelpass;
@property (nonatomic,retain) IBOutlet UIScrollView *scviewlogin;
@property (nonatomic,retain) IBOutlet UIButton *loginbutton;
@property (nonatomic,retain) IBOutlet UIButton *registerbutton;
@property (nonatomic,retain) IBOutlet UIButton *facebookloginbutton;
@property (nonatomic,retain) IBOutlet UIButton *forgetpassbutton;
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *loginloader;
@property (nonatomic,retain) IBOutlet UILabel *allerttext;
@property (strong, nonatomic)  NSTimer *timer;

@property (nonatomic,retain) IBOutlet UILabel *labelappname;
@property (nonatomic,retain) IBOutlet UILabel *labelwelcome;
@property (nonatomic,retain) IBOutlet UILabel *labelname;
@property (nonatomic,retain) IBOutlet UILabel *labelremember;
@property (nonatomic,retain) UIButton *remcheck;

@end
