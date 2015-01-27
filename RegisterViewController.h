//
//  RegisterViewController.h
//  Photoapp
//
//  Created by Esolz Technologies on 08/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController <UIScrollViewAccessibilityDelegate,UIScrollViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
{
    NSString *trimmedString;
    NSString *trimmedString2;
    NSString *trimmedString3;
    NSString *trimmedString4;
    NSCharacterSet * set;
    NSCharacterSet * setone;
    NSOperationQueue *que;
}
@property (nonatomic,retain) IBOutlet UILabel *labeltext;
@property (nonatomic,retain) IBOutlet UILabel *labelusername;
@property (nonatomic,retain) IBOutlet UILabel *labelpass;
@property (nonatomic,retain) IBOutlet UILabel *labeluseremail;
@property (nonatomic,retain) IBOutlet UILabel *labelphoneno;
@property (nonatomic,retain) IBOutlet UITextField  *usernameTextField;
@property (nonatomic,retain) IBOutlet UITextField *userpassTextField;
@property (nonatomic,retain) IBOutlet UITextField  *useremailTextField;
@property (nonatomic,retain) IBOutlet UITextField  *userphoneTextField;
@property (nonatomic,retain) IBOutlet UIScrollView *scviewlogin;
@property (nonatomic,retain) IBOutlet UIImageView *imageView;
@property (nonatomic,retain) IBOutlet UIScrollView *scviewregister;
@property (nonatomic,retain) IBOutlet UIButton *signupbutton;

-(void)hideKeyboard:(id)sender;
@end
