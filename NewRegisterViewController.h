//
//  NewRegisterViewController.h
//  Photoapp
//
//  Created by Bhaswar's MacBook Air on 07/04/14.
//  Copyright (c) 2014 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewRegisterViewController : UIViewController<UIScrollViewAccessibilityDelegate,UIScrollViewDelegate, UITextFieldDelegate>
{
    NSString *trimmedString;
    NSString *trimmedString2;
    NSString *trimmedString3;
    NSString *trimmedString4;
    NSCharacterSet * set;
    NSCharacterSet * setone;
    NSOperationQueue *que;
}
@property (nonatomic,retain) UILabel *labeltext;
@property (nonatomic,retain) UILabel *labelusername;
@property (nonatomic,retain) UILabel *labelpass;
@property (nonatomic,retain) UILabel *labeluseremail;
@property (nonatomic,retain) UILabel *labelphoneno;
@property (nonatomic,retain) UITextField  *usernameTextField;
@property (nonatomic,retain) UITextField *userpassTextField;
@property (nonatomic,retain) UITextField  *useremailTextField;
@property (nonatomic,retain) UITextField  *userphoneTextField;
@property (nonatomic,retain) UIScrollView *scviewlogin;
@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) UIScrollView *scviewregister;
-(IBAction)hideKeyboard:(id)sender;


@end
