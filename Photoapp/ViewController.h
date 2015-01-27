//
//  ViewController.h
//  Photoapp
//
//  Created by Esolz Technologies on 08/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UIImageView *show_img;
}
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *actp;
@property (nonatomic,retain) IBOutlet UILabel *labeltext;

//- (void)startStopServer;

@end
