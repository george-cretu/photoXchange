//
//  ForgetpasswordViewController.h
//  Photoapp
//
//  Created by Esolz Technologies on 08/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetpasswordViewController : UIViewController<UITextFieldDelegate>
{
    NSString *trimmedString;
    NSOperationQueue *quedata;
    IBOutlet UIScrollView *frgt_scrll_view;
}
- (IBAction)forgotpass:(id)sender;
@property (nonatomic,retain) IBOutlet UITextField  *emailTextField;
@property (nonatomic,retain) IBOutlet UIButton *buttonlogin;
-(IBAction)hideKeyboard:(id)sender;
@end
