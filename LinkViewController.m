//
//  LinkViewController.m
//  Photoapp
//
//  Created by Bhaswar's MacBook Air on 09/04/14.
//  Copyright (c) 2014 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import "LinkViewController.h"
#import "NewProfileViewController.h"

@interface LinkViewController ()

@end

@implementation LinkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;

    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
    {
        NSLog(@"1st");
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar@2x.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else
    {
        NSLog(@"2nd");
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bar.png"] forBarMetrics:nil];
    }
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationItem setTitle:@"User Guide"];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                           UITextAttributeFont: [UIFont fontWithName:@"MyriadPro-Bold" size:18.5],
                                                           }];
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back-up@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(gotoback)forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0,32/2, 25/2)];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
    

    
    NSURL *theURL = [NSURL URLWithString: @"http://www.fotohello.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL: theURL];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,55,self.view.bounds.size.width,self.view.bounds.size.height-55)];
    webView.scalesPageToFit = YES;
    [webView setDelegate: self];
    [webView loadRequest: request];
    [self.view addSubview:webView];
    //create view controlelr too, and push onto nav controller
    //  UIViewController *newController = [[UIViewController alloc] init];
}


- (void)gotoback
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    NewProfileViewController *control1 = [[NewProfileViewController alloc] init];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
}


@end
