//  AccountViewController.m
//  Photoapp
//  Created by Esolz Technologies on 08/05/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
#import "AccountViewController.h"
#import "SVProgressHUD.h"
#import "HomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NetworkManager.h"
#include <sys/socket.h>
#include <sys/dirent.h>
#include <CFNetwork/CFNetwork.h>
#pragma mark * ListController
#define kAlbumName @"Saved Photos"
@interface AccountViewController ()<NSStreamDelegate>
{
    UIImageView *buttonusertrouble;
    UILabel *headerlabel;
    UIButton *backButton;
    UIButton *saveButton;
    UILabel *notify_lbl;
    UIView *shadow_view;
    UIButton *button;
    int numb;
}
@property (nonatomic, strong, readwrite)  UITextField *               urlText;
@property (nonatomic, strong, readwrite)  UIActivityIndicatorView *   activityIndicator;
@property (nonatomic, strong, readwrite)  UITableView *               tableView;
@property (nonatomic, strong, readwrite)  UIBarButtonItem *           listOrCancelButton;
@property (nonatomic, assign, readonly ) BOOL              isReceiving;
@property (nonatomic, strong, readwrite) NSInputStream *   networkStream;
@property (nonatomic, strong, readwrite) NSMutableData *   listData;
@property (nonatomic, strong, readwrite) NSMutableArray *  listEntries;
@property (nonatomic, copy,   readwrite) NSString *        status;

- (void)updateStatus:(NSString *)statusString;
@end
@implementation AccountViewController
@synthesize imagetable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)updateStatus:(NSString *)statusString
{}

- (void)receiveDidStart
{
    [self.listEntries removeAllObjects];
    [self.tableView reloadData];
    [self.activityIndicator startAnimating];
    [[NetworkManager sharedInstance] didStartNetworkOperation];
}
- (void)parseListData
{
    NSMutableArray *    newEntries;
    NSUInteger          offset;
    newEntries = [NSMutableArray array];
    assert(newEntries != nil);
    offset = 0;
    do {
        CFIndex    bytesConsumed;
        CFDictionaryRef thisEntry;
        thisEntry = NULL;
        
        assert(offset <= [self.listData length]);
        bytesConsumed = CFFTPCreateParsedResourceListing(NULL, &((const uint8_t *) self.listData.bytes)[offset], (CFIndex) ([self.listData length] - offset), &thisEntry);
        if (bytesConsumed > 0) {
            
            if (thisEntry != NULL) {
                NSDictionary *  entryToAdd;
                
                entryToAdd = [self entryByReencodingNameInEntry:(__bridge NSDictionary *) thisEntry encoding:NSUTF8StringEncoding];
                
                [newEntries addObject:entryToAdd];
            }
            offset += (NSUInteger) bytesConsumed;
        }
        if (thisEntry != NULL) {
            CFRelease(thisEntry);
        }
        if (bytesConsumed == 0) {
            break;
        } else if (bytesConsumed < 0) {
            // We totally failed to parse the listing.  Fail.
            [self stopReceiveWithStatus:@"Listing parse failed"];
            break;
        }
    } while (YES);
    if ([newEntries count] != 0) {
        [self addListEntries:newEntries];
    }
    if (offset != 0) {
        [self.listData replaceBytesInRange:NSMakeRange(0, offset) withBytes:NULL length:0];
    }
}
- (NSDictionary *)entryByReencodingNameInEntry:(NSDictionary *)entry encoding:(NSStringEncoding)newEncoding
{
    NSDictionary *  result;
    NSString *      name;
    NSData *        nameData;
    NSString *      newName;
    newName = nil;
    name = [entry objectForKey:(id) kCFFTPResourceName];
    if (name != nil) {
        assert([name isKindOfClass:[NSString class]]);
        
        nameData = [name dataUsingEncoding:NSMacOSRomanStringEncoding];
        if (nameData != nil) {
            newName = [[NSString alloc] initWithData:nameData encoding:newEncoding];
        }
    }
    // If the above failed, just return the entry unmodified.  If it succeeded,
    // make a copy of the entry and replace the name with the new name that we
    // calculated.
    if (newName == nil) {
        assert(NO);                 // in the debug builds, if this fails, we should investigate why
        result = (NSDictionary *) entry;
    } else {
        NSMutableDictionary *   newEntry;
        newEntry = [entry mutableCopy];
        assert(newEntry != nil);
        
        [newEntry setObject:newName forKey:(id) kCFFTPResourceName];
        result = newEntry;
    }
    return result;
}
- (void)stopReceiveWithStatus:(NSString *)statusString
{
    if (self.networkStream != nil) {
        [self.networkStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.networkStream.delegate = nil;
        [self.networkStream close];
        self.networkStream = nil;
    }
    [self receiveDidStopWithStatus:statusString];
    self.listData = nil;
}
- (void)receiveDidStopWithStatus:(NSString *)statusString
{
    if (statusString == nil) {
        statusString = @"List succeeded";
    }
    NSLog(@"%@", statusString);
    [self.activityIndicator stopAnimating];
    [[NetworkManager sharedInstance] didStopNetworkOperation];
}
- (void)addListEntries:(NSArray *)newEntries
{
    assert(self.listEntries != nil);
}
- (void)startReceive
{
    BOOL                success;
    NSURL *             url;
    assert(self.networkStream == nil);
    url = [[NetworkManager sharedInstance] smartURLForString:self.urlText.text];
    success = (url != nil);
    
    if ( ! success) {
        NSLog(@"Invalid URL");
    } else {
        self.listData = [NSMutableData data];
        assert(self.listData != nil);
        self.networkStream = CFBridgingRelease(
                                               CFReadStreamCreateWithFTPURL(NULL, (__bridge CFURLRef) url)
                                               );
        assert(self.networkStream != nil);
        
        self.networkStream.delegate = self;
        [self.networkStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.networkStream open];
        [self receiveDidStart];
    }
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"NewFileUploaded"]) {
        
        [importArray removeAllObjects];
        NSLog(@"import elements now : %@",importArray);

        [directoryElements addObject:[notification object]];
        
        NSLog(@"Recieved image: %@", [notification object]);
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setInteger:([prefs integerForKey:@"numberNewPhoto"] + 1) forKey:@"numberNewPhoto"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if(self.imagetable != nil) {
            NSLog(@"hurrrray");
        [self.imagetable setHidden:NO];
        
            [self.imagetable reloadData];
            notify_lbl.hidden=YES;
       }
        AccountViewController *acc = [[AccountViewController alloc]init];
        [self.navigationController pushViewController:acc animated:NO];

    }
}
- (void)viewWillAppear:(BOOL)animated {
   
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [self.imagetable removeFromSuperview];
    [super viewWillDisappear:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar@2x.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBarHidden = NO;
        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars=NO;
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bar.png"] forBarMetrics:nil];
    }
    [self.navigationItem setTitle:@"All Photos"];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                           UITextAttributeFont: [UIFont fontWithName:@"MyriadPro-Bold" size:18.5],
                                                           }];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBarHidden = NO;
    
    button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
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
    
    saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(280, 7.0f, 58/2, 49/2);
    [saveButton setBackgroundImage:[UIImage imageNamed:@"import_button@2x.png"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(importImageToLibrary:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton_right = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = barButton_right;
    
    int count1;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"NewFileUploaded"
                                               object:nil];
    
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSLog(@" %@",documentsDirectory);
    directoryElements = [[NSMutableArray alloc] init];
    for (count1 = 0; count1 < (int)[directoryContent count]; count1++)
    {
        [directoryElements addObject:[directoryContent objectAtIndex:count1]];
    }
    if([directoryElements count]==0)
    {
        switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
            case UIUserInterfaceIdiomPhone:
            {
                switch(self.interfaceOrientation)
                {
                    case UIInterfaceOrientationLandscapeLeft:
                    case UIInterfaceOrientationLandscapeRight:
                    {
                        if ([[ver objectAtIndex:0] intValue] >= 7)
                        {
                            shadow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, (self.view.frame.size.height - 4))];
                        }
                        else
                        shadow_view= [[UIView alloc] initWithFrame:CGRectMake(0, 0,  [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width-4)];
                        shadow_view.backgroundColor = [UIColor blackColor];
                        shadow_view.alpha=0.5;
                        [self.view addSubview:shadow_view];
                        
                        notify_lbl = [[UILabel alloc] initWithFrame:CGRectMake(130, 130, 220, 80)];
                        notify_lbl.backgroundColor = [UIColor darkGrayColor];
                        notify_lbl.alpha=0.5;
                        notify_lbl.textColor = [UIColor whiteColor];
                        notify_lbl.text=@"Sorry, No Images Found";
                        notify_lbl.textAlignment=NSTextAlignmentCenter;
                        notify_lbl.lineBreakMode = NSLineBreakByWordWrapping;
                        notify_lbl.numberOfLines=3;
                        [notify_lbl setShadowColor:[UIColor whiteColor]];
                        [notify_lbl setShadowOffset:CGSizeMake(0, -1)];
                        notify_lbl.layer.zPosition=1;
                        [self.view addSubview:notify_lbl];
                        
                    }
                        break;
                    case UIInterfaceOrientationPortrait:
                    case UIInterfaceOrientationPortraitUpsideDown:
                    {
                        if ([[ver objectAtIndex:0] intValue] >= 7)
                        {
                            shadow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, (self.view.frame.size.height - 4))];
                        }
                        else
                        shadow_view= [[UIView alloc] initWithFrame:CGRectMake(0, 0,  [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-4)];
                        shadow_view.backgroundColor = [UIColor blackColor];
                        shadow_view.alpha=0.5;
                        [self.view addSubview:shadow_view];
                        
                        notify_lbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 220, 80)];
                        notify_lbl.backgroundColor = [UIColor darkGrayColor];
                        notify_lbl.alpha=0.5;
                        notify_lbl.textColor = [UIColor whiteColor];
                        notify_lbl.text=@"Sorry, No Images Found";
                        notify_lbl.textAlignment=NSTextAlignmentCenter;
                        notify_lbl.lineBreakMode = NSLineBreakByWordWrapping;
                        notify_lbl.numberOfLines=3;
                        [notify_lbl setShadowColor:[UIColor whiteColor]];
                        [notify_lbl setShadowOffset:CGSizeMake(0, -1)];
                        notify_lbl.layer.zPosition=1;
                        [self.view addSubview:notify_lbl];
                    }
                        break;
                }
                break;
            }
            case UIUserInterfaceIdiomPad:
            {
                switch(self.interfaceOrientation)
                {
                    case UIInterfaceOrientationLandscapeLeft:
                    {
                        if ([[ver objectAtIndex:0] intValue] >= 7)
                        {
                            shadow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, (self.view.frame.size.height - 4))];
                        }
                        else
                        shadow_view= [[UIView alloc] initWithFrame:CGRectMake(0, 0,  [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.height-4)];
                        shadow_view.backgroundColor = [UIColor blackColor];
                        shadow_view.alpha=0.5;
                        [self.view addSubview:shadow_view];
                        
                        notify_lbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, [[UIScreen mainScreen] bounds].size.height-100, 80)];
                        notify_lbl.backgroundColor = [UIColor darkGrayColor];
                        notify_lbl.alpha=0.5;
                        notify_lbl.textColor = [UIColor whiteColor];
                        notify_lbl.text=@"Sorry, No Images Found";
                        notify_lbl.textAlignment=NSTextAlignmentCenter;
                        notify_lbl.lineBreakMode = NSLineBreakByWordWrapping;
                        notify_lbl.numberOfLines=3;
                        [notify_lbl setShadowColor:[UIColor whiteColor]];
                        [notify_lbl setShadowOffset:CGSizeMake(0, -1)];
                        notify_lbl.layer.zPosition=1;
                        [self.view addSubview:notify_lbl];
                    }
                        break;
                    case UIInterfaceOrientationLandscapeRight:
                    {
                        if ([[ver objectAtIndex:0] intValue] >= 7)
                        {
                            shadow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, (self.view.frame.size.height - 4))];
                        }
                        else
                        shadow_view= [[UIView alloc] initWithFrame:CGRectMake(0, 0,  [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.height-4)];
                        shadow_view.backgroundColor = [UIColor blackColor];
                        shadow_view.alpha=0.5;
                        [self.view addSubview:shadow_view];
                        
                        notify_lbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, [[UIScreen mainScreen] bounds].size.height-100, 80)];
                        notify_lbl.backgroundColor = [UIColor darkGrayColor];
                        notify_lbl.alpha=0.5;
                        notify_lbl.textColor = [UIColor whiteColor];
                        notify_lbl.text=@"Sorry, No Images Found";
                        notify_lbl.textAlignment=NSTextAlignmentCenter;
                        notify_lbl.lineBreakMode = NSLineBreakByWordWrapping;
                        notify_lbl.numberOfLines=3;
                        [notify_lbl setShadowColor:[UIColor whiteColor]];
                        [notify_lbl setShadowOffset:CGSizeMake(0, -1)];
                        notify_lbl.layer.zPosition=1;
                        [self.view addSubview:notify_lbl];
                    }
                        break;
                    case UIInterfaceOrientationPortrait:
                    {
                        if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        shadow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, (self.view.frame.size.height - 4))];
                    }
                    else
                        shadow_view= [[UIView alloc] initWithFrame:CGRectMake(0, 0,  [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-4)];
                        shadow_view.backgroundColor = [UIColor blackColor];
                        shadow_view.alpha=0.5;
                        [self.view addSubview:shadow_view];
                        
                        notify_lbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, [[UIScreen mainScreen] bounds].size.width-100, 80)];
                        notify_lbl.backgroundColor = [UIColor darkGrayColor];
                        notify_lbl.alpha=0.5;
                        notify_lbl.textColor = [UIColor whiteColor];
                        notify_lbl.text=@"Sorry, No Images Found";
                        notify_lbl.textAlignment=NSTextAlignmentCenter;
                        notify_lbl.lineBreakMode = NSLineBreakByWordWrapping;
                        notify_lbl.numberOfLines=3;
                        [notify_lbl setShadowColor:[UIColor whiteColor]];
                        [notify_lbl setShadowOffset:CGSizeMake(0, -1)];
                        notify_lbl.layer.zPosition=1;
                        [self.view addSubview:notify_lbl];
                    }
                        break;
                    case UIInterfaceOrientationPortraitUpsideDown:
                    {
                        if ([[ver objectAtIndex:0] intValue] >= 7)
                        {
                            shadow_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, (self.view.frame.size.height - 4))];
                        }
                        else
                        shadow_view= [[UIView alloc] initWithFrame:CGRectMake(0, 0,  [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-4)];
                        shadow_view.backgroundColor = [UIColor blackColor];
                        shadow_view.alpha=0.5;
                        [self.view addSubview:shadow_view];
                        
                        notify_lbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, [[UIScreen mainScreen] bounds].size.width-100, 80)];
                        notify_lbl.backgroundColor = [UIColor darkGrayColor];
                        notify_lbl.alpha=0.5;
                        notify_lbl.textColor = [UIColor whiteColor];
                        notify_lbl.text=@"Sorry, No Images Found";
                        notify_lbl.textAlignment=NSTextAlignmentCenter;
                        notify_lbl.lineBreakMode = NSLineBreakByWordWrapping;
                        notify_lbl.numberOfLines=3;
                        [notify_lbl setShadowColor:[UIColor whiteColor]];
                        [notify_lbl setShadowOffset:CGSizeMake(0, -1)];
                        notify_lbl.layer.zPosition=1;
                        [self.view addSubview:notify_lbl];
                    }
                        break;
                }
                break;
            }
                break;
        }
    }

    
    
    
    
    
 else
 {
     NSLog(@"image count greater than 0");
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                         self.imagetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, (self.view.frame.size.height - 4))];
                    }
                    else
                    self.imagetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, (self.view.frame.size.height - 4))];
                    [self.imagetable setDelegate:self];
                    [self.imagetable setDataSource:self];
                    [self.imagetable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                    [self.imagetable setBackgroundColor:[UIColor clearColor]];
                    [self.view addSubview:self.imagetable];
                    numb = self.view.bounds.size.width/106.5f;
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        self.imagetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, ([[UIScreen mainScreen]bounds].size.height - 4))];
                    }
                    else

                    self.imagetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, ([[UIScreen mainScreen]bounds].size.height - 4))];
                    [self.imagetable setDelegate:self];
                    [self.imagetable setDataSource:self];
                    [self.imagetable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                    [self.imagetable setBackgroundColor:[UIColor clearColor]];
                    [self.view addSubview:self.imagetable];
                    numb = self.view.bounds.size.width/106.5f;
                }
                    break;
                    case UIInterfaceOrientationLandscapeRight:
                {
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        self.imagetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, ([[UIScreen mainScreen]bounds].size.height - 4))];
                    }
                    else
  
                    self.imagetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, ([[UIScreen mainScreen]bounds].size.height - 4))];
                    [self.imagetable setDelegate:self];
                    [self.imagetable setDataSource:self];
                    [self.imagetable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                    [self.imagetable setBackgroundColor:[UIColor clearColor]];
                    [self.view addSubview:self.imagetable];
                    
//                    [self.view addSubview:saveButton];
//                    self.imagetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, ([[UIScreen mainScreen]bounds].size.height - 45))];
                    [self.imagetable setDelegate:self];
                    [self.imagetable setDataSource:self];
                    [self.imagetable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                    [self.imagetable setBackgroundColor:[UIColor clearColor]];
                    [self.view addSubview:self.imagetable];
                    numb = self.view.bounds.size.width/106.5f;
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                    break;
            }
        }
            break;
            case UIUserInterfaceIdiomPad:
        {
                switch(self.interfaceOrientation)
                {
                    case UIDeviceOrientationPortrait:
                    case UIInterfaceOrientationPortraitUpsideDown:
                    {
                        if ([[ver objectAtIndex:0] intValue] >= 7)
                        {
                self.imagetable = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, (self.view.frame.size.height - 4))];
                        }
                        else
                self.imagetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (self.view.frame.size.height - 4))];
                        [self.imagetable setDelegate:self];
                        [self.imagetable setDataSource:self];
                        [self.imagetable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                        [self.imagetable setBackgroundColor:[UIColor clearColor]];
                        [self.view addSubview:self.imagetable];
                        numb = self.view.bounds.size.width/106.5f;
                    }
                        break;
                    case UIInterfaceOrientationLandscapeLeft:
                    {
                        if ([[ver objectAtIndex:0] intValue] >= 7)
                        {
                            self.imagetable = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, ([[UIScreen mainScreen]bounds].size.height - 4))];
                        }
                        else
                        self.imagetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, ([[UIScreen mainScreen]bounds].size.height - 4))];
                        [self.imagetable setDelegate:self];
                        [self.imagetable setDataSource:self];
                        [self.imagetable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                        [self.imagetable setBackgroundColor:[UIColor clearColor]];
                        [self.view addSubview:self.imagetable];
                        numb = self.view.bounds.size.width/106.5f;
                    }
                        break;
                    case UIInterfaceOrientationLandscapeRight:
                    {
                        if ([[ver objectAtIndex:0] intValue] >= 7)
                        {
                        self.imagetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, ([[UIScreen mainScreen]bounds].size.height - 4))];
                        }
                        else
                        self.imagetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, ([[UIScreen mainScreen]bounds].size.height - 4))];
                        [self.imagetable setDelegate:self];
                        [self.imagetable setDataSource:self];
                        [self.imagetable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                        [self.imagetable setBackgroundColor:[UIColor clearColor]];
                        [self.view addSubview:self.imagetable];
                        
//                        [self.view addSubview:saveButton];
//                        self.imagetable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, ([[UIScreen mainScreen]bounds].size.height - 45))];
//                        [self.imagetable setDelegate:self];
//                        [self.imagetable setDataSource:self];
//                        [self.imagetable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//                        [self.imagetable setBackgroundColor:[UIColor clearColor]];
//                        [self.view addSubview:self.imagetable];
                        numb = self.view.bounds.size.width/106.5f;
                    }
                        break;
                }
        }
            break;
    }
 }
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}

- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
     switch ([[UIDevice currentDevice] userInterfaceIdiom])
    {
        case UIUserInterfaceIdiomPhone:
        {
            switch(device.orientation)
            {
                case UIDeviceOrientationPortrait:
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, 320, 45);
                    headerlabel.frame = CGRectMake(0,10.5, 320, 25);
                    saveButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width-40, 7.0f, 58/2, 49.0f/2);
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         self.imagetable.frame = CGRectMake(0, 0, self.view.bounds.size.width, ([[UIScreen mainScreen]bounds].size.height - 4));
                                         shadow_view.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height-4);
                                         notify_lbl.frame= CGRectMake(50, 150, 220, 80);
                                     }
                                     completion:^(BOOL finished){ }];
                    [self.imagetable reloadData];
                    numb = self.view.bounds.size.width/106.5f;
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25);
                    saveButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.height-40, 7.0f, 58/2, 49/2);
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         self.imagetable.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 4);
                                         shadow_view.frame = CGRectMake(0, 0, self.view.bounds.size.width, [[UIScreen mainScreen] bounds].size.width-4);
                                         notify_lbl.frame= CGRectMake((self.view.bounds.size.width-220)/2, 150, 220, 80);
                                     }
                                     completion:^(BOOL finished){ }];
                    [self.imagetable reloadData];
                    numb = self.view.bounds.size.width/106.5f;
                }
                    break;
                case UIDeviceOrientationLandscapeRight:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25);
                    saveButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.height-40, 7.0f, 58/2, 49/2);
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         self.imagetable.frame = CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.height - 4));
                                         shadow_view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-4);
                                         notify_lbl.frame= CGRectMake((self.view.bounds.size.width-220)/2, 150, 220, 80);
                                     }
                                     completion:^(BOOL finished){ }];
                    [self.imagetable reloadData];
                    numb = self.view.bounds.size.width/106.5f;
                }
                    break;
            }
        }
            break;
        case UIUserInterfaceIdiomPad:
        {
            switch(device.orientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen] bounds].size.width, 25);
                    saveButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width-40, 7.0f, 58/2, 49.0f/2);
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         self.imagetable.frame = CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.height - 4));
                                         shadow_view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-4);
                                         notify_lbl.frame= CGRectMake(50, 150, self.view.bounds.size.width-100, 80);
                                     }
                                     completion:^(BOOL finished){ }];
                    numb = self.view.bounds.size.width/106.5f;
                    [self.imagetable reloadData];

                    NSLog(@"portrait orient ipad %f %d",self.imagetable.frame.size.width,numb);
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25);
                    saveButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.height-40, 7.0f, 58/2, 49/2);
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         self.imagetable.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, (self.view.bounds.size.height - 4));
                                         shadow_view.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, self.view.bounds.size.height-4);
                                         notify_lbl.frame= CGRectMake(50, 150, [[UIScreen mainScreen]bounds].size.height-100, 80);
                                     }
                                     completion:^(BOOL finished){ }];
                    numb = self.view.bounds.size.width/106.5f;
                    [self.imagetable reloadData];

                    NSLog(@"landscape left orient ipad %f %d",self.imagetable.frame.size.width,numb);

                }
                    break;
                case UIDeviceOrientationLandscapeRight:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen]bounds].size.height, 25);
                    saveButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.height-40, 7.0f, 58/2, 49/2);
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         self.imagetable.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, (self.view.bounds.size.height - 4));
                                         shadow_view.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, self.view.bounds.size.height-4);
                                         notify_lbl.frame= CGRectMake(50, 150, [[UIScreen mainScreen]bounds].size.height-100, 80);
                                     }
                                     completion:^(BOOL finished){ }];
                    numb = self.view.bounds.size.width/106.5f;
                    [self.imagetable reloadData];
                    NSLog(@"landscape right orient ipad %f %d",self.imagetable.frame.size.width,numb);
                }
                    break;
                    
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 45);
                    headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen] bounds].size.width, 25);
                    saveButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width-40, 7.0f, 58/2, 49.0f/2);
                    [UIView animateWithDuration:1.0
                                     animations:^{
                                         self.imagetable.frame = CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.height - 4));
                                         shadow_view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-4);
                                         notify_lbl.frame= CGRectMake(50, 150, self.view.bounds.size.width-100, 80);
                                     }
                                     completion:^(BOOL finished){ }];
                    numb = self.view.bounds.size.width/106.5f;
                    [self.imagetable reloadData];
                    NSLog(@"portrait orient ipad %f %d",self.imagetable.frame.size.width,numb);
                }
                    break;
            }
        }
            break;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    isImportEnabled = NO;
    importArray = [[NSMutableArray alloc] init];
    NSBundle *mainBundle = [NSBundle mainBundle];
    albumName = [mainBundle objectForInfoDictionaryKey:@"albumName"];
}

- (void)goBack:(id)sender {
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.5;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionFade;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//    [self.navigationController popViewControllerAnimated:NO];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    HomeViewController *control1 = [[HomeViewController alloc] init];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:control1 animated:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Images count: %lu", (unsigned long)[directoryElements count]);
//    return ceil((float)directoryElements.count / 3); // there are four photos per row.
 if ([directoryElements count]== 0)
     return 0;
    else
    {
//    switch(self.interfaceOrientation)
//    {
//        case UIDeviceOrientationPortrait:
//        case UIDeviceOrientationPortraitUpsideDown:
//        {
//            NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
//            if ([[ver objectAtIndex:0] intValue] >= 7)
//            {
//                numb = self.view.bounds.size.width/106.5;
//                if (directoryElements.count % numb == 0)
//                    return directoryElements.count/numb;
//                else
//                    return directoryElements.count/numb + 1;
//                [self.imagetable reloadData];
//                NSLog(@"7 portrait %d",numb);
//            }
//            else
//            {
//                numb = self.view.bounds.size.width/106.5f;
//                if (directoryElements.count % numb == 0)
//                    return directoryElements.count/numb;
//                else
//                    return directoryElements.count/numb + 1;
//                [self.imagetable reloadData];
//            }
//        }
//            break;
//            
//        case UIDeviceOrientationLandscapeRight:
//        case UIDeviceOrientationLandscapeLeft:
//        {
//            NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
//            if ([[ver objectAtIndex:0] intValue] >= 7)
//            {
//                numb = self.view.bounds.size.width/106.5f;
//                NSLog(@"land numb: %d",numb);
//                if (directoryElements.count % numb == 0)
//                    return directoryElements.count/numb;
//                else
//                    return directoryElements.count/numb + 1;
//                [self.imagetable reloadData];
//            }
//            else
//            {
                numb = self.view.bounds.size.width/106.5f;
                if (directoryElements.count % numb == 0)
                    return directoryElements.count/numb;
                else
                    return directoryElements.count/numb + 1;
                [self.imagetable reloadData];
//            }
//        }
//            break;
//    }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 194/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    cell = [tableView cellForRowAtIndexPath:indexPath];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    // Configure the cell...
    NSUInteger firstPhotoInCell = indexPath.row * numb;
    NSUInteger lastPhotoInCell  = firstPhotoInCell + numb;
    
    if (directoryElements.count <= firstPhotoInCell) {
        NSLog(@"We are out of range, asking to start with photo %d but we only have %d", firstPhotoInCell, assets.count);
        return nil;
    }
    NSUInteger currentPhotoIndex = 0;
    NSUInteger lastPhotoIndex = MIN(lastPhotoInCell, directoryElements.count);
    for ( ; firstPhotoInCell + currentPhotoIndex < lastPhotoIndex ; currentPhotoIndex++) {
        
        NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:[directoryElements objectAtIndex:(firstPhotoInCell + currentPhotoIndex)]];
        UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
        float padLeft = (0 * (currentPhotoIndex + 1)) + (currentPhotoIndex * 106.5f);
        
        UIView *imageContainer = [[UIView alloc] initWithFrame:CGRectMake(padLeft, 0, 106.5f ,194/2)];
        [imageContainer setBackgroundColor:[UIColor clearColor]];
        imageContainer.tag = (firstPhotoInCell + currentPhotoIndex);
        [imageContainer setUserInteractionEnabled:YES];
        [cell addSubview:imageContainer];
        
        UIImageView *albumV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 106.5f, 194/2)];
        albumV.userInteractionEnabled = YES;
        albumV.tag = firstPhotoInCell + currentPhotoIndex;
        albumV.contentMode = UIViewContentModeScaleAspectFit;
        albumV.image = img;
        [imageContainer addSubview:albumV];
        
        UITapGestureRecognizer *tapOnImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnImage:)];
        [tapOnImage setNumberOfTapsRequired:1];
        [imageContainer addGestureRecognizer:tapOnImage];
        
        cell.backgroundColor=[UIColor clearColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tapOnImage:(UITapGestureRecognizer *)gesture {
    NSLog(@"taponimage");
    if(!isImportEnabled) {
        NSLog(@"taponimage import not enabled");
        UIView *overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, gesture.view.frame.size.width, gesture.view.frame.size.height)];
        overlayView.tag = 100 + gesture.view.tag;
        [importArray addObject:[NSString stringWithFormat:@"%d", gesture.view.tag]];
        
        [overlayView setBackgroundColor:[UIColor colorWithWhite:.89 alpha:.67f]];
        [overlayView setAlpha:0.67f];
        [gesture.view addSubview:overlayView];
        
        UITapGestureRecognizer *tapOnLayer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnLayer:)];
        [tapOnLayer setNumberOfTapsRequired:1];
        [overlayView addGestureRecognizer:tapOnLayer];
    } else {
        NSLog(@"taponimage import enabled");
        UIView *tappedView = (UIView *)gesture.view;
        NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:[directoryElements objectAtIndex:tappedView.tag]];
        UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
        
        imageViewer = [[imageViewerViewController alloc] initWithNibName:@"imageViewerViewController" bundle:nil];
        [imageViewer setFullImage:img];
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:imageViewer animated:YES];
    }
}
- (void)tapOnLayer:(UITapGestureRecognizer *)gesture {
    NSLog(@"taponlayer");
    int element = gesture.view.tag - 100;
    NSInteger Aindex=[importArray indexOfObject:[NSString stringWithFormat:@"%d", element]];
    if(NSNotFound == Aindex) {
        NSLog(@"not found");
    } else {
        NSLog(@"taponlayer remove object");
        NSUInteger index = [importArray indexOfObject:[NSString stringWithFormat:@"%d", element]];
        [gesture.view removeFromSuperview];
        [importArray removeObjectAtIndex:index];
    }
}
- (void)importImageToLibrary:(id)sender {
    
    if([importArray count] <= 0) {
        UIAlertView *noImageAlert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                               message:@"Please select image(s) to import to library!"
                                                              delegate:self
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles:nil];
        noImageAlert.tag = 2;
        [noImageAlert show];
    } else {
        for (int count = 0; count < [importArray count]; count++) {
            
            int arrayIndex = [[importArray objectAtIndex:count] intValue];
            NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:[directoryElements objectAtIndex:arrayIndex]];
            UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
            
            UIView *overlay = (UIView *)[self.view viewWithTag:(100 + arrayIndex)];
            [overlay removeFromSuperview];
            
            assetsLibrary = [[ALAssetsLibrary alloc] init];
            [assetsLibrary writeImageToSavedPhotosAlbum:[img CGImage] orientation:(ALAssetOrientation)[img imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
                if (error) {
                     NSLog(@"Save error: %@", [error description]);
                } 
            }];
        }
        UIAlertView *deleteImgAlert = [[UIAlertView alloc] initWithTitle:@"PhotoXchange"
                                                                 message:@"All selected photo has been imported successfully. Do you want to delete these photos? (Photos will be stored in the library)"
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                       otherButtonTitles:@"Delete", nil];
        deleteImgAlert.tag = 1;
        [deleteImgAlert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"directory elements: %@",directoryElements);
    NSLog(@"import elements: %@",importArray);
    if(alertView.tag == 1) {
        NSLog(@"tag 1-e esche");
        if(buttonIndex == 1) {
            for (int count = 0; count < [importArray count]; count++) {
                int arrayIndex = [[importArray objectAtIndex:count] intValue];
                NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:[directoryElements objectAtIndex:arrayIndex]];
                NSError *error = nil;
                [[NSFileManager defaultManager] removeItemAtPath: getImagePath error: &error];
            }
            if([directoryElements count] > 0) {
                NSLog(@"directory > 0");
                [directoryElements removeAllObjects];
            }
            
            CATransition* transition = [CATransition animation];
            transition.duration = 0.5f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionFade;
            AccountViewController *control1 = [[AccountViewController alloc] init];
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            [[self navigationController] pushViewController:control1 animated:NO];
        }
                [self.imagetable reloadData];
    }
    else
    {
       directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    directoryElements = [[NSMutableArray alloc] init];
    for (int count1 = 0; count1 < (int)[directoryContent count]; count1++)
    {
        [directoryElements addObject:[directoryContent objectAtIndex:count1]];
    }
    [self.imagetable reloadData];
        [importArray removeAllObjects];
        NSLog(@"import elements now : %@",importArray);
    }
}
@end