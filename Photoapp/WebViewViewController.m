//
//  WebViewViewController.m
//  Photoapp
//
//  Created by maxcon4 on 04/03/14.
//  Copyright (c) 2014 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()<UIGestureRecognizerDelegate>{
    
    UIButton *button;
    
}

@end

@implementation WebViewViewController

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
	
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]];
    
    
}
-(void) viewWillAppear:(BOOL)animated
{
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar@2x.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bar.png"] forBarMetrics:nil];
    }
    [self.navigationItem setTitle:@"PxC Manual"];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                           UITextAttributeFont: [UIFont fontWithName:@"MyriadPro-Bold" size:18.5],
                                                           }];
    [self.navigationItem setHidesBackButton:YES];
    
    button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(gotobackFromManual:)forControlEvents:UIControlEventTouchUpInside];
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
    
   
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    int height =0,width=0;
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            height = [[UIScreen mainScreen]bounds].size.width;
            width = [[UIScreen mainScreen]bounds].size.height;
        }
            break;
            
        case UIInterfaceOrientationPortrait:
        {
            height = [[UIScreen mainScreen]bounds].size.height;
            width = [[UIScreen mainScreen]bounds].size.width;
        }
            break;
    }
    webView_new = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    webView_new.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [webView_new setBackgroundColor:[UIColor whiteColor]];
    webView_new.opaque=YES;
    [webView_new setDelegate:self];
    webView_new.scalesPageToFit = YES;
    
//    UIPinchGestureRecognizer *pgr = [[UIPinchGestureRecognizer alloc]
//                                     initWithTarget:self action:@selector(handlePinch:)];
//    pgr.delegate = self;
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://photo-xchange.com/User_Guideline.pdf"] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    [webView_new loadRequest:request];
//    [webView_new addGestureRecognizer:pgr];
    
   
    [self.view addSubview:webView_new];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner setCenter:webView_new.center];
    [spinner setColor:[UIColor redColor]];
    spinner.hidesWhenStopped=YES;
    [webView_new addSubview:spinner];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChangedinFTP:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}
-(void)orientationChangedinFTP:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationUnknown:
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationPortraitUpsideDown:
            break;
        case UIDeviceOrientationPortrait:
        {
            webView_new.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
            [spinner setCenter:webView_new.center];
            
            int scrollPosition = [[webView_new stringByEvaluatingJavaScriptFromString:@"window.pageYOffset"] intValue];
            [webView_new stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"scrollTo(0,%d)",scrollPosition]];
           
        }
            break;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
        {
            webView_new.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width);
            [spinner setCenter:webView_new.center];
            int scrollPosition = [[webView_new stringByEvaluatingJavaScriptFromString:@"window.pageYOffset"] intValue];
            [webView_new stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"scrollTo(0,%d)",scrollPosition]];
          
        }
            break;
            
            
    };
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@" request is %@",request);
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)localWebView {
    
    [ spinner performSelectorInBackground: @selector(startAnimating) withObject: nil];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [ spinner performSelectorInBackground: @selector(stopAnimating) withObject: nil];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)localWebView
{
    
    [ spinner performSelectorInBackground: @selector(stopAnimating) withObject: nil];
}
-(void)gotobackFromManual:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)handlePinch:(UIGestureRecognizer *)sender
{
    
}
@end