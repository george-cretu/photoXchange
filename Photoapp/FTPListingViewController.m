////  FTPListingViewController.m
////  Photoapp
////  Created by Iphone_1 on 23/08/13.
////  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//#import "KOTreeViewController.h"
//#import "FTPListingViewController.h"
//#import <QuartzCore/QuartzCore.h>
//#import "SVProgressHUD.h"
//#import "CustomTextField.h"
//#import "LibraryViewController.h"
//#import "HomeViewController.h"
//#import "ImageFromFTPViewController.h"
//#import "AFNetworking.h"
//#import "ImagePagingViewController.h"
//#import "RootViewController.h"
//#import "UIButton+WebCache.h"
//#import "UIImageView+WebCache.h"
//#define KOCOLOR_FILES_TITLE [UIColor colorWithRed:0.4 green:0.357 blue:0.325 alpha:1] /*#665b53*/
//#define KOCOLOR_FILES_TITLE_SHADOW [UIColor colorWithRed:1 green:1 blue:1 alpha:1] /*#ffffff*/
//#define KOCOLOR_FILES_COUNTER [UIColor colorWithRed:0.608 green:0.376 blue:0.251 alpha:1] /*#9b6040*/
//#define KOCOLOR_FILES_COUNTER_SHADOW [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35] /*#ffffff*/
//#define KOFONT_FILES_TITLE [UIFont fontWithName:@"HelveticaNeue" size:12.0f]
//#define KOFONT_FILES_COUNTER [UIFont fontWithName:@"HelveticaNeue-Bold" size:11.0f]
//static CGFloat const kIconHorizontalPadding = 10;
//static CGFloat const kDefaultIconSize = 40;
//static CGFloat const kMaxBounceAmount = 8;
//
//@interface FTPListingViewController ()
//{
//    UIImageView *buttonusertrouble,*bar_white;
//    UILabel *headerlabel;
//    UIView *nav_bar, *drop_down_view_ftp;
//    UIButton *new_folder_btn, *rename_folder_btn, *move_folder_btn, *delete_folder_btn, *backButton, *editButton;
//    BOOL intial_click_on_go_back;
//    UIAlertView *alert;
//    NSString *stringImage, *albumImage;
//    int checkFlag, imageorfolder;
//    NSString *imageToBeCopied;
//    int test;
//    NSString *thumbImage;
//    NSString *checkThumbImage, *thumb_new_path;
//    NSString *selectedImage;
//    NSArray *extension;
//    UIAlertView *deleteAlert;
//    NSDictionary *listEntry;
//    UIButton *button;
//    NSMutableArray *multiSelect;
//    UIView *tempHeader;
//}
//@property (nonatomic ,retain) NSIndexPath *selected_to_delete;
//@property (nonatomic, assign) CGFloat dragStart;
//@end
//@implementation FTPListingViewController
//@synthesize  folder_path_array,director_string,selected_to_delete;
//@synthesize selectedIndexPaths;
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//    }
//    return self;
//}
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    checkFlag = 0;
//    selectedImage = [[NSString alloc]init];
//    multiSelect = [[NSMutableArray alloc]init];
//
//    NSLog(@"yes ftp listing bm");
//    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
//    if ([[ver objectAtIndex:0] intValue] >= 7)
//    {
//        self.navigationController.navigationBarHidden = NO;
//        self.edgesForExtendedLayout=UIRectEdgeNone;
//        self.extendedLayoutIncludesOpaqueBars=NO;
//        self.automaticallyAdjustsScrollViewInsets=NO;
//    }
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenHeight = screenRect.size.height;
//    self.navigationController.navigationBarHidden= YES;
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]]];
//    editButton.hidden = YES;
//    
//    if ([[ver objectAtIndex:0] intValue] >= 7)
//    {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar@2x.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    }
//    else
//    {
//        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bar.png"] forBarMetrics:nil];
//    }
//    
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    [self.navigationItem setTitle:[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]] lastPathComponent]];
//    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
//    self.navigationItem.hidesBackButton = YES;
//    [[UINavigationBar appearance] setTitleTextAttributes:@{
//                                                           UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
//                                                           UITextAttributeFont: [UIFont fontWithName:@"MyriadPro-Bold" size:18.5],
//                                                           }];
//    button =  [UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self action:@selector(goback_ftp:)forControlEvents:UIControlEventTouchUpInside];
//    
//    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
//        case UIUserInterfaceIdiomPad:
//        {
//            [button setImage:[UIImage imageNamed:@"back-up1.png"] forState:UIControlStateNormal];
//            [button setFrame:CGRectMake(0, 0,32, 25)];
//        }
//            break;
//        case UIUserInterfaceIdiomPhone:
//        {
//            [button setImage:[UIImage imageNamed:@"back-up@2x.png"] forState:UIControlStateNormal];
//            [button setFrame:CGRectMake(0, 0,32/2, 25/2)];
//        }
//            break;
//    }
//
//    
//    
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.leftBarButtonItem = barButton;
//    
//    self.navigationController.navigationBarHidden = NO;
//    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
//        case UIUserInterfaceIdiomPhone:
//        {
//            switch(self.interfaceOrientation)
//            {
//                case UIInterfaceOrientationPortraitUpsideDown:
//                case UIDeviceOrientationPortrait:
//                {
//                    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
//                    {
//                        list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, 320, self.view.bounds.size.height-114/2)];
//                    }
//                    else
//                    {
//                        list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, 320, self.view.bounds.size.height-114/2)];
//                    }
//                    list_tab.backgroundColor = [UIColor clearColor];
//                    list_tab.dataSource=self;
//                    list_tab.delegate=self;
//                    list_tab.separatorStyle = UITableViewCellSeparatorStyleNone;
//                    list_tab.separatorColor =[UIColor clearColor];
//                    list_tab.showsVerticalScrollIndicator=NO;
////                    [list_tab setRowHeight:65.0f];
//                    [list_tab setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
//                    [self.view addSubview:list_tab];
//                    
//                    NSLog(@" listab frame is %@",NSStringFromCGRect(list_tab.frame));
//                    nav_bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 114/2)];
//                    [self.view addSubview:nav_bar];
//                    
//                    bar_white = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar@2x.png"]];
//                    bar_white.frame = CGRectMake(0, 0, 320, 114/2);
//                    [nav_bar addSubview:bar_white];
//                    
//                    //---------------- NEw Folder Button and it's subviews -------------------------------------
//                    new_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    new_folder_btn.frame =CGRectMake(0, 0, 75, 114/2);
//                    new_folder_btn.backgroundColor = [UIColor clearColor];
//                    new_folder_btn.tag=1;
//                    [new_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                    [nav_bar addSubview:new_folder_btn];
//                    
//                    UIImageView *new_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new-folder@2x.png"]];
//                    new_fol.frame = CGRectMake(27, 10, 59/2, 38/2);
//                    [new_folder_btn addSubview:new_fol];
//                    
//                    UILabel *new_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 80, 20)];
//                    new_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                    new_fol_lbl.text=@"New Folder";
//                    new_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                    new_fol_lbl.backgroundColor = [UIColor clearColor];
//                    new_fol_lbl.textColor=[UIColor darkGrayColor];
//                    [new_folder_btn addSubview:new_fol_lbl];
//                    
//                    //--------------------- Rename Folder Button and it's subviews------------------------
//                    rename_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    rename_folder_btn.frame =CGRectMake(80.5, 0, 75, 114/2);
//                    rename_folder_btn.backgroundColor = [UIColor clearColor];
//                    rename_folder_btn.tag=2;
//                    [rename_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                    [nav_bar addSubview:rename_folder_btn];
//                    
//                    UIImageView *ren_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rename-folder@2x.png"]];
//                    ren_fol.frame = CGRectMake(24.5, 10, 59/2, 19);
//                    [rename_folder_btn addSubview:ren_fol];
//                    
//                    UILabel *ren_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                    ren_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                    ren_fol_lbl.text=@"Rename Folder";
//                    ren_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                    ren_fol_lbl.backgroundColor = [UIColor clearColor];
//                    ren_fol_lbl.textColor=[UIColor darkGrayColor];
//                    [rename_folder_btn addSubview:ren_fol_lbl];
//                    
//                    //--------------------- Move Folder Button and it's subviews------------------------
//                    move_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    move_folder_btn.frame =CGRectMake(80.5*2, 0, 75, 114/2);
//                    move_folder_btn.backgroundColor = [UIColor clearColor];
//                    move_folder_btn.tag=3;
//                    [move_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                    [nav_bar addSubview:move_folder_btn];
//                    
//                    UIImageView *mov_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"move@2x.png"]];
//                    mov_fol.frame = CGRectMake(24.5f, 10, 59/2, 19);
//                    [move_folder_btn addSubview:mov_fol];
//                    
//                    UILabel *move_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                    move_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                    move_fol_lbl.text=@"Move Folder";
//                    move_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                    move_fol_lbl.backgroundColor = [UIColor clearColor];
//                    move_fol_lbl.textColor=[UIColor darkGrayColor];
//                    [move_folder_btn addSubview:move_fol_lbl];
//                    
//                    //--------------------- Delete Folder Button and it's subviews------------------------
//                    delete_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    delete_folder_btn.frame =CGRectMake(80.5f*3, 0, 75, 114/2);
//                    delete_folder_btn.backgroundColor = [UIColor clearColor];
//                    delete_folder_btn.tag=4;
//                    [delete_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                    [nav_bar addSubview:delete_folder_btn];
//                    
//                    UIImageView *del_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete@2x.png"]];
//                    del_fol.frame = CGRectMake(26.0f, 7.5f, 48/2, 49/2);
//                    [delete_folder_btn addSubview:del_fol];
//                    
//                    UILabel *del_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                    del_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                    del_fol_lbl.text=@"Delete Folder";
//                    del_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                    del_fol_lbl.backgroundColor = [UIColor clearColor];
//                    del_fol_lbl.textColor=[UIColor darkGrayColor];
//                    [delete_folder_btn addSubview:del_fol_lbl];
//                    
//                    //------------------- Folder table ---------------------------
//                    
//                    //----------------- Shadow View ------------------------------
//                    shadow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-45)];
//                    shadow_view.backgroundColor = [UIColor blackColor];
//                    shadow_view.alpha=0.79;
//                    shadow_view.layer.zPosition=1;
//                    shadow_view.userInteractionEnabled=YES;
//                    shadow_view.hidden=YES;
//                    [self.view addSubview:shadow_view];
//                    
//                    UITapGestureRecognizer *hideshadow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
//                    hideshadow.numberOfTapsRequired=1;
//                    [shadow_view addGestureRecognizer:hideshadow];
//                    
//                    //----------------- New Folder View --------------------------
//                    if([[UIScreen mainScreen] bounds].size.height<568)
//                    {
//                        new_folder_view = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-500/2)/2, 100-self.navigationController.navigationBar.frame.size.height, 500/2, 327/2)];
//                        new_folder_view.layer.zPosition=2;
//                        new_folder_view.userInteractionEnabled=YES;
//                        UIImageView *background_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500/2, 327/2)];
//                        background_img.image = [UIImage imageNamed:@"input-box1@2x.png"];
//                        [new_folder_view addSubview:background_img];
//                        [self.view addSubview:new_folder_view];
//                        new_folder_view.hidden=YES;
//                        
//                        title_lbl_for_new_view = [[UILabel alloc] initWithFrame:CGRectMake(5, 5.5, 500/2, 20)];
//                        title_lbl_for_new_view.backgroundColor = [UIColor clearColor];
//                        title_lbl_for_new_view.textColor =[UIColor colorWithRed:(208.0f/255.0f) green:(198.0f/255.0f) blue:(200.0f/255.0f) alpha:1];
//                        title_lbl_for_new_view.font= [UIFont fontWithName:@"SourceSansPro-Semibold" size:15.5f];
//                        [new_folder_view addSubview:title_lbl_for_new_view];
//                        
//                        text_enter = [[CustomTextField alloc] initWithFrame:CGRectMake(7.5f, 50, 469/2, 66/2)];
//                        text_enter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input-box@2x.png"]];
//                        text_enter.delegate=self;
//                        text_enter.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
//                        text_enter.autocapitalizationType=UITextAutocapitalizationTypeNone;
//                        text_enter.textColor = [UIColor blackColor];
//                        [new_folder_view addSubview:text_enter];
//                        
//                        ok_button = [[UIButton alloc] initWithFrame:CGRectMake(65, 327/2-57, 253/2, 57/2)];
//                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn@2x.png"] forState:UIControlStateNormal];
//                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn1@2x.png"] forState:UIControlStateHighlighted];
//                        [ok_button addTarget:self action:@selector(newfolderactions:) forControlEvents:UIControlEventTouchUpInside];
//                        [new_folder_view addSubview:ok_button];
//                    }
//                    else
//                    {
//                        new_folder_view = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-500/2)/2, 180-self.navigationController.navigationBar.frame.size.height, 500/2, 327/2)];
//                        new_folder_view.layer.zPosition=2;
//                        new_folder_view.userInteractionEnabled=YES;
//                        UIImageView *background_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500/2, 327/2)];
//                        background_img.image = [UIImage imageNamed:@"input-box1@2x.png"];
//                        [new_folder_view addSubview:background_img];
//                        [self.view addSubview:new_folder_view];
//                        new_folder_view.hidden=YES;
//                        
//                        title_lbl_for_new_view = [[UILabel alloc] initWithFrame:CGRectMake(5, 5.5, 500/2, 20)];
//                        title_lbl_for_new_view.backgroundColor = [UIColor clearColor];
//                        title_lbl_for_new_view.textColor =[UIColor colorWithRed:(208.0f/255.0f) green:(198.0f/255.0f) blue:(200.0f/255.0f) alpha:1];
//                        title_lbl_for_new_view.font= [UIFont fontWithName:@"SourceSansPro-Semibold" size:15.5f];
//                        [new_folder_view addSubview:title_lbl_for_new_view];
//                        
//                        text_enter = [[CustomTextField alloc] initWithFrame:CGRectMake(7.5f, 50, 469/2, 66/2)];
//                        text_enter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input-box@2x.png"]];
//                        text_enter.delegate=self;
//                        text_enter.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
//                        text_enter.autocapitalizationType=UITextAutocapitalizationTypeNone;
//                        text_enter.textColor = [UIColor blackColor];
//                        [new_folder_view addSubview:text_enter];
//                        
//                        ok_button = [[UIButton alloc] initWithFrame:CGRectMake(65, 327/2-57, 253/2, 57/2)];
//                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn@2x.png"] forState:UIControlStateNormal];
//                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn1@2x.png"] forState:UIControlStateHighlighted];
//                        [ok_button addTarget:self action:@selector(newfolderactions:) forControlEvents:UIControlEventTouchUpInside];
//                        ok_button.tag=0;
//                        [new_folder_view addSubview:ok_button];
//                    }
//                }
//                    break;
//                case UIInterfaceOrientationLandscapeRight:
//                case UIInterfaceOrientationLandscapeLeft:
//                {
//                    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
//                    {
//                list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, [[UIScreen mainScreen] bounds].size.height, screenHeight-114/2)];
//                    }
//                    else
//                    {
//                list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, [[UIScreen mainScreen] bounds].size.height, screenHeight-114/2)];
//                    }
//                    
//                    list_tab.backgroundColor = [UIColor clearColor];
//                    list_tab.dataSource=self;
//                    list_tab.delegate=self;
//                    list_tab.separatorColor =[UIColor clearColor];
//                    list_tab.separatorStyle = UITableViewCellSeparatorStyleNone;
//                    [list_tab setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
////                    [list_tab setRowHeight:65.0f];
//                    list_tab.showsVerticalScrollIndicator=NO;
//                    [self.view addSubview:list_tab];
//                    
//                    nav_bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 114/2)];
//                    [self.view addSubview:nav_bar];
//                    
//                    bar_white = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar@2x.png"]];
//                    bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 114/2);
//                    [nav_bar addSubview:bar_white];
//                    
//                    //----------------- Shadow View ------------------------------
//                    shadow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen] bounds].size.width-45)];
//                    shadow_view.backgroundColor = [UIColor blackColor];
//                    shadow_view.alpha=0.79;
//                    shadow_view.layer.zPosition=1;
//                    shadow_view.userInteractionEnabled=YES;
//                    shadow_view.hidden=YES;
//                    [self.view addSubview:shadow_view];
//                    
//                    UITapGestureRecognizer *hideshadow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
//                    hideshadow.numberOfTapsRequired=1;
//                    [shadow_view addGestureRecognizer:hideshadow];
//                    
//                    //----------------- New Folder View --------------------------
//                    if([[UIScreen mainScreen] bounds].size.height<568)
//                    {
//                        
//                        //---------------- NEw Folder Button and it's subviews -------------------------------------
//                        new_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                        new_folder_btn.frame =CGRectMake(20, 0, 75, 114/2);
//                        new_folder_btn.backgroundColor = [UIColor clearColor];
//                        new_folder_btn.tag=1;
//                        [new_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                        [nav_bar addSubview:new_folder_btn];
//                        
//                        UIImageView *new_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new-folder@2x.png"]];
//                        new_fol.frame = CGRectMake(27, 10, 59/2, 38/2);
//                        [new_folder_btn addSubview:new_fol];
//                        
//                        UILabel *new_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 80, 20)];
//                        new_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                        new_fol_lbl.text=@"New Folder";
//                        new_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                        new_fol_lbl.backgroundColor = [UIColor clearColor];
//                        new_fol_lbl.textColor=[UIColor darkGrayColor];
//                        [new_folder_btn addSubview:new_fol_lbl];
//                        
//                        //--------------------- Rename Folder Button and it's subviews------------------------
//                        rename_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                        rename_folder_btn.frame =CGRectMake(80.5+60, 0, 75, 114/2);
//                        rename_folder_btn.backgroundColor = [UIColor clearColor];
//                        rename_folder_btn.tag=2;
//                        [rename_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                        [nav_bar addSubview:rename_folder_btn];
//                        
//                        UIImageView *ren_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rename-folder@2x.png"]];
//                        ren_fol.frame = CGRectMake(24.5, 10, 59/2, 19);
//                        [rename_folder_btn addSubview:ren_fol];
//                        
//                        UILabel *ren_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                        ren_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                        ren_fol_lbl.text=@"Rename Folder";
//                        ren_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                        ren_fol_lbl.backgroundColor = [UIColor clearColor];
//                        ren_fol_lbl.textColor=[UIColor darkGrayColor];
//                        [rename_folder_btn addSubview:ren_fol_lbl];
//                        
//                        //--------------------- Move Folder Button and it's subviews------------------------
//                        move_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                        move_folder_btn.frame =CGRectMake(80.5*2+100, 0, 75, 114/2);
//                        move_folder_btn.backgroundColor = [UIColor clearColor];
//                        move_folder_btn.tag=3;
//                        [move_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                        [nav_bar addSubview:move_folder_btn];
//                        
//                        UIImageView *mov_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"move@2x.png"]];
//                        mov_fol.frame = CGRectMake(24.5f, 10, 59/2, 19);
//                        [move_folder_btn addSubview:mov_fol];
//                        
//                        UILabel *move_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                        move_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                        move_fol_lbl.text=@"Move Folder";
//                        move_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                        move_fol_lbl.backgroundColor = [UIColor clearColor];
//                        move_fol_lbl.textColor=[UIColor darkGrayColor];
//                        [move_folder_btn addSubview:move_fol_lbl];
//                        
//                        //--------------------- Delete Folder Button and it's subviews------------------------
//                        delete_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                        delete_folder_btn.frame =CGRectMake(80.5f*3+130, 0, 75, 114/2);
//                        delete_folder_btn.backgroundColor = [UIColor clearColor];
//                        delete_folder_btn.tag=4;
//                        [delete_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                        [nav_bar addSubview:delete_folder_btn];
//                        
//                        UIImageView *del_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete@2x.png"]];
//                        del_fol.frame = CGRectMake(26.0f, 7.5f, 48/2, 49/2);
//                        [delete_folder_btn addSubview:del_fol];
//                        
//                        UILabel *del_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                        del_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                        del_fol_lbl.text=@"Delete Folder";
//                        del_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                        del_fol_lbl.backgroundColor = [UIColor clearColor];
//                        del_fol_lbl.textColor=[UIColor darkGrayColor];
//                        [delete_folder_btn addSubview:del_fol_lbl];
//                        
//                        //------------------- Folder table ---------------------------
//                        
//                        new_folder_view = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.height-500/2)/2, -34, 500/2, 327/2)];
//                        new_folder_view.layer.zPosition=2;
//                        new_folder_view.userInteractionEnabled=YES;
//                        UIImageView *background_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500/2, 327/2)];
//                        background_img.image = [UIImage imageNamed:@"input-box1@2x.png"];
//                        [new_folder_view addSubview:background_img];
//                        [self.view addSubview:new_folder_view];
//                        new_folder_view.hidden=YES;
//                        
//                        title_lbl_for_new_view = [[UILabel alloc] initWithFrame:CGRectMake(5, 5.5, 500/2, 20)];
//                        title_lbl_for_new_view.backgroundColor = [UIColor clearColor];
//                        title_lbl_for_new_view.textColor =[UIColor colorWithRed:(208.0f/255.0f) green:(198.0f/255.0f) blue:(200.0f/255.0f) alpha:1];
//                        title_lbl_for_new_view.font= [UIFont fontWithName:@"SourceSansPro-Semibold" size:15.5f];
//                        [new_folder_view addSubview:title_lbl_for_new_view];
//                        
//                        text_enter = [[CustomTextField alloc] initWithFrame:CGRectMake(7.5f, 50, 469/2, 66/2)];
//                        text_enter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input-box@2x.png"]];
//                        text_enter.delegate=self;
//                        text_enter.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
//                        text_enter.autocapitalizationType=UITextAutocapitalizationTypeNone;
//                        text_enter.textColor = [UIColor blackColor];
//                        [new_folder_view addSubview:text_enter];
//                        
//                        ok_button = [[UIButton alloc] initWithFrame:CGRectMake(65, 327/2-57, 253/2, 57/2)];
//                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn@2x.png"] forState:UIControlStateNormal];
//                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn1@2x.png"] forState:UIControlStateHighlighted];
//                        [ok_button addTarget:self action:@selector(newfolderactions:) forControlEvents:UIControlEventTouchUpInside];
//                        [new_folder_view addSubview:ok_button];
//                    }
//                    else
//                    {
//                        //---------------- NEw Folder Button and it's subviews -------------------------------------
//                        new_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                        new_folder_btn.frame =CGRectMake(20, 0, 75, 114/2);
//                        new_folder_btn.backgroundColor = [UIColor clearColor];
//                        new_folder_btn.tag=1;
//                        [new_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                        [nav_bar addSubview:new_folder_btn];
//                        
//                        UIImageView *new_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new-folder@2x.png"]];
//                        new_fol.frame = CGRectMake(27, 10, 59/2, 38/2);
//                        [new_folder_btn addSubview:new_fol];
//                        
//                        UILabel *new_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 80, 20)];
//                        new_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                        new_fol_lbl.text=@"New Folder";
//                        new_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                        new_fol_lbl.backgroundColor = [UIColor clearColor];
//                        new_fol_lbl.textColor=[UIColor darkGrayColor];
//                        [new_folder_btn addSubview:new_fol_lbl];
//                        
//                        //--------------------- Rename Folder Button and it's subviews------------------------
//                        rename_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                        rename_folder_btn.frame =CGRectMake(80.5+90, 0, 75, 114/2);
//                        rename_folder_btn.backgroundColor = [UIColor clearColor];
//                        rename_folder_btn.tag=2;
//                        [rename_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                        [nav_bar addSubview:rename_folder_btn];
//                        
//                        UIImageView *ren_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rename-folder@2x.png"]];
//                        ren_fol.frame = CGRectMake(24.5, 10, 59/2, 19);
//                        [rename_folder_btn addSubview:ren_fol];
//                        
//                        UILabel *ren_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                        ren_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                        ren_fol_lbl.text=@"Rename Folder";
//                        ren_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                        ren_fol_lbl.backgroundColor = [UIColor clearColor];
//                        ren_fol_lbl.textColor=[UIColor darkGrayColor];
//                        [rename_folder_btn addSubview:ren_fol_lbl];
//                        
//                        //--------------------- Move Folder Button and it's subviews------------------------
//                        move_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                        move_folder_btn.frame =CGRectMake(80.5*2+150, 0, 75, 114/2);
//                        move_folder_btn.backgroundColor = [UIColor clearColor];
//                        move_folder_btn.tag=3;
//                        [move_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                        [nav_bar addSubview:move_folder_btn];
//                        
//                        UIImageView *mov_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"move@2x.png"]];
//                        mov_fol.frame = CGRectMake(24.5f, 10, 59/2, 19);
//                        [move_folder_btn addSubview:mov_fol];
//                        
//                        UILabel *move_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                        move_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                        move_fol_lbl.text=@"Move Folder";
//                        move_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                        move_fol_lbl.backgroundColor = [UIColor clearColor];
//                        move_fol_lbl.textColor=[UIColor darkGrayColor];
//                        [move_folder_btn addSubview:move_fol_lbl];
//                        
//                        //--------------------- Delete Folder Button and it's subviews------------------------
//                        delete_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                        delete_folder_btn.frame =CGRectMake(80.5f*3+210, 0, 75, 114/2);
//                        delete_folder_btn.backgroundColor = [UIColor clearColor];
//                        delete_folder_btn.tag=4;
//                        [delete_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                        [nav_bar addSubview:delete_folder_btn];
//                        
//                        UIImageView *del_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete@2x.png"]];
//                        del_fol.frame = CGRectMake(26.0f, 7.5f, 48/2, 49/2);
//                        [delete_folder_btn addSubview:del_fol];
//                        
//                        UILabel *del_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                        del_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                        del_fol_lbl.text=@"Delete Folder";
//                        del_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                        del_fol_lbl.backgroundColor = [UIColor clearColor];
//                        del_fol_lbl.textColor=[UIColor darkGrayColor];
//                        [delete_folder_btn addSubview:del_fol_lbl];
//                        
//                        //------------------- Folder table ---------------------------
//                        new_folder_view = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.height-500/2)/2, -34, 500/2, 327/2)];
//                        new_folder_view.layer.zPosition=2;
//                        new_folder_view.userInteractionEnabled=YES;
//                        UIImageView *background_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500/2, 327/2)];
//                        background_img.image = [UIImage imageNamed:@"input-box1@2x.png"];
//                        [new_folder_view addSubview:background_img];
//                        [self.view addSubview:new_folder_view];
//                        new_folder_view.hidden=YES;
//                        
//                        title_lbl_for_new_view = [[UILabel alloc] initWithFrame:CGRectMake(5, 5.5, 500/2, 20)];
//                        title_lbl_for_new_view.backgroundColor = [UIColor clearColor];
//                        title_lbl_for_new_view.textColor =[UIColor colorWithRed:(208.0f/255.0f) green:(198.0f/255.0f) blue:(200.0f/255.0f) alpha:1];
//                        title_lbl_for_new_view.font= [UIFont fontWithName:@"SourceSansPro-Semibold" size:15.5f];
//                        [new_folder_view addSubview:title_lbl_for_new_view];
//                        
//                        text_enter = [[CustomTextField alloc] initWithFrame:CGRectMake(7.5f, 50, 469/2, 66/2)];
//                        text_enter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input-box@2x.png"]];
//                        text_enter.delegate=self;
//                        text_enter.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
//                        text_enter.autocapitalizationType=UITextAutocapitalizationTypeNone;
//                        text_enter.textColor = [UIColor blackColor];
//                        [new_folder_view addSubview:text_enter];
//                        
//                        ok_button = [[UIButton alloc] initWithFrame:CGRectMake(65, 327/2-57, 253/2, 57/2)];
//                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn@2x.png"] forState:UIControlStateNormal];
//                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn1@2x.png"] forState:UIControlStateHighlighted];
//                        [ok_button addTarget:self action:@selector(newfolderactions:) forControlEvents:UIControlEventTouchUpInside];
//                        ok_button.tag=0;
//                        [new_folder_view addSubview:ok_button];
//                    }
//                }
//                    break;
//            }
//        }
//            break;
//        case UIUserInterfaceIdiomPad:
//        {
//            switch (self.interfaceOrientation)
//            {
//                case UIInterfaceOrientationPortraitUpsideDown:
//                    break;
//                case UIDeviceOrientationPortrait:
//                {
//                    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
//                    {
//                        list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, [[UIScreen mainScreen] bounds].size.width, self.view.bounds.size.height-114/2)];
//                    }
//                    else
//                    {
//                        list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, [[UIScreen mainScreen] bounds].size.width, self.view.bounds.size.height-57)];
//                    }
//                    list_tab.backgroundColor = [UIColor clearColor];
//                    list_tab.dataSource=self;
//                    list_tab.delegate=self;
//                    list_tab.separatorColor =[UIColor clearColor];
//                    list_tab.separatorStyle = UITableViewCellSeparatorStyleNone;
//                    list_tab.showsVerticalScrollIndicator=NO;
////                    [list_tab setRowHeight:65.0f];
//                    [list_tab setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
//                    [self.view addSubview:list_tab];
//                    
//                    nav_bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 114/2)];
//                    [self.view addSubview:nav_bar];
//                    
//                    bar_white = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar@2x.png"]];
//                    bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 114/2);
//                    [nav_bar addSubview:bar_white];
//                    
//                    //---------------- NEw Folder Button and it's subviews -------------------------------------
//                    new_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    new_folder_btn.frame =CGRectMake(65, 0, 75, 114/2);
//                    new_folder_btn.backgroundColor = [UIColor clearColor];
//                    new_folder_btn.tag=1;
//                    [new_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                    [nav_bar addSubview:new_folder_btn];
//                    
//                    UIImageView *new_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new-folder@2x.png"]];
//                    new_fol.frame = CGRectMake(27, 10, 59/2, 38/2);
//                    [new_folder_btn addSubview:new_fol];
//                    
//                    UILabel *new_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 80, 20)];
//                    new_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                    new_fol_lbl.text=@"New Folder";
//                    new_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                    new_fol_lbl.backgroundColor = [UIColor clearColor];
//                    new_fol_lbl.textColor=[UIColor darkGrayColor];
//                    [new_folder_btn addSubview:new_fol_lbl];
//                    
//                    //--------------------- Rename Folder Button and it's subviews------------------------
//                    rename_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    rename_folder_btn.frame =CGRectMake(128*2, 0, 75, 114/2);
//                    rename_folder_btn.backgroundColor = [UIColor clearColor];
//                    rename_folder_btn.tag=2;
//                    [rename_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                    [nav_bar addSubview:rename_folder_btn];
//                    
//                    UIImageView *ren_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rename-folder@2x.png"]];
//                    ren_fol.frame = CGRectMake(24.5, 10, 59/2, 19);
//                    [rename_folder_btn addSubview:ren_fol];
//                    
//                    UILabel *ren_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                    ren_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                    ren_fol_lbl.text=@"Rename Folder";
//                    ren_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                    ren_fol_lbl.backgroundColor = [UIColor clearColor];
//                    ren_fol_lbl.textColor=[UIColor darkGrayColor];
//                    [rename_folder_btn addSubview:ren_fol_lbl];
//                    
//                    //--------------------- Move Folder Button and it's subviews------------------------
//                    move_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    move_folder_btn.frame =CGRectMake(128*3+65, 0, 75, 114/2);
//                    move_folder_btn.backgroundColor = [UIColor clearColor];
//                    move_folder_btn.tag=3;
//                    [move_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                    [nav_bar addSubview:move_folder_btn];
//                    
//                    UIImageView *mov_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"move@2x.png"]];
//                    mov_fol.frame = CGRectMake(24.5f, 10, 59/2, 19);
//                    [move_folder_btn addSubview:mov_fol];
//                    
//                    UILabel *move_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                    move_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                    move_fol_lbl.text=@"Move Folder";
//                    move_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                    move_fol_lbl.backgroundColor = [UIColor clearColor];
//                    move_fol_lbl.textColor=[UIColor darkGrayColor];
//                    [move_folder_btn addSubview:move_fol_lbl];
//                    
//                    //--------------------- Delete Folder Button and it's subviews------------------------
//                    delete_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    delete_folder_btn.frame =CGRectMake(128*4+115, 0, 75, 114/2);
//                    delete_folder_btn.backgroundColor = [UIColor clearColor];
//                    delete_folder_btn.tag=4;
//                    [delete_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                    [nav_bar addSubview:delete_folder_btn];
//                    
//                    UIImageView *del_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete@2x.png"]];
//                    del_fol.frame = CGRectMake(26.0f, 7.5f, 48/2, 49/2);
//                    [delete_folder_btn addSubview:del_fol];
//                    
//                    UILabel *del_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                    del_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                    del_fol_lbl.text=@"Delete Folder";
//                    del_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                    del_fol_lbl.backgroundColor = [UIColor clearColor];
//                    del_fol_lbl.textColor=[UIColor darkGrayColor];
//                    [delete_folder_btn addSubview:del_fol_lbl];
//                    
//                    //------------------- Folder table ---------------------------
//                    
//                    //----------------- Shadow View ------------------------------
//                    shadow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-45)];
//                    shadow_view.backgroundColor = [UIColor blackColor];
//                    shadow_view.alpha=0.79;
//                    shadow_view.layer.zPosition=1;
//                    shadow_view.userInteractionEnabled=YES;
//                    shadow_view.hidden=YES;
//                    [self.view addSubview:shadow_view];
//                    
//                    UITapGestureRecognizer *hideshadow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
//                    hideshadow.numberOfTapsRequired=1;
//                    [shadow_view addGestureRecognizer:hideshadow];
//                    
//                    //----------------- New Folder View --------------------------
//                new_folder_view = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-500/2)/2, 180, 500/2, 327/2)];
//                    new_folder_view.layer.zPosition=2;
//                    new_folder_view.userInteractionEnabled=YES;
//                    UIImageView *background_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500/2, 327/2)];
//                    background_img.image = [UIImage imageNamed:@"input-box1@2x.png"];
//                    [new_folder_view addSubview:background_img];
//                    [self.view addSubview:new_folder_view];
//                    new_folder_view.hidden=YES;
//                    
//                    title_lbl_for_new_view = [[UILabel alloc] initWithFrame:CGRectMake(5, 5.5, 500/2, 20)];
//                    title_lbl_for_new_view.backgroundColor = [UIColor clearColor];
//                    title_lbl_for_new_view.textColor =[UIColor colorWithRed:(208.0f/255.0f) green:(198.0f/255.0f) blue:(200.0f/255.0f) alpha:1];
//                    title_lbl_for_new_view.font= [UIFont fontWithName:@"SourceSansPro-Semibold" size:15.5f];
//                    [new_folder_view addSubview:title_lbl_for_new_view];
//                    
//                    text_enter = [[CustomTextField alloc] initWithFrame:CGRectMake(7.5f, 50, 469/2, 66/2)];
//                    text_enter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input-box@2x.png"]];
//                    text_enter.delegate=self;
//                    text_enter.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
//                    text_enter.autocapitalizationType=UITextAutocapitalizationTypeNone;
//                    text_enter.textColor = [UIColor blackColor];
//                    [new_folder_view addSubview:text_enter];
//                    
//                    ok_button = [[UIButton alloc] initWithFrame:CGRectMake(65, 327/2-57, 253/2, 57/2)];
//                    [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn@2x.png"] forState:UIControlStateNormal];
//                    [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn1@2x.png"] forState:UIControlStateHighlighted];
//                    [ok_button addTarget:self action:@selector(newfolderactions:) forControlEvents:UIControlEventTouchUpInside];
//                    ok_button.tag=0;
//                    [new_folder_view addSubview:ok_button];
//                }
//                    break;
//                case  UIInterfaceOrientationLandscapeRight:
//                case UIInterfaceOrientationLandscapeLeft:
//                {
//                    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
//                    {
//                list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, [[UIScreen mainScreen] bounds].size.height, screenHeight-114/2-65)];
//                    }
//                    else
//                    {
//                list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, [[UIScreen mainScreen] bounds].size.height, screenHeight-114/2-65)];
//                    }
//                    list_tab.backgroundColor = [UIColor clearColor];
//                    list_tab.dataSource=self;
//                    list_tab.delegate=self;
//                    list_tab.separatorColor =[UIColor clearColor];
//                    list_tab.separatorStyle = UITableViewCellSeparatorStyleNone;
//                    list_tab.showsVerticalScrollIndicator=NO;
////                    [list_tab setRowHeight:65.0f];
//                    [list_tab setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
//                    [self.view addSubview:list_tab];
//                    
//                    nav_bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 114/2)];
//                    [self.view addSubview:nav_bar];
//                    
//                    bar_white = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar@2x.png"]];
//                    bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 114/2);
//                    [nav_bar addSubview:bar_white];
//                    
//                    //---------------- NEw Folder Button and it's subviews -------------------------------------
//                    new_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    new_folder_btn.frame =CGRectMake(80, 0, 75, 114/2);
//                    new_folder_btn.backgroundColor = [UIColor clearColor];
//                    new_folder_btn.tag=1;
//                    [new_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                    [nav_bar addSubview:new_folder_btn];
//                    
//                    UIImageView *new_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new-folder@2x.png"]];
//                    new_fol.frame = CGRectMake(27, 10, 59/2, 38/2);
//                    [new_folder_btn addSubview:new_fol];
//                    
//                    UILabel *new_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 80, 20)];
//                    new_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                    new_fol_lbl.text=@"New Folder";
//                    new_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                    new_fol_lbl.backgroundColor = [UIColor clearColor];
//                    new_fol_lbl.textColor=[UIColor darkGrayColor];
//                    [new_folder_btn addSubview:new_fol_lbl];
//                    
//                    //--------------------- Rename Folder Button and it's subviews------------------------
//                    rename_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    rename_folder_btn.frame =CGRectMake(199.5f+140, 0, 75, 114/2);
//                    rename_folder_btn.backgroundColor = [UIColor clearColor];
//                    rename_folder_btn.tag=2;
//                    [rename_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                    [nav_bar addSubview:rename_folder_btn];
//                    
//                    UIImageView *ren_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rename-folder@2x.png"]];
//                    ren_fol.frame = CGRectMake(24.5, 10, 59/2, 19);
//                    [rename_folder_btn addSubview:ren_fol];
//                    
//                    UILabel *ren_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                    ren_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                    ren_fol_lbl.text=@"Rename Folder";
//                    ren_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                    ren_fol_lbl.backgroundColor = [UIColor clearColor];
//                    ren_fol_lbl.textColor=[UIColor darkGrayColor];
//                    [rename_folder_btn addSubview:ren_fol_lbl];
//                    
//                    //--------------------- Move Folder Button and it's subviews------------------------
//                    move_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    move_folder_btn.frame =CGRectMake(199.5f*2+195, 0, 75, 114/2);
//                    move_folder_btn.backgroundColor = [UIColor clearColor];
//                    move_folder_btn.tag=3;
//                    [move_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                    [nav_bar addSubview:move_folder_btn];
//                    
//                    UIImageView *mov_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"move@2x.png"]];
//                    mov_fol.frame = CGRectMake(24.5f, 10, 59/2, 19);
//                    [move_folder_btn addSubview:mov_fol];
//                    
//                    UILabel *move_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                    move_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                    move_fol_lbl.text=@"Move Folder";
//                    move_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                    move_fol_lbl.backgroundColor = [UIColor clearColor];
//                    move_fol_lbl.textColor=[UIColor darkGrayColor];
//                    [move_folder_btn addSubview:move_fol_lbl];
//                    
//                    //--------------------- Delete Folder Button and it's subviews------------------------
//                    delete_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    delete_folder_btn.frame =CGRectMake(199.5f*3+255, 0, 75, 114/2);
//                    delete_folder_btn.backgroundColor = [UIColor clearColor];
//                    delete_folder_btn.tag=4;
//                    [delete_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
//                    [nav_bar addSubview:delete_folder_btn];
//                    
//                    UIImageView *del_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete@2x.png"]];
//                    del_fol.frame = CGRectMake(26.0f, 7.5f, 48/2, 49/2);
//                    [delete_folder_btn addSubview:del_fol];
//                    
//                    UILabel *del_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
//                    del_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
//                    del_fol_lbl.text=@"Delete Folder";
//                    del_fol_lbl.textAlignment=NSTextAlignmentCenter;
//                    del_fol_lbl.backgroundColor = [UIColor clearColor];
//                    del_fol_lbl.textColor=[UIColor darkGrayColor];
//                    [delete_folder_btn addSubview:del_fol_lbl];
//                    
//                    //------------------- Folder table ---------------------------
//                    
//                    //----------------- Shadow View ------------------------------
//                    shadow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height-45)];
//                    shadow_view.backgroundColor = [UIColor blackColor];
//                    shadow_view.alpha=0.79;
//                    shadow_view.layer.zPosition=1;
//                    shadow_view.userInteractionEnabled=YES;
//                    shadow_view.hidden=YES;
//                    [self.view addSubview:shadow_view];
//                    
//                    UITapGestureRecognizer *hideshadow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
//                    hideshadow.numberOfTapsRequired=1;
//                    [shadow_view addGestureRecognizer:hideshadow];
//                    
//                    //----------------- New Folder View --------------------------
//                    
//                new_folder_view = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.height-500/2)/2, 180, 500/2, 327/2)];
//                    new_folder_view.layer.zPosition=2;
//                    new_folder_view.userInteractionEnabled=YES;
//                    UIImageView *background_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500/2, 327/2)];
//                    background_img.image = [UIImage imageNamed:@"input-box1@2x.png"];
//                    [new_folder_view addSubview:background_img];
//                    [self.view addSubview:new_folder_view];
//                    new_folder_view.hidden=YES;
//                    
//                    title_lbl_for_new_view = [[UILabel alloc] initWithFrame:CGRectMake(5, 5.5, 500/2, 20)];
//                    title_lbl_for_new_view.backgroundColor = [UIColor clearColor];
//                    title_lbl_for_new_view.textColor =[UIColor colorWithRed:(208.0f/255.0f) green:(198.0f/255.0f) blue:(200.0f/255.0f) alpha:1];
//                    title_lbl_for_new_view.font= [UIFont fontWithName:@"SourceSansPro-Semibold" size:15.5f];
//                    [new_folder_view addSubview:title_lbl_for_new_view];
//                    
//                    text_enter = [[CustomTextField alloc] initWithFrame:CGRectMake(7.5f, 50, 469/2, 66/2)];
//                    text_enter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input-box@2x.png"]];
//                    text_enter.delegate=self;
//                    text_enter.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
//                    text_enter.autocapitalizationType=UITextAutocapitalizationTypeNone;
//                    text_enter.textColor = [UIColor blackColor];
//                    [new_folder_view addSubview:text_enter];
//                    
//                    ok_button = [[UIButton alloc] initWithFrame:CGRectMake(65, 327/2-57, 253/2, 57/2)];
//                    [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn@2x.png"] forState:UIControlStateNormal];
//                    [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn1@2x.png"] forState:UIControlStateHighlighted];
//                    [ok_button addTarget:self action:@selector(newfolderactions:) forControlEvents:UIControlEventTouchUpInside];
//                    ok_button.tag=0;
//                    [new_folder_view addSubview:ok_button];
//                }
//                    break;
//            }
//        }
//            break;
//    }
//}
//-(void)copyThisUrl:(UIButton *)sender
//{
//    if([[NSString stringWithFormat:@"%@",[sender titleForState:UIControlStateNormal]] isEqualToString:@"Copy Url"])
//    {
//        [self copyAlertShow];
//    }
//    else
//    {
////        [self dropdownaction];
//        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Your Action"
//                                                                 delegate:self
//                                                        cancelButtonTitle:@"Cancel Button"
//                                                   destructiveButtonTitle:nil
//                                                        otherButtonTitles:@"Copy Url", @"Check all images",@"Rename photo",@"Delete photo",@"Copy / Paste photo",nil];
//        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
//        if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad)
//        {
//            [actionSheet addButtonWithTitle:@"Cancel"];
//        }
//        [actionSheet showInView:self.view];
//    }
//}
//
//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    self.selectedIndexPaths = [[NSMutableArray alloc]init];
//    [list_tab reloadData];
//
//    switch (buttonIndex) {
//        case 0:
//        {
//            [tempHeader removeFromSuperview];
//            nav_bar.hidden = NO;
//            NSLog(@"here here");
//            [self copyAlertShow];
//        }
//            break;
//        case 1:
//        {
//            [tempHeader removeFromSuperview];
//            nav_bar.hidden = NO;
//
//            NSMutableArray *imgs = [[NSMutableArray alloc] init];
//            for (int j = 0; j<[folder_table_data count];j++)
//            {
//                NSDictionary *dict = [folder_table_data objectAtIndex:j];
//                if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"type"]] isEqualToString:@"file"])
//                {
//                    NSString *str = [NSString stringWithFormat:@"%@/%@",director_string,[dict objectForKey:@"name"]];
//                    [imgs addObject:[str stringByReplacingOccurrencesOfString:@".." withString:parent_url_for_ftp_image_listing]];
//                }
//            }
//            ImagePagingViewController *image_paging = [[ImagePagingViewController alloc] init];
//            image_paging.array_new_images = imgs;
//            image_paging.ftp_path = [NSString stringWithFormat:@"%@",self.navigationItem.title];
//            [self.navigationController pushViewController:image_paging animated:NO];
//        }
//            break;
//            case 2:
//        {
//            [tempHeader removeFromSuperview];
//            nav_bar.hidden = NO;
//            [SVProgressHUD showErrorWithStatus:@"Select a photo to rename"];
//            checkFlag=2;
//        }
//            break;
//            case 3:
//        {
//            [tempHeader removeFromSuperview];
//            nav_bar.hidden = NO;
//
//            [SVProgressHUD showErrorWithStatus:@"Select a photo to delete"];
//            checkFlag=3;
//        }
//            break;
//        case 4:     //=============================COPY + PASTE====================================//
//        {
//            nav_bar.hidden = YES;
//            
//            tempHeader = [[UIView alloc]init];
//            tempHeader.frame = CGRectMake(0, 0, 320, 57);
//            tempHeader.backgroundColor = [UIColor blackColor];
//            [self.view addSubview:tempHeader];
//            
//            UILabel *infoLbl = [[UILabel alloc]init];
//            infoLbl.frame = CGRectMake(10, 5, 180, 40);
//            infoLbl.text = @"Select the images and tap done when finished";
//            infoLbl.textColor = [UIColor whiteColor];
//            infoLbl.font = [UIFont systemFontOfSize:15];
//            infoLbl.textAlignment = NSTextAlignmentLeft;
//            infoLbl.numberOfLines = 2;
//            [tempHeader addSubview:infoLbl];
//            
//            UIButton *doneBtn = [[UIButton alloc]init];
//            doneBtn.frame = CGRectMake(222, 13.5f, 80, 30);
//            doneBtn.layer.cornerRadius = 5;
//            doneBtn.backgroundColor = [UIColor clearColor];
//            doneBtn.layer.borderWidth = 2;
//            doneBtn.layer.borderColor = [[UIColor whiteColor]CGColor];
//            [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
//            [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [doneBtn addTarget:self action:@selector(doneto:) forControlEvents:UIControlEventTouchUpInside];
//            [tempHeader addSubview:doneBtn];
//
//            [SVProgressHUD showErrorWithStatus:@"Select a photo to copy"];
//            checkFlag=4;
//        }
//            break;
//    }
//    
//}
//
//-(void)copyAlertShow
//{
//    UIAlertView *alert_confirm = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Do you want to copy this url?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
//    alert_confirm.tag=100;
//    [alert_confirm show];
//}
//
////-(void)copyPastePhotosAlertShow
////{
////    
////    UIAlertView *alert_confirm = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Select the photos to be copied" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
////    alert_confirm.tag=100;
////    [alert_confirm show];
////    
////}
//
//-(void)dropdownaction
//{
//    int height_for_drop_down_menu=0,x_postion_for_drop_down_menu=0,y_position_for_name_view=0;
//    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
//        case UIUserInterfaceIdiomPad:
//        {
//            height_for_drop_down_menu = 100;
//        }
//            break;
//        case UIUserInterfaceIdiomPhone:
//        {
//            height_for_drop_down_menu = 200;
//        }
//            break;
//    }
//    
//    switch (self.interfaceOrientation)
//    {
//        case UIDeviceOrientationPortrait:
//        {
//            x_postion_for_drop_down_menu =[[UIScreen mainScreen]bounds].size.width;
//            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.height;
//        }
//            break;
//        case UIInterfaceOrientationLandscapeLeft:
//        {
//            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
//            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
//        }
//            break;
//        case UIInterfaceOrientationLandscapeRight:
//        {
//            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
//            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
//        }
//            break;
//        case UIInterfaceOrientationPortraitUpsideDown:
//        {
//            x_postion_for_drop_down_menu =[[UIScreen mainScreen]bounds].size.width;
//            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.height;
//        }
//            break;
//    }
//    
//    if(drop_down_view_ftp == nil)
//    {
//        drop_down_view_ftp = [[UIView alloc]  initWithFrame:CGRectMake(x_postion_for_drop_down_menu-150, 0, 150, 0)];
//        drop_down_view_ftp.backgroundColor = [UIColor clearColor];
//        drop_down_view_ftp.autoresizesSubviews = YES;
//        drop_down_view_ftp.clipsToBounds = YES;
//        
//        for (int count = 0;count<2;count++)
//        {
//            CGRect btn_frame =  CGRectMake(0, 0, 150, 0);
//            NSString *title=nil;
//            switch (count) {
//                case 0:
//                {
//                    title=@"Copy Url";
//                }
//                    break;
//                case 1:
//                {
//                    title = @"Check all images";
//                }
//                    break;
//            }
//            UIButton *btn = [[UIButton alloc] initWithFrame:btn_frame];
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [btn setTitle:title forState:UIControlStateNormal];
//            [btn setTag:count];
//            [btn setBackgroundColor:[UIColor colorWithRed:(255.0f/255.0f) green:(164.0f/255.0f) blue:(115.0f/255.0f) alpha:1.0f]];
//            if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone)
//            {
//                [[btn layer]setCornerRadius:20];
//            }
//            else
//            {
//                [[btn layer]setCornerRadius:30];
//            }
//            
//            [btn addTarget:self action:@selector(btn_functions_forFtp:) forControlEvents:UIControlEventTouchUpInside];
//            [drop_down_view_ftp addSubview:btn];
//        }
//        [self.view addSubview:drop_down_view_ftp];
//    }
//    if(drop_down_view_ftp.frame.size.height==0)
//    {
//        [self openPopup];
//    }
//    else
//    {
//        [self closePopup];
//    }
//}
//
//-(void)btn_functions_forFtp:(UIButton *)bt_sender
//{
//    [self closePopup];
//    switch ([bt_sender tag]) {
//        case 0:
//        {
//          [self copyAlertShow];
//        }
//            break;
//        case 1:
//        {
//            NSMutableArray *imgs = [[NSMutableArray alloc] init];
//            for (int j = 0; j<[folder_table_data count];j++)
//            {
//                NSDictionary *dict = [folder_table_data objectAtIndex:j];
//                if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"type"]] isEqualToString:@"file"])
//                {
//                    NSString *str = [NSString stringWithFormat:@"%@/%@",director_string,[dict objectForKey:@"name"]];
//                    
//                      [imgs addObject:[str stringByReplacingOccurrencesOfString:@".." withString:parent_url_for_ftp_image_listing]];
//                }
//            }
//            ImagePagingViewController *image_paging = [[ImagePagingViewController alloc] init];
//            image_paging.array_new_images = imgs;
//            image_paging.ftp_path = [NSString stringWithFormat:@"%@",self.navigationItem.title];
//            [self.navigationController pushViewController:image_paging animated:NO];
//        }
//            break;
//    }
//}
//
//-(void)goback_ftp:(UIButton *)sender
//{
//    NSLog(@"in go-back-ftp");
//    checkFlag = 0;
//    nav_bar.hidden = NO;
//    tempHeader.hidden = YES;
//
//
//    self.selectedIndexPaths = [[NSMutableArray alloc]init];
//
//    if([folder_path_array count]==0)
//    {
//        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        delegate.libopen = YES;
////        [self.navigationController popViewControllerAnimated:NO];
//        RootViewController *root = [[RootViewController alloc]init];
//        [self.navigationController pushViewController:root animated:NO];
//    }
//    else
//    {
//        [UIView transitionWithView: list_tab
//                          duration: 0.5f
//                           options: UIViewAnimationOptionTransitionCrossDissolve
//                        animations: ^(void)
//         {
//             list_tab.hidden=YES;
//         }
//                        completion: ^(BOOL isFinished)
//         {
//             [SVProgressHUD showSuccessWithStatus:@"Loading.."];
//             director_string = [folder_path_array lastObject];
//             
//             thumb_new_path = [director_string stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"];
//             [folder_path_array removeLastObject];
//             [self starttheftplisting];
//         }];
//    }
//}
//- (void)displayPickerForGroup:(ALAssetsGroup *)group
//{
//    ELCAssetTablePicker *tablePicker = [[ELCAssetTablePicker alloc] initWithNibName: nil bundle: nil];
//    tablePicker.singleSelection = YES;
//    tablePicker.immediateReturn = YES;
//    
//    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
//    elcPicker.maximumImagesCount = 1;
//    elcPicker.delegate = self;
//    tablePicker.parent = elcPicker;
//    // Move me
//    tablePicker.assetGroup = group;
//    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];
//    
//    [self presentViewController:elcPicker animated:YES completion:nil];
//}
//- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
//{
//    if([info count]>0)
//    {
//        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//        delegate.libopen = NO;
//        ImageDetailViewController *image_detail = [[ImageDetailViewController alloc] init];
//        image_detail.image_data_from_library = [NSMutableArray arrayWithCapacity:[info count]];
//        image_detail.url_of_images = [[NSMutableArray alloc] init];
//        
//        for(NSDictionary *dict in info) {
//            UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
//            
//            [image_detail.url_of_images addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:UIImagePickerControllerReferenceURL]]];
//            [image_detail.image_data_from_library addObject:image];
//        }
//        image_detail.imgtypestatic=NO;
//        image_detail.selected_image = [[UIImage alloc] init];
//        image_detail.selected_image = (UIImage *)[image_detail.image_data_from_library objectAtIndex:0];
//        image_detail.url_of_image = [image_detail.url_of_images objectAtIndex:0];
//        image_detail.tag = 0;
//        
//        CATransition* transition = [CATransition animation];
//        transition.duration = 0.5;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.type = kCATransitionFade;
//        
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//            [self.navigationController.view.layer addAnimation:transition forKey:nil];
//            [self.navigationController pushViewController:image_detail animated:YES];
//        }];
//    }
//    else
//    {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//}
//-(void)openPopup
//{
//    int height_for_drop_down_menu=0,x_postion_for_drop_down_menu=0,y_position_for_name_view=0;
//    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
//        case UIUserInterfaceIdiomPad:
//        {
//            height_for_drop_down_menu = 100;
//        }
//            break;
//        case UIUserInterfaceIdiomPhone:
//        {
//            height_for_drop_down_menu = 200;
//        }
//            break;
//    }
//    
//    switch (self.interfaceOrientation)
//    {
//        case UIDeviceOrientationPortrait:
//        {
//            x_postion_for_drop_down_menu =[[UIScreen mainScreen]bounds].size.width;
//            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.height;
//        }
//            break;
//        case UIInterfaceOrientationLandscapeLeft:
//        {
//            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
//            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
//        }
//            break;
//        case UIInterfaceOrientationLandscapeRight:
//        {
//            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
//            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
//        }
//            break;
//        case UIInterfaceOrientationPortraitUpsideDown:
//        {
//            x_postion_for_drop_down_menu =[[UIScreen mainScreen]bounds].size.width;
//            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.height;
//        }
//            break;
//    }
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        list_tab.layer.opacity=0.5;
//        list_tab.scrollEnabled=NO;
//        drop_down_view_ftp.frame = CGRectMake(x_postion_for_drop_down_menu-150, 0, 150, height_for_drop_down_menu);
//        
//        for (UIView *sub in drop_down_view_ftp.subviews)
//        {
//            if([sub isKindOfClass:[UIButton class]])
//            {
//                UIButton *btn = (UIButton *)sub;
//                CGRect frame_btn = btn.frame;
//                switch (btn.tag) {
//                    case 0:
//                    {
//                        frame_btn.origin.y=0;
//                    }
//                        break;
//                    case 1:
//                    {
//                        if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone)
//                        {
//                            frame_btn.origin.y=height_for_drop_down_menu/4+1.0f;
//                        }
//                        else
//                        {
//                            frame_btn.origin.y=height_for_drop_down_menu/2+1.0f;
//                        }
//                    }
//                        break;
//                }
//                if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad)
//                {
//                    CGFloat height = height_for_drop_down_menu/2;
//                    frame_btn.size.height = height;
//                    btn.frame = frame_btn;
//                }
//                else
//                {
//                    CGFloat height = height_for_drop_down_menu/4;
//                    frame_btn.size.height = height;
//                    btn.frame = frame_btn;
//                }
//            }
//        }
//    }];
//}
//-(void)closePopup
//{
//    int height_for_drop_down_menu=0,x_postion_for_drop_down_menu=0,y_position_for_name_view=0;
//    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
//        case UIUserInterfaceIdiomPad:
//        {
//            height_for_drop_down_menu = 200;
//        }
//            break;
//        case UIUserInterfaceIdiomPhone:
//        {
//            height_for_drop_down_menu = 100;
//        }
//            break;
//    }
//    switch (self.interfaceOrientation)
//    {
//        case UIDeviceOrientationPortrait:
//        {
//            x_postion_for_drop_down_menu =[[UIScreen mainScreen]bounds].size.width;
//            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.height;
//        }
//            break;
//        case UIInterfaceOrientationLandscapeLeft:
//        {
//            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
//            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
//        }
//            break;
//        case UIInterfaceOrientationLandscapeRight:
//        {
//            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
//            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
//        }
//            break;
//        case UIInterfaceOrientationPortraitUpsideDown:
//        {
//            x_postion_for_drop_down_menu =[[UIScreen mainScreen]bounds].size.width;
//            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.height;
//        }
//            break;
//    }
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        list_tab.layer.opacity=1;
//        list_tab.scrollEnabled=YES;
//        drop_down_view_ftp.frame = CGRectMake(x_postion_for_drop_down_menu-150, 0, 150, 0);
//        
//        for (UIView *sub in drop_down_view_ftp.subviews)
//        {
//            if([sub isKindOfClass:NSClassFromString(@"UIButton")])
//            {
//                UIButton *bt = (UIButton *)sub;
//                CGRect bt_frame = bt.frame;
//                
//                bt_frame = CGRectMake(bt_frame.origin.x, [bt tag]*drop_down_view_ftp.frame.size.height/2, bt_frame.size.width, drop_down_view_ftp.frame.size.height/2);
//                bt.frame = bt_frame;
//            }
//        }
//    }];
//}
//
//-(void)orientationChangedinFTP:(NSNotification *)note
//{
//    UIDevice * device = note.object;
//    switch ([[UIDevice currentDevice] userInterfaceIdiom])
//    {
//        case UIUserInterfaceIdiomPhone:
//        {
//            switch(device.orientation)
//            {
//                case UIDeviceOrientationUnknown:
//                case UIDeviceOrientationFaceDown:
//                case UIDeviceOrientationFaceUp:
//                case UIDeviceOrientationPortraitUpsideDown:
//                    break;
//                case UIDeviceOrientationPortrait:
//                {
//                    [UIView animateWithDuration:1.0
//                                     animations:^{
//                                         
//                                         bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 114/2);
//                                         nav_bar.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 114/2);
//                                         new_folder_btn.frame =CGRectMake(0, 0, 75, 114/2);
//                                         rename_folder_btn.frame =CGRectMake(80.5, 0, 75, 114/2);
//                                         move_folder_btn.frame =CGRectMake(80.5*2, 0, 75, 114/2);
//                                         delete_folder_btn.frame =CGRectMake(80.5f*3, 0, 75, 114/2);
//                                         shadow_view.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height-45);
//                                         if([[UIScreen mainScreen] bounds].size.height<568)
//                                         {
//                                              new_folder_view.frame =CGRectMake(([[UIScreen mainScreen] bounds].size.width-500/2)/2, 100-self.navigationController.navigationBar.frame.size.height, 500/2, 327/2);
//                                         }
//                                         else
//                                         {
//                                              new_folder_view.frame =CGRectMake(([[UIScreen mainScreen] bounds].size.width-500/2)/2,180-self.navigationController.navigationBar.frame.size.height, 500/2, 327/2);
//                                         }
//                                         
//                                         if(drop_down_view_ftp.frame.size.height>0 && drop_down_view_ftp!=nil)
//                                         {
//                                             [self openPopup];
//                                         }
//                                     }
//                                     completion:^(BOOL finished){  }];
//                }
//                    break;
//                case UIDeviceOrientationLandscapeLeft:
//                case UIDeviceOrientationLandscapeRight:
//                {
//                    [UIView animateWithDuration:1.0
//                                     animations:^{
//                                         bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 114/2);
//                                         nav_bar.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 114/2);
//                                         new_folder_btn.frame =CGRectMake(20, 0, 75, 114/2);
//                                         if([[UIScreen mainScreen]bounds].size.height<568)
//                                         {
//                                             rename_folder_btn.frame = CGRectMake(80.5+60, 0, 75, 114/2);
//                                             move_folder_btn.frame = CGRectMake(80.5*2+100, 0, 75, 114/2);
//                                             delete_folder_btn.frame = CGRectMake(80.5*3+150, 0, 75, 114/2);
//                                         }
//                                         else
//                                         {
//                                             rename_folder_btn.frame = CGRectMake(80.5+90, 0, 75, 114/2);
//                                             move_folder_btn.frame = CGRectMake(80.5*2+150, 0, 75, 114/2);
//                                             delete_folder_btn.frame = CGRectMake(80.5f*3+210, 0, 75, 114/2);
//                                         }
//                                         new_folder_view.frame =CGRectMake(([[UIScreen mainScreen] bounds].size.height-500/2)/2, -34, 500/2, 327/2);
//                                         shadow_view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-45);
//                                         
//                                         if(drop_down_view_ftp.frame.size.height>0 && drop_down_view_ftp!=nil)
//                                         {
//                                             [self openPopup];
//                                         }
//                                     }
//                                     completion:^(BOOL finished){ }];
//                }
//                    break;
//            };
//        }
//            break;
//        case UIUserInterfaceIdiomPad:
//        {
//            switch(device.orientation)
//            {
//                case UIDeviceOrientationUnknown:
//                case UIDeviceOrientationFaceDown:
//                case UIDeviceOrientationFaceUp:
//                case UIDeviceOrientationPortraitUpsideDown:
//                                    break;
//                case UIDeviceOrientationPortrait:
//                {
//                    [UIView animateWithDuration:1.0
//                                     animations:^{
//                                         [self setViewMovedUp:NO];
//                                         bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 114/2);
//                                         nav_bar.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 114/2);
//                                         new_folder_btn.frame =CGRectMake(65, 0, 75, 114/2);
//                                         rename_folder_btn.frame =CGRectMake(128*2, 0, 75, 114/2);
//                                         move_folder_btn.frame =CGRectMake(128*3+65, 0, 75, 114/2);
//                                         delete_folder_btn.frame =CGRectMake(128*4+115, 0, 75, 114/2);
//                                         shadow_view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-45);
//                                         if([[UIScreen mainScreen] bounds].size.height<568)
//                                         {
//                                             new_folder_view.frame =CGRectMake(([[UIScreen mainScreen] bounds].size.width-500/2)/2, 100-self.navigationController.navigationBar.frame.size.height, 500/2, 327/2);
//                                         }
//                                         else
//                                         {
//                                             new_folder_view.frame =CGRectMake(([[UIScreen mainScreen] bounds].size.width-500/2)/2,180-self.navigationController.navigationBar.frame.size.height, 500/2, 327/2);
//                                         }
//                                         if(drop_down_view_ftp.frame.size.height>0 && drop_down_view_ftp!=nil)
//                                         {
//                                             [self openPopup];
//                                         }
//                                     }
//                                     completion:^(BOOL finished){  }];
//                }
//                    break;
//                case UIDeviceOrientationLandscapeLeft:
//                case UIDeviceOrientationLandscapeRight:
//                {
//                    [UIView animateWithDuration:1.0
//                                     animations:^{
//                                         [self setViewMovedUp:YES];
//                                         bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 114/2);
//                                         nav_bar.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 114/2);
//                                         new_folder_btn.frame =CGRectMake(80, 0, 75, 114/2);
//                                         rename_folder_btn.frame = CGRectMake(199.5f+140, 0, 75, 114/2);
//                                         move_folder_btn.frame = CGRectMake(199.5f*2+195, 0, 75, 114/2);
//                                         delete_folder_btn.frame = CGRectMake(199.5f*3+255, 0, 75, 114/2);
//                                         new_folder_view.frame =CGRectMake(([[UIScreen mainScreen] bounds].size.height-500/2)/2, 60, 500/2, 327/2);
//                        shadow_view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
//                                         if(drop_down_view_ftp.frame.size.height>0 && drop_down_view_ftp!=nil)
//                                         {
//                                             [self openPopup];
//                                         }
//                                     }
//                                     completion:^(BOOL finished){ }];
//                }
//                    break;
//            };
//        }
//            break;
//    }
//    [list_tab reloadData];
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    if([SVProgressHUD isVisible])
//    {
//        [SVProgressHUD dismiss];
//    }
//    drop_down_view_ftp = nil;
//    [super viewWillDisappear:YES];
//}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:NO];
//    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self selector:@selector(orientationChangedinFTP:)
//     name:UIDeviceOrientationDidChangeNotification
//     object:[UIDevice currentDevice]];
//}
//
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:YES];
//    imageorfolder=0;
//    self.selectedIndexPaths = [[NSMutableArray alloc]init];
//    
//    if(folder_path_array==nil && [director_string length]==0)
//    {
//        folder_path_array = [[NSMutableArray alloc] init];
//        director_string =[[NSString alloc] init];
//        director_string = [NSString stringWithFormat:@"../user/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]];
//        thumb_new_path = [director_string stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"];
//    }
//    intial_click_on_go_back = YES;
//     [SVProgressHUD showWithStatus:@"Loading.."];
//    [self starttheftplisting];
//}
//
//-(void)starttheftplisting
//{
//    NSString *url_string = [[NSString alloc] init];
//    intial=YES;
//    selectedindex = 0;
//    url_string = [NSString stringWithFormat:@"%@iosphoto_actiontest.php?dir=%@",mydomainurl,[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSLog(@" url is %@",url_string);
//    
//    if (![[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isKindOfClass:[NSNull class]] && [[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] length] != 0)
//
//    
//    [self new_reload:url_string];
//}
//
//-(void)new_reload:(NSString *)urlString
//{
//    NSString *urlString1 =urlString;
//    NSLog(@"ftp:- fired url is: %@",urlString1);
//    NSString *newString1 = [urlString1 stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    @try {
//        NSError *error;     //**** change made here nil added ****//
//        
//        NSData *signeddataURL1 =[NSData dataWithContentsOfURL:[NSURL URLWithString:newString1]];
//        
//        if (signeddataURL1 == nil)
//        {
//            alert = [[UIAlertView alloc] initWithTitle:@"Error in Server Connection!"
//                                               message:nil
//                                              delegate:self
//                                     cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
//            [alert show];
//        }
//        else
//        {
//            
//            NSMutableDictionary *data = [NSJSONSerialization JSONObjectWithData:signeddataURL1 //1
//                                                                        options:kNilOptions
//                                                                          error:&error];
//            
//            NSLog(@"data coming: %@",data);
//            [self.navigationItem setTitle:[NSString stringWithFormat:@"%@",[director_string lastPathComponent]]];
//            
//            //    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
//            //
//            //    AFJSONRequestOperation *operation_folders = [AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]
//            //                                success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
//            //                                                 {
//            folder_table_data = [[NSMutableArray alloc] init];
//            BOOL images_present = NO;
//            for (NSDictionary *obt in data)
//            {
//                [folder_table_data  addObject:obt];
//                
//                if([[NSString stringWithFormat:@"%@",[obt objectForKey:@"type"]] isEqualToString:@"file"])
//                {
//                    NSLog(@"image present yes");
//                    images_present = YES;
//                }
//            }
//            
//            //        [list_tab reloadData];
//            if([folder_table_data count]>0)
//            {
//                NSLog(@"yes count is > 0");
//                [list_tab reloadData];
//            }
//            else
//            {
//                UIButton *add_button =  [UIButton buttonWithType:UIButtonTypeCustom];
//                [[add_button titleLabel] setTextAlignment:NSTextAlignmentCenter];
//                [[add_button titleLabel] setNumberOfLines:3];
//                [[add_button titleLabel] setFont:[UIFont systemFontOfSize:13]];
//                [[add_button titleLabel] setTextAlignment:NSTextAlignmentCenter];
//                [add_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                [add_button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//                [add_button addTarget:self action:@selector(copyThisUrl:)forControlEvents:UIControlEventTouchUpInside];
//                [add_button setFrame:CGRectMake(0, 0,32, 25/2)];
//                [add_button setTitle:@"Copy Url" forState:UIControlStateNormal];
//                UIBarButtonItem *actionbarButton = [[UIBarButtonItem alloc] initWithCustomView:add_button];
//                self.navigationItem.rightBarButtonItem = actionbarButton;
//                [list_tab reloadData];
//
//                [SVProgressHUD showErrorWithStatus:@"The folder is empty"];
//            }
//            
//            if(drop_down_view_ftp!=nil)
//            {
//                [self closePopup];
//            }
//            // NSLog(@" images present is %d",images_present);
//            UIButton *add_button =  [UIButton buttonWithType:UIButtonTypeCustom];
//            [[add_button titleLabel] setTextAlignment:NSTextAlignmentCenter];
//            [[add_button titleLabel] setNumberOfLines:3];
//            [[add_button titleLabel] setFont:[UIFont systemFontOfSize:13]];
//            [[add_button titleLabel] setTextAlignment:NSTextAlignmentCenter];
//            [add_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [add_button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//            [add_button addTarget:self action:@selector(copyThisUrl:)forControlEvents:UIControlEventTouchUpInside];
//            [add_button setFrame:CGRectMake(0, 0,32, 25/2)];
//            if(images_present != YES)
//            {
//                [add_button setTitle:@"Copy Url" forState:UIControlStateNormal];
//            }
//            else
//            {
//                [add_button setTitle:@"More" forState:UIControlStateNormal];
//            }
//            UIBarButtonItem *actionbarButton = [[UIBarButtonItem alloc] initWithCustomView:add_button];
//            self.navigationItem.rightBarButtonItem = actionbarButton;
//            
//            //                                                     [UIView transitionWithView: list_tab
//            //                                                                       duration: 1.00f
//            //                                                                        options: UIViewAnimationOptionTransitionCrossDissolve
//            //                                                                     animations: ^(void)
//            //                                                      {
//            
//            list_tab.hidden=NO;
//            
//            //                                                      }
//            //                                                                    completion: ^(BOOL isFinished){
//
//        }
//        
//    }
//    @catch (NSException *exception) {
//        NSLog(@"exception in ftp listing : %@",exception.description);
//    }
//       //                                                                     }];
//    
////                                                 }
////                                                failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON)
////                                                 {
////                                                     [SVProgressHUD showErrorWithStatus:@"Internet failure"];
////                                                 }];
////    [operation_folders start];
//}
//
//
////-----------------------------TableView-----------------------------------------------------------//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//        return 65;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [SVProgressHUD dismiss];
//    
//    listEntry = [[NSDictionary alloc] init];
//    
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    cell= nil;
//    
//    if (cell == nil) {
//        
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        
//    }
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleGray;
//    
//    cell.frame = CGRectMake(0, 0, tableView.frame.size.width, 65);
//    
//    
//    
//    listEntry = [folder_table_data objectAtIndex:((NSUInteger) indexPath.row)];
//    
//    cell.contentView.tag=indexPath.row;
//    
//    
//    
//    UIImageView *cell_back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copymove-cell-bg.png"]];
//    
//    [cell_back setContentMode:UIViewContentModeTopRight];
//    
//    [cell.contentView addSubview:cell_back];
//    
//    
//    
//    //    UIButton *iconButton_FTP = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    //    [iconButton_FTP setFrame:CGRectMake(9, 9, 50, 50)];
//    
//    //    [iconButton_FTP setAdjustsImageWhenHighlighted:NO];
//    
//    //    [cell.contentView addSubview:iconButton_FTP];
//    
//    
//    
//    UIImageView *iconImage_FTP = [[UIImageView alloc]init];
//    
//    [iconImage_FTP setFrame:CGRectMake(9, 7, 50, 50)];
//    
//    [cell.contentView addSubview:iconImage_FTP];
//    
//    
//    
//    UILabel *folder_name_for = [[UILabel alloc] init];
//    
//    [folder_name_for setFont:KOFONT_FILES_TITLE];
//    
//    [folder_name_for setTextColor:KOCOLOR_FILES_COUNTER];
//    
//    [folder_name_for.layer setShadowColor:KOCOLOR_FILES_TITLE_SHADOW.CGColor];
//    
//    [folder_name_for.layer setShadowOffset:CGSizeMake(0, 1)];
//    
//    [folder_name_for.layer setShadowOpacity:1.0f];
//    
//    [folder_name_for.layer setShadowRadius:0.0f];
//    
//    [folder_name_for setBackgroundColor:[UIColor clearColor]];
//    
//    [folder_name_for setFrame:CGRectMake(90, (cell.frame.size.height-20)/2, folder_name_for.frame.size.width, 20)];
//    
//    [cell.contentView addSubview:folder_name_for];
//    
//    int set_Away;
//    
//    if([UIDevice currentDevice].userInterfaceIdiom== UIUserInterfaceIdiomPad)
//        
//    {
//        
//        set_Away=100;
//        
//    }
//    
//    else
//        
//    {
//        
//        set_Away = 70;
//        
//    }
//    
//    NSLog(@"calculation: %f",self.view.bounds.size.width-set_Away);
//    
//    
//    
//    UIButton *details_button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-set_Away,(cell.frame.size.height-28)/2, 47, 28)];
//    
//    [details_button setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
//    
//    [details_button setBackgroundImage:[UIImage imageNamed:@"item-counter"] forState:UIControlStateNormal];
//    
//    [details_button setBackgroundImage:[UIImage imageNamed:@"item-counter"] forState:UIControlStateHighlighted];
//    
//    [details_button setBackgroundImage:[UIImage imageNamed:@"item-counter"] forState:UIControlStateSelected];
//    
//    [details_button setTitle:@"Details" forState:UIControlStateNormal];
//    
//    [details_button setTitle:@"Details" forState:UIControlStateHighlighted];
//    
//    [details_button setTitle:@"Details" forState:UIControlStateSelected];
//    
//    
//    
//    [details_button setTitleColor:KOCOLOR_FILES_COUNTER forState:UIControlStateNormal];
//    
//    [details_button setTitleColor:KOCOLOR_FILES_COUNTER forState:UIControlStateSelected];
//    
//    [details_button setTitleColor:KOCOLOR_FILES_COUNTER forState:UIControlStateHighlighted];
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//        
//    {
//        
//        [[details_button titleLabel] setShadowOffset:CGSizeMake(0, 1)];
//        
//    }
//    
//    
//    
//    [[details_button titleLabel] setFont:KOFONT_FILES_COUNTER];
//    
//    
//    
//    [details_button addTarget:self action:@selector(detailsaboutfolder:) forControlEvents:UIControlEventTouchUpInside];
//    
//    details_button.tag=indexPath.row;
//    
//    
//    
//    //    thumbImage = [[NSString alloc]init];
//    
//    checkThumbImage = [[NSString alloc]init];
//    
//    
//    if ([[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isKindOfClass:[NSNull class]] || [[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] length] == 0)
//
//    director_string=prev_directory;
//thumb_new_path = [director_string stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"];
//    
//    NSLog(@"director string: %@",director_string);
//    
//    
//    
//    //    thumbImage = [NSString stringWithFormat:@"%@/user/%@/%@",parent_url_for_ftp_image_listing,director_string,[listEntry objectForKey:@"image_name"]];
//    
//    
//    
//    
//    
//    //    checkString = [NSString stringWithFormat:@"%@",[listEntry objectForKey:@"type"]];
//    
//    
//    NSArray *dir_array= [director_string componentsSeparatedByString:@"../user/"];
//    
//    NSString *dir_new_str = [dir_array objectAtIndex:1];
//    
//    NSLog(@"dir_new_str :%@",dir_new_str);
//    
//    
//    if(![[listEntry objectForKey:@"name"] isEqualToString:@"."]&&![[listEntry objectForKey:@"name"] isEqualToString:@".."])
//    {
//        if([[NSString stringWithFormat:@"%@",[listEntry objectForKey:@"type"]] isEqualToString:@"file"])
//        {
//            //            albumImage = [NSString stringWithFormat:@"%@/%@",string,[listEntry objectForKey:@"thumb_image_name"]];
//            
//            albumImage = [NSString stringWithFormat:@"%@%@/%@",userurl,dir_new_str,[listEntry objectForKey:@"thumb_image_name"]];
//            
//            //            NSLog(@"THuMBiMAGE======================>%@",thumbImage);
//            
//            NSLog(@"ALBUMiMAGE======================>%@",albumImage);
//            
//            NSLog(@"Second if");
//            NSLog(@"This is after the Initial Step");
//
//            folder_name_for.text=[listEntry objectForKey:@"name"];
//            
//            [iconImage_FTP setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[albumImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
//            
//            //            [iconButton_FTP setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",string]] forState:UIControlStateNormal];
//            
//            //            [iconButton_FTP setImage:[UIImage imageNamed:@"imageFileicon.png"] forState:UIControlStateNormal];
//            
//            //            [iconButton_FTP setImage:[UIImage imageNamed:@"imageFileicon.png"] forState:UIControlStateSelected];
//            
//            //            [iconButton_FTP setImage:[UIImage imageNamed:@"imageFileicon.png"] forState:UIControlStateHighlighted];
//            
//            
//            //            UISwipeGestureRecognizer * Swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipetoDelete:)];
//            
//            //            Swipeleft.direction=UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
//            
//            //            [cell.contentView addGestureRecognizer:Swipeleft];
//            
//            cell_back.frame= CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height);
//        }
//        
//        else
//        {
//            NSLog(@"first else");
//            
//            UIImageView *backgroundfolderimg = [[UIImageView alloc]initWithFrame:CGRectMake(-2, -10, 77, 77)];
//            [cell.contentView addSubview:backgroundfolderimg];
//            backgroundfolderimg.image= [UIImage imageNamed:@"rednew-folder.png"];
//            
//            [iconImage_FTP setFrame:CGRectMake(11, 16, 50, 40)];
//
//            iconImage_FTP.layer.zPosition=2;
//            
//            if([[listEntry objectForKey:@"number_of_images"] intValue]>0)
//            {
//              folder_name_for.text=[NSString stringWithFormat:@"%@ (%d)",[listEntry objectForKey:@"name"],[[listEntry objectForKey:@"number_of_images"] intValue]];
//            }
//            else
//            {
//                folder_name_for.text=[listEntry objectForKey:@"name"];
//            }
//            if(intial)
//            {
//                NSLog(@"initial if");
//                
//                checkThumbImage = [NSString stringWithFormat:@"%@%@/%@/%@",[userurl stringByReplacingOccurrencesOfString:@"user" withString:@"thumb"],dir_new_str,[listEntry objectForKey:@"name"] ,[listEntry objectForKey:@"image_name"]];
//                NSLog(@"checkTHUMBiMAGE bb======================>%@",checkThumbImage);
//                
//                //                if ([[listEntry objectForKey:@"type"] isEqualToString:@"file"])     //============Check if return "type" is file or directory
//                //                {
//                if ([[listEntry objectForKey:@"number_of_images"] intValue]>0)
//                {
//                    NSLog(@"etay ashbe");
//                    [iconImage_FTP setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[checkThumbImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]]; //setImageWithURl
//                }
//                else
//                {
//                    NSLog(@"onnotay ashbe");
////                    [iconImage_FTP setImage:[UIImage imageNamed:@"item-icon-folder"]];
//                    
//                    //                [iconButton_FTP setImage:[UIImage imageNamed:@"item-icon-folder"] forState:UIControlStateSelected];
//                    //                [iconButton_FTP setImage:[UIImage imageNamed:@"item-icon-folder"] forState:UIControlStateHighlighted];
//                }
//            }
//            else
//            {
//                checkThumbImage = [NSString stringWithFormat:@"%@%@/%@/%@",[userurl stringByReplacingOccurrencesOfString:@"user" withString:@"thumb"],dir_new_str,[listEntry objectForKey:@"name"] ,[listEntry objectForKey:@"image_name"]];
//                
//                [iconImage_FTP setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[checkThumbImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
//                
//                if(indexPath.row==selectedindex)
//                {
//                    NSLog(@"initial if");
//                    //                checkThumbImage = [NSString stringWithFormat:@"%@%@/%@/%@",userurl,director_string,[listEntry objectForKey:@"name"],[listEntry objectForKey:@"image_name"]];
//                    
//                    [iconImage_FTP setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[checkThumbImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
//                    
//                    NSLog(@"checkTHUMBiMAGE bb======================>%@",checkThumbImage);
//                    
//                    //                if ([[listEntry objectForKey:@"type"] isEqualToString:@"file"])     //============Check if return "type" is file or directory
//                    //                {
//                    if ([[listEntry objectForKey:@"number_of_images"] intValue]>0)
//                    {
//                        NSLog(@"etay ashbe");
//                        
//                        [iconImage_FTP setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[checkThumbImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]]; //setImageWithURl
//                    }
//                    else
//                    {
//                        NSLog(@"onnotay ashbe");
//                        
////                        [iconImage_FTP setImage:[UIImage imageNamed:@"item-icon-folder"]];
//                        
//                        //                [iconButton_FTP setImage:[UIImage imageNamed:@"item-icon-folder"] forState:UIControlStateSelected];
//                        //                [iconButton_FTP setImage:[UIImage imageNamed:@"item-icon-folder"] forState:UIControlStateHighlighted];
//                    }
//                    
//                }else{
//                    if ([[listEntry objectForKey:@"number_of_images"] intValue]>0)
//                    {
//                    checkThumbImage = [NSString stringWithFormat:@"%@%@/%@/%@",[userurl stringByReplacingOccurrencesOfString:@"user" withString:@"thumb"],dir_new_str,[listEntry objectForKey:@"name"],[listEntry objectForKey:@"image_name"]];
//                    
//                    [iconImage_FTP setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[checkThumbImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
//                    }else
//                    {
//                        NSLog(@"onnotay ashbe");
//                        
////                        [iconImage_FTP setImage:[UIImage imageNamed:@"item-icon-folder"]];
//                        
//                        //                [iconButton_FTP setImage:[UIImage imageNamed:@"item-icon-folder"] forState:UIControlStateSelected];
//                        //                [iconButton_FTP setImage:[UIImage imageNamed:@"item-icon-folder"] forState:UIControlStateHighlighted];
//                    }
//                }
//            }
//            
//            cell.contentView.frame= cell.bounds;
//            [cell.contentView addSubview:details_button];
//        }
//    }
//    else
//    {
//        cell_back.image = [UIImage imageNamed:@"copymove-cell-bg1.png"];
//        folder_name_for.textColor = [UIColor lightGrayColor];
//        cell.userInteractionEnabled=NO;
//    }
//    
//    CGFloat width =  [folder_name_for.text sizeWithFont:KOFONT_FILES_TITLE].width;
//    CGRect folder_frame = [folder_name_for frame];
//    folder_frame.size.width = width;
//    [folder_name_for setFrame:folder_frame];
//    
//    BOOL isSelected = [self.selectedIndexPaths containsObject:indexPath]; //=================================MULTIPLE IMAGES SELECTION AND STORING=====================//
//    //    //NSLog(@"isselected: %hhd",isSelected);
//    if (isSelected)
//    {
////        NSMutableArray *listArray = [[NSMutableArray alloc]init];
////        [listArray addObject:listEntry];
//        
//        [multiSelect addObject: [[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"]];
//        NSLog(@"yes selected");
//        NSLog(@"ARRAYYYYY==========>%@",multiSelect);
//        cell_back.image = [UIImage imageNamed:@"copymove-cell-bg1.png"];
//        
//    }
//    
//    return cell;
//}
//
//
//-(void)swipetoDelete:(UISwipeGestureRecognizer*)gestureRecognizer
//{
////    selected_to_delete = [NSIndexPath indexPathForRow:[[gestureRecognizer view] tag] inSection:0];
////    NSLog(@" tag is %d",[[gestureRecognizer view] tag]);
//////    selected_to_delete = ;
////    if(alert ==nil)
////    {
////        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"This will permanently remove photo from your folder. Do you want to go with it?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
////        alert.tag = 99;
////        [alert show];
////    }
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return (NSInteger) ([folder_table_data count]);
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (checkFlag == 4 )
//    {
//        if ([[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"directory"])
//        {
//        }
//        else
//          [self addOrRemoveSelectedIndexPath:indexPath];
//    }
//    else
//    [self addOrRemoveSelectedIndexPath:indexPath];
//    about_details=NO;
//    if([[NSString stringWithFormat:@"%@",[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"type"]] isEqualToString:@"file"] && checkFlag==0)
//    {
//        NSLog(@"CHECK FLAG == 0");
//        
//        ImageFromFTPViewController *img_ftp = [[ImageFromFTPViewController alloc] init];
//        img_ftp.url = [NSString stringWithFormat:@"%@/%@",director_string,[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"]];
//        img_ftp.folder_path_fromprev = folder_path_array;
//        NSLog(@"bhaswar got url is %@",[NSString stringWithFormat:@"%@/%@",director_string,[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"]]);
//        CATransition* transition = [CATransition animation];
//        transition.duration = 0.25;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.type = kCATransitionMoveIn;
//        transition.subtype = kCATransitionFromTop;
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
//        [self.navigationController pushViewController:img_ftp animated:NO];
//    }
//    else if (checkFlag == 2)//=======================Rename File=========================//
//    {
//
//        if([[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"file"])
//        {
//            NSLog(@"RENAME IF");
//        shadow_view.hidden=NO;
//        list_tab.userInteractionEnabled=NO;
//        title_lbl_for_new_view.text = @"New file name";
//        [UIView transitionWithView: new_folder_view
//                          duration: 0.5f
//                           options: UIViewAnimationOptionTransitionCrossDissolve
//                        animations: ^(void)
//         {
//             new_folder_view.hidden=NO;
//             
//             selectedImage = [[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"];
//             ok_button.tag=5;
//             [list_tab reloadData];
//         }
//         
//                        completion: ^(BOOL isFinished){
////                            [text_enter becomeFirstResponder];
////                            NSLog(@"SELECTEDDDDDDD iMAGE=================>%@",text_enter.text);
//            }];
//        }
//        else {
//            
//            deleteAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"This is not an image file" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
//            [deleteAlert show];
////            [self starttheftplisting];
//            checkFlag=0;
//            
//
//        }
//        
//        
//        NSLog(@"SELECTEDDDDDDD iMAGEb=================>%@",[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"]);
//
//    
//    }else if (checkFlag == 3)//======================Delete File=========================//
//    {
//        if([[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"file"])
//        {
//
//        selectedImage = [[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"];
//        deleteAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Do you want to delete the image" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//        [deleteAlert setTag:909];
//        [deleteAlert show];
//        
//        }
//        else {
//            
//            deleteAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"This is not an image file" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [deleteAlert show];
////            [self starttheftplisting];
//            checkFlag=0;
//            
//        }
//        
////        NSLog(@" url is %@",renameURL);
////        NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: renameURL ]];
////        NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
////        NSLog(@"serveroutput: %@",serverOutput);
////        alert = nil;
////        [folder_table_data removeObjectAtIndex:selected_to_delete.row];
////        [list_tab reloadData];
////        //[list_tab deleteRowsAtIndexPaths:@[selected_to_delete] withRowAnimation:UITableViewRowAnimationFade];
//        
//        
//    }else if (checkFlag == 4)       //================================Copy Image Folder Tree===============
//    {
//        
//        if([[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"file"])
//        {
//            
////        KOTreeViewController *tree = [[KOTreeViewController alloc] init];
////        tree.imageName = [[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"];
////        tree.image_to_be_copy = [NSString stringWithFormat:@"%@",director_string];
////        tree.type =@"COPY";
////        CATransition* transition = [CATransition animation];
////        transition.duration = 0.25;
////        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
////        transition.type = kCATransitionMoveIn;
////        transition.subtype = kCATransitionFromTop;
////        [self.navigationController.view.layer addAnimation:transition forKey:nil];
////        [self.navigationController pushViewController:tree animated:NO];
//            
//        
//            
////            checkFlag = 0;
//            imageorfolder=1;
//            
//        }else{
//            
//            NSLog(@"ELSE IS AN IDIOT");
//            
//            deleteAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"This is not an image file" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [deleteAlert show];
////            [self starttheftplisting];
////            checkFlag=0;
//            imageorfolder=0;
//        }
//
//        
//    }
//        if(selectedindex==indexPath.row && !(intial))
//        {
//            intial=YES;
//            selectedindex = 0;
//        }
//        else
//        {
//            if(intial)
//            {
//                intial=NO;
//            }
//            intial=NO;
//             selectedindex=indexPath.row;
//        }
//    
//        [tableView reloadData];
//    multiSelect = [[NSMutableArray alloc]init];
//
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//   
//    listEntry = [[NSDictionary alloc] init];
//    listEntry = [folder_table_data objectAtIndex:((NSUInteger) indexPath.row)];
//    
//    if (![[NSString stringWithFormat:@"%@",[listEntry objectForKey:@"type"]] isEqualToString:@"file"])
//    {
//        return NO;
//    }
//    return YES;
//}
//
//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
//    if([alertView tag]==99)
//    {
//        switch (buttonIndex) {
//            case 0:
//            {
//                 alert = nil;
//                // [list_tab reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
//            }
//                break;
//            case 1:
//            {
//                @try{
//                
//                NSString *path = [NSString stringWithFormat:@"%@/%@",director_string,[[folder_table_data objectAtIndex:selected_to_delete.row] objectForKey:@"name"]];
//                NSString *thumb_path = [[NSString stringWithFormat:@"%@/%@",director_string,[[folder_table_data objectAtIndex:selected_to_delete.row] objectForKey:@"name"]]stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"];
//                NSString *encodedpath = [self encodeToPercentEscapeString:path];
//                NSString *thumb_encodedpath = [self encodeToPercentEscapeString:thumb_path];
//                    
//                NSString *url_string = [NSString stringWithFormat:@"%@delete_image.php?path=%@",mydomainurl,encodedpath];
//                NSLog(@" url is %@",url_string);
//                NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: url_string ]];
//                
//                if (dataURL == nil)
//                {
//                    alert = [[UIAlertView alloc] initWithTitle:@"Error in Server Connection!"
//                                                       message:nil
//                                                      delegate:self
//                                             cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
//                    [alert show];
//                }
//                else
//                {
//
//                NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
//                NSLog(@"serveroutput: %@",serverOutput);
//                alert = nil;
//                [folder_table_data removeObjectAtIndex:selected_to_delete.row];
//                [list_tab reloadData];
//                //[list_tab deleteRowsAtIndexPaths:@[selected_to_delete] withRowAnimation:UITableViewRowAnimationFade];
//                }
//                }
//                @catch (NSException *exception) {
//                    NSLog(@"exception dropbox: %@",exception);
//                }
//                @finally {
//                }
//
//            }
//                break;
//                 selected_to_delete = nil;
//        }
//    }
//    if(alertView.tag ==100)
//    {
//        switch (buttonIndex) {
//            case 0:
//                break;
//            case 1:
//            {
//                NSString *selected_path=@"";
//                if(!intial)
//                {
//                        NSDictionary *dict = [folder_table_data objectAtIndex:selectedindex];
//                        selected_path = [NSString stringWithFormat:@"%@/%@",director_string,[dict objectForKey:@"name"]];
//                }
//                else
//                {
//                        selected_path = director_string;
//                }
//                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
//                {
//                    NSString *copy_url = [NSString stringWithFormat:@"http://photo-xchange.com/photolist.php?path=%@",[selected_path  stringByRemovingPercentEncoding]];
//                    copy_url = [copy_url stringByReplacingOccurrencesOfString:@".." withString:@""];
//                    
//                    UIPasteboard *pb = [UIPasteboard generalPasteboard];
//                    [pb setString:[copy_url stringByReplacingOccurrencesOfString:@".." withString:@""]];
//                }
//                else
//                {
//                    NSString *copy_url = [NSString stringWithFormat:@"http://photo-xchange.com/photolist.php?path=%@",[selected_path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ]];
//                    copy_url = [copy_url stringByReplacingOccurrencesOfString:@".." withString:@""];
//                    
//                    UIPasteboard *pb = [UIPasteboard generalPasteboard];
//                    [pb setString:[copy_url stringByReplacingOccurrencesOfString:@".." withString:@""]];
//                }
//            }
//                break;
//        }
//    }
//    if(alertView.tag==101)
//    {
//        switch (buttonIndex) {
//            case 0:
//            {
//                NSLog(@" Cancel ");
//                [UIView transitionWithView: list_tab
//                                  duration: 0.5f
//                                   options: UIViewAnimationOptionTransitionCrossDissolve
//                                animations: ^(void)
//                 {
//                     intial = YES;
////                     [list_tab setHidden:YES];
//                     
//                 }
//                                completion: ^(BOOL isFinished)
//                 {
////                 NSString *url_string = [NSString stringWithFormat:@"%@iosphoto_action.php?dir=%@",mydomainurl,[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
////                [self new_reload:url_string];
//                 }];
//            }
//                break;
//            case 1:
//            {
//                [UIView transitionWithView: list_tab
//                                  duration: 0.5f
//                                   options: UIViewAnimationOptionTransitionCrossDissolve
//                                animations: ^(void)
//                 {
//                     list_tab.hidden=YES;
//                 }
//                                completion: ^(BOOL isFinished)
//                 {
//                     NSString *url_string = [[NSString alloc] init];
//                     
//                     url_string = [NSString stringWithFormat:@"%@iosphoto_action.php?action=delete&dir=%@&folder_name=%@&thumb_dir=%@&file_type=%@&user_id=%@",mydomainurl,[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[thumb_new_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"type"],[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]];
//                     NSLog(@" %@",url_string);
//                     
//                     [self new_reload:url_string];
//                     about_details=NO;
//                     intial=YES;
//                     selectedindex = 0;
//                 }];
//            }
//                break;
//        }
//    }
//    if (deleteAlert.tag == 909) {
//        
//        if(buttonIndex == 0)
//        {
//            // Do something
//        }
//            else
//         {
//                // Some code
//             NSLog(@"SELECTEDIMAGEEEEEEEEEEEEEEEEEE===>%@",selectedImage);
//             
//             @try{
//             
//                 NSString *encodedimage =  [self encodeToPercentEscapeString:selectedImage];
//             NSString *renameURL = [NSString stringWithFormat:@"%@photo_operation.php?action=delete_image&dir=%@&thumb_dir=%@&file=%@",mydomainurl, [director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[thumb_new_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],encodedimage];
//             
//             NSError *error;
//             NSLog(@"FIRED URLlll===========================>%@",renameURL);
//             NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:renameURL]options:NSDataReadingUncached error:&error];
//                 if (data == nil)
//                 {
//                     alert = [[UIAlertView alloc] initWithTitle:@"Error in Server Connection!"
//                                                        message:nil
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
//                     [alert show];
//                 }
//                 else
//                 {
//
//                 NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data //1
//                                 
//                                                                options:kNilOptions
//                                 
//                                                                  error:&error];
//             
//             NSLog(@"JSON==============>%@",[json objectForKey:@"msg"]);
//             
//             if ([[json objectForKey:@"msg"]  isEqual: @"success"]) {
//                 
//                 [self starttheftplisting];
//                 UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Successfully deleted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                 [renameAlert show];
//                 
//             }else{
//                 
//                 UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Unsucessfull" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                 [renameAlert show];
//             }
//            }
//         }
//             @catch (NSException *exception) {
//                 NSLog(@"exception in ftp listing : %@",exception.description);
//             }
//
//        checkFlag=0;
//         }
//    }
//   }
//
////---------------------------UIButton MEthods -----------------------------------------------//
//-(void)aboutediting:(UIButton *)sender
//{
//    switch (about_details) {
//        case 0:
//        {
//            about_details = YES;
//            [list_tab reloadRowsAtIndexPaths:[list_tab indexPathsForVisibleRows]
//                             withRowAnimation:UITableViewRowAnimationFade];
//        }
//            break;
//        case 1:
//        {
//            about_details = NO;
//            [list_tab reloadRowsAtIndexPaths:[list_tab indexPathsForVisibleRows]
//                            withRowAnimation:UITableViewRowAnimationFade];
//        }
//            break;
//    }
//}
//-(void)newfolderactions:(UIButton *)sender
//{
//    [UIView transitionWithView: shadow_view
//                      duration: 1.00f
//                       options: UIViewAnimationOptionTransitionCrossDissolve
//                    animations: ^(void)
//     {
//         [text_enter resignFirstResponder];
//         shadow_view.hidden=YES;
//         new_folder_view.hidden=YES;
//         list_tab.userInteractionEnabled=YES;
//     }
//                    completion: ^(BOOL isFinished){
//                        switch ([sender tag]) {
//                            case 1:
//                            {
//                                NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
//                                NSString *trimmed_string = [[text_enter text] stringByTrimmingCharactersInSet:whitespace];
//                                if([trimmed_string length]>0)
//                                {
//                                    list_tab.hidden=YES;
//                                    [SVProgressHUD showSuccessWithStatus:@"Loading.."];
//                                    NSString *url_string = [[NSString alloc] init];
//                                    
//                                    url_string = [NSString stringWithFormat:@"%@iosphoto_action.php?action=create&dir=%@&thumb_dir=%@&folder_name=%@&user_id=%@",mydomainurl,[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[thumb_new_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[text_enter.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]];
//                                    NSLog(@" url is %@",url_string);
//                                    [self new_reload:url_string];
//                                    intial=YES;
//                                    selectedindex = 0;
//                                }
//                                else
//                                {
//                                    [SVProgressHUD showErrorWithStatus:@"Please enter a valid name for the folder"];
//                                }
//                            }
//                                break;
//                            case 2:
//                            {
//                                @try{
//                                NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
//                                NSString *trimmed_string = [[text_enter text] stringByTrimmingCharactersInSet:whitespace];
//                                
//                                if([trimmed_string length]>0)
//                                {
////                                    list_tab.hidden=YES;
//                                    NSLog(@"ghghghgh");
//                                    NSString *url_string = [[NSString alloc] init];
//                                    
//                                    url_string = [NSString stringWithFormat:@"%@iosphoto_action.php?action=rename&dir=%@&thumb_dir=%@&old_name=%@&new_name=%@&user_id=%@",mydomainurl,[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[thumb_new_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[text_enter.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]];
//                                    NSLog(@"url ta elo: %@",url_string);
//                                    //==========xyz
//
//                                    NSError *error=nil;
//                                    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:url_string]options:NSDataReadingUncached error:&error];
//                                    if (data == nil)
//                                    {
//                                        alert = [[UIAlertView alloc] initWithTitle:@"Error in Server Connection!"
//                                                                           message:nil
//                                                                          delegate:self
//                                                                 cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
//                                        [alert show];
//                                    }
//                                    else
//                                    {
//
//                                    
//                                    NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data //1
//                                                        
//                                                                                       options:kNilOptions
//                                                        
//                                                                                         error:&error];
//                                    
//                                    NSLog(@"DELETE FOLDER CHECK==============>%@",[json objectForKey:@"msg"]);
//                                    
//                                    if ([[json objectForKey:@"msg"]  isEqual: @"file with this name already exits"]) {
//                                        
//                                        UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Name already exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                        [renameAlert show];
//                                    
//                                        
//                                    }else if ([[json objectForKey:@"msg"]  isEqual: @"success"]){
//                                        
//                                        [self starttheftplisting];
//                                        UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Successfully renamed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                        [renameAlert show];
//                                        text_enter.text = @"";
//
//                                    }else{
//                                        
//                                        [self starttheftplisting];
//                                        UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Unsuccessfull" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                        [renameAlert show];
//                                    }
//
//                                    //==========
//                                    
//                                    intial=YES;
//                                    selectedindex = 0;
//                                }
//                                }
//                                else
//                                {
//                                    [SVProgressHUD showErrorWithStatus:@"Please enter a valid name for the folder"];
//                                }
//                                checkFlag=0;
//                            }
//                                @catch (NSException *exception) {
//                                    NSLog(@"exception dropbox: %@",exception);
//                                }
//                                @finally {
//                                }
//                            }
//                                
//                                break;
//                            case 3:
//                            {
//                                NSString *data_for_new_path = text_enter.text;
//                                if([data_for_new_path length]==0||[data_for_new_path stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]==0||[data_for_new_path rangeOfString:[NSString stringWithFormat:@"../user/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]]].location == NSNotFound)
//                                {
//                                    [text_enter resignFirstResponder];
//                                    [SVProgressHUD showErrorWithStatus:@"Please provide a proper path"];
//                                    move=NO;
//                                }
//                                else
//                                {
//                                    NSString *url_string = [[NSString alloc] init];
//                                    
//                                    url_string = [NSString stringWithFormat:@"%@iosphoto_action.php?action=move&dir=%@&old_name=%@&new_name=%@&old_name_thumb=%@&new_name_thumb=%@",mydomainurl,[NSString stringWithFormat:@"../user/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]],[NSString stringWithFormat:@"%@/%@",director_string,[[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]],[NSString stringWithFormat:@"%@/%@",data_for_new_path,[[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]], [NSString stringWithFormat:@"%@/%@",thumb_new_path,[[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]],[NSString stringWithFormat:@"%@/%@",[data_for_new_path stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"],[[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
//                                    
//                                    NSLog(@" url to move %@",url_string);
//                                     [self new_reload:url_string];
//                                    intial=YES;
//                                    selectedindex = 0;
//                                    move=NO;
//                                }
//                            }
//                                break;
//                            case 5:
//                            {
//                                
//                                @try{
//                                if (![text_enter.text isEqualToString:@""]) {
//                                    
//                                    NSString *encodedText = [self encodeToPercentEscapeString:text_enter.text];
//
//                                extension = [selectedImage componentsSeparatedByString:[NSString stringWithFormat:@"."]];
//                                NSString *renameURL = [NSString stringWithFormat:@"%@photo_operation.php?action=rename_image&dir=%@&thumb_dir=%@&imageoriginal=%@&changetoimage=%@.%@",mydomainurl, [director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[thumb_new_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],selectedImage,encodedText,[extension objectAtIndex: extension.count-1]];
//                                NSError *error=Nil;
//                                NSLog(@"FIRED URLlll===========================>%@",renameURL);
//                                NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:renameURL]options:NSDataReadingUncached error:&error];
//                                    if (data == nil)
//                                    {
//                                        alert = [[UIAlertView alloc] initWithTitle:@"Error in Server Connection!"
//                                                                           message:nil
//                                                                          delegate:self
//                                                                 cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
//                                        [alert show];
//                                    }
//                                    else
//                                    {
//
//                                NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data //1
//                                                    
//                                                                                   options:kNilOptions
//                                                    
//                                                                                     error:&error];
//                                
//                                NSLog(@"JSON==============>%@",[json objectForKey:@"msg"]);
//                                
//                                if ([[json objectForKey:@"msg"]  isEqual: @"success"]) {
//                                    
//                                    [self starttheftplisting];
//                                    UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Successfully renamed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                    [renameAlert show];
//                                    text_enter.text = @"";
//                                    
//                                }else if ([[json objectForKey:@"msg"]  isEqual: @"file with this name already exits"]){
//                                    
//                                    UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Name already exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                    [renameAlert show];
//                                }else{
//                                    
//                                    UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Unsuccessfull" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                    [renameAlert show];
//                                    
//                                }
////                                NSLog(@"ACSHE=======>TEXT ENTER=%@=========SELECTED IMAGE=%@", text_enter.text,selectedImage);
//                                
//                                checkFlag=0;
//                                }
//                                }
//                                else{
//                                    
//                                    deleteAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter a name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                    [deleteAlert show];
//                                    [self starttheftplisting];
//                                    checkFlag=0;
//                                    
//                                }
//                            }
//                                @catch (NSException *exception) {
//                                    NSLog(@"exception dropbox: %@",exception);
//                                }
//                                @finally {
//                                }
//
//                            }
//
//                        }
//                        
//                    }];
//}
//
//-(void)setViewMovedUp:(BOOL)movedUp
//{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.3];
//    
//    CGRect rect = new_folder_view.frame;
//    if (movedUp)
//    {
//        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
//    }
//    else
//    {
//        rect.origin.y += kOFFSET_FOR_KEYBOARD;
//    }
//    new_folder_view.frame = rect;
//    [UIView commitAnimations];
//}
//-(void)navbaractions:(UIButton *)sender
//{
//    switch (sender.tag) {
//        case 1:
//        {
//            shadow_view.hidden=NO;
//            list_tab.userInteractionEnabled=NO;
//            title_lbl_for_new_view.text = @"Folder Name";
//            [UIView transitionWithView: new_folder_view
//                              duration: 0.5f
//                               options: UIViewAnimationOptionTransitionCrossDissolve
//                            animations: ^(void)
//             {
//                 new_folder_view.hidden=NO;
//                 ok_button.tag=1;
//             }
//                            completion: ^(BOOL isFinished){ [text_enter becomeFirstResponder];  }];
//                            text_enter.text = @"";
//        }
//            break;
//        case 2:
//        {
//            switch (intial) {
//                case 1:
//                {
//                    [SVProgressHUD showErrorWithStatus:@"Please select a folder to rename"];
//                }
//                    break;
//                default:
//                {
//                    shadow_view.hidden=NO;
//                    list_tab.userInteractionEnabled=NO;
//                    title_lbl_for_new_view.text = @"Rename folder";
//                    [UIView transitionWithView: new_folder_view
//                                      duration: 0.5f
//                                       options: UIViewAnimationOptionTransitionCrossDissolve
//                                    animations: ^(void)
//                     {
//                         new_folder_view.hidden=NO;
//                         text_enter.text=[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"];
//                         ok_button.tag=2;
//                     }
//                                    completion: ^(BOOL isFinished){ [text_enter becomeFirstResponder];  }];
//                                    text_enter.text = @"";
//                }
//                    break;
//            }
//        }
//            break;
//        case 3:
//        {
//            switch (intial) {
//                case 1:
//                {
//                    
//                    [SVProgressHUD showErrorWithStatus:@"Please select a folder to move"];
//                }
//                    break;
//                default:
//                {
//                    
//                    KOTreeViewController *tree = [[KOTreeViewController alloc] init];
//                    tree.folder_path_to_be_moved = [NSString stringWithFormat:@"%@/%@",director_string,[[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//                    tree.type =@"MOVE";
//                    CATransition* transition = [CATransition animation];
//                    transition.duration = 0.25;
//                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//                    transition.type = kCATransitionMoveIn;
//                    transition.subtype = kCATransitionFromTop;
//                    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//                    [self.navigationController pushViewController:tree animated:NO];
//                    move=NO;
//                }
//                    break;
//            }
//        }
//            break;
//        case 4:
//        {
//            switch (intial) {
//                case 1:
//                {
//                    [SVProgressHUD showErrorWithStatus:@"Please select a folder to delete"];
//                }
//                    break;
//                default:
//                {
//                    UIAlertView *alert_delete_confirm = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"This will permanently delete the folder. Do you want to do it?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//                    [alert_delete_confirm setTag:101];
//                    [alert_delete_confirm show];
//                }
//                    break;
//            }
//        }
//            break;
//        }
//}
//-(void)detailsaboutfolder:(UIButton *)sender
//{
//    
////    NSDictionary *albumThumb = [[NSDictionary alloc] init];
////    albumThumb = [folder_table_data objectAtIndex:((NSUInteger) indexPath.row)];
////    
////    if (![[NSString stringWithFormat:@"%@",[albumThumb objectForKey:@"type"]] isEqualToString:@"file"])
////    {
////        return NO;
////    }
////    return YES;
//
//    self.selectedIndexPaths = [[NSMutableArray alloc]init];
//   
//    prev_directory = [[NSString alloc] init];
//    prev_directory = director_string;
//    director_string = [NSString stringWithFormat:@"%@/%@",prev_directory,[[folder_table_data objectAtIndex:[sender tag]] objectForKey:@"name"]];
//    [folder_path_array addObject:prev_directory];
//    thumb_new_path = [director_string stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"];
//    
//    [UIView transitionWithView: list_tab
//     
//                      duration: 0.5f
//                       options: UIViewAnimationOptionTransitionCrossDissolve
//                    animations: ^(void)
//     {
//         list_tab.hidden=YES;
//     }
//                    completion: ^(BOOL isFinished)
//                    {
//                        [SVProgressHUD showSuccessWithStatus:@"Loading.."];
//                        NSString *url_string = [[NSString alloc] init];
//                        url_string = [NSString stringWithFormat:@"%@iosphoto_actiontest.php?dir=%@",mydomainurl,[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//                        if (![[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isKindOfClass:[NSNull class]] && [[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] length] != 0)
//                        {
//                        [self new_reload:url_string];
//                        about_details=NO;
//                        about_details = YES;
//                        intial_click_on_go_back = YES;
//                        intial=YES;
//                        selectedindex = 0;
//                        }
////                        [SVProgressHUD showSuccessWithStatus:@"Loading.."];
////                        NSString *url_string = [[NSString alloc] init];
////                        url_string = [NSString stringWithFormat:@"%@iosphoto_action.php?dir=%@",mydomainurl,[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
////                        stringImage = [NSString stringWithFormat:@"%@/user/%@/%@",parent_url_for_ftp_image_listing,[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"],[[folder_table_data objectAtIndex:[sender tag]] objectForKey:@"name"]];
//////                        stringImage = [NSString stringWithFormat:@"%@/user/%@",parent_url_for_ftp_image_listing,[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]];
////                        NSLog(@"directorString=======>%@",director_string);
////                        NSLog(@"stringImage==========>%@",stringImage);
////                         [self new_reload:url_string];
////                        about_details=NO;
////                        about_details = YES;
////                        intial_click_on_go_back = YES;
////                        intial=YES;
////                        selectedindex = 0;
//                        
//                    }];
//}
//
//-(void)goBack:(id)sender
//{
//    checkFlag = 0;
//    NSLog(@"just go-back");
//    self.selectedIndexPaths = [[NSMutableArray alloc]init];
//    move=NO;
//    switch (shadow_view.hidden) {
//        case 0:
//        {
//            [UIView transitionWithView: shadow_view
//                              duration: 1.00f
//                               options: UIViewAnimationOptionTransitionCrossDissolve
//                            animations: ^(void)
//             {
//                 [text_enter resignFirstResponder];
//                 shadow_view.hidden=YES;
//                 new_folder_view.hidden=YES;
//                 list_tab.userInteractionEnabled=YES;
//                 ok_button.tag=0;
//             }
//                            completion: ^(BOOL isFinished){
//                            }];
//        }
//            break;
//        default:
//        {
//            switch (about_details) {
//                case 1:
//                {
//                    about_details=NO;
//                    
//                    director_string = prev_directory;
//                    thumb_new_path = [director_string stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"];
//                    
//                    NSString *url_string = [[NSString alloc] init];
//                    url_string = [NSString stringWithFormat:@"%@iosphoto_actiontest.php?dir=%@",mydomainurl,[prev_directory stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//                    if (![[prev_directory stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isKindOfClass:[NSNull class]] && [[prev_directory stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] length] != 0)
//                    {
//                     [self new_reload:url_string];
//                    intial=YES;
//                    selectedindex = 0;
//                    }
//                }
//                    break;
//                default:
//                {
//                    about_details = NO;
//                    [list_tab removeFromSuperview];
//                    CATransition* transition = [CATransition animation];
//                    transition.duration = 0.5;
//                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//                    transition.type = kCATransitionFade;
//                    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//                    [self.navigationController popViewControllerAnimated:NO];
//                }
//                    break;
//            }
//        }
//    }
//}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    if(!shadow_view.hidden)
//    {
//        [UIView transitionWithView: shadow_view
//                          duration: 1.00f
//                           options: UIViewAnimationOptionTransitionCrossDissolve
//                        animations: ^(void)
//         {
//             [text_enter resignFirstResponder];
//             shadow_view.hidden=YES;
//             new_folder_view.hidden=YES;
//             list_tab.userInteractionEnabled=YES;
//             ok_button.tag=0;
//         }
//                        completion: ^(BOOL isFinished){
//                        }];
//    }
//    if(move)
//    {
//        NSString *data_for_new_path = textField.text;
//        if([data_for_new_path length]==0||[data_for_new_path stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]==0||[data_for_new_path rangeOfString:[NSString stringWithFormat:@"../user/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]]].location == NSNotFound)
//        {
//            [SVProgressHUD showErrorWithStatus:@"Please provide a proper path"];
//            move=NO;
//        }
//    }
//    return YES;
//}
//-(void)moveToFTP:(ELCImagePickerController *)picker
//{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//}
//
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // selected_to_delete = [NSIndexPath indexPathForRow:[[gestureRecognizer view] tag] inSection:0];
//        // NSLog(@" tag is %d",[[gestureRecognizer view] tag]); if(alert ==nil)
//        // {
//        // alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"This will permanently remove photo from your folder. Do you want to go with it?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//        // alert.tag = 99;
//        // [alert show];
//        // }
//        
//        if([[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"file"])
//        {
//            
//            selectedImage = [[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"];
//            deleteAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Do you want to delete the image" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//            [deleteAlert setTag:909];
//            [deleteAlert show];
//            
//        }
//        
//    }
//}
//
//-(void) tapSingle:(UITapGestureRecognizer *)sender{
//   
//}
//
//- (void)addOrRemoveSelectedIndexPath:(NSIndexPath *)indexPath
//{
//    
////            self.selectedIndexPaths = [[NSMutableArray alloc]init];
////    
////        [self.selectedIndexPaths addObject:indexPath];
////    
////    [list_tab reloadRowsAtIndexPaths:@[indexPath]
////                       withRowAnimation:UITableViewRowAnimationFade];
//    
//    
//    
//    
//    if (!self.selectedIndexPaths) {
//        self.selectedIndexPaths = [NSMutableArray new];
//    }
//    
//    if ([[[folder_table_data objectAtIndex:indexPath.row]objectForKey:@"type"] isEqualToString:@"directory"])
//    {
//        NSLog(@"self.selectedindexpaths initial initial");
//
////        self.selectedIndexPaths = [[NSMutableArray alloc]init];
////        [self.selectedIndexPaths addObject:indexPath];
//        BOOL containsIndexPath = [self.selectedIndexPaths containsObject:indexPath];
//
//        if (containsIndexPath) {
//            [self.selectedIndexPaths removeObject:indexPath];
//        }else{
//             self.selectedIndexPaths = [[NSMutableArray alloc]init];
//            [self.selectedIndexPaths addObject:indexPath];
//        }
//
//    }
//   else
//   {
//       BOOL containsIndexPath = [self.selectedIndexPaths containsObject:indexPath];
//    
//      if (containsIndexPath) {
//        [self.selectedIndexPaths removeObject:indexPath];
//       }else{
//         [self.selectedIndexPaths addObject:indexPath];
//      }
//   }
//    [list_tab reloadRowsAtIndexPaths:@[indexPath]
//                       withRowAnimation:UITableViewRowAnimationFade];
//
//    NSLog(@"self.selectedindexpaths: %@",self.selectedIndexPaths);
//}
//
//-(void)doneto:(UIButton *)sender{
//    
//    nav_bar.hidden = NO;
//    tempHeader.hidden = YES;
//    if ([multiSelect count] == 0)
//    {
//        UIAlertView *alert_confirm = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Image has been selected!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
//        alert_confirm.tag=130;
//        [alert_confirm show];
//    }
//    else
//    {
//    KOTreeViewController *tree = [[KOTreeViewController alloc] init];
//    tree.imageName = [multiSelect componentsJoinedByString:@","];
//    NSLog(@"tree.imageName: %@",tree.imageName);
//    tree.image_to_be_copy = [NSString stringWithFormat:@"%@",director_string];
//    tree.type =@"COPY";
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.25;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionMoveIn;
//    transition.subtype = kCATransitionFromTop;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//    [self.navigationController pushViewController:tree animated:NO];
//    }
//    checkFlag = 0;
//    
//}
//
//-(NSString*) encodeToPercentEscapeString:(NSString *)string {
//    return (NSString *)
//    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
//                                                              (CFStringRef) string,
//                                                              NULL,
//                                                              (CFStringRef) @"!*'();:@&=+$,/?%#[]",
//                                                              kCFStringEncodingUTF8));
//}
//
//-(NSString*) decodeFromPercentEscapeString:(NSString *)string {
//    return (NSString *)
//    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
//                                                                              (CFStringRef) string,
//                                                                              CFSTR(""),
//                                                                              kCFStringEncodingUTF8));
//}
//@end



































//  FTPListingViewController.m
//  Photoapp
//  Created by Iphone_1 on 23/08/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
#import "KOTreeViewController.h"
#import "FTPListingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"
#import "CustomTextField.h"
#import "LibraryViewController.h"
#import "HomeViewController.h"
#import "ImageFromFTPViewController.h"
#import "AFNetworking.h"
#import "ImagePagingViewController.h"
#import "RootViewController.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#define KOCOLOR_FILES_TITLE [UIColor colorWithRed:0.4 green:0.357 blue:0.325 alpha:1] /*#665b53*/
#define KOCOLOR_FILES_TITLE_SHADOW [UIColor colorWithRed:1 green:1 blue:1 alpha:1] /*#ffffff*/
#define KOCOLOR_FILES_COUNTER [UIColor colorWithRed:0.608 green:0.376 blue:0.251 alpha:1] /*#9b6040*/
#define KOCOLOR_FILES_COUNTER_SHADOW [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35] /*#ffffff*/
#define KOFONT_FILES_TITLE [UIFont fontWithName:@"HelveticaNeue" size:12.0f]
#define KOFONT_FILES_COUNTER [UIFont fontWithName:@"HelveticaNeue-Bold" size:11.0f]
static CGFloat const kIconHorizontalPadding = 10;
static CGFloat const kDefaultIconSize = 40;
static CGFloat const kMaxBounceAmount = 8;

@interface FTPListingViewController ()
{
    UIImageView *buttonusertrouble,*bar_white;
    UILabel *headerlabel;
    UIView *nav_bar, *drop_down_view_ftp;
    UIButton *new_folder_btn, *rename_folder_btn, *move_folder_btn, *delete_folder_btn, *backButton, *editButton;
    BOOL intial_click_on_go_back;
    UIAlertView *alert;
    NSString *stringImage, *albumImage;
    int checkFlag, imageorfolder;
    NSString *imageToBeCopied;
    int test;
    NSString *thumbImage;
    NSString *checkThumbImage, *thumb_new_path;
    NSString *selectedImage;
    NSArray *extension;
    UIAlertView *deleteAlert;
    NSDictionary *listEntry;
    UIButton *button;
    NSMutableArray *multiSelect;
    UIView *tempHeader;
}
@property (nonatomic ,retain) NSIndexPath *selected_to_delete;
@property (nonatomic, assign) CGFloat dragStart;
@end
@implementation FTPListingViewController
@synthesize  folder_path_array,director_string,selected_to_delete;
@synthesize selectedIndexPaths;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    checkFlag = 0;
    selectedImage = [[NSString alloc]init];
    multiSelect = [[NSMutableArray alloc]init];
    
    NSLog(@"yes ftp listing bm");
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        self.navigationController.navigationBarHidden = NO;
        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars=NO;
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    self.navigationController.navigationBarHidden= YES;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]]];
    editButton.hidden = YES;
    
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar@2x.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bar.png"] forBarMetrics:nil];
    }
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationItem setTitle:[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]] lastPathComponent]];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                           UITextAttributeFont: [UIFont fontWithName:@"MyriadPro-Bold" size:18.5],
                                                           }];
    button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(goback_ftp:)forControlEvents:UIControlEventTouchUpInside];
    
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
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIInterfaceOrientationPortraitUpsideDown:
                case UIDeviceOrientationPortrait:
                {
                    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
                    {
                        list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, 320, self.view.bounds.size.height-114/2)];
                    }
                    else
                    {
                        list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, 320, self.view.bounds.size.height-114/2)];
                    }
                    list_tab.backgroundColor = [UIColor clearColor];
                    list_tab.dataSource=self;
                    list_tab.delegate=self;
                    list_tab.separatorStyle = UITableViewCellSeparatorStyleNone;
                    list_tab.separatorColor =[UIColor clearColor];
                    list_tab.showsVerticalScrollIndicator=NO;
                    //                    [list_tab setRowHeight:65.0f];
                    [list_tab setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    [self.view addSubview:list_tab];
                    
                    NSLog(@" listab frame is %@",NSStringFromCGRect(list_tab.frame));
                    nav_bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 114/2)];
                    [self.view addSubview:nav_bar];
                    
                    bar_white = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar@2x.png"]];
                    bar_white.frame = CGRectMake(0, 0, 320, 114/2);
                    [nav_bar addSubview:bar_white];
                    
                    //---------------- NEw Folder Button and it's subviews -------------------------------------
                    new_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    new_folder_btn.frame =CGRectMake(0, 0, 75, 114/2);
                    new_folder_btn.backgroundColor = [UIColor clearColor];
                    new_folder_btn.tag=1;
                    [new_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    [nav_bar addSubview:new_folder_btn];
                    
                    UIImageView *new_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new-folder@2x.png"]];
                    new_fol.frame = CGRectMake(27, 10, 59/2, 38/2);
                    [new_folder_btn addSubview:new_fol];
                    
                    UILabel *new_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 80, 20)];
                    new_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    new_fol_lbl.text=@"New Folder";
                    new_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    new_fol_lbl.backgroundColor = [UIColor clearColor];
                    new_fol_lbl.textColor=[UIColor darkGrayColor];
                    [new_folder_btn addSubview:new_fol_lbl];
                    
                    //--------------------- Rename Folder Button and it's subviews------------------------
                    rename_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    rename_folder_btn.frame =CGRectMake(80.5, 0, 75, 114/2);
                    rename_folder_btn.backgroundColor = [UIColor clearColor];
                    rename_folder_btn.tag=2;
                    [rename_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    [nav_bar addSubview:rename_folder_btn];
                    
                    UIImageView *ren_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rename-folder@2x.png"]];
                    ren_fol.frame = CGRectMake(24.5, 10, 59/2, 19);
                    [rename_folder_btn addSubview:ren_fol];
                    
                    UILabel *ren_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    ren_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    ren_fol_lbl.text=@"Rename Folder";
                    ren_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    ren_fol_lbl.backgroundColor = [UIColor clearColor];
                    ren_fol_lbl.textColor=[UIColor darkGrayColor];
                    [rename_folder_btn addSubview:ren_fol_lbl];
                    
                    //--------------------- Move Folder Button and it's subviews------------------------
                    move_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    move_folder_btn.frame =CGRectMake(80.5*2, 0, 75, 114/2);
                    move_folder_btn.backgroundColor = [UIColor clearColor];
                    move_folder_btn.tag=3;
                    [move_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    [nav_bar addSubview:move_folder_btn];
                    
                    UIImageView *mov_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"move@2x.png"]];
                    mov_fol.frame = CGRectMake(24.5f, 10, 59/2, 19);
                    [move_folder_btn addSubview:mov_fol];
                    
                    UILabel *move_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    move_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    move_fol_lbl.text=@"Move Folder";
                    move_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    move_fol_lbl.backgroundColor = [UIColor clearColor];
                    move_fol_lbl.textColor=[UIColor darkGrayColor];
                    [move_folder_btn addSubview:move_fol_lbl];
                    
                    //--------------------- Delete Folder Button and it's subviews------------------------
                    delete_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    delete_folder_btn.frame =CGRectMake(80.5f*3, 0, 75, 114/2);
                    delete_folder_btn.backgroundColor = [UIColor clearColor];
                    delete_folder_btn.tag=4;
                    [delete_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    [nav_bar addSubview:delete_folder_btn];
                    
                    UIImageView *del_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete@2x.png"]];
                    del_fol.frame = CGRectMake(26.0f, 7.5f, 48/2, 49/2);
                    [delete_folder_btn addSubview:del_fol];
                    
                    UILabel *del_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    del_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    del_fol_lbl.text=@"Delete Folder";
                    del_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    del_fol_lbl.backgroundColor = [UIColor clearColor];
                    del_fol_lbl.textColor=[UIColor darkGrayColor];
                    [delete_folder_btn addSubview:del_fol_lbl];
                    
                    //------------------- Folder table ---------------------------
                    
                    //----------------- Shadow View ------------------------------
                    shadow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-45)];
                    shadow_view.backgroundColor = [UIColor blackColor];
                    shadow_view.alpha=0.79;
                    shadow_view.layer.zPosition=1;
                    shadow_view.userInteractionEnabled=YES;
                    shadow_view.hidden=YES;
                    [self.view addSubview:shadow_view];
                    
                    UITapGestureRecognizer *hideshadow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
                    hideshadow.numberOfTapsRequired=1;
                    [shadow_view addGestureRecognizer:hideshadow];
                    
                    //----------------- New Folder View --------------------------
                    if([[UIScreen mainScreen] bounds].size.height<568)
                    {
                        new_folder_view = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-500/2)/2, 100-self.navigationController.navigationBar.frame.size.height, 500/2, 327/2)];
                        new_folder_view.layer.zPosition=2;
                        new_folder_view.userInteractionEnabled=YES;
                        UIImageView *background_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500/2, 327/2)];
                        background_img.image = [UIImage imageNamed:@"input-box1@2x.png"];
                        [new_folder_view addSubview:background_img];
                        [self.view addSubview:new_folder_view];
                        new_folder_view.hidden=YES;
                        
                        title_lbl_for_new_view = [[UILabel alloc] initWithFrame:CGRectMake(5, 5.5, 500/2, 20)];
                        title_lbl_for_new_view.backgroundColor = [UIColor clearColor];
                        title_lbl_for_new_view.textColor =[UIColor colorWithRed:(208.0f/255.0f) green:(198.0f/255.0f) blue:(200.0f/255.0f) alpha:1];
                        title_lbl_for_new_view.font= [UIFont fontWithName:@"SourceSansPro-Semibold" size:15.5f];
                        [new_folder_view addSubview:title_lbl_for_new_view];
                        
                        text_enter = [[CustomTextField alloc] initWithFrame:CGRectMake(7.5f, 50, 469/2, 66/2)];
                        text_enter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input-box@2x.png"]];
                        text_enter.delegate=self;
                        text_enter.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
                        text_enter.autocapitalizationType=UITextAutocapitalizationTypeNone;
                        text_enter.textColor = [UIColor blackColor];
                        [new_folder_view addSubview:text_enter];
                        
                        ok_button = [[UIButton alloc] initWithFrame:CGRectMake(65, 327/2-57, 253/2, 57/2)];
                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn@2x.png"] forState:UIControlStateNormal];
                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn1@2x.png"] forState:UIControlStateHighlighted];
                        [ok_button addTarget:self action:@selector(newfolderactions:) forControlEvents:UIControlEventTouchUpInside];
                        [new_folder_view addSubview:ok_button];
                    }
                    else
                    {
                        new_folder_view = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-500/2)/2, 180-self.navigationController.navigationBar.frame.size.height, 500/2, 327/2)];
                        new_folder_view.layer.zPosition=2;
                        new_folder_view.userInteractionEnabled=YES;
                        UIImageView *background_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500/2, 327/2)];
                        background_img.image = [UIImage imageNamed:@"input-box1@2x.png"];
                        [new_folder_view addSubview:background_img];
                        [self.view addSubview:new_folder_view];
                        new_folder_view.hidden=YES;
                        
                        title_lbl_for_new_view = [[UILabel alloc] initWithFrame:CGRectMake(5, 5.5, 500/2, 20)];
                        title_lbl_for_new_view.backgroundColor = [UIColor clearColor];
                        title_lbl_for_new_view.textColor =[UIColor colorWithRed:(208.0f/255.0f) green:(198.0f/255.0f) blue:(200.0f/255.0f) alpha:1];
                        title_lbl_for_new_view.font= [UIFont fontWithName:@"SourceSansPro-Semibold" size:15.5f];
                        [new_folder_view addSubview:title_lbl_for_new_view];
                        
                        text_enter = [[CustomTextField alloc] initWithFrame:CGRectMake(7.5f, 50, 469/2, 66/2)];
                        text_enter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input-box@2x.png"]];
                        text_enter.delegate=self;
                        text_enter.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
                        text_enter.autocapitalizationType=UITextAutocapitalizationTypeNone;
                        text_enter.textColor = [UIColor blackColor];
                        [new_folder_view addSubview:text_enter];
                        
                        ok_button = [[UIButton alloc] initWithFrame:CGRectMake(65, 327/2-57, 253/2, 57/2)];
                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn@2x.png"] forState:UIControlStateNormal];
                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn1@2x.png"] forState:UIControlStateHighlighted];
                        [ok_button addTarget:self action:@selector(newfolderactions:) forControlEvents:UIControlEventTouchUpInside];
                        ok_button.tag=0;
                        [new_folder_view addSubview:ok_button];
                    }
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                case UIInterfaceOrientationLandscapeLeft:
                {
                    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
                    {
                        list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, [[UIScreen mainScreen] bounds].size.height, screenHeight-114/2)];
                    }
                    else
                    {
                        list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, [[UIScreen mainScreen] bounds].size.height, screenHeight-114/2)];
                    }
                    
                    list_tab.backgroundColor = [UIColor clearColor];
                    list_tab.dataSource=self;
                    list_tab.delegate=self;
                    list_tab.separatorColor =[UIColor clearColor];
                    list_tab.separatorStyle = UITableViewCellSeparatorStyleNone;
                    [list_tab setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    //                    [list_tab setRowHeight:65.0f];
                    list_tab.showsVerticalScrollIndicator=NO;
                    [self.view addSubview:list_tab];
                    
                    nav_bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 114/2)];
                    [self.view addSubview:nav_bar];
                    
                    bar_white = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar@2x.png"]];
                    bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 114/2);
                    [nav_bar addSubview:bar_white];
                    
                    //----------------- Shadow View ------------------------------
                    shadow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen] bounds].size.width-45)];
                    shadow_view.backgroundColor = [UIColor blackColor];
                    shadow_view.alpha=0.79;
                    shadow_view.layer.zPosition=1;
                    shadow_view.userInteractionEnabled=YES;
                    shadow_view.hidden=YES;
                    [self.view addSubview:shadow_view];
                    
                    UITapGestureRecognizer *hideshadow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
                    hideshadow.numberOfTapsRequired=1;
                    [shadow_view addGestureRecognizer:hideshadow];
                    
                    //----------------- New Folder View --------------------------
                    if([[UIScreen mainScreen] bounds].size.height<568)
                    {
                        
                        //---------------- NEw Folder Button and it's subviews -------------------------------------
                        new_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                        new_folder_btn.frame =CGRectMake(20, 0, 75, 114/2);
                        new_folder_btn.backgroundColor = [UIColor clearColor];
                        new_folder_btn.tag=1;
                        [new_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                        [nav_bar addSubview:new_folder_btn];
                        
                        UIImageView *new_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new-folder@2x.png"]];
                        new_fol.frame = CGRectMake(27, 10, 59/2, 38/2);
                        [new_folder_btn addSubview:new_fol];
                        
                        UILabel *new_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 80, 20)];
                        new_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                        new_fol_lbl.text=@"New Folder";
                        new_fol_lbl.textAlignment=NSTextAlignmentCenter;
                        new_fol_lbl.backgroundColor = [UIColor clearColor];
                        new_fol_lbl.textColor=[UIColor darkGrayColor];
                        [new_folder_btn addSubview:new_fol_lbl];
                        
                        //--------------------- Rename Folder Button and it's subviews------------------------
                        rename_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                        rename_folder_btn.frame =CGRectMake(80.5+60, 0, 75, 114/2);
                        rename_folder_btn.backgroundColor = [UIColor clearColor];
                        rename_folder_btn.tag=2;
                        [rename_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                        [nav_bar addSubview:rename_folder_btn];
                        
                        UIImageView *ren_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rename-folder@2x.png"]];
                        ren_fol.frame = CGRectMake(24.5, 10, 59/2, 19);
                        [rename_folder_btn addSubview:ren_fol];
                        
                        UILabel *ren_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                        ren_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                        ren_fol_lbl.text=@"Rename Folder";
                        ren_fol_lbl.textAlignment=NSTextAlignmentCenter;
                        ren_fol_lbl.backgroundColor = [UIColor clearColor];
                        ren_fol_lbl.textColor=[UIColor darkGrayColor];
                        [rename_folder_btn addSubview:ren_fol_lbl];
                        
                        //--------------------- Move Folder Button and it's subviews------------------------
                        move_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                        move_folder_btn.frame =CGRectMake(80.5*2+100, 0, 75, 114/2);
                        move_folder_btn.backgroundColor = [UIColor clearColor];
                        move_folder_btn.tag=3;
                        [move_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                        [nav_bar addSubview:move_folder_btn];
                        
                        UIImageView *mov_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"move@2x.png"]];
                        mov_fol.frame = CGRectMake(24.5f, 10, 59/2, 19);
                        [move_folder_btn addSubview:mov_fol];
                        
                        UILabel *move_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                        move_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                        move_fol_lbl.text=@"Move Folder";
                        move_fol_lbl.textAlignment=NSTextAlignmentCenter;
                        move_fol_lbl.backgroundColor = [UIColor clearColor];
                        move_fol_lbl.textColor=[UIColor darkGrayColor];
                        [move_folder_btn addSubview:move_fol_lbl];
                        
                        //--------------------- Delete Folder Button and it's subviews------------------------
                        delete_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                        delete_folder_btn.frame =CGRectMake(80.5f*3+130, 0, 75, 114/2);
                        delete_folder_btn.backgroundColor = [UIColor clearColor];
                        delete_folder_btn.tag=4;
                        [delete_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                        [nav_bar addSubview:delete_folder_btn];
                        
                        UIImageView *del_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete@2x.png"]];
                        del_fol.frame = CGRectMake(26.0f, 7.5f, 48/2, 49/2);
                        [delete_folder_btn addSubview:del_fol];
                        
                        UILabel *del_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                        del_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                        del_fol_lbl.text=@"Delete Folder";
                        del_fol_lbl.textAlignment=NSTextAlignmentCenter;
                        del_fol_lbl.backgroundColor = [UIColor clearColor];
                        del_fol_lbl.textColor=[UIColor darkGrayColor];
                        [delete_folder_btn addSubview:del_fol_lbl];
                        
                        //------------------- Folder table ---------------------------
                        
                        new_folder_view = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.height-500/2)/2, -34, 500/2, 327/2)];
                        new_folder_view.layer.zPosition=2;
                        new_folder_view.userInteractionEnabled=YES;
                        UIImageView *background_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500/2, 327/2)];
                        background_img.image = [UIImage imageNamed:@"input-box1@2x.png"];
                        [new_folder_view addSubview:background_img];
                        [self.view addSubview:new_folder_view];
                        new_folder_view.hidden=YES;
                        
                        title_lbl_for_new_view = [[UILabel alloc] initWithFrame:CGRectMake(5, 5.5, 500/2, 20)];
                        title_lbl_for_new_view.backgroundColor = [UIColor clearColor];
                        title_lbl_for_new_view.textColor =[UIColor colorWithRed:(208.0f/255.0f) green:(198.0f/255.0f) blue:(200.0f/255.0f) alpha:1];
                        title_lbl_for_new_view.font= [UIFont fontWithName:@"SourceSansPro-Semibold" size:15.5f];
                        [new_folder_view addSubview:title_lbl_for_new_view];
                        
                        text_enter = [[CustomTextField alloc] initWithFrame:CGRectMake(7.5f, 50, 469/2, 66/2)];
                        text_enter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input-box@2x.png"]];
                        text_enter.delegate=self;
                        text_enter.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
                        text_enter.autocapitalizationType=UITextAutocapitalizationTypeNone;
                        text_enter.textColor = [UIColor blackColor];
                        [new_folder_view addSubview:text_enter];
                        
                        ok_button = [[UIButton alloc] initWithFrame:CGRectMake(65, 327/2-57, 253/2, 57/2)];
                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn@2x.png"] forState:UIControlStateNormal];
                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn1@2x.png"] forState:UIControlStateHighlighted];
                        [ok_button addTarget:self action:@selector(newfolderactions:) forControlEvents:UIControlEventTouchUpInside];
                        [new_folder_view addSubview:ok_button];
                    }
                    else
                    {
                        //---------------- NEw Folder Button and it's subviews -------------------------------------
                        new_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                        new_folder_btn.frame =CGRectMake(20, 0, 75, 114/2);
                        new_folder_btn.backgroundColor = [UIColor clearColor];
                        new_folder_btn.tag=1;
                        [new_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                        [nav_bar addSubview:new_folder_btn];
                        
                        UIImageView *new_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new-folder@2x.png"]];
                        new_fol.frame = CGRectMake(27, 10, 59/2, 38/2);
                        [new_folder_btn addSubview:new_fol];
                        
                        UILabel *new_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 80, 20)];
                        new_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                        new_fol_lbl.text=@"New Folder";
                        new_fol_lbl.textAlignment=NSTextAlignmentCenter;
                        new_fol_lbl.backgroundColor = [UIColor clearColor];
                        new_fol_lbl.textColor=[UIColor darkGrayColor];
                        [new_folder_btn addSubview:new_fol_lbl];
                        
                        //--------------------- Rename Folder Button and it's subviews------------------------
                        rename_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                        rename_folder_btn.frame =CGRectMake(80.5+90, 0, 75, 114/2);
                        rename_folder_btn.backgroundColor = [UIColor clearColor];
                        rename_folder_btn.tag=2;
                        [rename_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                        [nav_bar addSubview:rename_folder_btn];
                        
                        UIImageView *ren_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rename-folder@2x.png"]];
                        ren_fol.frame = CGRectMake(24.5, 10, 59/2, 19);
                        [rename_folder_btn addSubview:ren_fol];
                        
                        UILabel *ren_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                        ren_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                        ren_fol_lbl.text=@"Rename Folder";
                        ren_fol_lbl.textAlignment=NSTextAlignmentCenter;
                        ren_fol_lbl.backgroundColor = [UIColor clearColor];
                        ren_fol_lbl.textColor=[UIColor darkGrayColor];
                        [rename_folder_btn addSubview:ren_fol_lbl];
                        
                        //--------------------- Move Folder Button and it's subviews------------------------
                        move_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                        move_folder_btn.frame =CGRectMake(80.5*2+150, 0, 75, 114/2);
                        move_folder_btn.backgroundColor = [UIColor clearColor];
                        move_folder_btn.tag=3;
                        [move_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                        [nav_bar addSubview:move_folder_btn];
                        
                        UIImageView *mov_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"move@2x.png"]];
                        mov_fol.frame = CGRectMake(24.5f, 10, 59/2, 19);
                        [move_folder_btn addSubview:mov_fol];
                        
                        UILabel *move_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                        move_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                        move_fol_lbl.text=@"Move Folder";
                        move_fol_lbl.textAlignment=NSTextAlignmentCenter;
                        move_fol_lbl.backgroundColor = [UIColor clearColor];
                        move_fol_lbl.textColor=[UIColor darkGrayColor];
                        [move_folder_btn addSubview:move_fol_lbl];
                        
                        //--------------------- Delete Folder Button and it's subviews------------------------
                        delete_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                        delete_folder_btn.frame =CGRectMake(80.5f*3+210, 0, 75, 114/2);
                        delete_folder_btn.backgroundColor = [UIColor clearColor];
                        delete_folder_btn.tag=4;
                        [delete_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                        [nav_bar addSubview:delete_folder_btn];
                        
                        UIImageView *del_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete@2x.png"]];
                        del_fol.frame = CGRectMake(26.0f, 7.5f, 48/2, 49/2);
                        [delete_folder_btn addSubview:del_fol];
                        
                        UILabel *del_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                        del_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                        del_fol_lbl.text=@"Delete Folder";
                        del_fol_lbl.textAlignment=NSTextAlignmentCenter;
                        del_fol_lbl.backgroundColor = [UIColor clearColor];
                        del_fol_lbl.textColor=[UIColor darkGrayColor];
                        [delete_folder_btn addSubview:del_fol_lbl];
                        
                        //------------------- Folder table ---------------------------
                        new_folder_view = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.height-500/2)/2, -34, 500/2, 327/2)];
                        new_folder_view.layer.zPosition=2;
                        new_folder_view.userInteractionEnabled=YES;
                        UIImageView *background_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500/2, 327/2)];
                        background_img.image = [UIImage imageNamed:@"input-box1@2x.png"];
                        [new_folder_view addSubview:background_img];
                        [self.view addSubview:new_folder_view];
                        new_folder_view.hidden=YES;
                        
                        title_lbl_for_new_view = [[UILabel alloc] initWithFrame:CGRectMake(5, 5.5, 500/2, 20)];
                        title_lbl_for_new_view.backgroundColor = [UIColor clearColor];
                        title_lbl_for_new_view.textColor =[UIColor colorWithRed:(208.0f/255.0f) green:(198.0f/255.0f) blue:(200.0f/255.0f) alpha:1];
                        title_lbl_for_new_view.font= [UIFont fontWithName:@"SourceSansPro-Semibold" size:15.5f];
                        [new_folder_view addSubview:title_lbl_for_new_view];
                        
                        text_enter = [[CustomTextField alloc] initWithFrame:CGRectMake(7.5f, 50, 469/2, 66/2)];
                        text_enter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input-box@2x.png"]];
                        text_enter.delegate=self;
                        text_enter.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
                        text_enter.autocapitalizationType=UITextAutocapitalizationTypeNone;
                        text_enter.textColor = [UIColor blackColor];
                        [new_folder_view addSubview:text_enter];
                        
                        ok_button = [[UIButton alloc] initWithFrame:CGRectMake(65, 327/2-57, 253/2, 57/2)];
                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn@2x.png"] forState:UIControlStateNormal];
                        [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn1@2x.png"] forState:UIControlStateHighlighted];
                        [ok_button addTarget:self action:@selector(newfolderactions:) forControlEvents:UIControlEventTouchUpInside];
                        ok_button.tag=0;
                        [new_folder_view addSubview:ok_button];
                    }
                }
                    break;
            }
        }
            break;
        case UIUserInterfaceIdiomPad:
        {
            switch (self.interfaceOrientation)
            {
                case UIInterfaceOrientationPortraitUpsideDown:
                    break;
                case UIDeviceOrientationPortrait:
                {
                    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
                    {
                        list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, [[UIScreen mainScreen] bounds].size.width, self.view.bounds.size.height-114/2)];
                    }
                    else
                    {
                        list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, [[UIScreen mainScreen] bounds].size.width, self.view.bounds.size.height-57)];
                    }
                    list_tab.backgroundColor = [UIColor clearColor];
                    list_tab.dataSource=self;
                    list_tab.delegate=self;
                    list_tab.separatorColor =[UIColor clearColor];
                    list_tab.separatorStyle = UITableViewCellSeparatorStyleNone;
                    list_tab.showsVerticalScrollIndicator=NO;
                    //                    [list_tab setRowHeight:65.0f];
                    [list_tab setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    [self.view addSubview:list_tab];
                    
                    nav_bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 114/2)];
                    [self.view addSubview:nav_bar];
                    
                    bar_white = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar@2x.png"]];
                    bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 114/2);
                    [nav_bar addSubview:bar_white];
                    
                    //---------------- NEw Folder Button and it's subviews -------------------------------------
                    new_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    new_folder_btn.frame =CGRectMake(65, 0, 75, 114/2);
                    new_folder_btn.backgroundColor = [UIColor clearColor];
                    new_folder_btn.tag=1;
                    [new_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    [nav_bar addSubview:new_folder_btn];
                    
                    UIImageView *new_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new-folder@2x.png"]];
                    new_fol.frame = CGRectMake(27, 10, 59/2, 38/2);
                    [new_folder_btn addSubview:new_fol];
                    
                    UILabel *new_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 80, 20)];
                    new_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    new_fol_lbl.text=@"New Folder";
                    new_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    new_fol_lbl.backgroundColor = [UIColor clearColor];
                    new_fol_lbl.textColor=[UIColor darkGrayColor];
                    [new_folder_btn addSubview:new_fol_lbl];
                    
                    //--------------------- Rename Folder Button and it's subviews------------------------
                    rename_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    rename_folder_btn.frame =CGRectMake(128*2, 0, 75, 114/2);
                    rename_folder_btn.backgroundColor = [UIColor clearColor];
                    rename_folder_btn.tag=2;
                    [rename_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    [nav_bar addSubview:rename_folder_btn];
                    
                    UIImageView *ren_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rename-folder@2x.png"]];
                    ren_fol.frame = CGRectMake(24.5, 10, 59/2, 19);
                    [rename_folder_btn addSubview:ren_fol];
                    
                    UILabel *ren_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    ren_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    ren_fol_lbl.text=@"Rename Folder";
                    ren_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    ren_fol_lbl.backgroundColor = [UIColor clearColor];
                    ren_fol_lbl.textColor=[UIColor darkGrayColor];
                    [rename_folder_btn addSubview:ren_fol_lbl];
                    
                    //--------------------- Move Folder Button and it's subviews------------------------
                    move_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    move_folder_btn.frame =CGRectMake(128*3+65, 0, 75, 114/2);
                    move_folder_btn.backgroundColor = [UIColor clearColor];
                    move_folder_btn.tag=3;
                    [move_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    [nav_bar addSubview:move_folder_btn];
                    
                    UIImageView *mov_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"move@2x.png"]];
                    mov_fol.frame = CGRectMake(24.5f, 10, 59/2, 19);
                    [move_folder_btn addSubview:mov_fol];
                    
                    UILabel *move_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    move_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    move_fol_lbl.text=@"Move Folder";
                    move_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    move_fol_lbl.backgroundColor = [UIColor clearColor];
                    move_fol_lbl.textColor=[UIColor darkGrayColor];
                    [move_folder_btn addSubview:move_fol_lbl];
                    
                    //--------------------- Delete Folder Button and it's subviews------------------------
                    delete_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    delete_folder_btn.frame =CGRectMake(128*4+115, 0, 75, 114/2);
                    delete_folder_btn.backgroundColor = [UIColor clearColor];
                    delete_folder_btn.tag=4;
                    [delete_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    [nav_bar addSubview:delete_folder_btn];
                    
                    UIImageView *del_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete@2x.png"]];
                    del_fol.frame = CGRectMake(26.0f, 7.5f, 48/2, 49/2);
                    [delete_folder_btn addSubview:del_fol];
                    
                    UILabel *del_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    del_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    del_fol_lbl.text=@"Delete Folder";
                    del_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    del_fol_lbl.backgroundColor = [UIColor clearColor];
                    del_fol_lbl.textColor=[UIColor darkGrayColor];
                    [delete_folder_btn addSubview:del_fol_lbl];
                    
                    //------------------- Folder table ---------------------------
                    
                    //----------------- Shadow View ------------------------------
                    shadow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-45)];
                    shadow_view.backgroundColor = [UIColor blackColor];
                    shadow_view.alpha=0.79;
                    shadow_view.layer.zPosition=1;
                    shadow_view.userInteractionEnabled=YES;
                    shadow_view.hidden=YES;
                    [self.view addSubview:shadow_view];
                    
                    UITapGestureRecognizer *hideshadow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
                    hideshadow.numberOfTapsRequired=1;
                    [shadow_view addGestureRecognizer:hideshadow];
                    
                    //----------------- New Folder View --------------------------
                    new_folder_view = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-500/2)/2, 180, 500/2, 327/2)];
                    new_folder_view.layer.zPosition=2;
                    new_folder_view.userInteractionEnabled=YES;
                    
                    UIImageView *background_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500/2, 327/2)];
                    background_img.image = [UIImage imageNamed:@"input-box1@2x.png"];
                    [new_folder_view addSubview:background_img];
                    [self.view addSubview:new_folder_view];
                    new_folder_view.hidden=YES;
                    
                    title_lbl_for_new_view = [[UILabel alloc] initWithFrame:CGRectMake(5, 5.5, 500/2, 20)];
                    title_lbl_for_new_view.backgroundColor = [UIColor clearColor];
                    title_lbl_for_new_view.textColor =[UIColor colorWithRed:(208.0f/255.0f) green:(198.0f/255.0f) blue:(200.0f/255.0f) alpha:1];
                    title_lbl_for_new_view.font= [UIFont fontWithName:@"SourceSansPro-Semibold" size:15.5f];
                    [new_folder_view addSubview:title_lbl_for_new_view];
                    
                    text_enter = [[CustomTextField alloc] initWithFrame:CGRectMake(7.5f, 50, 469/2, 66/2)];
                    text_enter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input-box@2x.png"]];
                    text_enter.delegate=self;
                    text_enter.text=@"";
                    text_enter.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
                    text_enter.autocapitalizationType=UITextAutocapitalizationTypeNone;
                    text_enter.textColor = [UIColor blackColor];
                    [new_folder_view addSubview:text_enter];
                    
                    ok_button = [[UIButton alloc] initWithFrame:CGRectMake(65, 327/2-57, 253/2, 57/2)];
                    [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn@2x.png"] forState:UIControlStateNormal];
                    [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn1@2x.png"] forState:UIControlStateHighlighted];
                    [ok_button addTarget:self action:@selector(newfolderactions:) forControlEvents:UIControlEventTouchUpInside];
                    ok_button.tag=0;
                    [new_folder_view addSubview:ok_button];
                }
                    break;
                case  UIInterfaceOrientationLandscapeRight:
                case UIInterfaceOrientationLandscapeLeft:
                {
                    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
                    {
                        list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, [[UIScreen mainScreen] bounds].size.height, screenHeight-114/2-65)];
                    }
                    else
                    {
                        list_tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 114/2, [[UIScreen mainScreen] bounds].size.height, screenHeight-114/2-65)];
                    }
                    list_tab.backgroundColor = [UIColor clearColor];
                    list_tab.dataSource=self;
                    list_tab.delegate=self;
                    list_tab.separatorColor =[UIColor clearColor];
                    list_tab.separatorStyle = UITableViewCellSeparatorStyleNone;
                    list_tab.showsVerticalScrollIndicator=NO;
                    //                    [list_tab setRowHeight:65.0f];
                    [list_tab setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    [self.view addSubview:list_tab];
                    
                    nav_bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 114/2)];
                    [self.view addSubview:nav_bar];
                    
                    bar_white = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar@2x.png"]];
                    bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 114/2);
                    [nav_bar addSubview:bar_white];
                    
                    //---------------- NEw Folder Button and it's subviews -------------------------------------
                    new_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    new_folder_btn.frame =CGRectMake(80, 0, 75, 114/2);
                    new_folder_btn.backgroundColor = [UIColor clearColor];
                    new_folder_btn.tag=1;
                    [new_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    [nav_bar addSubview:new_folder_btn];
                    
                    UIImageView *new_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new-folder@2x.png"]];
                    new_fol.frame = CGRectMake(27, 10, 59/2, 38/2);
                    [new_folder_btn addSubview:new_fol];
                    
                    UILabel *new_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 80, 20)];
                    new_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    new_fol_lbl.text=@"New Folder";
                    new_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    new_fol_lbl.backgroundColor = [UIColor clearColor];
                    new_fol_lbl.textColor=[UIColor darkGrayColor];
                    [new_folder_btn addSubview:new_fol_lbl];
                    
                    //--------------------- Rename Folder Button and it's subviews------------------------
                    rename_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    rename_folder_btn.frame =CGRectMake(199.5f+140, 0, 75, 114/2);
                    rename_folder_btn.backgroundColor = [UIColor clearColor];
                    rename_folder_btn.tag=2;
                    [rename_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    [nav_bar addSubview:rename_folder_btn];
                    
                    UIImageView *ren_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rename-folder@2x.png"]];
                    ren_fol.frame = CGRectMake(24.5, 10, 59/2, 19);
                    [rename_folder_btn addSubview:ren_fol];
                    
                    UILabel *ren_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    ren_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    ren_fol_lbl.text=@"Rename Folder";
                    ren_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    ren_fol_lbl.backgroundColor = [UIColor clearColor];
                    ren_fol_lbl.textColor=[UIColor darkGrayColor];
                    [rename_folder_btn addSubview:ren_fol_lbl];
                    
                    //--------------------- Move Folder Button and it's subviews------------------------
                    move_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    move_folder_btn.frame =CGRectMake(199.5f*2+195, 0, 75, 114/2);
                    move_folder_btn.backgroundColor = [UIColor clearColor];
                    move_folder_btn.tag=3;
                    [move_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    [nav_bar addSubview:move_folder_btn];
                    
                    UIImageView *mov_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"move@2x.png"]];
                    mov_fol.frame = CGRectMake(24.5f, 10, 59/2, 19);
                    [move_folder_btn addSubview:mov_fol];
                    
                    UILabel *move_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    move_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    move_fol_lbl.text=@"Move Folder";
                    move_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    move_fol_lbl.backgroundColor = [UIColor clearColor];
                    move_fol_lbl.textColor=[UIColor darkGrayColor];
                    [move_folder_btn addSubview:move_fol_lbl];
                    
                    //--------------------- Delete Folder Button and it's subviews------------------------
                    delete_folder_btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    delete_folder_btn.frame =CGRectMake(199.5f*3+255, 0, 75, 114/2);
                    delete_folder_btn.backgroundColor = [UIColor clearColor];
                    delete_folder_btn.tag=4;
                    [delete_folder_btn addTarget:self action:@selector(navbaractions:) forControlEvents:UIControlEventTouchUpInside];
                    [nav_bar addSubview:delete_folder_btn];
                    
                    UIImageView *del_fol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete@2x.png"]];
                    del_fol.frame = CGRectMake(26.0f, 7.5f, 48/2, 49/2);
                    [delete_folder_btn addSubview:del_fol];
                    
                    UILabel *del_fol_lbl = [[UILabel alloc] initWithFrame:CGRectMake(2, 35, 80, 20)];
                    del_fol_lbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.5];
                    del_fol_lbl.text=@"Delete Folder";
                    del_fol_lbl.textAlignment=NSTextAlignmentCenter;
                    del_fol_lbl.backgroundColor = [UIColor clearColor];
                    del_fol_lbl.textColor=[UIColor darkGrayColor];
                    [delete_folder_btn addSubview:del_fol_lbl];
                    
                    //------------------- Folder table ---------------------------
                    
                    //----------------- Shadow View ------------------------------
                    shadow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height-45)];
                    shadow_view.backgroundColor = [UIColor blackColor];
                    shadow_view.alpha=0.79;
                    shadow_view.layer.zPosition=1;
                    shadow_view.userInteractionEnabled=YES;
                    shadow_view.hidden=YES;
                    [self.view addSubview:shadow_view];
                    
                    UITapGestureRecognizer *hideshadow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
                    hideshadow.numberOfTapsRequired=1;
                    [shadow_view addGestureRecognizer:hideshadow];
                    
                    //----------------- New Folder View --------------------------
                    
                    new_folder_view = [[UIView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.height-500/2)/2, 180, 500/2, 327/2)];
                    new_folder_view.layer.zPosition=2;
                    
                    new_folder_view.userInteractionEnabled=YES;
                    UIImageView *background_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500/2, 327/2)];
                    background_img.image = [UIImage imageNamed:@"input-box1@2x.png"];
                    [new_folder_view addSubview:background_img];
                    [self.view addSubview:new_folder_view];
                    new_folder_view.hidden=YES;
                    
                    title_lbl_for_new_view = [[UILabel alloc] initWithFrame:CGRectMake(5, 5.5, 500/2, 20)];
                    title_lbl_for_new_view.backgroundColor = [UIColor clearColor];
                    title_lbl_for_new_view.textColor =[UIColor colorWithRed:(208.0f/255.0f) green:(198.0f/255.0f) blue:(200.0f/255.0f) alpha:1];
                    title_lbl_for_new_view.font= [UIFont fontWithName:@"SourceSansPro-Semibold" size:15.5f];
                    [new_folder_view addSubview:title_lbl_for_new_view];
                    
                    text_enter = [[CustomTextField alloc] initWithFrame:CGRectMake(7.5f, 50, 469/2, 66/2)];
                    text_enter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"input-box@2x.png"]];
                    text_enter.delegate=self;
                    text_enter.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
                    text_enter.autocapitalizationType=UITextAutocapitalizationTypeNone;
                    text_enter.textColor = [UIColor blackColor];
                    [new_folder_view addSubview:text_enter];
                    
                    ok_button = [[UIButton alloc] initWithFrame:CGRectMake(65, 327/2-57, 253/2, 57/2)];
                    [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn@2x.png"] forState:UIControlStateNormal];
                    [ok_button setBackgroundImage:[UIImage imageNamed:@"ok-btn1@2x.png"] forState:UIControlStateHighlighted];
                    [ok_button addTarget:self action:@selector(newfolderactions:) forControlEvents:UIControlEventTouchUpInside];
                    ok_button.tag=0;
                    [new_folder_view addSubview:ok_button];
                }
                    break;
            }
        }
            break;
    }
}
-(void)copyThisUrl:(UIButton *)sender
{
    if([[NSString stringWithFormat:@"%@",[sender titleForState:UIControlStateNormal]] isEqualToString:@"Copy Url"])
    {
        [self copyAlertShow];
    }
    else
    {
        //        [self dropdownaction];
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Your Action"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel Button"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Copy Url", @"Check all images",@"Rename photo",@"Delete photo",@"Copy / Paste photo",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad)
        {
            [actionSheet addButtonWithTitle:@"Cancel"];
        }
        [actionSheet showInView:self.view];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.selectedIndexPaths = [[NSMutableArray alloc]init];
    [list_tab reloadData];
    
    switch (buttonIndex) {
        case 0:
        {
            [tempHeader removeFromSuperview];
            nav_bar.hidden = NO;
            NSLog(@"here here");
            [self copyAlertShow];
        }
            break;
        case 1:
        {
            [tempHeader removeFromSuperview];
            nav_bar.hidden = NO;
            
            NSMutableArray *imgs = [[NSMutableArray alloc] init];
            for (int j = 0; j<[folder_table_data count];j++)
            {
                NSDictionary *dict = [folder_table_data objectAtIndex:j];
                if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"type"]] isEqualToString:@"file"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@/%@",director_string,[dict objectForKey:@"name"]];
                    [imgs addObject:[str stringByReplacingOccurrencesOfString:@".." withString:parent_url_for_ftp_image_listing]];
                }
            }
            ImagePagingViewController *image_paging = [[ImagePagingViewController alloc] init];
            image_paging.array_new_images = imgs;
            image_paging.ftp_path = [NSString stringWithFormat:@"%@",self.navigationItem.title];
            [self.navigationController pushViewController:image_paging animated:NO];
        }
            break;
        case 2:
        {
            [tempHeader removeFromSuperview];
            nav_bar.hidden = NO;
            [SVProgressHUD showErrorWithStatus:@"Select a photo to rename"];
            checkFlag=2;
        }
            break;
        case 3:
        {
            [tempHeader removeFromSuperview];
            nav_bar.hidden = NO;
            
            [SVProgressHUD showErrorWithStatus:@"Select a photo to delete"];
            checkFlag=3;
        }
            break;
        case 4:     //=============================COPY + PASTE====================================//
        {
            nav_bar.hidden = YES;
            
            tempHeader = [[UIView alloc]init];
            tempHeader.frame = CGRectMake(0, 0, 320, 57);
            tempHeader.backgroundColor = [UIColor blackColor];
            [self.view addSubview:tempHeader];
            
            UILabel *infoLbl = [[UILabel alloc]init];
            infoLbl.frame = CGRectMake(10, 5, 180, 40);
            infoLbl.text = @"Select the images and tap done when finished";
            infoLbl.textColor = [UIColor whiteColor];
            infoLbl.font = [UIFont systemFontOfSize:15];
            infoLbl.textAlignment = NSTextAlignmentLeft;
            infoLbl.numberOfLines = 2;
            [tempHeader addSubview:infoLbl];
            
            UIButton *doneBtn = [[UIButton alloc]init];
            doneBtn.frame = CGRectMake(222, 13.5f, 80, 30);
            doneBtn.layer.cornerRadius = 5;
            doneBtn.backgroundColor = [UIColor clearColor];
            doneBtn.layer.borderWidth = 2;
            doneBtn.layer.borderColor = [[UIColor whiteColor]CGColor];
            [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
            [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [doneBtn addTarget:self action:@selector(doneto:) forControlEvents:UIControlEventTouchUpInside];
            [tempHeader addSubview:doneBtn];
            
            [SVProgressHUD showErrorWithStatus:@"Select a photo to copy"];
            checkFlag=4;
        }
            break;
    }
    
}

-(void)copyAlertShow
{
    UIAlertView *alert_confirm = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Do you want to copy this url?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    alert_confirm.tag=100;
    [alert_confirm show];
}

//-(void)copyPastePhotosAlertShow
//{
//
//    UIAlertView *alert_confirm = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Select the photos to be copied" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    alert_confirm.tag=100;
//    [alert_confirm show];
//
//}

-(void)dropdownaction
{
    int height_for_drop_down_menu=0,x_postion_for_drop_down_menu=0,y_position_for_name_view=0;
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPad:
        {
            height_for_drop_down_menu = 100;
        }
            break;
        case UIUserInterfaceIdiomPhone:
        {
            height_for_drop_down_menu = 200;
        }
            break;
    }
    
    switch (self.interfaceOrientation)
    {
        case UIDeviceOrientationPortrait:
        {
            x_postion_for_drop_down_menu =[[UIScreen mainScreen]bounds].size.width;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.height;
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
        }
            break;
        case UIInterfaceOrientationLandscapeRight:
        {
            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            x_postion_for_drop_down_menu =[[UIScreen mainScreen]bounds].size.width;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.height;
        }
            break;
    }
    
    if(drop_down_view_ftp == nil)
    {
        drop_down_view_ftp = [[UIView alloc]  initWithFrame:CGRectMake(x_postion_for_drop_down_menu-150, 0, 150, 0)];
        drop_down_view_ftp.backgroundColor = [UIColor clearColor];
        drop_down_view_ftp.autoresizesSubviews = YES;
        drop_down_view_ftp.clipsToBounds = YES;
        
        for (int count = 0;count<2;count++)
        {
            CGRect btn_frame =  CGRectMake(0, 0, 150, 0);
            NSString *title=nil;
            switch (count) {
                case 0:
                {
                    title=@"Copy Url";
                }
                    break;
                case 1:
                {
                    title = @"Check all images";
                }
                    break;
            }
            UIButton *btn = [[UIButton alloc] initWithFrame:btn_frame];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTag:count];
            [btn setBackgroundColor:[UIColor colorWithRed:(255.0f/255.0f) green:(164.0f/255.0f) blue:(115.0f/255.0f) alpha:1.0f]];
            if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone)
            {
                [[btn layer]setCornerRadius:20];
            }
            else
            {
                [[btn layer]setCornerRadius:30];
            }
            
            [btn addTarget:self action:@selector(btn_functions_forFtp:) forControlEvents:UIControlEventTouchUpInside];
            [drop_down_view_ftp addSubview:btn];
        }
        [self.view addSubview:drop_down_view_ftp];
    }
    if(drop_down_view_ftp.frame.size.height==0)
    {
        [self openPopup];
    }
    else
    {
        [self closePopup];
    }
}

-(void)btn_functions_forFtp:(UIButton *)bt_sender
{
    [self closePopup];
    switch ([bt_sender tag]) {
        case 0:
        {
            [self copyAlertShow];
        }
            break;
        case 1:
        {
            NSMutableArray *imgs = [[NSMutableArray alloc] init];
            for (int j = 0; j<[folder_table_data count];j++)
            {
                NSDictionary *dict = [folder_table_data objectAtIndex:j];
                if([[NSString stringWithFormat:@"%@",[dict objectForKey:@"type"]] isEqualToString:@"file"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@/%@",director_string,[dict objectForKey:@"name"]];
                    
                    [imgs addObject:[str stringByReplacingOccurrencesOfString:@".." withString:parent_url_for_ftp_image_listing]];
                }
            }
            ImagePagingViewController *image_paging = [[ImagePagingViewController alloc] init];
            image_paging.array_new_images = imgs;
            image_paging.ftp_path = [NSString stringWithFormat:@"%@",self.navigationItem.title];
            [self.navigationController pushViewController:image_paging animated:NO];
        }
            break;
    }
}

-(void)goback_ftp:(UIButton *)sender
{
    NSLog(@"in go-back-ftp");
    checkFlag = 0;
    nav_bar.hidden = NO;
    tempHeader.hidden = YES;
    
    
    self.selectedIndexPaths = [[NSMutableArray alloc]init];
    
    if([folder_path_array count]==0)
    {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.libopen = YES;
        //        [self.navigationController popViewControllerAnimated:NO];
        RootViewController *root = [[RootViewController alloc]init];
        [self.navigationController pushViewController:root animated:NO];
    }
    else
    {
        [UIView transitionWithView: list_tab
                          duration: 0.5f
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        animations: ^(void)
         {
             list_tab.hidden=YES;
         }
                        completion: ^(BOOL isFinished)
         {
             [SVProgressHUD showSuccessWithStatus:@"Loading.."];
             director_string = [folder_path_array lastObject];
             
             thumb_new_path = [director_string stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"];
             [folder_path_array removeLastObject];
             [self starttheftplisting];
         }];
    }
}
- (void)displayPickerForGroup:(ALAssetsGroup *)group
{
    ELCAssetTablePicker *tablePicker = [[ELCAssetTablePicker alloc] initWithNibName: nil bundle: nil];
    tablePicker.singleSelection = YES;
    tablePicker.immediateReturn = YES;
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
    elcPicker.maximumImagesCount = 1;
    elcPicker.delegate = self;
    tablePicker.parent = elcPicker;
    // Move me
    tablePicker.assetGroup = group;
    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    if([info count]>0)
    {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        delegate.libopen = NO;
        ImageDetailViewController *image_detail = [[ImageDetailViewController alloc] init];
        image_detail.image_data_from_library = [NSMutableArray arrayWithCapacity:[info count]];
        image_detail.url_of_images = [[NSMutableArray alloc] init];
        
        for(NSDictionary *dict in info) {
            UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
            
            [image_detail.url_of_images addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:UIImagePickerControllerReferenceURL]]];
            [image_detail.image_data_from_library addObject:image];
        }
        image_detail.imgtypestatic=NO;
        image_detail.selected_image = [[UIImage alloc] init];
        image_detail.selected_image = (UIImage *)[image_detail.image_data_from_library objectAtIndex:0];
        image_detail.url_of_image = [image_detail.url_of_images objectAtIndex:0];
        image_detail.tag = 0;
        
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            [self.navigationController pushViewController:image_detail animated:YES];
        }];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)openPopup
{
    int height_for_drop_down_menu=0,x_postion_for_drop_down_menu=0,y_position_for_name_view=0;
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPad:
        {
            height_for_drop_down_menu = 100;
        }
            break;
        case UIUserInterfaceIdiomPhone:
        {
            height_for_drop_down_menu = 200;
        }
            break;
    }
    
    switch (self.interfaceOrientation)
    {
        case UIDeviceOrientationPortrait:
        {
            x_postion_for_drop_down_menu =[[UIScreen mainScreen]bounds].size.width;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.height;
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
        }
            break;
        case UIInterfaceOrientationLandscapeRight:
        {
            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            x_postion_for_drop_down_menu =[[UIScreen mainScreen]bounds].size.width;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.height;
        }
            break;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        list_tab.layer.opacity=0.5;
        list_tab.scrollEnabled=NO;
        drop_down_view_ftp.frame = CGRectMake(x_postion_for_drop_down_menu-150, 0, 150, height_for_drop_down_menu);
        
        for (UIView *sub in drop_down_view_ftp.subviews)
        {
            if([sub isKindOfClass:[UIButton class]])
            {
                UIButton *btn = (UIButton *)sub;
                CGRect frame_btn = btn.frame;
                switch (btn.tag) {
                    case 0:
                    {
                        frame_btn.origin.y=0;
                    }
                        break;
                    case 1:
                    {
                        if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone)
                        {
                            frame_btn.origin.y=height_for_drop_down_menu/4+1.0f;
                        }
                        else
                        {
                            frame_btn.origin.y=height_for_drop_down_menu/2+1.0f;
                        }
                    }
                        break;
                }
                if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad)
                {
                    CGFloat height = height_for_drop_down_menu/2;
                    frame_btn.size.height = height;
                    btn.frame = frame_btn;
                }
                else
                {
                    CGFloat height = height_for_drop_down_menu/4;
                    frame_btn.size.height = height;
                    btn.frame = frame_btn;
                }
            }
        }
    }];
}
-(void)closePopup
{
    int height_for_drop_down_menu=0,x_postion_for_drop_down_menu=0,y_position_for_name_view=0;
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPad:
        {
            height_for_drop_down_menu = 200;
        }
            break;
        case UIUserInterfaceIdiomPhone:
        {
            height_for_drop_down_menu = 100;
        }
            break;
    }
    switch (self.interfaceOrientation)
    {
        case UIDeviceOrientationPortrait:
        {
            x_postion_for_drop_down_menu =[[UIScreen mainScreen]bounds].size.width;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.height;
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
        }
            break;
        case UIInterfaceOrientationLandscapeRight:
        {
            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            x_postion_for_drop_down_menu =[[UIScreen mainScreen]bounds].size.width;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.height;
        }
            break;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        list_tab.layer.opacity=1;
        list_tab.scrollEnabled=YES;
        drop_down_view_ftp.frame = CGRectMake(x_postion_for_drop_down_menu-150, 0, 150, 0);
        
        for (UIView *sub in drop_down_view_ftp.subviews)
        {
            if([sub isKindOfClass:NSClassFromString(@"UIButton")])
            {
                UIButton *bt = (UIButton *)sub;
                CGRect bt_frame = bt.frame;
                
                bt_frame = CGRectMake(bt_frame.origin.x, [bt tag]*drop_down_view_ftp.frame.size.height/2, bt_frame.size.width, drop_down_view_ftp.frame.size.height/2);
                bt.frame = bt_frame;
            }
        }
    }];
}

-(void)orientationChangedinFTP:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch ([[UIDevice currentDevice] userInterfaceIdiom])
    {
        case UIUserInterfaceIdiomPhone:
        {
            switch(device.orientation)
            {
                case UIDeviceOrientationUnknown:
                case UIDeviceOrientationFaceDown:
                case UIDeviceOrientationFaceUp:
                case UIDeviceOrientationPortraitUpsideDown:
                    break;
                case UIDeviceOrientationPortrait:
                {
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         
                                         bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 114/2);
                                         nav_bar.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 114/2);
                                         new_folder_btn.frame =CGRectMake(0, 0, 75, 114/2);
                                         rename_folder_btn.frame =CGRectMake(80.5, 0, 75, 114/2);
                                         move_folder_btn.frame =CGRectMake(80.5*2, 0, 75, 114/2);
                                         delete_folder_btn.frame =CGRectMake(80.5f*3, 0, 75, 114/2);
                                         shadow_view.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height-45);
                                         if([[UIScreen mainScreen] bounds].size.height<568)
                                         {
                                             new_folder_view.frame =CGRectMake(([[UIScreen mainScreen] bounds].size.width-500/2)/2, 100-self.navigationController.navigationBar.frame.size.height, 500/2, 327/2);
                                         }
                                         else
                                         {
                                             new_folder_view.frame =CGRectMake(([[UIScreen mainScreen] bounds].size.width-500/2)/2,180-self.navigationController.navigationBar.frame.size.height, 500/2, 327/2);
                                         }
                                         
                                         if(drop_down_view_ftp.frame.size.height>0 && drop_down_view_ftp!=nil)
                                         {
                                             [self openPopup];
                                         }
                                     }
                                     completion:^(BOOL finished){  }];
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                case UIDeviceOrientationLandscapeRight:
                {
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 114/2);
                                         nav_bar.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 114/2);
                                         new_folder_btn.frame =CGRectMake(20, 0, 75, 114/2);
                                         if([[UIScreen mainScreen]bounds].size.height<568)
                                         {
                                             rename_folder_btn.frame = CGRectMake(80.5+60, 0, 75, 114/2);
                                             move_folder_btn.frame = CGRectMake(80.5*2+100, 0, 75, 114/2);
                                             delete_folder_btn.frame = CGRectMake(80.5*3+150, 0, 75, 114/2);
                                         }
                                         else
                                         {
                                             rename_folder_btn.frame = CGRectMake(80.5+90, 0, 75, 114/2);
                                             move_folder_btn.frame = CGRectMake(80.5*2+150, 0, 75, 114/2);
                                             delete_folder_btn.frame = CGRectMake(80.5f*3+210, 0, 75, 114/2);
                                         }
                                         new_folder_view.frame =CGRectMake(([[UIScreen mainScreen] bounds].size.height-500/2)/2, -34, 500/2, 327/2);
                                         shadow_view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-45);
                                         
                                         if(drop_down_view_ftp.frame.size.height>0 && drop_down_view_ftp!=nil)
                                         {
                                             [self openPopup];
                                         }
                                     }
                                     completion:^(BOOL finished){ }];
                }
                    break;
            };
        }
            break;
        case UIUserInterfaceIdiomPad:
        {
            switch(device.orientation)
            {
                case UIDeviceOrientationUnknown:
                case UIDeviceOrientationFaceDown:
                case UIDeviceOrientationFaceUp:
                case UIDeviceOrientationPortraitUpsideDown:
                    break;
                case UIDeviceOrientationPortrait:
                {
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         [self setViewMovedUp:NO];
                                         bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 114/2);
                                         nav_bar.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 114/2);
                                         new_folder_btn.frame =CGRectMake(65, 0, 75, 114/2);
                                         rename_folder_btn.frame =CGRectMake(128*2, 0, 75, 114/2);
                                         move_folder_btn.frame =CGRectMake(128*3+65, 0, 75, 114/2);
                                         delete_folder_btn.frame =CGRectMake(128*4+115, 0, 75, 114/2);
                                         shadow_view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-45);
                                         if([[UIScreen mainScreen] bounds].size.height<568)
                                         {
                                             new_folder_view.frame =CGRectMake(([[UIScreen mainScreen] bounds].size.width-500/2)/2, 100-self.navigationController.navigationBar.frame.size.height, 500/2, 327/2);
                                         }
                                         else
                                         {
                                             new_folder_view.frame =CGRectMake(([[UIScreen mainScreen] bounds].size.width-500/2)/2,180-self.navigationController.navigationBar.frame.size.height, 500/2, 327/2);
                                         }
                                         if(drop_down_view_ftp.frame.size.height>0 && drop_down_view_ftp!=nil)
                                         {
                                             [self openPopup];
                                         }
                                     }
                                     completion:^(BOOL finished){  }];
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                case UIDeviceOrientationLandscapeRight:
                {
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         [self setViewMovedUp:YES];
                                         bar_white.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 114/2);
                                         nav_bar.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 114/2);
                                         new_folder_btn.frame =CGRectMake(80, 0, 75, 114/2);
                                         rename_folder_btn.frame = CGRectMake(199.5f+140, 0, 75, 114/2);
                                         move_folder_btn.frame = CGRectMake(199.5f*2+195, 0, 75, 114/2);
                                         delete_folder_btn.frame = CGRectMake(199.5f*3+255, 0, 75, 114/2);
                                         new_folder_view.frame =CGRectMake(([[UIScreen mainScreen] bounds].size.height-500/2)/2, 60, 500/2, 327/2);
                                         shadow_view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
                                         if(drop_down_view_ftp.frame.size.height>0 && drop_down_view_ftp!=nil)
                                         {
                                             [self openPopup];
                                         }
                                     }
                                     completion:^(BOOL finished){ }];
                }
                    break;
            };
        }
            break;
    }
    [list_tab reloadData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    if([SVProgressHUD isVisible])
    {
        [SVProgressHUD dismiss];
    }
    drop_down_view_ftp = nil;
    [super viewWillDisappear:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChangedinFTP:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    imageorfolder=0;
    self.selectedIndexPaths = [[NSMutableArray alloc]init];
    
    if(folder_path_array==nil && [director_string length]==0)
    {
        folder_path_array = [[NSMutableArray alloc] init];
        director_string =[[NSString alloc] init];
        director_string = [NSString stringWithFormat:@"../user/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]];
        thumb_new_path = [director_string stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"];
    }
    intial_click_on_go_back = YES;
    [SVProgressHUD showWithStatus:@"Loading.."];
    [self starttheftplisting];
}

-(void)starttheftplisting
{
    NSString *url_string = [[NSString alloc] init];
    intial=YES;
    selectedindex = 0;
    url_string = [NSString stringWithFormat:@"%@iosphoto_actiontest.php?dir=%@",mydomainurl,[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@" url is %@",url_string);
    
    if (![[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isKindOfClass:[NSNull class]] && [[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] length] != 0)
        
        
        [self new_reload:url_string];
}

-(void)new_reload:(NSString *)urlString
{
    NSString *urlString1 =urlString;
    NSLog(@"ftp:- fired url is: %@",urlString1);
    NSString *newString1 = [urlString1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    @try {
        NSError *error;     //**** change made here nil added ****//
        
        NSData *signeddataURL1 =[NSData dataWithContentsOfURL:[NSURL URLWithString:newString1]];
        
        if (signeddataURL1 == nil)
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Error in Server Connection!"
                                               message:nil
                                              delegate:self
                                     cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
            [alert show];
        }
        else
        {
            
            NSMutableDictionary *data = [NSJSONSerialization JSONObjectWithData:signeddataURL1 //1
                                                                        options:kNilOptions
                                                                          error:&error];
            
            NSLog(@"data coming: %@",data);
            [self.navigationItem setTitle:[NSString stringWithFormat:@"%@",[director_string lastPathComponent]]];
            
            //    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
            //
            //    AFJSONRequestOperation *operation_folders = [AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]
            //                                success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
            //                                                 {
            folder_table_data = [[NSMutableArray alloc] init];
            BOOL images_present = NO;
            for (NSDictionary *obt in data)
            {
                [folder_table_data  addObject:obt];
                
                if([[NSString stringWithFormat:@"%@",[obt objectForKey:@"type"]] isEqualToString:@"file"])
                {
                    NSLog(@"image present yes");
                    images_present = YES;
                }
            }
            
            //        [list_tab reloadData];
            if([folder_table_data count]>0)
            {
                NSLog(@"yes count is > 0");
                [list_tab reloadData];
            }
            else
            {
                UIButton *add_button =  [UIButton buttonWithType:UIButtonTypeCustom];
                [[add_button titleLabel] setTextAlignment:NSTextAlignmentCenter];
                [[add_button titleLabel] setNumberOfLines:3];
                [[add_button titleLabel] setFont:[UIFont systemFontOfSize:13]];
                [[add_button titleLabel] setTextAlignment:NSTextAlignmentCenter];
                [add_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [add_button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [add_button addTarget:self action:@selector(copyThisUrl:)forControlEvents:UIControlEventTouchUpInside];
                [add_button setFrame:CGRectMake(0, 0,32, 25/2)];
                [add_button setTitle:@"Copy Url" forState:UIControlStateNormal];
                UIBarButtonItem *actionbarButton = [[UIBarButtonItem alloc] initWithCustomView:add_button];
                self.navigationItem.rightBarButtonItem = actionbarButton;
                [list_tab reloadData];
                
                [SVProgressHUD showErrorWithStatus:@"The folder is empty"];
            }
            
            if(drop_down_view_ftp!=nil)
            {
                [self closePopup];
            }
            // NSLog(@" images present is %d",images_present);
            UIButton *add_button =  [UIButton buttonWithType:UIButtonTypeCustom];
            [[add_button titleLabel] setTextAlignment:NSTextAlignmentCenter];
            [[add_button titleLabel] setNumberOfLines:3];
            [[add_button titleLabel] setFont:[UIFont systemFontOfSize:13]];
            [[add_button titleLabel] setTextAlignment:NSTextAlignmentCenter];
            [add_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [add_button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [add_button addTarget:self action:@selector(copyThisUrl:)forControlEvents:UIControlEventTouchUpInside];
            [add_button setFrame:CGRectMake(0, 0,32, 25/2)];
            if(images_present != YES)
            {
                [add_button setTitle:@"Copy Url" forState:UIControlStateNormal];
            }
            else
            {
                [add_button setTitle:@"More" forState:UIControlStateNormal];
            }
            UIBarButtonItem *actionbarButton = [[UIBarButtonItem alloc] initWithCustomView:add_button];
            self.navigationItem.rightBarButtonItem = actionbarButton;
            
            //                                                     [UIView transitionWithView: list_tab
            //                                                                       duration: 1.00f
            //                                                                        options: UIViewAnimationOptionTransitionCrossDissolve
            //                                                                     animations: ^(void)
            //                                                      {
            
            list_tab.hidden=NO;
            
            //                                                      }
            //                                                                    completion: ^(BOOL isFinished){
            
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"exception in ftp listing : %@",exception.description);
    }
    //                                                                     }];
    
    //                                                 }
    //                                                failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON)
    //                                                 {
    //                                                     [SVProgressHUD showErrorWithStatus:@"Internet failure"];
    //                                                 }];
    //    [operation_folders start];
}


//-----------------------------TableView-----------------------------------------------------------//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD dismiss];
    
    listEntry = [[NSDictionary alloc] init];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell= nil;
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.frame = CGRectMake(0, 0, tableView.frame.size.width, 65);
    
    
    
    listEntry = [folder_table_data objectAtIndex:((NSUInteger) indexPath.row)];
    
    cell.contentView.tag=indexPath.row;
    
    
    
    UIImageView *cell_back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copymove-cell-bg.png"]];
    
    [cell_back setContentMode:UIViewContentModeTopRight];
    
    [cell.contentView addSubview:cell_back];
    
    
    
    //    UIButton *iconButton_FTP = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //    [iconButton_FTP setFrame:CGRectMake(9, 9, 50, 50)];
    
    //    [iconButton_FTP setAdjustsImageWhenHighlighted:NO];
    
    //    [cell.contentView addSubview:iconButton_FTP];
    
    
    
    UIImageView *iconImage_FTP = [[UIImageView alloc]init];
    
    [iconImage_FTP setFrame:CGRectMake(9, 7, 50, 50)];
    
    [cell.contentView addSubview:iconImage_FTP];
    
    
    
    UILabel *folder_name_for = [[UILabel alloc] init];
    
    [folder_name_for setFont:KOFONT_FILES_TITLE];
    
    [folder_name_for setTextColor:KOCOLOR_FILES_COUNTER];
    
    [folder_name_for.layer setShadowColor:KOCOLOR_FILES_TITLE_SHADOW.CGColor];
    
    [folder_name_for.layer setShadowOffset:CGSizeMake(0, 1)];
    
    [folder_name_for.layer setShadowOpacity:1.0f];
    
    [folder_name_for.layer setShadowRadius:0.0f];
    
    [folder_name_for setBackgroundColor:[UIColor clearColor]];
    
    [folder_name_for setFrame:CGRectMake(90, (cell.frame.size.height-20)/2, folder_name_for.frame.size.width, 20)];
    
    [cell.contentView addSubview:folder_name_for];
    
    int set_Away;
    
    if([UIDevice currentDevice].userInterfaceIdiom== UIUserInterfaceIdiomPad)
        
    {
        
        set_Away=100;
        
    }
    
    else
        
    {
        
        set_Away = 70;
        
    }
    
    NSLog(@"calculation: %f",self.view.bounds.size.width-set_Away);
    
    
    
    UIButton *details_button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-set_Away,(cell.frame.size.height-28)/2, 47, 28)];
    
    [details_button setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
    
    [details_button setBackgroundImage:[UIImage imageNamed:@"item-counter"] forState:UIControlStateNormal];
    
    [details_button setBackgroundImage:[UIImage imageNamed:@"item-counter"] forState:UIControlStateHighlighted];
    
    [details_button setBackgroundImage:[UIImage imageNamed:@"item-counter"] forState:UIControlStateSelected];
    
    [details_button setTitle:@"Details" forState:UIControlStateNormal];
    
    [details_button setTitle:@"Details" forState:UIControlStateHighlighted];
    
    [details_button setTitle:@"Details" forState:UIControlStateSelected];
    
    
    
    [details_button setTitleColor:KOCOLOR_FILES_COUNTER forState:UIControlStateNormal];
    
    [details_button setTitleColor:KOCOLOR_FILES_COUNTER forState:UIControlStateSelected];
    
    [details_button setTitleColor:KOCOLOR_FILES_COUNTER forState:UIControlStateHighlighted];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        
    {
        
        [[details_button titleLabel] setShadowOffset:CGSizeMake(0, 1)];
        
    }
    
    
    
    [[details_button titleLabel] setFont:KOFONT_FILES_COUNTER];
    
    
    
    [details_button addTarget:self action:@selector(detailsaboutfolder:) forControlEvents:UIControlEventTouchUpInside];
    
    details_button.tag=indexPath.row;
    
    
    
    //    thumbImage = [[NSString alloc]init];
    
    checkThumbImage = [[NSString alloc]init];
    
    
    if ([[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isKindOfClass:[NSNull class]] || [[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] length] == 0)
        
        director_string=prev_directory;
    thumb_new_path = [director_string stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"];
    
    NSLog(@"director string: %@",director_string);
    
    
    
    //    thumbImage = [NSString stringWithFormat:@"%@/user/%@/%@",parent_url_for_ftp_image_listing,director_string,[listEntry objectForKey:@"image_name"]];
    
    
    
    
    
    //    checkString = [NSString stringWithFormat:@"%@",[listEntry objectForKey:@"type"]];
    
    
    NSArray *dir_array= [director_string componentsSeparatedByString:@"../user/"];
    
    NSString *dir_new_str = [dir_array objectAtIndex:1];
    
    NSLog(@"dir_new_str :%@",dir_new_str);
    
    
    if(![[listEntry objectForKey:@"name"] isEqualToString:@"."]&&![[listEntry objectForKey:@"name"] isEqualToString:@".."])
    {
        if([[NSString stringWithFormat:@"%@",[listEntry objectForKey:@"type"]] isEqualToString:@"file"])
        {
            //            albumImage = [NSString stringWithFormat:@"%@/%@",string,[listEntry objectForKey:@"thumb_image_name"]];
            
            albumImage = [NSString stringWithFormat:@"%@%@/%@",userurl,dir_new_str,[listEntry objectForKey:@"thumb_image_name"]];
            
            //            NSLog(@"THuMBiMAGE======================>%@",thumbImage);
            
            NSLog(@"ALBUMiMAGE======================>%@",albumImage);
            
            NSLog(@"Second if");
            NSLog(@"This is after the Initial Step");
            
            folder_name_for.text=[listEntry objectForKey:@"name"];
            
            [iconImage_FTP setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[albumImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
            
            //            [iconButton_FTP setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",string]] forState:UIControlStateNormal];
            
            //            [iconButton_FTP setImage:[UIImage imageNamed:@"imageFileicon.png"] forState:UIControlStateNormal];
            
            //            [iconButton_FTP setImage:[UIImage imageNamed:@"imageFileicon.png"] forState:UIControlStateSelected];
            
            //            [iconButton_FTP setImage:[UIImage imageNamed:@"imageFileicon.png"] forState:UIControlStateHighlighted];
            
            
            //            UISwipeGestureRecognizer * Swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipetoDelete:)];
            
            //            Swipeleft.direction=UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
            
            //            [cell.contentView addGestureRecognizer:Swipeleft];
            
            cell_back.frame= CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height);
        }
        
        else
        {
            NSLog(@"first else");
            
            UIImageView *backgroundfolderimg = [[UIImageView alloc]initWithFrame:CGRectMake(-2, -10, 77, 77)];
            [cell.contentView addSubview:backgroundfolderimg];
            backgroundfolderimg.image= [UIImage imageNamed:@"rednew-folder.png"];
            
            [iconImage_FTP setFrame:CGRectMake(11, 16, 50, 40)];
            
            iconImage_FTP.layer.zPosition=2;
            
            if([[listEntry objectForKey:@"number_of_images"] intValue]>0)
            {
                folder_name_for.text=[NSString stringWithFormat:@"%@ (%d)",[listEntry objectForKey:@"name"],[[listEntry objectForKey:@"number_of_images"] intValue]];
            }
            else
            {
                folder_name_for.text=[listEntry objectForKey:@"name"];
            }
            if(intial)
            {
                NSLog(@"initial if");
                
                checkThumbImage = [NSString stringWithFormat:@"%@%@/%@/%@",[userurl stringByReplacingOccurrencesOfString:@"user" withString:@"thumb"],dir_new_str,[listEntry objectForKey:@"name"] ,[listEntry objectForKey:@"image_name"]];
                NSLog(@"checkTHUMBiMAGE bb======================>%@",checkThumbImage);
                
                //                if ([[listEntry objectForKey:@"type"] isEqualToString:@"file"])     //============Check if return "type" is file or directory
                //                {
                if ([[listEntry objectForKey:@"number_of_images"] intValue]>0)
                {
                    NSLog(@"etay ashbe");
                    [iconImage_FTP setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[checkThumbImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]]; //setImageWithURl
                }
                else
                {
                    NSLog(@"onnotay ashbe");
                    //                    [iconImage_FTP setImage:[UIImage imageNamed:@"item-icon-folder"]];
                    
                    //                [iconButton_FTP setImage:[UIImage imageNamed:@"item-icon-folder"] forState:UIControlStateSelected];
                    //                [iconButton_FTP setImage:[UIImage imageNamed:@"item-icon-folder"] forState:UIControlStateHighlighted];
                }
            }
            else
            {
                checkThumbImage = [NSString stringWithFormat:@"%@%@/%@/%@",[userurl stringByReplacingOccurrencesOfString:@"user" withString:@"thumb"],dir_new_str,[listEntry objectForKey:@"name"] ,[listEntry objectForKey:@"image_name"]];
                
                [iconImage_FTP setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[checkThumbImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
                
                if(indexPath.row==selectedindex)
                {
                    NSLog(@"initial if");
                    //                checkThumbImage = [NSString stringWithFormat:@"%@%@/%@/%@",userurl,director_string,[listEntry objectForKey:@"name"],[listEntry objectForKey:@"image_name"]];
                    
                    [iconImage_FTP setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[checkThumbImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
                    
                    NSLog(@"checkTHUMBiMAGE bb======================>%@",checkThumbImage);
                    
                    //                if ([[listEntry objectForKey:@"type"] isEqualToString:@"file"])     //============Check if return "type" is file or directory
                    //                {
                    if ([[listEntry objectForKey:@"number_of_images"] intValue]>0)
                    {
                        NSLog(@"etay ashbe");
                        
                        [iconImage_FTP setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[checkThumbImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]]; //setImageWithURl
                    }
                    else
                    {
                        NSLog(@"onnotay ashbe");
                        
                        //                        [iconImage_FTP setImage:[UIImage imageNamed:@"item-icon-folder"]];
                        
                        //                [iconButton_FTP setImage:[UIImage imageNamed:@"item-icon-folder"] forState:UIControlStateSelected];
                        //                [iconButton_FTP setImage:[UIImage imageNamed:@"item-icon-folder"] forState:UIControlStateHighlighted];
                    }
                    
                }else{
                    if ([[listEntry objectForKey:@"number_of_images"] intValue]>0)
                    {
                        checkThumbImage = [NSString stringWithFormat:@"%@%@/%@/%@",[userurl stringByReplacingOccurrencesOfString:@"user" withString:@"thumb"],dir_new_str,[listEntry objectForKey:@"name"],[listEntry objectForKey:@"image_name"]];
                        
                        [iconImage_FTP setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[checkThumbImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
                    }else
                    {
                        NSLog(@"onnotay ashbe");
                        
                        //                        [iconImage_FTP setImage:[UIImage imageNamed:@"item-icon-folder"]];
                        
                        //                [iconButton_FTP setImage:[UIImage imageNamed:@"item-icon-folder"] forState:UIControlStateSelected];
                        //                [iconButton_FTP setImage:[UIImage imageNamed:@"item-icon-folder"] forState:UIControlStateHighlighted];
                    }
                }
            }
            
            cell.contentView.frame= cell.bounds;
            [cell.contentView addSubview:details_button];
        }
    }
    else
    {
        cell_back.image = [UIImage imageNamed:@"copymove-cell-bg1.png"];
        folder_name_for.textColor = [UIColor lightGrayColor];
        cell.userInteractionEnabled=NO;
    }
    
    CGFloat width =  [folder_name_for.text sizeWithFont:KOFONT_FILES_TITLE].width;
    CGRect folder_frame = [folder_name_for frame];
    folder_frame.size.width = width;
    [folder_name_for setFrame:folder_frame];
    
    BOOL isSelected = [self.selectedIndexPaths containsObject:indexPath]; //=================================MULTIPLE IMAGES SELECTION AND STORING=====================//
    //    //NSLog(@"isselected: %hhd",isSelected);
    if (isSelected)
    {
        //        NSMutableArray *listArray = [[NSMutableArray alloc]init];
        //        [listArray addObject:listEntry];
        
        [multiSelect addObject: [[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"]];
        NSLog(@"yes selected");
        NSLog(@"ARRAYYYYY==========>%@",multiSelect);
        cell_back.image = [UIImage imageNamed:@"copymove-cell-bg1.png"];
        
    }
    
    return cell;
}


-(void)swipetoDelete:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //    selected_to_delete = [NSIndexPath indexPathForRow:[[gestureRecognizer view] tag] inSection:0];
    //    NSLog(@" tag is %d",[[gestureRecognizer view] tag]);
    ////    selected_to_delete = ;
    //    if(alert ==nil)
    //    {
    //        alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"This will permanently remove photo from your folder. Do you want to go with it?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    //        alert.tag = 99;
    //        [alert show];
    //    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (NSInteger) ([folder_table_data count]);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (checkFlag == 4 )
    {
        if ([[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"directory"])
        {
        }
        else
            [self addOrRemoveSelectedIndexPath:indexPath];
    }
    else
        [self addOrRemoveSelectedIndexPath:indexPath];
    about_details=NO;
    if([[NSString stringWithFormat:@"%@",[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"type"]] isEqualToString:@"file"] && checkFlag==0)
    {
        NSLog(@"CHECK FLAG == 0");
        
        ImageFromFTPViewController *img_ftp = [[ImageFromFTPViewController alloc] init];
        img_ftp.url = [NSString stringWithFormat:@"%@/%@",director_string,[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"]];
        img_ftp.folder_path_fromprev = folder_path_array;
        NSLog(@"bhaswar got url is %@",[NSString stringWithFormat:@"%@/%@",director_string,[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"]]);
        CATransition* transition = [CATransition animation];
        transition.duration = 0.25;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:img_ftp animated:NO];
    }
    else if (checkFlag == 2)//=======================Rename File=========================//
    {
        
        if([[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"file"])
        {
            NSLog(@"RENAME IF");
            shadow_view.hidden=NO;
            list_tab.userInteractionEnabled=NO;
            title_lbl_for_new_view.text = @"New file name";
            text_enter.text=@"";
            [UIView transitionWithView: new_folder_view
                              duration: 0.5f
                               options: UIViewAnimationOptionTransitionCrossDissolve
                            animations: ^(void)
             {
                 new_folder_view.hidden=NO;
                 
                 selectedImage = [[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"];
                 ok_button.tag=5;
                 
                 [list_tab reloadData];
             }
             
                            completion: ^(BOOL isFinished){
                                //                            [text_enter becomeFirstResponder];
                                //                            NSLog(@"SELECTEDDDDDDD iMAGE=================>%@",text_enter.text);
                            }];
        }
        else {
            
            deleteAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"This is not an image file" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            [deleteAlert show];
            //            [self starttheftplisting];
            checkFlag=0;
            
            
        }
        
        
        NSLog(@"SELECTEDDDDDDD iMAGEb=================>%@",[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"]);
        [self.selectedIndexPaths removeObject:indexPath];
        
        
    }else if (checkFlag == 3)//======================Delete File=========================//
    {
        if([[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"file"])
        {
            
            selectedImage = [[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"];
            deleteAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Do you want to delete the image" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            [deleteAlert setTag:909];
            [deleteAlert show];
            
        }
        else {
            
            deleteAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"This is not an image file" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [deleteAlert show];
            //            [self starttheftplisting];
            checkFlag=0;
            
        }
        
        //        NSLog(@" url is %@",renameURL);
        //        NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: renameURL ]];
        //        NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
        //        NSLog(@"serveroutput: %@",serverOutput);
        //        alert = nil;
        //        [folder_table_data removeObjectAtIndex:selected_to_delete.row];
        //        [list_tab reloadData];
        //        //[list_tab deleteRowsAtIndexPaths:@[selected_to_delete] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }else if (checkFlag == 4)       //================================Copy Image Folder Tree===============
    {
        
        if([[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"file"])
        {
            
            //        KOTreeViewController *tree = [[KOTreeViewController alloc] init];
            //        tree.imageName = [[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"];
            //        tree.image_to_be_copy = [NSString stringWithFormat:@"%@",director_string];
            //        tree.type =@"COPY";
            //        CATransition* transition = [CATransition animation];
            //        transition.duration = 0.25;
            //        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            //        transition.type = kCATransitionMoveIn;
            //        transition.subtype = kCATransitionFromTop;
            //        [self.navigationController.view.layer addAnimation:transition forKey:nil];
            //        [self.navigationController pushViewController:tree animated:NO];
            
            
            
            //            checkFlag = 0;
            imageorfolder=1;
            
        }else{
            
            NSLog(@"ELSE IS AN IDIOT");
            
            deleteAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"This is not an image file" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [deleteAlert show];
            //            [self starttheftplisting];
            //            checkFlag=0;
            imageorfolder=0;
        }
        
        
    }
    if(selectedindex==indexPath.row && !(intial))
    {
        intial=YES;
        selectedindex = 0;
    }
    else
    {
        if(intial)
        {
            intial=NO;
        }
        intial=NO;
        selectedindex=indexPath.row;
    }
    
    [tableView reloadData];
    multiSelect = [[NSMutableArray alloc]init];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    listEntry = [[NSDictionary alloc] init];
    listEntry = [folder_table_data objectAtIndex:((NSUInteger) indexPath.row)];
    
    if (![[NSString stringWithFormat:@"%@",[listEntry objectForKey:@"type"]] isEqualToString:@"file"])
    {
        return NO;
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if([alertView tag]==99)
    {
        switch (buttonIndex) {
            case 0:
            {
                alert = nil;
                // [list_tab reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
                break;
            case 1:
            {
                @try{
                    
                    NSString *path = [NSString stringWithFormat:@"%@/%@",director_string,[[folder_table_data objectAtIndex:selected_to_delete.row] objectForKey:@"name"]];
                    NSString *thumb_path = [[NSString stringWithFormat:@"%@/%@",director_string,[[folder_table_data objectAtIndex:selected_to_delete.row] objectForKey:@"name"]]stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"];
                    NSString *encodedpath = [self encodeToPercentEscapeString:path];
                    NSString *thumb_encodedpath = [self encodeToPercentEscapeString:thumb_path];
                    
                    NSString *url_string = [NSString stringWithFormat:@"%@delete_image.php?path=%@",mydomainurl,encodedpath];
                    NSLog(@" url is %@",url_string);
                    NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: url_string ]];
                    
                    if (dataURL == nil)
                    {
                        alert = [[UIAlertView alloc] initWithTitle:@"Error in Server Connection!"
                                                           message:nil
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
                        [alert show];
                    }
                    else
                    {
                        
                        NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSUTF8StringEncoding];
                        NSLog(@"serveroutput: %@",serverOutput);
                        alert = nil;
                        [folder_table_data removeObjectAtIndex:selected_to_delete.row];
                        [list_tab reloadData];
                        //[list_tab deleteRowsAtIndexPaths:@[selected_to_delete] withRowAnimation:UITableViewRowAnimationFade];
                    }
                }
                @catch (NSException *exception) {
                    NSLog(@"exception dropbox: %@",exception);
                }
                @finally {
                }
                
            }
                break;
                selected_to_delete = nil;
        }
    }
    if(alertView.tag ==100)
    {
        switch (buttonIndex) {
            case 0:
                break;
            case 1:
            {
                NSString *selected_path=@"";
                if(!intial)
                {
                    NSDictionary *dict = [folder_table_data objectAtIndex:selectedindex];
                    selected_path = [NSString stringWithFormat:@"%@/%@",director_string,[dict objectForKey:@"name"]];
                }
                else
                {
                    selected_path = director_string;
                }
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
                {
                    NSString *copy_url = [NSString stringWithFormat:@"http://photo-xchange.com/photolist.php?path=%@",[selected_path  stringByRemovingPercentEncoding]];
                    copy_url = [copy_url stringByReplacingOccurrencesOfString:@".." withString:@""];
                    
                    UIPasteboard *pb = [UIPasteboard generalPasteboard];
                    [pb setString:[copy_url stringByReplacingOccurrencesOfString:@".." withString:@""]];
                }
                else
                {
                    NSString *copy_url = [NSString stringWithFormat:@"http://photo-xchange.com/photolist.php?path=%@",[selected_path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ]];
                    copy_url = [copy_url stringByReplacingOccurrencesOfString:@".." withString:@""];
                    
                    UIPasteboard *pb = [UIPasteboard generalPasteboard];
                    [pb setString:[copy_url stringByReplacingOccurrencesOfString:@".." withString:@""]];
                }
            }
                break;
        }
    }
    if(alertView.tag==101)
    {
        switch (buttonIndex) {
            case 0:
            {
                NSLog(@" Cancel ");
                [UIView transitionWithView: list_tab
                                  duration: 0.5f
                                   options: UIViewAnimationOptionTransitionCrossDissolve
                                animations: ^(void)
                 {
                     intial = YES;
                     //                     [list_tab setHidden:YES];
                     
                 }
                                completion: ^(BOOL isFinished)
                 {
                     //                 NSString *url_string = [NSString stringWithFormat:@"%@iosphoto_action.php?dir=%@",mydomainurl,[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                     //                [self new_reload:url_string];
                 }];
            }
                break;
            case 1:
            {
                [UIView transitionWithView: list_tab
                                  duration: 0.5f
                                   options: UIViewAnimationOptionTransitionCrossDissolve
                                animations: ^(void)
                 {
                     list_tab.hidden=YES;
                 }
                                completion: ^(BOOL isFinished)
                 {
                     NSString *url_string = [[NSString alloc] init];
                     
                     url_string = [NSString stringWithFormat:@"%@iosphoto_action.php?action=delete&dir=%@&folder_name=%@&thumb_dir=%@&file_type=%@&user_id=%@",mydomainurl,[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[thumb_new_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"type"],[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]];
                     NSLog(@" %@",url_string);
                     
                     [self new_reload:url_string];
                     about_details=NO;
                     intial=YES;
                     selectedindex = 0;
                 }];
            }
                break;
        }
    }
    if (deleteAlert.tag == 909) {
        
        if(buttonIndex == 0)
        {
            // Do something
        }
        else
        {
            // Some code
            NSLog(@"SELECTEDIMAGEEEEEEEEEEEEEEEEEE===>%@",selectedImage);
            
            @try{
                
                NSString *encodedimage =  [self encodeToPercentEscapeString:selectedImage];
                NSString *renameURL = [NSString stringWithFormat:@"%@photo_operation.php?action=delete_image&dir=%@&thumb_dir=%@&file=%@",mydomainurl, [director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[thumb_new_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],encodedimage];
                
                NSError *error;
                NSLog(@"FIRED URLlll===========================>%@",renameURL);
                NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:renameURL]options:NSDataReadingUncached error:&error];
                if (data == nil)
                {
                    alert = [[UIAlertView alloc] initWithTitle:@"Error in Server Connection!"
                                                       message:nil
                                                      delegate:self
                                             cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
                    [alert show];
                }
                else
                {
                    
                    NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data //1
                                        
                                                                       options:kNilOptions
                                        
                                                                         error:&error];
                    
                    NSLog(@"JSON==============>%@",[json objectForKey:@"msg"]);
                    
                    if ([[json objectForKey:@"msg"]  isEqual: @"success"]) {
                        
                        [self starttheftplisting];
                        UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Successfully deleted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [renameAlert show];
                        
                    }else{
                        
                        UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Unsucessfull" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [renameAlert show];
                    }
                }
            }
            @catch (NSException *exception) {
                NSLog(@"exception in ftp listing : %@",exception.description);
            }
            
            checkFlag=0;
        }
    }
}

//---------------------------UIButton MEthods -----------------------------------------------//
-(void)aboutediting:(UIButton *)sender
{
    switch (about_details) {
        case 0:
        {
            about_details = YES;
            [list_tab reloadRowsAtIndexPaths:[list_tab indexPathsForVisibleRows]
                            withRowAnimation:UITableViewRowAnimationFade];
        }
            break;
        case 1:
        {
            about_details = NO;
            [list_tab reloadRowsAtIndexPaths:[list_tab indexPathsForVisibleRows]
                            withRowAnimation:UITableViewRowAnimationFade];
        }
            break;
    }
}
-(void)newfolderactions:(UIButton *)sender
{
    [UIView transitionWithView: shadow_view
                      duration: 1.00f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
         [text_enter resignFirstResponder];
         shadow_view.hidden=YES;
         new_folder_view.hidden=YES;
         list_tab.userInteractionEnabled=YES;
         
     }
                    completion: ^(BOOL isFinished){
                        switch ([sender tag]) {
                            case 1:
                            {
                                NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
                                NSString *trimmed_string = [[text_enter text] stringByTrimmingCharactersInSet:whitespace];
                                
                                
                                //*********added by josph*********
                                
                                NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
                                BOOL valid = [[trimmed_string stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
                                
                                
                                if(trimmed_string !=nil)
                                {
                                    
                                    if([trimmed_string length]>0 && valid==YES)
                                    {
                                        list_tab.hidden=YES;
                                        [SVProgressHUD showSuccessWithStatus:@"Loading.."];
                                        NSString *url_string = [[NSString alloc] init];
                                        
                                        url_string = [NSString stringWithFormat:@"%@iosphoto_action.php?action=create&dir=%@&thumb_dir=%@&folder_name=%@&user_id=%@",mydomainurl,[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[thumb_new_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[text_enter.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]];
                                        NSLog(@" url is %@",url_string);
                                        [self new_reload:url_string];
                                        intial=YES;
                                        selectedindex = 0;
                                    }
                                    else
                                    {
                                        if([trimmed_string length]< 1)
                                        {
                                            [SVProgressHUD showErrorWithStatus:@"Please enter a valid name for the folder"];
                                        }
                                        else if(valid!=YES)
                                        {
                                            //                                        [SVProgressHUD showErrorWithStatus:@"Please enter only alphanumeric name for the folder"];
                                            UIAlertView *aphaAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter only alphanumeric name for the folder" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                            [aphaAlert show];
                                        }
                                        
                                    }
                                }
                                else
                                {
                                    [SVProgressHUD showErrorWithStatus:@"Please enter a valid name for the folder"];
                                }
                            }
                                break;
                            case 2:
                            {
                                @try{
                                    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
                                    NSString *trimmed_string = [[text_enter text] stringByTrimmingCharactersInSet:whitespace];
                                    
                                    NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
                                    BOOL valid = [[trimmed_string stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
                                    
                                    if([trimmed_string length]>0 && valid==YES)
                                    {
                                        //                                    list_tab.hidden=YES;
                                        NSLog(@"ghghghgh");
                                        NSString *url_string = [[NSString alloc] init];
                                        
                                        url_string = [NSString stringWithFormat:@"%@iosphoto_action.php?action=rename&dir=%@&thumb_dir=%@&old_name=%@&new_name=%@&user_id=%@",mydomainurl,[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[thumb_new_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[text_enter.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]];
                                        NSLog(@"url ta elo: %@",url_string);
                                        //==========xyz
                                        
                                        NSError *error=nil;
                                        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:url_string]options:NSDataReadingUncached error:&error];
                                        if (data == nil)
                                        {
                                            alert = [[UIAlertView alloc] initWithTitle:@"Error in Server Connection!"
                                                                               message:nil
                                                                              delegate:self
                                                                     cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
                                            [alert show];
                                        }
                                        else
                                        {
                                            
                                            
                                            NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data //1
                                                                
                                                                                               options:kNilOptions
                                                                
                                                                                                 error:&error];
                                            
                                            NSLog(@"DELETE FOLDER CHECK==============>%@",[json objectForKey:@"msg"]);
                                            
                                            if ([[json objectForKey:@"msg"]  isEqual: @"file with this name already exits"]) {
                                                
                                                UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Name already exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                [renameAlert show];
                                                
                                                
                                            }else if ([[json objectForKey:@"msg"]  isEqual: @"success"]){
                                                
                                                [self starttheftplisting];
                                                UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Successfully renamed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                [renameAlert show];
                                                text_enter.text = @"";
                                                
                                            }
                                            else
                                            {
                                                
                                                [self starttheftplisting];
                                                UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Unsuccessfull" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                [renameAlert show];
                                            }
                                            
                                            //==========
                                            
                                            intial=YES;
                                            selectedindex = 0;
                                        }
                                    }
                                    else
                                    {
                                        
                                        if([trimmed_string length]< 1)
                                        {
                                            [SVProgressHUD showErrorWithStatus:@"Please enter a valid name for the folder"];
                                        }
                                        else if(valid!=YES)
                                        {
                                            //[SVProgressHUD showErrorWithStatus:@"Please enter only alphanumeric name for the folder"];
                                            UIAlertView *aphaAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter only alphanumeric name for the folder" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                            [aphaAlert show];
                                        }
                                        
                                    }
                                    checkFlag=0;
                                }
                                @catch (NSException *exception) {
                                    NSLog(@"exception dropbox: %@",exception);
                                }
                                @finally {
                                }
                            }
                                
                                break;
                            case 3:
                            {
                                NSString *data_for_new_path = text_enter.text;
                                if([data_for_new_path length]==0||[data_for_new_path stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]==0||[data_for_new_path rangeOfString:[NSString stringWithFormat:@"../user/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]]].location == NSNotFound)
                                {
                                    [text_enter resignFirstResponder];
                                    [SVProgressHUD showErrorWithStatus:@"Please provide a proper path"];
                                    move=NO;
                                }
                                else
                                {
                                    NSString *url_string = [[NSString alloc] init];
                                    
                                    url_string = [NSString stringWithFormat:@"%@iosphoto_action.php?action=move&dir=%@&old_name=%@&new_name=%@&old_name_thumb=%@&new_name_thumb=%@",mydomainurl,[NSString stringWithFormat:@"../user/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]],[NSString stringWithFormat:@"%@/%@",director_string,[[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]],[NSString stringWithFormat:@"%@/%@",data_for_new_path,[[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]], [NSString stringWithFormat:@"%@/%@",thumb_new_path,[[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]],[NSString stringWithFormat:@"%@/%@",[data_for_new_path stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"],[[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                                    
                                    NSLog(@" url to move %@",url_string);
                                    [self new_reload:url_string];
                                    intial=YES;
                                    selectedindex = 0;
                                    move=NO;
                                }
                            }
                                break;
                            case 5:
                            {
                                
                                @try{
                                    
                                    NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
                                    BOOL valid = [[text_enter.text  stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
                                    
                                    if (![text_enter.text isEqualToString:@""] && valid==YES)
                                    {
                                        
                                        NSString *encodedText = [self encodeToPercentEscapeString:text_enter.text];
                                        
                                        extension = [selectedImage componentsSeparatedByString:[NSString stringWithFormat:@"."]];
                                        NSString *renameURL = [NSString stringWithFormat:@"%@photo_operation.php?action=rename_image&dir=%@&thumb_dir=%@&imageoriginal=%@&changetoimage=%@.%@",mydomainurl, [director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[thumb_new_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],selectedImage,encodedText,[extension objectAtIndex: extension.count-1]];
                                        NSError *error=Nil;
                                        NSLog(@"FIRED URLlll===========================>%@",renameURL);
                                        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:renameURL]options:NSDataReadingUncached error:&error];
                                        if (data == nil)
                                        {
                                            alert = [[UIAlertView alloc] initWithTitle:@"Error in Server Connection!"
                                                                               message:nil
                                                                              delegate:self
                                                                     cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
                                            [alert show];
                                        }
                                        else
                                        {
                                            
                                            NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data //1
                                                                
                                                                                               options:kNilOptions
                                                                
                                                                                                 error:&error];
                                            
                                            NSLog(@"JSON==============>%@",[json objectForKey:@"msg"]);
                                            
                                            if ([[json objectForKey:@"msg"]  isEqual: @"success"]) {
                                                
                                                [self starttheftplisting];
                                                UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Successfully renamed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                [renameAlert show];
                                                text_enter.text = @"";
                                                
                                            }else if ([[json objectForKey:@"msg"]  isEqual: @"file with this name already exits"]){
                                                
                                                UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Name already exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                [renameAlert show];
                                            }else{
                                                
                                                UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Unsuccessfull" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                [renameAlert show];
                                                
                                            }
                                            //                                NSLog(@"ACSHE=======>TEXT ENTER=%@=========SELECTED IMAGE=%@", text_enter.text,selectedImage);
                                            
                                            checkFlag=0;
                                        }
                                    }
                                    else
                                    {
                                        
                                        if([text_enter.text isEqualToString:@""])
                                        {
                                            deleteAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter a name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                            [deleteAlert show];
                                            [self starttheftplisting];
                                            checkFlag=0;
                                        }
                                        else if(valid!=YES)
                                        {
                                            UIAlertView *aphaAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter only alphanumeric name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                            [aphaAlert show];
                                            [self starttheftplisting];
                                            checkFlag=0;
                                        }
                                        
                                        
                                    }
                                }
                                @catch (NSException *exception) {
                                    NSLog(@"exception dropbox: %@",exception);
                                }
                                @finally {
                                }
                                
                            }
                                
                        }
                        
                    }];
}

-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = new_folder_view.frame;
    if (movedUp)
    {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
    }
    new_folder_view.frame = rect;
    [UIView commitAnimations];
}
-(void)navbaractions:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            shadow_view.hidden=NO;
            list_tab.userInteractionEnabled=NO;
            title_lbl_for_new_view.text = @"Folder Name";
            [UIView transitionWithView: new_folder_view
                              duration: 0.5f
                               options: UIViewAnimationOptionTransitionCrossDissolve
                            animations: ^(void)
             {
                 new_folder_view.hidden=NO;
                 ok_button.tag=1;
             }
                            completion: ^(BOOL isFinished){ [text_enter becomeFirstResponder];  }];
            text_enter.text = @"";
        }
            break;
        case 2:
        {
            switch (intial) {
                case 1:
                {
                    [SVProgressHUD showErrorWithStatus:@"Please select a folder to rename"];
                }
                    break;
                default:
                {
                    shadow_view.hidden=NO;
                    list_tab.userInteractionEnabled=NO;
                    title_lbl_for_new_view.text = @"Rename folder";
                    [UIView transitionWithView: new_folder_view
                                      duration: 0.5f
                                       options: UIViewAnimationOptionTransitionCrossDissolve
                                    animations: ^(void)
                     {
                         new_folder_view.hidden=NO;
                         text_enter.text=[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"];
                         ok_button.tag=2;
                     }
                                    completion: ^(BOOL isFinished){ [text_enter becomeFirstResponder];  }];
                    text_enter.text = @"";
                }
                    break;
            }
        }
            break;
        case 3:
        {
            switch (intial) {
                case 1:
                {
                    
                    [SVProgressHUD showErrorWithStatus:@"Please select a folder to move"];
                }
                    break;
                default:
                {
                    
                    KOTreeViewController *tree = [[KOTreeViewController alloc] init];
                    tree.folder_path_to_be_moved = [NSString stringWithFormat:@"%@/%@",director_string,[[[folder_table_data objectAtIndex:selectedindex] objectForKey:@"name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    tree.type =@"MOVE";
                    CATransition* transition = [CATransition animation];
                    transition.duration = 0.25;
                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    transition.type = kCATransitionMoveIn;
                    transition.subtype = kCATransitionFromTop;
                    [self.navigationController.view.layer addAnimation:transition forKey:nil];
                    [self.navigationController pushViewController:tree animated:NO];
                    move=NO;
                }
                    break;
            }
        }
            break;
        case 4:
        {
            switch (intial) {
                case 1:
                {
                    [SVProgressHUD showErrorWithStatus:@"Please select a folder to delete"];
                }
                    break;
                default:
                {
                    UIAlertView *alert_delete_confirm = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"This will permanently delete the folder. Do you want to do it?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                    [alert_delete_confirm setTag:101];
                    [alert_delete_confirm show];
                }
                    break;
            }
        }
            break;
    }
}
-(void)detailsaboutfolder:(UIButton *)sender
{
    
    //    NSDictionary *albumThumb = [[NSDictionary alloc] init];
    //    albumThumb = [folder_table_data objectAtIndex:((NSUInteger) indexPath.row)];
    //
    //    if (![[NSString stringWithFormat:@"%@",[albumThumb objectForKey:@"type"]] isEqualToString:@"file"])
    //    {
    //        return NO;
    //    }
    //    return YES;
    
    self.selectedIndexPaths = [[NSMutableArray alloc]init];
    
    prev_directory = [[NSString alloc] init];
    prev_directory = director_string;
    director_string = [NSString stringWithFormat:@"%@/%@",prev_directory,[[folder_table_data objectAtIndex:[sender tag]] objectForKey:@"name"]];
    [folder_path_array addObject:prev_directory];
    thumb_new_path = [director_string stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"];
    
    [UIView transitionWithView: list_tab
     
                      duration: 0.5f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
         list_tab.hidden=YES;
     }
                    completion: ^(BOOL isFinished)
     {
         [SVProgressHUD showSuccessWithStatus:@"Loading.."];
         NSString *url_string = [[NSString alloc] init];
         url_string = [NSString stringWithFormat:@"%@iosphoto_actiontest.php?dir=%@",mydomainurl,[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
         if (![[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isKindOfClass:[NSNull class]] && [[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] length] != 0)
         {
             [self new_reload:url_string];
             about_details=NO;
             about_details = YES;
             intial_click_on_go_back = YES;
             intial=YES;
             selectedindex = 0;
         }
         //                        [SVProgressHUD showSuccessWithStatus:@"Loading.."];
         //                        NSString *url_string = [[NSString alloc] init];
         //                        url_string = [NSString stringWithFormat:@"%@iosphoto_action.php?dir=%@",mydomainurl,[director_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
         //                        stringImage = [NSString stringWithFormat:@"%@/user/%@/%@",parent_url_for_ftp_image_listing,[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"],[[folder_table_data objectAtIndex:[sender tag]] objectForKey:@"name"]];
         ////                        stringImage = [NSString stringWithFormat:@"%@/user/%@",parent_url_for_ftp_image_listing,[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]];
         //                        NSLog(@"directorString=======>%@",director_string);
         //                        NSLog(@"stringImage==========>%@",stringImage);
         //                         [self new_reload:url_string];
         //                        about_details=NO;
         //                        about_details = YES;
         //                        intial_click_on_go_back = YES;
         //                        intial=YES;
         //                        selectedindex = 0;
         
     }];
}

-(void)goBack:(id)sender
{
    checkFlag = 0;
    NSLog(@"just go-back");
    self.selectedIndexPaths = [[NSMutableArray alloc]init];
    move=NO;
    switch (shadow_view.hidden) {
        case 0:
        {
            [UIView transitionWithView: shadow_view
                              duration: 1.00f
                               options: UIViewAnimationOptionTransitionCrossDissolve
                            animations: ^(void)
             {
                 [text_enter resignFirstResponder];
                 shadow_view.hidden=YES;
                 new_folder_view.hidden=YES;
                 list_tab.userInteractionEnabled=YES;
                 ok_button.tag=0;
             }
                            completion: ^(BOOL isFinished){
                            }];
        }
            break;
        default:
        {
            switch (about_details) {
                case 1:
                {
                    about_details=NO;
                    
                    director_string = prev_directory;
                    thumb_new_path = [director_string stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"];
                    
                    NSString *url_string = [[NSString alloc] init];
                    url_string = [NSString stringWithFormat:@"%@iosphoto_actiontest.php?dir=%@",mydomainurl,[prev_directory stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    if (![[prev_directory stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isKindOfClass:[NSNull class]] && [[prev_directory stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] length] != 0)
                    {
                        [self new_reload:url_string];
                        intial=YES;
                        selectedindex = 0;
                    }
                }
                    break;
                default:
                {
                    about_details = NO;
                    [list_tab removeFromSuperview];
                    CATransition* transition = [CATransition animation];
                    transition.duration = 0.5;
                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    transition.type = kCATransitionFade;
                    [self.navigationController.view.layer addAnimation:transition forKey:nil];
                    [self.navigationController popViewControllerAnimated:NO];
                }
                    break;
            }
        }
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(!shadow_view.hidden)
    {
        [UIView transitionWithView: shadow_view
                          duration: 1.00f
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        animations: ^(void)
         {
             [text_enter resignFirstResponder];
             shadow_view.hidden=YES;
             new_folder_view.hidden=YES;
             list_tab.userInteractionEnabled=YES;
             ok_button.tag=0;
         }
                        completion: ^(BOOL isFinished){
                        }];
    }
    if(move)
    {
        NSString *data_for_new_path = textField.text;
        if([data_for_new_path length]==0||[data_for_new_path stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]==0||[data_for_new_path rangeOfString:[NSString stringWithFormat:@"../user/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]]].location == NSNotFound)
        {
            [SVProgressHUD showErrorWithStatus:@"Please provide a proper path"];
            move=NO;
        }
    }
    return YES;
}
-(void)moveToFTP:(ELCImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // selected_to_delete = [NSIndexPath indexPathForRow:[[gestureRecognizer view] tag] inSection:0];
        // NSLog(@" tag is %d",[[gestureRecognizer view] tag]); if(alert ==nil)
        // {
        // alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"This will permanently remove photo from your folder. Do you want to go with it?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        // alert.tag = 99;
        // [alert show];
        // }
        
        if([[[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"file"])
        {
            
            selectedImage = [[folder_table_data objectAtIndex:indexPath.row] objectForKey:@"name"];
            deleteAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Do you want to delete the image" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            [deleteAlert setTag:909];
            [deleteAlert show];
            
        }
        
    }
}

-(void) tapSingle:(UITapGestureRecognizer *)sender{
    
}

- (void)addOrRemoveSelectedIndexPath:(NSIndexPath *)indexPath
{
    
    //            self.selectedIndexPaths = [[NSMutableArray alloc]init];
    //
    //        [self.selectedIndexPaths addObject:indexPath];
    //
    //    [list_tab reloadRowsAtIndexPaths:@[indexPath]
    //                       withRowAnimation:UITableViewRowAnimationFade];
    
    
    
    
    if (!self.selectedIndexPaths) {
        self.selectedIndexPaths = [NSMutableArray new];
    }
    
    if ([[[folder_table_data objectAtIndex:indexPath.row]objectForKey:@"type"] isEqualToString:@"directory"])
    {
        NSLog(@"self.selectedindexpaths initial initial");
        
        //        self.selectedIndexPaths = [[NSMutableArray alloc]init];
        //        [self.selectedIndexPaths addObject:indexPath];
        BOOL containsIndexPath = [self.selectedIndexPaths containsObject:indexPath];
        
        if (containsIndexPath) {
            [self.selectedIndexPaths removeObject:indexPath];
        }else{
            self.selectedIndexPaths = [[NSMutableArray alloc]init];
            [self.selectedIndexPaths addObject:indexPath];
        }
        
    }
    else
    {
        BOOL containsIndexPath = [self.selectedIndexPaths containsObject:indexPath];
        
        if (containsIndexPath) {
            [self.selectedIndexPaths removeObject:indexPath];
        }else{
            [self.selectedIndexPaths addObject:indexPath];
        }
    }
    [list_tab reloadRowsAtIndexPaths:@[indexPath]
                    withRowAnimation:UITableViewRowAnimationFade];
    
    NSLog(@"self.selectedindexpaths: %@",self.selectedIndexPaths);
}

-(void)doneto:(UIButton *)sender{
    
    nav_bar.hidden = NO;
    tempHeader.hidden = YES;
    if ([multiSelect count] == 0)
    {
        UIAlertView *alert_confirm = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Image has been selected!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
        alert_confirm.tag=130;
        [alert_confirm show];
    }
    else
    {
        KOTreeViewController *tree = [[KOTreeViewController alloc] init];
        tree.imageName = [multiSelect componentsJoinedByString:@","];
        NSLog(@"tree.imageName: %@",tree.imageName);
        tree.image_to_be_copy = [NSString stringWithFormat:@"%@",director_string];
        tree.type =@"COPY";
        CATransition* transition = [CATransition animation];
        transition.duration = 0.25;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:tree animated:NO];
    }
    checkFlag = 0;
    
}

-(NSString*) encodeToPercentEscapeString:(NSString *)string {
    return (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                              (CFStringRef) string,
                                                              NULL,
                                                              (CFStringRef) @"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
}

-(NSString*) decodeFromPercentEscapeString:(NSString *)string {
    return (NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                              (CFStringRef) string,
                                                                              CFSTR(""),
                                                                              kCFStringEncodingUTF8));
}
@end