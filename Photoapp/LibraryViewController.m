//
//  LibraryViewController.m
//  Photoapp
//
//  Created by Soumalya on 18/06/13.
//  Copyright (c) 2013 Esolz Technologies Pvt Ltd. All rights reserved.
//

#import "LibraryViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FTPListingViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "SVProgressHUD.h"
#import "ImageDetailViewController.h"
@interface LibraryViewController ()
{
    UIImageView *buttonusertrouble;
    UILabel *headerlabel;
    UIButton *backButton;
    UIButton *editButton;
}

@end

@implementation LibraryViewController

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
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    albumName = [mainBundle objectForInfoDictionaryKey:@"albumName"];
    
}
- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
      switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
          case UIUserInterfaceIdiomPhone:
          {
              switch(device.orientation)
              {
                  case UIDeviceOrientationPortrait:
                  {
                      buttonusertrouble.frame = CGRectMake(0, 0, 320, 45);
                      headerlabel.frame = CGRectMake(0,10.5, [[UIScreen mainScreen] bounds].size.width, 25);
                      [editButton setFrame:CGRectMake(320-59/2-5, (45-38/2)/2, 59/2, 38/2)];
                      [UIView animateWithDuration:1.0
                                       animations:^{
                                           libraryTable.frame =CGRectMake(0, 45, 320, ([[UIScreen mainScreen] bounds].size.height - 45));
                                           [libraryTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                                       }
                                       completion:^(BOOL finished){ }];
                      
                  }
                      break;
                      
                  case UIDeviceOrientationLandscapeRight:
                  {
                      buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                      headerlabel.frame = CGRectMake([[UIScreen mainScreen]bounds].size.height-300,10.5, 170, 25);
                      [editButton setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.height-59/2-5, (45-38/2)/2, 59/2, 38/2)];
                      [UIView animateWithDuration:1.0
                                       animations:^{
                                           libraryTable.frame =CGRectMake(15, 45, [[UIScreen mainScreen] bounds].size.height, ([[UIScreen mainScreen] bounds].size.width - 45));
                                           [libraryTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];}
                                       completion:^(BOOL finished){ }];
                      
                  }
                      break;
                  case UIDeviceOrientationLandscapeLeft:
                  {
                      buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                      headerlabel.frame = CGRectMake([[UIScreen mainScreen]bounds].size.height-300,10.5, 170, 25);
                      [editButton setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.height-59/2-5, (45-38/2)/2, 59/2, 38/2)];
                      [UIView animateWithDuration:1.0
                                       animations:^{
                                           
                                           libraryTable.frame =CGRectMake(15, 45, [[UIScreen mainScreen] bounds].size.height, ([[UIScreen mainScreen] bounds].size.width - 45));
                                           [libraryTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
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
                  case UIDeviceOrientationPortrait:
                  {
                      buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 45);
                      headerlabel.frame = CGRectMake(0,12.5, [[UIScreen mainScreen]bounds].size.width, 25);
                      [editButton setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width-59/2-5, (45-38/2)/2, 59/2, 38/2)];
                      [UIView animateWithDuration:1.0
                                       animations:^{
                                           libraryTable.frame =CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.width, ([[UIScreen mainScreen] bounds].size.height - 45));
                                           [libraryTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                                       }
                                       completion:^(BOOL finished){ }];
                      
                  }
                      break;
                      
                  case UIDeviceOrientationLandscapeRight:
                  {
                      buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                      headerlabel.frame = CGRectMake(0,12.5, [[UIScreen mainScreen]bounds].size.height, 25);
                      [editButton setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.height-59/2-5, (45-38/2)/2, 59/2, 38/2)];
                      [UIView animateWithDuration:1.0
                                       animations:^{
                                           libraryTable.frame =CGRectMake(15, 45, [[UIScreen mainScreen] bounds].size.height, ([[UIScreen mainScreen] bounds].size.width - 45));
                                           [libraryTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];}
                                       completion:^(BOOL finished){ }];
                      
                  }
                      break;
                  case UIDeviceOrientationLandscapeLeft:
                  {
                      buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45);
                      headerlabel.frame = CGRectMake(0,12.5, [[UIScreen mainScreen]bounds].size.height, 25);
                      [editButton setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.height-59/2-5, (45-38/2)/2, 59/2, 38/2)];
                      [UIView animateWithDuration:1.0
                                       animations:^{
                                           
                                           libraryTable.frame =CGRectMake(15, 45, [[UIScreen mainScreen] bounds].size.height, ([[UIScreen mainScreen] bounds].size.width - 45));
                                           [libraryTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                                       }
                                       completion:^(BOOL finished){ }];
                      
                  }
                      break;
                  case UIDeviceOrientationPortraitUpsideDown:
                  {
                      buttonusertrouble.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 45);
                      headerlabel.frame = CGRectMake(0,12.5, [[UIScreen mainScreen]bounds].size.width, 25);
                      [editButton setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width-59/2-5, (45-38/2)/2, 59/2, 38/2)];
                      [UIView animateWithDuration:1.0
                                       animations:^{
                                           libraryTable.frame =CGRectMake(0, 45, [[UIScreen mainScreen] bounds].size.width, ([[UIScreen mainScreen] bounds].size.height - 45));
                                           [libraryTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                                       }
                                       completion:^(BOOL finished){ }];
                  }
                      break;
                      
              };

          }
              break;
      }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
                    [self.view addSubview:buttonusertrouble];
                    
                    
                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,12.5, 320, 25)];
                    [headerlabel setTextColor:[UIColor whiteColor]];
                    [headerlabel setBackgroundColor:[UIColor clearColor]];
                    [headerlabel setText:@"Library"];
                    headerlabel.textAlignment = NSTextAlignmentCenter;
                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
                    [self.view addSubview:headerlabel];
                    
                    backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
                    [backButton addSubview:arrow_img];
                    [backButton addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:backButton];
                    
                    editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [editButton setFrame:CGRectMake(320-59/2-5, (45-38/2)/2, 59/2, 38/2)];
                    [editButton setBackgroundImage:[UIImage imageNamed:@"folder_for_lib@2x.png"] forState:UIControlStateNormal];
                    [editButton addTarget:self action:@selector(goToListing) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:editButton];
                }
                break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45)];
                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
                    [self.view addSubview:buttonusertrouble];
                    
                    
                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,12.5, [[UIScreen mainScreen]bounds].size.height, 25)];
                    [headerlabel setTextColor:[UIColor whiteColor]];
                    [headerlabel setBackgroundColor:[UIColor clearColor]];
                    [headerlabel setText:@"Library"];
                     headerlabel.textAlignment = NSTextAlignmentCenter;
                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
                    [self.view addSubview:headerlabel];
                    
                    backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
                    [backButton addSubview:arrow_img];
                    [backButton addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:backButton];
                    
                    editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [editButton setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.height-59/2-5, (45-38/2)/2, 59/2, 38/2)];
                    [editButton setBackgroundImage:[UIImage imageNamed:@"folder_for_lib@2x.png"] forState:UIControlStateNormal];
                    [editButton addTarget:self action:@selector(goToListing) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:editButton];
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45)];
                    buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
                    [self.view addSubview:buttonusertrouble];
                    
                    
                    headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,12.5, [[UIScreen mainScreen]bounds].size.height, 25)];
                    [headerlabel setTextColor:[UIColor whiteColor]];
                    [headerlabel setBackgroundColor:[UIColor clearColor]];
                    [headerlabel setText:@"Library"];
                     headerlabel.textAlignment = NSTextAlignmentCenter;
                    [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
                    [self.view addSubview:headerlabel];
                    
                    backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
                    UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
                    arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
                    [backButton addSubview:arrow_img];
                    [backButton addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:backButton];
                    
                    editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [editButton setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.height-59/2-5, (45-38/2)/2, 59/2, 38/2)];
                    [editButton setBackgroundImage:[UIImage imageNamed:@"folder_for_lib@2x.png"] forState:UIControlStateNormal];
                    [editButton addTarget:self action:@selector(goToListing) forControlEvents:UIControlEventTouchUpInside];
                    [self.view addSubview:editButton];
                }
                    break;
                    
            }
            break;
        case UIUserInterfaceIdiomPad :
            {
                switch (self.interfaceOrientation) {
                    case UIInterfaceOrientationPortrait:
                    {
                        buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 45)];
                        buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
                        [self.view addSubview:buttonusertrouble];
                        
                        
                        headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,12.5, [[UIScreen mainScreen]bounds].size.width, 25)];
                        [headerlabel setTextColor:[UIColor whiteColor]];
                        [headerlabel setBackgroundColor:[UIColor clearColor]];
                        [headerlabel setText:@"Library"];
                        headerlabel.textAlignment = NSTextAlignmentCenter;
                        [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
                        [self.view addSubview:headerlabel];
                        
                        backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
                        UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
                        arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
                        [backButton addSubview:arrow_img];
                        [backButton addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
                        [self.view addSubview:backButton];
                        
                        editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                        [editButton setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width-59/2-5, (45-38/2)/2, 59/2, 38/2)];
                        [editButton setBackgroundImage:[UIImage imageNamed:@"folder_for_lib@2x.png"] forState:UIControlStateNormal];
                        [editButton addTarget:self action:@selector(goToListing) forControlEvents:UIControlEventTouchUpInside];
                        [self.view addSubview:editButton];
                    }
                        break;
                    case UIInterfaceOrientationLandscapeLeft:
                    {
                        buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45)];
                        buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
                        [self.view addSubview:buttonusertrouble];
                        
                        
                        headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,12.5, [[UIScreen mainScreen]bounds].size.height, 25)];
                        [headerlabel setTextColor:[UIColor whiteColor]];
                        [headerlabel setBackgroundColor:[UIColor clearColor]];
                        [headerlabel setText:@"Library"];
                        headerlabel.textAlignment = NSTextAlignmentCenter;
                        [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
                        [self.view addSubview:headerlabel];
                        
                        backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
                        UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
                        arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
                        [backButton addSubview:arrow_img];
                        [backButton addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
                        [self.view addSubview:backButton];
                        
                        editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                        [editButton setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.height-59/2-5, (45-38/2)/2, 59/2, 38/2)];
                        [editButton setBackgroundImage:[UIImage imageNamed:@"folder_for_lib@2x.png"] forState:UIControlStateNormal];
                        [editButton addTarget:self action:@selector(goToListing) forControlEvents:UIControlEventTouchUpInside];
                        [self.view addSubview:editButton];
                    }
                        break;
                    case UIInterfaceOrientationLandscapeRight:
                    {
                        buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.height, 45)];
                        buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
                        [self.view addSubview:buttonusertrouble];
                        
                        
                        headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,12.5, [[UIScreen mainScreen]bounds].size.height, 25)];
                        [headerlabel setTextColor:[UIColor whiteColor]];
                        [headerlabel setBackgroundColor:[UIColor clearColor]];
                        [headerlabel setText:@"Library"];
                        headerlabel.textAlignment = NSTextAlignmentCenter;
                        [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
                        [self.view addSubview:headerlabel];
                        
                        backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
                        UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
                        arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
                        [backButton addSubview:arrow_img];
                        [backButton addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
                        [self.view addSubview:backButton];
                        
                        editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                        [editButton setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.height-59/2-5, (45-38/2)/2, 59/2, 38/2)];
                        [editButton setBackgroundImage:[UIImage imageNamed:@"folder_for_lib@2x.png"] forState:UIControlStateNormal];
                        [editButton addTarget:self action:@selector(goToListing) forControlEvents:UIControlEventTouchUpInside];
                        [self.view addSubview:editButton];
                    }
                        break;
                    case UIInterfaceOrientationPortraitUpsideDown:
                    {
                        buttonusertrouble = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 45)];
                        buttonusertrouble.image = [UIImage imageNamed:@"top-bar.png"];
                        [self.view addSubview:buttonusertrouble];
                        
                        
                        headerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,12.5, [[UIScreen mainScreen]bounds].size.width, 25)];
                        [headerlabel setTextColor:[UIColor whiteColor]];
                        [headerlabel setBackgroundColor:[UIColor clearColor]];
                        [headerlabel setText:@"Library"];
                        headerlabel.textAlignment = NSTextAlignmentCenter;
                        [headerlabel setFont:[UIFont fontWithName:@"MyriadPro-Bold" size:18.5]];
                        [self.view addSubview:headerlabel];
                        
                        backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32*2, 40)];
                        UIImageView *arrow_img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-up@2x.png"]];
                        arrow_img.frame = CGRectMake(20, 12.5f, 16, 12.5f);
                        [backButton addSubview:arrow_img];
                        [backButton addTarget:self action:@selector(goBack:)forControlEvents:UIControlEventTouchUpInside];
                        [self.view addSubview:backButton];
                        
                        editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                        [editButton setFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width-59/2-5, (45-38/2)/2, 59/2, 38/2)];
                        [editButton setBackgroundImage:[UIImage imageNamed:@"folder_for_lib@2x.png"] forState:UIControlStateNormal];
                        [editButton addTarget:self action:@selector(goToListing) forControlEvents:UIControlEventTouchUpInside];
                        [self.view addSubview:editButton];
                    }
                        break;
                    default:
                        break;
                }
            }
            break;
        }
    }
[self aboutimagetoshow];
}
-(void)aboutimagetoshow
{
    //--------------About UItableView---------------------//
    if (!assetsLibrary) {
        assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    if (!assets) {
        assets = [[NSMutableArray alloc] init];
    } else {
        [assets removeAllObjects];
    }
    if (!groups) {
        groups = [[NSMutableArray alloc] init];
    } else {
        [groups removeAllObjects];
    }
    tableVAppeared=NO;

    NSLog(@" asset count is %d",[assets count]);
//    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
//        if([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:albumName])
//        {
//            if (group) {
//                [groups addObject:group];
//                assetsGroup = group;
//                ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
//                    if (result) {
//                        tableVAppeared=YES;
//                        [assets addObject:result];
//                    }
//                };
//                
//                ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
//                [assetsGroup setAssetsFilter:onlyPhotosFilter];
//                [assetsGroup enumerateAssetsUsingBlock:assetsEnumerationBlock];
//            } else {
//                tableVAppeared=NO;
//                NSLog(@" where there is none");
//                
//            }
//            
//            
//        }
//        [self performSelectorOnMainThread:@selector(getAllAssets) withObject:nil waitUntilDone:NO];
//    };
//    
//    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
//        
//        NSString *errorMessage = nil;
//        switch ([error code]) {
//            case ALAssetsLibraryAccessUserDeniedError:
//            case ALAssetsLibraryAccessGloballyDeniedError:
//                errorMessage = @"The user has declined access to it.";
//                break;
//            default:
//                errorMessage = @"Reason unknown.";
//                break;
//        }
//
//    };
//
//    NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces;
//    [assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];

    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        
        NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                errorMessage = @"The user has declined access to it.";
                break;
            default:
                errorMessage = @"Reason unknown.";
                break;
        }
        
    };
    
   
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
        [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop)
         {
             if(asset)
             {
                 if(!tableVAppeared)
                 {
                     tableVAppeared = YES;
                 }
                 [assets addObject:asset];
             }
               NSLog(@" count  is now %d",[assets count]);
              [self performSelectorOnMainThread:@selector(getAllAssets) withObject:nil waitUntilDone:NO];
         }];
     }
                               failureBlock:failureBlock];
    

    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
    
}
-(void)goToListing
{
    FTPListingViewController *list = [[FTPListingViewController alloc] init];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:list animated:NO];
}
- (void)goBack:(id)sender {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)checkFTP
{
    __block NSString *serverOutput = nil;
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSError *error = nil;
        NSString *dir_path = [NSString stringWithFormat:@"../user/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]];
        NSString *the_url = [NSString stringWithFormat:@"%@iosphoto_action.php?dir=%@&action=image_file",mydomainurl,dir_path];
        NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString:[the_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSArray *json = [NSJSONSerialization
                         JSONObjectWithData: dataURL
                         options:kNilOptions
                         error:&error];
        
        if([json count]>0)
        {
            for (int i= 0; i<[json count];i++)
            {
                
                NSString *path = [NSString stringWithFormat:@"http://192.254.152.111/~photoxch/user/%@/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"],[json objectAtIndex:i]];
                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                UIImage *image = [UIImage imageWithData: data];
                                
                if(image!=nil)
                {
//                    [assetsLibrary saveImage:image toAlbum:albumName withCompletionBlock:^(NSError *error) {
//                        if (error!=nil) {
//                            NSLog(@"Save error: %@", [error description]);
//                          }
                    [assetsLibrary writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
                        
                        if (!error) {
                            dispatch_sync(dispatch_get_main_queue(), ^{
                                NSData *dataURL_delete =  [NSData dataWithContentsOfURL: [ NSURL URLWithString:[NSString stringWithFormat:@"%@iosphoto_action.php?dir=%@&file=%@&action=delete_image_file",mydomainurl,dir_path,[[json objectAtIndex:i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
                                
                                serverOutput = [[NSString alloc] initWithData:dataURL_delete encoding: NSUTF8StringEncoding];
//                                if([serverOutput isEqualToString:@"1"])
//                                {
//                                    [self aboutimagetoshow];
//                                }
//                                else
//                                {
//                                    NSLog(@"Faliure");
//                                }
                                
                            });
                        }
                       
                    }];
                }

                }
                
               
            }
   });
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
   
//    static_imgs = [[NSMutableArray alloc] initWithObjects:@"pic-1@2x.png",@"pic-2@2x.png",@"pic-3@2x.png",@"pic-4@2x.png",@"pic-5@2x.png",@"pic-6@2x.png",@"pic-7@2x.png",@"pic-8@2x.png",@"pic-9@2x.png",@"pic-10@2x.png",@"pic-11@2x.png",@"pic-12@2x.png",@"pic-13@2x.png",@"pic-14@2x.png",nil];
    [self checkFTP];

//        timer_foraction = [NSTimer scheduledTimerWithTimeInterval:1.5f
//                                                  target:self
//                                                selector:@selector(checkFTP)
//                                                userInfo:nil
//                                                 repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer_foraction forMode:NSRunLoopCommonModes];
}
- (void)getAllAssets {

    
    for (UIView *sub in self.view.subviews)
    {
         if([sub isKindOfClass:NSClassFromString(@"UITableView")])
         {
             [sub removeFromSuperview];
         }
    }
    
    
    if(tableVAppeared)
    {
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    libraryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, 320, (self.view.frame.size.height - 45))];
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    libraryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, [[UIScreen mainScreen]bounds].size.height, ([[UIScreen mainScreen]bounds].size.width - 45))];
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    libraryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, [[UIScreen mainScreen]bounds].size.height, ([[UIScreen mainScreen]bounds].size.width - 45))];
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                    libraryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, 320, (self.view.frame.size.height - 45))];
                }
                    break;
            }
        }
            break;
        case UIUserInterfaceIdiomPad:
        {
            switch(self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    libraryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, [[UIScreen mainScreen]bounds].size.width, (self.view.frame.size.height - 45))];
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    libraryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, [[UIScreen mainScreen]bounds].size.height, ([[UIScreen mainScreen]bounds].size.width - 45))];
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    libraryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, [[UIScreen mainScreen]bounds].size.height, ([[UIScreen mainScreen]bounds].size.width - 45))];
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                    libraryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, [[UIScreen mainScreen]bounds].size.width, (self.view.frame.size.height - 45))];
                }
                    break;
            }
        }
            break;
    }
//    if()
    [libraryTable setDelegate:self];
    [libraryTable setDataSource:self];
    [libraryTable setBackgroundColor:[UIColor clearColor]];
    [libraryTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    libraryTable.showsVerticalScrollIndicator=NO;
    [self.view addSubview:libraryTable];
    

    [libraryTable reloadData];
    }
    else
    {
        UILabel *notify = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 60)];
        notify.font = [UIFont systemFontOfSize:20];
        notify.textAlignment = NSTextAlignmentCenter;
        notify.text=@"There are no images to display";
        notify.backgroundColor = [UIColor clearColor];
        notify.textColor = [UIColor darkGrayColor];
        [self.view addSubview:notify];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    if (timer_foraction != nil)
    {
        [timer_foraction invalidate];
        timer_foraction = nil;
    }

    
    [libraryTable removeFromSuperview];
    [super viewWillDisappear:YES];
}
#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int returnval = 0;
    float data_count= 0.0f;
    switch (tableVAppeared) {
        case 1:
        {
            data_count = assets.count;
        }
        break;
            
        default:
        {
            //data_count = static_imgs.count;
            data_count = 0;
        }
        break;
    }
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIInterfaceOrientationPortrait:
                {
                    returnval= ceil((float) data_count/3);
                }
                break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    returnval= ceil((float) data_count/5);
                }
                break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    return returnval= ((float) data_count/5);
                }
                break;
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                    returnval= ceil((float) data_count/3); 
                }
                break;
            }
            break;
        }
        break;
        case UIUserInterfaceIdiomPad:
        {
            switch(self.interfaceOrientation)
            {
                case UIInterfaceOrientationPortrait:
                {
                    returnval= ceil((float) data_count/4);
                }
                break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    returnval= ceil((float) data_count/5);
                }
                break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    return returnval= ((float) data_count/5);
                }
                break;
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                     returnval= ceil((float) data_count/4);
                }
                break;
            }
            break;
        }
        break;
    }
    NSLog(@"Table rows: %d", assets.count);
    return returnval;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = nil;
    cell = [tableView cellForRowAtIndexPath:indexPath];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    // Configure the cell...
    
    int number_of_photos_to_display = 0;
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIInterfaceOrientationPortrait:
                {
                    number_of_photos_to_display = 3;
                }
                    break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    number_of_photos_to_display=5;
                }
                    break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    number_of_photos_to_display=5;
                }
                    break;
            }
            break;
        }
            break;
        case UIUserInterfaceIdiomPad:
        {
            switch(self.interfaceOrientation)
            {
                case UIInterfaceOrientationPortrait:
                {
                    number_of_photos_to_display = 4;
                }
                break;
                case UIInterfaceOrientationLandscapeLeft:
                {
                    number_of_photos_to_display=5;
                }
                break;
                case UIInterfaceOrientationLandscapeRight:
                {
                    number_of_photos_to_display=5;
                }
                    break;
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                    number_of_photos_to_display=4;
                }
                    break;
            }
            break;
        }
            break;
    }
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone:
        {
            NSUInteger firstPhotoInCell = indexPath.row * number_of_photos_to_display;
            NSUInteger lastPhotoInCell  = firstPhotoInCell + number_of_photos_to_display;
            
            NSUInteger lastPhotoIndex;
            if(tableVAppeared)
            {
                if (assets.count <= firstPhotoInCell) {
                    NSLog(@"We are out of range, asking to start with photo %d but we only have %d", firstPhotoInCell, assets.count);
                    return nil;
                }
                
                lastPhotoIndex = MIN(lastPhotoInCell, assets.count);
            }
            else
            {
                lastPhotoIndex = MIN(lastPhotoInCell, static_imgs.count);
                
            }
            
            for (NSUInteger currentPhotoIndex = 0 ; firstPhotoInCell + currentPhotoIndex < lastPhotoIndex ; currentPhotoIndex++) {
                
                UIImage *img = [[UIImage alloc] init];
                NSDate* date = [[NSDate alloc] init];
                if(tableVAppeared)
                {
                    ALAsset *asset = [assets objectAtIndex:firstPhotoInCell + currentPhotoIndex];
                    CGImageRef thumbnailImageRef = [asset thumbnail];
                    img = [UIImage imageWithCGImage:thumbnailImageRef];
                    date = [asset valueForProperty:ALAssetPropertyDate];
                    
                }
                
                else
                {
                    img = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[static_imgs objectAtIndex:firstPhotoInCell+currentPhotoIndex]]];
                }
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"MMM d, h:mm a"];
                
                float padLeft = (0 * (currentPhotoIndex + 1)) + (currentPhotoIndex * 213/2);
                
                UIView *imageContainer = [[UIView alloc] initWithFrame:CGRectMake(padLeft-2, 5, 213/2 ,194/2)];
                [imageContainer setBackgroundColor:[UIColor clearColor]];
                imageContainer.tag = (firstPhotoInCell + currentPhotoIndex);
                [imageContainer setUserInteractionEnabled:YES];
                [cell addSubview:imageContainer];
                
                UIImageView *albumV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 213/2, 194/2)];
                albumV.userInteractionEnabled = YES;
                albumV.tag = firstPhotoInCell + currentPhotoIndex;
                albumV.contentMode = UIViewContentModeScaleAspectFit;
                albumV.image = img;
                albumV.layer.borderColor = [UIColor blackColor].CGColor;
                albumV.layer.borderWidth = 2.0f;
                [imageContainer addSubview:albumV];
                
                
                UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewFullPic:)];
                [albumV addGestureRecognizer:tapgesture];
            }

            
        }
            break;
        case UIUserInterfaceIdiomPad:
        {
            NSUInteger firstPhotoInCell = indexPath.row * number_of_photos_to_display;
            NSUInteger lastPhotoInCell  = firstPhotoInCell + number_of_photos_to_display;
            
            NSUInteger lastPhotoIndex;
            if(tableVAppeared)
            {
                if (assets.count <= firstPhotoInCell) {
                    NSLog(@"We are out of range, asking to start with photo %d but we only have %d", firstPhotoInCell, assets.count);
                    return nil;
                }
                
                lastPhotoIndex = MIN(lastPhotoInCell, assets.count);
            }
            else
            {
                lastPhotoIndex = MIN(lastPhotoInCell, static_imgs.count);
                
            }
            
            for (NSUInteger currentPhotoIndex = 0 ; firstPhotoInCell + currentPhotoIndex < lastPhotoIndex ; currentPhotoIndex++) {
                
                UIImage *img = [[UIImage alloc] init];
                if(tableVAppeared)
                {
                    ALAsset *asset = [assets objectAtIndex:firstPhotoInCell + currentPhotoIndex];
                    CGImageRef thumbnailImageRef = [asset thumbnail];
                    img = [UIImage imageWithCGImage:thumbnailImageRef];
                   
                }
                
                else
                {
                    img = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[static_imgs objectAtIndex:firstPhotoInCell+currentPhotoIndex]]];
                }
                

                
                float padLeft = (0 * (currentPhotoIndex + 1)) + (currentPhotoIndex * 373/2);
                
                UIView *imageContainer = [[UIView alloc] initWithFrame:CGRectMake(padLeft-2, 5, 373/2 ,375/2)];
                [imageContainer setBackgroundColor:[UIColor clearColor]];
                imageContainer.tag = (firstPhotoInCell + currentPhotoIndex);
                [imageContainer setUserInteractionEnabled:YES];
                [cell addSubview:imageContainer];
                
                UIImageView *albumV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 373/2 ,375/2)];
                albumV.userInteractionEnabled = YES;
                albumV.tag = firstPhotoInCell + currentPhotoIndex;
                
                albumV.image = img;
                albumV.layer.borderColor = [UIColor blackColor].CGColor;
                albumV.layer.borderWidth = 2.0f;
                [imageContainer addSubview:albumV];
                
                
                UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewFullPic:)];
                [albumV addGestureRecognizer:tapgesture];
            }

        }
            break;
            
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int value = 0;
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPad:
        {
            value = 375/2;
        }
            break;
        case UIUserInterfaceIdiomPhone:
        {
            value = 194/2;
        }
    }
    return value;
}
- (void)viewFullPic:(UIGestureRecognizer *)gesture {
    

    UIImage *img = [[UIImage alloc] init];
    
    ImageDetailViewController *img_new = [[ImageDetailViewController alloc] init];
//    if(tableVAppeared)
//    {
    ALAsset *asset = [assets objectAtIndex:gesture.view.tag];
    CGImageRef thumbnailImageRef = [[asset defaultRepresentation] fullResolutionImage];
    img = [UIImage imageWithCGImage:thumbnailImageRef];
        img_new.image_data_from_library = [[NSMutableArray alloc] initWithCapacity:[assets count]];
        img_new.image_data_from_library = assets;
        img_new.imgtypestatic=NO;
//    }
//    else
//    {
//        img = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[static_imgs objectAtIndex:gesture.view.tag]]];
//        img_new.image_data_from_library = [[NSMutableArray alloc] initWithArray:static_imgs copyItems:YES];
//        img_new.imgtypestatic=YES;
//    }
    
    img_new.selected_image = [[UIImage alloc] init];
    img_new.selected_image = img;
    img_new.tag = gesture.view.tag;
    
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:img_new animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [self aboutimagetoshow];
    // Dispose of any resources that can be recreated.
}

@end
