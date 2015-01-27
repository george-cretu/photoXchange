//
//  NewProfileViewController.h
//  Photoapp
//
//  Created by Bhaswar's MacBook Air on 08/04/14.
//  Copyright (c) 2014 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewProfileViewController : UIViewController<UIScrollViewAccessibilityDelegate,UIScrollViewDelegate, UITextFieldDelegate>
{
    NSString *trimmedString,*trimmedString2,*trimmedString3,*trimmedString4;
    NSCharacterSet * set;
    NSCharacterSet * setone;
    NSOperationQueue *que;
    UIButton *editbt;
}
@property (nonatomic,retain) UILabel *labelusername,*labeltext,*labelpass,*labeluserconfpass,*labelphoneno;
@property (nonatomic,retain) UITextField  *usernameTextField,*userpassTextField,*userconfpassTextField,*userphoneTextField, *useremail;
@property (nonatomic,retain) UIScrollView *scviewprofile;
-(void)hideKeyboard:(id)sender;
- (void)edit_prof:(id)sender;

@end
