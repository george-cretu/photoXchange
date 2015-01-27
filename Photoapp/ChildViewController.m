//
//  ChildViewController.m
//  Photoapp
//
//  Created by maxcon4 on 28/02/14.
//  Copyright (c) 2014 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import "ChildViewController.h"
#import "UIImageView+WebCache.h"
@interface ChildViewController ()

@end

@implementation ChildViewController
@synthesize index,image_url;
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
	
    UIImageView *image_full_screen = [[UIImageView alloc] init];
    NSString *encodedstr =  image_url;
    NSLog(@"child url is %@",encodedstr);
    [image_full_screen setImageWithURL:[NSURL URLWithString:encodedstr]
                                placeholderImage:[UIImage imageNamed:@"splash screen.png"] options:SDWebImageProgressiveDownload];
    [image_full_screen setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [image_full_screen setContentMode:UIViewContentModeScaleAspectFit];
    [image_full_screen setFrame:self.view.frame];
    [self.view addSubview:image_full_screen];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
