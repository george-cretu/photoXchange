//
//  ProfileViewController.h
//  Photoapp
//
//  Created by Soumalya on 23/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UIScrollViewAccessibilityDelegate,UIScrollViewDelegate>
{
    NSString *trimmedString,*trimmedString2,*trimmedString3,*trimmedString4;
    NSCharacterSet * set;
    NSCharacterSet * setone;
    NSOperationQueue *que;
    IBOutlet UIButton *editbt;
}
@property (nonatomic,retain) IBOutlet UILabel *labelusername,*labeltext,*labelpass,*labeluserconfpass,*labelphoneno;
@property (nonatomic,retain) IBOutlet UITextField  *usernameTextField,*userpassTextField,*userconfpassTextField,*userphoneTextField, *useremail;
@property (nonatomic,retain) IBOutlet UIScrollView *scviewprofile;
-(IBAction)hideKeyboard:(id)sender;
- (IBAction)edit_prof:(id)sender;
@end
