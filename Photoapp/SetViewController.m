//  SetViewController.m
//  Photoapp
//  Created by Admin on 12/08/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
#import "WebViewViewController.h"
#import "RTLabel.h"
#import "SetViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "HomeViewController.h"
@interface SetViewController ()<RTLabelDelegate>
{
    UIImageView *img;
    UIButton *backButton;
    UILabel *headerlabel,*title_label;
    UIView *extraview,*shadowView;
    NSString *appVersion;
}
@end
@implementation SetViewController
@synthesize tableview;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad
{
    //self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)firewebview:(UIGestureRecognizer *)sender
{
    NSString *stng2a = [NSString stringWithFormat:@"http://photo-xchange.com/faq.php"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stng2a]];
}

- (void) orientationChanged:(NSNotification *)note
{
    [tableview reloadData];
    UIDevice * device = note.object;
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(device.orientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    NSLog(@"portrait");
                    //                     shadowView.frame= CGRectMake(10,45,300,130) ;
                    [shadowView removeFromSuperview];
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    
                    if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,-45,300,130)] ;
                    }
                    else if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0f)
                    {
                        NSLog(@"7.0 iphone orientation portrait");
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,45,300,130)] ;
                    }

                    else
                    {
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,-10,300,130)] ;
                    }
                    [self.view addSubview:shadowView];
                    shadowView.autoresizesSubviews=YES;
                    shadowView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
                    shadowView.backgroundColor = [UIColor clearColor];
                    shadowView.userInteractionEnabled=YES;
                    
                    if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                        NSLog(@"at 7.1");
                       title_label = [[UILabel alloc] initWithFrame:CGRectMake(0,35, 300, 130)];
                    }
                    else if ([[UIDevice currentDevice].systemVersion intValue] == 7)
                    {
                        NSLog(@"at 7");
                        title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 130)];
                    }
                    else
                    {
                        title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 130)];
                    }
                    [self.view addSubview:shadowView];
                    
                    
                   // title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 130)];
                    //    [title_label setDelegate:self];
                    [title_label setNumberOfLines:6];
                    //    title_label.lineSpacing = 0.0;
                    title_label.font=[UIFont systemFontOfSize:13];
                    
                    //                    [title_label setText:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];
                    //                    [title_label setTextColor:[UIColor whiteColor]];
                    
                    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,120)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(120,4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(124,79)];
                    
                    title_label.attributedText = string;
                    
                    title_label.backgroundColor=[UIColor clearColor];
                    [shadowView addSubview:title_label];
                    
                    shadowView.layer.shadowColor = [[UIColor blackColor] CGColor];
                    shadowView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
                    shadowView.layer.shadowRadius = 3.0f;
                    shadowView.layer.shadowOpacity = 1.0f;
                    
                    [extraview removeFromSuperview];
                    if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1)
                    {
                        NSLog(@"portrait 7.1");
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, self.view.bounds.size.height-100)];
                    }

                    
                   else if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0)
                    {
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 160, 300, self.view.bounds.size.height-170)];
                    }
                    else
                    {
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, self.view.bounds.size.height-110)];
                    }
                    [self.view addSubview:extraview];
                    
                    extraview.backgroundColor=[UIColor clearColor];
                    
                    extraview.layer.cornerRadius=7;
                    extraview.layer.borderColor=[[UIColor whiteColor]CGColor];
                    extraview.layer.borderWidth=1.5f;
                    
                    
                    [tableview removeFromSuperview];
                    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, extraview.frame.size.height)];
                    tableview.delegate=self;
                    tableview.dataSource=self;
                    tableview.backgroundColor = [UIColor clearColor];
                    tableview.scrollEnabled=YES;
                    //    [tableview setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    tableview.separatorColor = [UIColor blackColor];
                    tableview.contentInset = UIEdgeInsetsZero;
                    [extraview addSubview:tableview];
                    
                    [tableview setContentOffset:CGPointMake(0, 0) animated: NO];
                    
                    shadowView.userInteractionEnabled=YES;
                    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firewebview:)];
                    gesture.delegate=self;
                    [shadowView addGestureRecognizer:gesture];
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                case UIDeviceOrientationLandscapeRight:
                {
                    NSLog(@"landscape");
                    //                  shadowView.frame= CGRectMake(134,45,300,130) ;
                    [shadowView removeFromSuperview];
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                        NSLog(@"here 7.1 ladscape");
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,0,self.view.bounds.size.width-20,100)] ;
                    }

                    
                    else if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0f)
                    {
                         NSLog(@"here 7 ladscape");
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,30,self.view.bounds.size.width-20,100)] ;
                    }
                    else
                    {
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,-15,self.view.bounds.size.width-20,100)] ;
                    }
                    [self.view addSubview:shadowView];
                    
                    //                    shadowView  =  [[UIView alloc] initWithFrame: CGRectMake((self.view.bounds.size.width-300)/2,45,300,130)] ;
                    [self.view addSubview:shadowView];
                    shadowView.autoresizesSubviews=YES;
                    shadowView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
                    shadowView.backgroundColor = [UIColor clearColor];
                    shadowView.userInteractionEnabled=YES;
                    
                    
                    if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                         NSLog(@"at 7.1");
                        title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, -10, shadowView.frame.size.width, shadowView.frame.size.height)];
                    }
                    else if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0f)
                    {
                         NSLog(@"at 7");
                        title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    }
                    else
                    {
                        title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    }
                    [self.view addSubview:shadowView];
                    
                    
                   // title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    //    [title_label setDelegate:self];
                    [title_label setNumberOfLines:6];
                    //    title_label.lineSpacing = 0.0;
                    title_label.font=[UIFont systemFontOfSize:13];
                    //                    [title_label setText:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];
                    //                    [title_label setTextColor:[UIColor whiteColor]];
                    
                    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,120)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(120,4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(124,79)];
                    
                    title_label.attributedText = string;
                    
                    title_label.backgroundColor=[UIColor clearColor];
                    [shadowView addSubview:title_label];
                    
                    shadowView.layer.shadowColor = [[UIColor blackColor] CGColor];
                    shadowView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
                    shadowView.layer.shadowRadius = 3.0f;
                    shadowView.layer.shadowOpacity = 1.0f;
                    
                    [extraview removeFromSuperview];
                    //                  extraview = [[UIView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-300)/2, 160, 300, 150)];
                    if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                        NSLog(@"orientation me ladscape 7.1");
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10,80, self.view.bounds.size.width-20, self.view.bounds.size.height-90)];
                    }
                    else if ([[UIDevice currentDevice].systemVersion intValue] == 7.0f)
                    {
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 115, self.view.bounds.size.width-20, self.view.bounds.size.height-120)];
                    }
                    else
                    {
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 65, self.view.bounds.size.width-20, self.view.bounds.size.height-75)];
                    }
                    
                    [self.view addSubview:extraview];
                    
                    extraview.backgroundColor=[UIColor clearColor];
                    extraview.layer.cornerRadius=7;
                    extraview.layer.borderColor=[[UIColor whiteColor]CGColor];
                    extraview.layer.borderWidth=1.5f;
                    
                    [tableview removeFromSuperview];
                    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, extraview.frame.size.width, extraview.frame.size.height)];
                    tableview.delegate=self;
                    tableview.dataSource=self;
                    tableview.backgroundColor = [UIColor clearColor];
                    tableview.scrollEnabled=YES;
                    //    [tableview setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    tableview.separatorColor = [UIColor blackColor];
                    tableview.contentInset = UIEdgeInsetsZero;
                    [extraview addSubview:tableview];
                    [tableview setContentOffset:CGPointMake(0, 0) animated: NO];
                    
                    shadowView.userInteractionEnabled=YES;
                    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firewebview:)];
                    gesture.delegate=self;
                    [shadowView addGestureRecognizer:gesture];
                }
                    break;
            }
        }
            break;
            
            ///////////////////////////////////////////////////      IPAD IPAD     /////////////////////////////////////////////////////////////////
        case UIUserInterfaceIdiomPad:
        {
            switch(device.orientation)
            {
                    CGFloat width_tbl,height_tbl;
                    
                case UIInterfaceOrientationLandscapeLeft:
                case UIInterfaceOrientationLandscapeRight:
                {
                    width_tbl = [[UIScreen mainScreen]bounds].size.height;
                    height_tbl = [[UIScreen mainScreen]bounds].size.width;
                    
                    [shadowView removeFromSuperview];
                    
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                        NSLog(@"orientation e ladscape ipad 7.1");
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,10,width_tbl-20,100)] ;
                    }
                    else if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0f)
                    {
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,45,width_tbl-20,100)] ;
                    }
                    else
                    {
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,-15,width_tbl-20,100)] ;
                    }
                    
                    //              shadowView  =  [[UIView alloc] initWithFrame: CGRectMake((width_tbl-500)/2,45,500,130)] ;
                    [self.view addSubview:shadowView];
                    
                    shadowView.autoresizesSubviews=YES;
                    shadowView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
                    shadowView.backgroundColor = [UIColor clearColor];
                    shadowView.userInteractionEnabled=YES;
                    title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    //    [title_label setDelegate:self];
                    [title_label setNumberOfLines:7];
                    //    title_label.lineSpacing = 0.0;
                    title_label.font=[UIFont systemFontOfSize:16];
                    //                [title_label setText:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];
                    //                [title_label setTextColor:[UIColor whiteColor]];
                    
                    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,120)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(120,4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(124,79)];
                    
                    title_label.attributedText = string;
                    
                    title_label.backgroundColor=[UIColor clearColor];
                    [shadowView addSubview:title_label];
                    
                    shadowView.layer.shadowColor = [[UIColor blackColor] CGColor];
                    shadowView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
                    shadowView.layer.shadowRadius = 3.0f;
                    shadowView.layer.shadowOpacity = 1.0f;
                    
                    [extraview removeFromSuperview];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 130, width_tbl-20, 525)];
                    }
                    else
                    {
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 70, width_tbl-20, 525)];
                    }
                    
                    //                extraview= [[UIView alloc]initWithFrame:CGRectMake((width_tbl-500)/2, 160, 500, 525)];
                    [self.view addSubview:extraview];
                    
                    extraview.backgroundColor=[UIColor clearColor];
                    extraview.layer.cornerRadius=7;
                    extraview.layer.borderColor=[[UIColor whiteColor]CGColor];
                    extraview.layer.borderWidth=1.5f;
                    
                    
                    [tableview removeFromSuperview];
                    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, extraview.frame.size.width, extraview.frame.size.height)];
                    tableview.delegate=self;
                    tableview.dataSource=self;
                    tableview.backgroundColor = [UIColor clearColor];
                    tableview.scrollEnabled=YES;
                    //    [tableview setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    tableview.separatorColor = [UIColor blackColor];
                    tableview.contentInset = UIEdgeInsetsZero;
                    [extraview addSubview:tableview];
                    [tableview setContentOffset:CGPointMake(0, 0) animated: NO];
                    
                    //    shadowView.frame= CGRectMake(134,45,300,130) ;
                    //    [shadowView removeFromSuperview];
                    shadowView.userInteractionEnabled=YES;
                    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firewebview:)];
                    gesture.delegate=self;
                    [shadowView addGestureRecognizer:gesture];
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                case UIInterfaceOrientationPortrait:
                {
                    height_tbl = [[UIScreen mainScreen]bounds].size.height;
                    width_tbl = [[UIScreen mainScreen]bounds].size.width;
                    
                    [shadowView removeFromSuperview];
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    
                    if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                        NSLog(@"orientation e portrain 7.1 ipad");
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,10,width_tbl-20,100)] ;
                    }
                    else if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0f)
                    {
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,45,width_tbl-20,100)] ;
                    }
                    else
                    {
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,-15,width_tbl-20,100)] ;
                    }
                    
                    //                shadowView  =  [[UIView alloc] initWithFrame: CGRectMake((width_tbl-500)/2,45,500,130)] ;
                    [self.view addSubview:shadowView];
                    
                    shadowView.autoresizesSubviews=YES;
                    shadowView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
                    shadowView.backgroundColor = [UIColor clearColor];
                    shadowView.userInteractionEnabled=YES;
                    title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    //    [title_label setDelegate:self];
                    [title_label setNumberOfLines:7];
                    //    title_label.lineSpacing = 0.0;
                    title_label.font=[UIFont systemFontOfSize:16];
                    //                [title_label setText:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];  //<a href='http://photo-xchange.com/User_Guideline.pdf'>here</a>
                    //                [title_label setTextColor:[UIColor whiteColor]];
                    
                    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,120)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(120,4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(124,79)];
                    
                    title_label.attributedText = string;
                    
                    title_label.backgroundColor=[UIColor clearColor];
                    [shadowView addSubview:title_label];
                    
                    shadowView.layer.shadowColor = [[UIColor blackColor] CGColor];
                    shadowView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
                    shadowView.layer.shadowRadius = 3.0f;
                    shadowView.layer.shadowOpacity = 1.0f;
                    
                    
                    [extraview removeFromSuperview];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 130, width_tbl-20, 525)];
                    }
                    else
                    {
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 70, width_tbl-20, 525)];
                    }
                    
                    //                extraview= [[UIView alloc]initWithFrame:CGRectMake((width_tbl-500)/2, 160, 500, 525)];
                    [self.view addSubview:extraview];
                    extraview.backgroundColor=[UIColor clearColor];
                    extraview.layer.cornerRadius=7;
                    extraview.layer.borderColor=[[UIColor whiteColor]CGColor];
                    extraview.layer.borderWidth=1.5f;
                    
                    [tableview removeFromSuperview];
                    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, extraview.frame.size.width, extraview.frame.size.height)];
                    tableview.delegate=self;
                    tableview.dataSource=self;
                    tableview.backgroundColor = [UIColor clearColor];
                    tableview.scrollEnabled=YES;
                    //    [tableview setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    tableview.separatorColor = [UIColor blackColor];
                    tableview.contentInset = UIEdgeInsetsZero;
                    [extraview addSubview:tableview];
                    [tableview setContentOffset:CGPointMake(0, 0) animated: NO];
                    //           shadowView.frame= CGRectMake(10,45,300,130) ;
                    shadowView.userInteractionEnabled=YES;
                    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firewebview:)];
                    gesture.delegate=self;
                    [shadowView addGestureRecognizer:gesture];
                }
                    break;
            }
        }
            break;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]];
    
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[ver objectAtIndex:0] floatValue] >= 7)
    {
         NSLog(@"1st version %f",[[UIDevice currentDevice].systemVersion floatValue]);
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar@2x.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bar.png"] forBarMetrics:nil];
    }
    [self.navigationItem setTitle:@"Settings"];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                           UITextAttributeFont: [UIFont fontWithName:@"MyriadPro-Bold" size:18.5],
                                                           }];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBarHidden = NO;
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
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
    [button addTarget:self action:@selector(gotoback:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
    
    CGFloat width_tbl,height_tbl;
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch (self.interfaceOrientation) {
                case UIInterfaceOrientationLandscapeLeft:
                case UIInterfaceOrientationLandscapeRight:
                {
                    width_tbl = [[UIScreen mainScreen]bounds].size.height;
                    height_tbl = [[UIScreen mainScreen]bounds].size.width;
                    NSLog(@"1st");
                    NSLog(@"%f",[[UIDevice currentDevice].systemVersion floatValue]);
                    [shadowView removeFromSuperview];
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                   
                    
                    if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                        NSLog(@"view me landscape here 7.1");
                         shadowView=[[UIView alloc] initWithFrame:CGRectMake(10,-50,width_tbl-50,100)];
                        
                    }
                    else if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0f)
                    {
                       NSLog(@"view me landscape here 7.0");
                       shadowView=[[UIView alloc] initWithFrame:CGRectMake(10,30,width_tbl-20,100)];
                    }
                    else
                    {
                         NSLog(@"view me landscape here 6.1");
                        shadowView=[[UIView alloc] initWithFrame:CGRectMake(10,-15,width_tbl-20,100)];
                    }
                    [self.view addSubview:shadowView];
                    
                    shadowView.autoresizesSubviews=YES;
                    shadowView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
                    shadowView.backgroundColor = [UIColor clearColor];
                    shadowView.userInteractionEnabled=YES;
                    
                    
                    if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                        NSLog(@"at 7.1");
                        title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, shadowView.frame.size.width, shadowView.frame.size.height)];
                    }
                    else if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0f)
                    {
                        NSLog(@"at 7");
                        title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    }
                    else
                    {
                        title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    }
                    [self.view addSubview:shadowView];
                    
                    
                    
                    
                    
                    
                   // title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    //    [title_label setDelegate:self];
                    [title_label setNumberOfLines:3];
                    //    title_label.lineSpacing = 0.0;
                    title_label.font=[UIFont systemFontOfSize:13];
                    //            [title_label setText:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];
                    //            [title_label setTextColor:[UIColor whiteColor]];
                    
                    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,120)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(120,4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(124,79)];
                    
                    title_label.attributedText = string;
                    title_label.backgroundColor=[UIColor clearColor];
                    [shadowView addSubview:title_label];
                    
                    shadowView.layer.shadowColor = [[UIColor blackColor] CGColor];
                    shadowView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
                    shadowView.layer.shadowRadius = 3.0f;
                    shadowView.layer.shadowOpacity = 1.0f;
                    
                    [extraview removeFromSuperview];
                    
                   if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10,95, width_tbl-20, height_tbl-160)];
                    }
                    else if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0f)
                    {
                        NSLog(@"view for tble in 7.0");
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 115, width_tbl-20, height_tbl-120)];
                    }
                    else
                    {
                        NSLog(@"6.1 e table");
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 70, width_tbl-20, height_tbl-130)];
                    }
                    [self.view addSubview:extraview];
                    
                    extraview.backgroundColor=[UIColor clearColor];
                    extraview.layer.cornerRadius=7;
                    extraview.layer.borderColor=[[UIColor whiteColor]CGColor];
                    extraview.layer.borderWidth=1.5f;
                    
                    [tableview removeFromSuperview];
                    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, extraview.frame.size.width, extraview.frame.size.height)];
                    tableview.delegate=self;
                    tableview.dataSource=self;
                    tableview.backgroundColor = [UIColor clearColor];
                    tableview.scrollEnabled=YES;
                    //    [tableview setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    tableview.separatorColor = [UIColor blackColor];
                    tableview.contentInset = UIEdgeInsetsZero;
                    [extraview addSubview:tableview];
                    [tableview setContentOffset:CGPointMake(0, 0) animated: NO];
                    
                    //            shadowView.frame= CGRectMake(134,45,300,130) ;
                    //            [shadowView removeFromSuperview];
                    shadowView.userInteractionEnabled=YES;
                    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firewebview:)];
                    gesture.delegate=self;
                    [shadowView addGestureRecognizer:gesture];
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                case UIInterfaceOrientationPortrait:
                {
                    height_tbl = [[UIScreen mainScreen]bounds].size.height;
                    width_tbl = [[UIScreen mainScreen]bounds].size.width;
                     NSLog(@"2nd");
                    [shadowView removeFromSuperview];
                    
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                   if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,0,300,100)] ;
                    }
                    else if ([[UIDevice currentDevice].systemVersion intValue] == 7)
                    {
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,45,300,130)] ;
                    }
                    else
                    {
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,-15,300,130)] ;
                    }
                    [self.view addSubview:shadowView];
                    
                    shadowView.autoresizesSubviews=YES;
                    shadowView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
                    shadowView.backgroundColor = [UIColor clearColor];
                    shadowView.userInteractionEnabled=YES;
                    
                    if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                        NSLog(@"at 7.1");
                        title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    }
                    else if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0f)
                    {
                        NSLog(@"at 7");
                        title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    }
                    else
                    {
                        title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    }
                    [self.view addSubview:shadowView];
                    
                    
                    
                    
                    
                    
                    //    [title_label setDelegate:self];
                    [title_label setNumberOfLines:6];
                    //    title_label.lineSpacing = 0.0;
                    title_label.font=[UIFont systemFontOfSize:13];
                    //            [title_label setText:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."]; //<a href='http://photo-xchange.com/User_Guideline.pdf'>here</a>
                    //
                    //            [title_label setTextColor:[UIColor whiteColor]];
                    
                    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,120)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(120,4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(124,79)];
                    
                    title_label.attributedText = string;
                    title_label.backgroundColor=[UIColor clearColor];
                    [shadowView addSubview:title_label];
                    
                    shadowView.layer.shadowColor = [[UIColor clearColor] CGColor];
                    shadowView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
                    shadowView.layer.shadowRadius = 3.0f;
                    shadowView.layer.shadowOpacity = 1.0f;
                    
                    
                    [extraview removeFromSuperview];
                    
                    if ([[UIDevice currentDevice].systemVersion floatValue]  == 7.1f)
                    {
                        NSLog(@"potrait 7.1 view");
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10,100, 300, height_tbl-180)];
                    }
                    else if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0f)
                    {
                        NSLog(@"7.0 iphone portrait view");
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 160, 300, height_tbl-170)];
                    }
                    else
                    {
                        NSLog(@"ekahene");
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 100, 300, height_tbl-170)];
                    }
                    
                    [self.view addSubview:extraview];
                    extraview.backgroundColor=[UIColor clearColor];
                    extraview.layer.cornerRadius=7;
                    extraview.layer.borderColor=[[UIColor whiteColor]CGColor];
                    extraview.layer.borderWidth=1.5f;
                    
                    [tableview removeFromSuperview];
                    
                    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, extraview.frame.size.height)];
                    tableview.delegate=self;
                    tableview.dataSource=self;
                    tableview.backgroundColor = [UIColor clearColor];
                    tableview.scrollEnabled=YES;
                    //    [tableview setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    tableview.separatorColor = [UIColor blackColor];
                    tableview.contentInset = UIEdgeInsetsZero;
                    [extraview addSubview:tableview];
                    
                    [tableview setContentOffset:CGPointMake(0, 0) animated: NO];
                    //           shadowView.frame= CGRectMake(10,45,300,130) ;
                    
                    shadowView.userInteractionEnabled=YES;
                    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firewebview:)];
                    gesture.delegate=self;
                    [shadowView addGestureRecognizer:gesture];
                }
                    break;
            }
        }
            break;
            
        case UIUserInterfaceIdiomPad:
        {
            switch (self.interfaceOrientation) {
                case UIInterfaceOrientationLandscapeLeft:
                case UIInterfaceOrientationLandscapeRight:
                {
                    width_tbl = [[UIScreen mainScreen]bounds].size.height;
                    height_tbl = [[UIScreen mainScreen]bounds].size.width;
                     NSLog(@"3rd");
                    [shadowView removeFromSuperview];
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                        NSLog(@"ipad view 7.1 landscape");
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,10,self.view.frame.size.width-20,100)] ;
                    }
                    else if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0f)
                    {
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,45,self.view.frame.size.width-20,100)] ;
                    }
                    else
                    {
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,-15,self.view.frame.size.width-20,100)] ;
                    }
                    //                    shadowView  =  [[UIView alloc] initWithFrame: CGRectMake((1024-500)/2,45,500,130)] ;
                    [self.view addSubview:shadowView];
                    
                    
                    shadowView.autoresizesSubviews=YES;
                    shadowView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
                    shadowView.backgroundColor = [UIColor clearColor];
                    shadowView.userInteractionEnabled=YES;
                    
                    
                    if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                        NSLog(@"at 7.1");
                        title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    }
                    else if ([[UIDevice currentDevice].systemVersion intValue] == 7)
                    {
                        NSLog(@"at 7");
                        title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    }
                    else
                    {
                        title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    }
                    [self.view addSubview:shadowView];
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                   // title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    //    [title_label setDelegate:self];
                    [title_label setNumberOfLines:7];
                    //    title_label.lineSpacing = 0.0;
                    title_label.font=[UIFont systemFontOfSize:16];
                    //                    [title_label setText:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];
                    //                    [title_label setTextColor:[UIColor whiteColor]];
                    
                    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,120)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(120,4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(124,79)];
                    
                    title_label.attributedText = string;
                    
                    title_label.backgroundColor=[UIColor clearColor];
                    [shadowView addSubview:title_label];
                    
                    shadowView.layer.shadowColor = [[UIColor blackColor] CGColor];
                    shadowView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
                    shadowView.layer.shadowRadius = 3.0f;
                    shadowView.layer.shadowOpacity = 1.0f;
                    
                    [extraview removeFromSuperview];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 130, width_tbl-20, 525)];
                    }
                    else
                    {
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 70, width_tbl-20, 525)];
                    }
                    //                    extraview= [[UIView alloc]initWithFrame:CGRectMake((width_tbl-500)/2, 160, 500, 525)];
                    [self.view addSubview:extraview];
                    
                    extraview.backgroundColor=[UIColor clearColor];
                    extraview.layer.cornerRadius=3;
                    extraview.layer.borderColor=[[UIColor whiteColor]CGColor];
                    extraview.layer.borderWidth=1.5f;
                    
                    [tableview removeFromSuperview];
                    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, extraview.frame.size.width, extraview.frame.size.height)];
                    tableview.delegate=self;
                    tableview.dataSource=self;
                    tableview.backgroundColor = [UIColor clearColor];
                    tableview.scrollEnabled=YES;
                    //    [tableview setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    tableview.separatorColor = [UIColor blackColor];
                    tableview.contentInset = UIEdgeInsetsZero;
                    [extraview addSubview:tableview];
                    [tableview setContentOffset:CGPointMake(0, 0) animated: NO];
                    
                    //            shadowView.frame= CGRectMake(134,45,300,130) ;
                    //            [shadowView removeFromSuperview];
                    shadowView.userInteractionEnabled=YES;
                    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firewebview:)];
                    gesture.delegate=self;
                    [shadowView addGestureRecognizer:gesture];
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                case UIInterfaceOrientationPortrait:
                {
                    height_tbl = [[UIScreen mainScreen]bounds].size.height;
                    width_tbl = [[UIScreen mainScreen]bounds].size.width;
                     NSLog(@"4th");
                    [shadowView removeFromSuperview];
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    
                    if ([[UIDevice currentDevice].systemVersion floatValue] == 7.1f)
                    {
                        NSLog(@"ipad e 7.1 portrait");
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,10,width_tbl-20,100)] ;
                    }
                    else if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0f)
                    {
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,45,width_tbl-20,100)] ;
                    }
                    else
                    {
                        shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,-15,width_tbl-20,100)] ;
                    }
                    
                    //                  shadowView  =  [[UIView alloc] initWithFrame: CGRectMake((width_tbl-500)/2,45,500,130)] ;
                    [self.view addSubview:shadowView];
                    
                    shadowView.autoresizesSubviews=YES;
                    shadowView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
                    shadowView.backgroundColor = [UIColor clearColor];
                    shadowView.userInteractionEnabled=YES;
                    title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, shadowView.frame.size.width, shadowView.frame.size.height)];
                    //    [title_label setDelegate:self];
                    [title_label setNumberOfLines:3];
                    //    title_label.lineSpacing = 0.0;
                    title_label.font=[UIFont systemFontOfSize:16];
                    //                    [title_label setText:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];
                    //                    [title_label setTextColor:[UIColor whiteColor]];
                    
                    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"In order to further assist you to get the most out of your pXc app,a step by step user manual is available for your use HERE. It demonstrates and explains all of pXc's functions and operating guidelines."];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,120)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(120,4)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(124,79)];
                    
                    title_label.attributedText = string;
                    
                    title_label.backgroundColor=[UIColor clearColor];
                    [shadowView addSubview:title_label];
                    
                    shadowView.layer.shadowColor = [[UIColor blackColor] CGColor];
                    shadowView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
                    shadowView.layer.shadowRadius = 3.0f;
                    shadowView.layer.shadowOpacity = 1.0f;
                    
                    [extraview removeFromSuperview];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 130, width_tbl-20, 525)];
                    }
                    else
                    {
                        extraview= [[UIView alloc]initWithFrame:CGRectMake(10, 70, width_tbl-20, 525)];
                    }
                    //                    extraview= [[UIView alloc]initWithFrame:CGRectMake((width_tbl-500)/2, 160, 500, 525)];
                    [self.view addSubview:extraview];
                    extraview.backgroundColor=[UIColor clearColor];
                    extraview.layer.cornerRadius=7;
                    extraview.layer.borderColor=[[UIColor whiteColor]CGColor];
                    extraview.layer.borderWidth=1.5f;
                    
                    [tableview removeFromSuperview];
                    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, extraview.frame.size.width, extraview.frame.size.height)];
                    tableview.delegate=self;
                    tableview.dataSource=self;
                    tableview.backgroundColor = [UIColor clearColor];
                    tableview.scrollEnabled=YES;
                    //    [tableview setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    tableview.separatorColor = [UIColor blackColor];
                    tableview.contentInset = UIEdgeInsetsZero;
                    [extraview addSubview:tableview];
                    
                    [tableview setContentOffset:CGPointMake(0, 0) animated: NO];
                    //           shadowView.frame= CGRectMake(10,45,300,130) ;
                    shadowView.userInteractionEnabled=YES;
                    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firewebview:)];
                    gesture.delegate=self;
                    [shadowView addGestureRecognizer:gesture];
                }
                    break;
            }
        }
            break;
    }
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
    //    shadowView  =  [[UIView alloc] initWithFrame: CGRectMake(10,45,300,130)] ;
    //    [self.view addSubview:shadowView];
    [tableview reloadData];
    appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults] ;
    NSArray *DescArr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"ip: %@", [prefs objectForKey:@"address"]],@"FTP domain: 192.254.152.111",[NSString stringWithFormat:@"FTP username: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]],[NSString stringWithFormat:@"FTP password: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_user_pass"]],[NSString stringWithFormat:@"Home path:%@%@",userurl,[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]],[NSString stringWithFormat:@"FTP Root Directory: ftp://192.254.152.111:21/home/photoxch/public_html/user/:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]], [NSString stringWithFormat:@"App Version:%@",appVersion],nil];
    NSString *text = [DescArr objectAtIndex:[indexPath row]];
    CGSize constraint = CGSizeMake(tableView.frame.size.width, 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat height = MAX(size.height, 59.0f);
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"ip: %@", [prefs objectForKey:@"address"]];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"FTP domain: 192.254.152.111"];
            break;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"FTP username: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]];
            break;
        case 3:
            cell.textLabel.text = [NSString stringWithFormat:@"FTP password: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_user_pass"]];
            break;
        case 4:
            cell.textLabel.text = [NSString stringWithFormat:@"Home path: %@%@",userurl,[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]];
            break;
        case 5:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"FTP Root Directory: ftp://192.254.152.111:21/home/photoxch/public_html/user/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]];
            NSLog(@"text text: %@",cell.textLabel.text);
        }
            break;
        case 6:
            cell.textLabel.text = [NSString stringWithFormat:@"App Version: %@",appVersion];
            break;
    }
    cell.textLabel.font= [UIFont systemFontOfSize:13];
    cell.textLabel.textAlignment= NSTextAlignmentCenter;
    cell.textLabel.numberOfLines=4;
    [cell.textLabel sizeToFit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return Nil;
}
- (void)gotoback:(id)sender
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    HomeViewController *control1 = [[HomeViewController alloc] init];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
}

- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    NSString *stng2a = [NSString stringWithFormat:@"http://photo-xchange.com/faq.php"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stng2a]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end