//
//  ViewController.m
//  Photoapp
//
//  Created by Esolz Technologies on 08/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize actp,labeltext;
- (void)viewDidLoad
{
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPad:
        {
            switch (self.interfaceOrientation) {
                case UIInterfaceOrientationPortrait:
                {
                    show_img.frame= CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    show_img.image = [UIImage imageNamed:@"Default-Portrait~ipad.png"];
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    show_img.frame= CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    show_img.image = [UIImage imageNamed:@"Default-Landscape~ipad.png"];
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    show_img.frame= CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    show_img.image = [UIImage imageNamed:@"Default-Landscape~ipad.png"];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
            
            
        default:
            break;
    }
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [actp startAnimating];
    
    [labeltext setTextColor:UIColorFromRGB(0xf79a28)];
    [labeltext setBackgroundColor:[UIColor clearColor]];
    [labeltext setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:24.5]];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChangedProfile:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)orientationChangedProfile:(NSNotification *)note
{
    UIDevice * device = note.object;
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom])
    {
        case UIUserInterfaceIdiomPad:
        {
            
            switch(device.orientation)
            {
                case UIDeviceOrientationPortrait:
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    show_img.frame= CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    show_img.image = [UIImage imageNamed:@"Default-Portrait~ipad.png"];
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                {
                    show_img.frame= CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    show_img.image = [UIImage imageNamed:@"Default-Landscape~ipad.png"];
                }
                    break;
                    
                case UIDeviceOrientationLandscapeRight:
                {
                    show_img.frame= CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    show_img.image = [UIImage imageNamed:@"Default-Landscape~ipad.png"];
                }
                    break;
                case UIDeviceOrientationUnknown:
                case UIDeviceOrientationFaceUp:
                case UIDeviceOrientationFaceDown:
                    break;
            }
        }
            break;
            
        case UIUserInterfaceIdiomPhone:
            break;
            
        default:
            break;
            
    }
}

@end