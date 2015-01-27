/*
    File: RootViewController.h
Abstract: Main View Controller.
 Version: 1.1
Copyright (C) 2013 Apple Inc. All Rights Reserved.
*/

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface RootViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>
@property (nonatomic,retain) UIView *drop_dow_menu,*name_view;

@end
