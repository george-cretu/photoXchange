//
//  ShareFirstStepViewController.m
//  Photoapp
//
//  Created by Iphone_1 on 09/01/14.
//  Copyright (c) 2014 Esolz Technologies Pvt Ltd. All rights reserved.
//
#import "SVProgressHUD.h"
#import "KOTreeViewController.h"
#import "ShareFirstStepViewController.h"
#import "ImageGridCell.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import <DropboxSDK/DropboxSDK.h>
#import <stdlib.h>

CGSize CollectionViewCellSize = { .height = 75, .width = 75 };
NSString *CollectionViewCellIdentifier = @"SelectionDelegateExample";

@interface ShareFirstStepViewController ()
{
     PSUICollectionView *_gridView;
    ALAssetsLibrary *library;
    NSString *filename;
    NSTimer *timera;
    UIButton *button;
}
@property (nonatomic,retain) NSMutableArray *images_array_to_share;
@end

@implementation ShareFirstStepViewController
@synthesize image_urls,images_array_to_share,type;
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
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]]];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar@2x.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bar.png"] forBarMetrics:nil];
    }
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationItem setTitle:@"Select To Share"];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                           UITextAttributeFont: [UIFont fontWithName:@"MyriadPro-Bold" size:18.5],
                                                           }];
    
    button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(goBackToImageDetail:)forControlEvents:UIControlEventTouchUpInside];
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
    
    
    UIBarButtonItem *toggleMultiSelectButton = [[UIBarButtonItem alloc] initWithTitle:@"Upload" style:UIBarButtonItemStylePlain target:self action:@selector(GoToFtpShare)];
    [self.navigationItem setRightBarButtonItem:toggleMultiSelectButton];
    
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    
    self.navigationController.navigationBarHidden = NO;
    
    
    [self createGridView];

}
-(void)goBackToImageDetail:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)GoToFtpShare
{
    if ([images_array_to_share count] == 0)
    {
        UIAlertView *show_alert1;
        show_alert1 = [[UIAlertView alloc] initWithTitle:@"No Image selected!!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [show_alert1 show];

    }
    else
    {
    if(type==Email)
    {
        if ([MFMailComposeViewController canSendMail]==YES)
        {
            
            MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
            controller.mailComposeDelegate = self;
            
            if (self.title)
                [controller setSubject:@"via PhotoXchange"];
            
            //Create a string with HTML formatting for the email body
            NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@"<html><body>"];
            //Add some text to it however you want
            
            //                    NSString *strURL = [[NSURL URLWithString:@"www.google.com"] absoluteString];
            //                    [emailBody appendString:[NSString stringWithFormat:@"<p><a href='%@'>%@</a></p>", strURL, strURL]];
            
            [emailBody appendString:[NSString stringWithFormat:@"<p>via PXC </p>"]];
            
            //close the HTML formatting
            [emailBody appendString:@"</body></html>"];
            
            [controller setMessageBody:emailBody isHTML:YES];
            
            ALAssetsLibrary *library_of_phone = [[ALAssetsLibrary alloc] init];
            for (NSString *yourImagePath in images_array_to_share )
            {
                [library_of_phone assetForURL:[NSURL URLWithString:yourImagePath] resultBlock:^(ALAsset *asset)
                {
                   NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:1.0 orientation:[[asset defaultRepresentation] orientation]], 1.0);
                    [controller addAttachmentData:imageData mimeType:@"image/jpeg" fileName:[NSString
                                                                                           stringWithFormat:@"a.jpg"]];
                    
                } failureBlock:^(NSError *error) {}];
            }
            
            [self.navigationController presentViewController:controller animated:YES completion:nil];
#if !__has_feature(objc_arc)
            [controller release];
            [emailBody release];
#endif
        }
        else
        {
            NSString *deviceType        = [UIDevice currentDevice].model;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"")
                                                            message:[NSString stringWithFormat:NSLocalizedString(@"Your %@ must have an email account set up", @""), deviceType]
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"Ok", @"")
                                                  otherButtonTitles:nil];
            [alert show];
#if !__has_feature(objc_arc)
            [alert release];
#endif
        }
    }
    else if (type==FTP)
    {
        NSLog(@"ftp type");
        KOTreeViewController *tree = [[KOTreeViewController alloc] init];
        tree.original_array=image_urls;
        tree.img_to_shared_array = images_array_to_share;
        tree.type =@"UPLOAD";
        CATransition* transition = [CATransition animation];
        transition.duration = 0.25;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:tree animated:NO];
    }
    
    else
    {
//        NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
//        UIImage *image = [[UIImage alloc] initWithData:data];
//        UIImage *image = [UIImage imageWithData:data];
        
//        NSMutableArray *newimgarr = [[NSMutableArray alloc]init];
//        if ([images_array_to_share count]> 5)
//        {
//            NSLog(@"pach er beshi %d",[images_array_to_share count]);
//            for (int imgno= 0; imgno< 5; imgno++)
//            {
//                [newimgarr addObject:[images_array_to_share objectAtIndex:imgno]];
//            }
//            
//            NSLog(@"first tym count: %d",[newimgarr count]);
//            
//            if( [[DBSession sharedSession] isLinked])
//            {
//                NSLog(@"in dropbox if");
//                restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
//                restClient.delegate = self;
//                ALAssetsLibrary *library_of_phone = [[ALAssetsLibrary alloc] init];
//                for (NSString *yourImagePath in newimgarr )
//                {
//                    NSLog(@"called once");
//                    [library_of_phone assetForURL:[NSURL URLWithString:yourImagePath] resultBlock:^(ALAsset *asset)
//                     {
//                         NSString* originalFileName = [[asset defaultRepresentation] filename];
//                         
//                         NSLog(@"filename tulche: %@",originalFileName);
//                         NSArray* foo = [originalFileName componentsSeparatedByString: @"."];
//                         NSString* originalfn = [foo objectAtIndex: 0];
//                         
//                         NSDateFormatter *formatter;
//                         NSString        *dateString;
//                         
//                         formatter = [[NSDateFormatter alloc] init];
//                         [formatter setDateFormat:@"dd-MM-yyyyHH:mm:ss"];
//                         
//                         dateString = [formatter stringFromDate:[NSDate date]];
//                         NSLog(@"datestring gives: %@",dateString);
//                         
//                         
//                         
//                         NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:1.0 orientation:[[asset defaultRepresentation] orientation]], 1.0);
//                         
//                         UIImage *newimage = [UIImage imageWithData:imageData];
//                         
//                         //                     NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//                         //                     NSMutableString *randomString = [NSMutableString stringWithCapacity: 12];
//                         //                     for (int i=0; i<12; i++)
//                         //                     {
//                         //                         [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
//                         //                     }
//                         NSString *upldstr= [NSString stringWithFormat:@"%@%@",originalfn,dateString];
//                         NSLog(@"upldstr --------- %@",upldstr);
//                         
//                         filename = [NSString stringWithFormat:@"%@.png",upldstr];
//                         NSString *tmpPngFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Temp.png"];
//                         
//                         
//                         [UIImagePNGRepresentation(newimage) writeToFile:tmpPngFile atomically:YES];
//                         
//                         //                NSString *destDir = @"/";
//                         NSString *destDir = @"/pXc Photos";
//                         [restClient uploadFile:filename toPath:destDir
//                                  withParentRev:nil fromPath:tmpPngFile];
//                         
//                     } failureBlock:^(NSError *error) {}];
//                }
//                
//                //       [SVProgressHUD showSuccessWithStatus:@"Image has been successfully uploaded to the Photos folder of your Dropbox"];
//                
//                timera = [NSTimer scheduledTimerWithTimeInterval:30.0
//                                                          target:self
//                                                        selector:@selector(targetMethod)
//                                                        userInfo:nil
//                                                         repeats:NO];
//
//            }
//            else
//            {
//                NSLog(@"in dropbox else");
//                NSString *tmpPngFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Temp.png"];
//                
//                AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//                delegate.dropboxarr = newimgarr;
//                delegate.imgvwr=@"no";
//                
//                [[DBSession sharedSession] linkFromController:self];
//                [[NSUserDefaults standardUserDefaults] setObject:tmpPngFile forKey:@"whatwesaved"];
//            }
//        }
        
        
//        ------------------------------------------------------------------------------------------------------------------------
//        else
//        {
        if( [[DBSession sharedSession] isLinked])
        {
            NSLog(@"in dropbox if");
            restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
            restClient.delegate = self;
            ALAssetsLibrary *library_of_phone = [[ALAssetsLibrary alloc] init];
            for (NSString *yourImagePath in images_array_to_share )
            {
                NSLog(@"called once");
                @try {
                    [library_of_phone assetForURL:[NSURL URLWithString:yourImagePath] resultBlock:^(ALAsset *asset)
                 {
                     NSString* originalFileName = [[asset defaultRepresentation] filename];
                     
                     NSLog(@"filename tulche: %@",originalFileName);
                     NSArray* foo = [originalFileName componentsSeparatedByString: @"."];
                     NSString* originalfn = [foo objectAtIndex: 0];
                     
                     NSDateFormatter *formatter;
                     NSString        *dateString;
                     
                     formatter = [[NSDateFormatter alloc] init];
                     [formatter setDateFormat:@"dd-MM-yyyy-HH:mm:ss"];
                     
                     dateString = [formatter stringFromDate:[NSDate date]];
                     NSLog(@"datestring gives: %@",dateString);
                     
                     
                     
                     NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:1.0 orientation:[[asset defaultRepresentation] orientation]], 1.0);
                    
                     UIImage *newimage = [UIImage imageWithData:imageData];
                     
//                     NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//                     NSMutableString *randomString = [NSMutableString stringWithCapacity: 12];
//                     for (int i=0; i<12; i++)
//                     {
//                         [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
//                     }
                     NSString *upldstr= [NSString stringWithFormat:@"%@-%@",originalfn,dateString];
                     NSLog(@"upldstr --------- %@",upldstr);
                     
                     filename = [NSString stringWithFormat:@"%@.png",upldstr];
                     NSString *tmpPngFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Temp.png"];
                     
                     
                     [UIImagePNGRepresentation(newimage) writeToFile:tmpPngFile atomically:YES];
                     
                     //                NSString *destDir = @"/";
                     NSString *destDir = @"/pXc Photos";
                     [restClient uploadFile:filename toPath:destDir
                              withParentRev:nil fromPath:tmpPngFile];

                 } failureBlock:^(NSError *error) {}];
                    
                }
                @catch (NSException *exception) {
                    NSLog(@"exception dropbox: %@",exception);
                }
                @finally {
                }

            }

            //       [SVProgressHUD showSuccessWithStatus:@"Image has been successfully uploaded to the Photos folder of your Dropbox"];
            [NSThread detachNewThreadSelector:@selector(showsts:) toTarget:self withObject:@"Successfully uploaded to the pXc Photos folder of your Dropbox"];
        }
        else
        {
            NSLog(@"in dropbox else");
            NSString *tmpPngFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Temp.png"];
            
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            delegate.dropboxarr = images_array_to_share;
            delegate.imgvwr=@"no";
            
            [[DBSession sharedSession] linkFromController:self];
            [[NSUserDefaults standardUserDefaults] setObject:tmpPngFile forKey:@"whatwesaved"];
        }
//        }
    }
  }
}

-(void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error {
    
    NSLog(@"File upload failed with error - %@", error.userInfo);
    
    NSString *myfile=[error.userInfo valueForKey:@"sourcePath"];
    
    NSString *destDir = @"/pXc Photos";

    
    [self.restClient uploadFile:filename toPath:destDir withParentRev:nil fromPath:myfile];
}

- (void)mailComposeController:(MFMailComposeViewController*)mailController  didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
{
    switch (result)
    {
        case MFMailComposeResultSent:
        {
            [mailController dismissViewControllerAnimated:YES completion:^{
                [SVProgressHUD showSuccessWithStatus:@"Successfully mailed"];
                [self.navigationController popViewControllerAnimated:NO];
            }];
            
            
        }
            break;
            
        case MFMailComposeResultCancelled:
        case MFMailComposeResultFailed:
        case MFMailComposeResultSaved:
            
            [mailController dismissViewControllerAnimated:YES completion:nil];
            break;
            
        default:
            break;
    }
    
    
}

- (void)createGridView
{
    PSUICollectionViewFlowLayout *layout = [[PSUICollectionViewFlowLayout alloc] init];
    _gridView = [[PSUICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    CGFloat width_tbl,height_tbl;
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            width_tbl = [[UIScreen mainScreen]bounds].size.height;
            height_tbl = [[UIScreen mainScreen]bounds].size.width-20;
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            {
                _gridView.frame = CGRectMake(0, 0, width_tbl, height_tbl-20);
            }
            else
            {
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"started"] isEqualToString:@"yes"])
                  _gridView.frame = CGRectMake(0, -40, width_tbl, height_tbl+20-40);
                else
                _gridView.frame = CGRectMake(0, 0, width_tbl, height_tbl+20);
            }
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        case UIInterfaceOrientationPortrait:
        {
            height_tbl = [[UIScreen mainScreen]bounds].size.height-114/2;
            width_tbl = [[UIScreen mainScreen]bounds].size.width;
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            {
                _gridView.frame = CGRectMake(0, 0, width_tbl, height_tbl-20);
            }
            else
            {
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"started"] isEqualToString:@"yes"])
                    _gridView.frame = CGRectMake(0, -40, width_tbl, height_tbl+20-40);
                else
                _gridView.frame = CGRectMake(0, 0, width_tbl, height_tbl+20);
            }
        }
            break;
    }
    
//    _gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _gridView.delegate = self;
    _gridView.dataSource = self;
    _gridView.backgroundColor = [UIColor clearColor];
    _gridView.allowsMultipleSelection=YES;
    [_gridView registerClass:[ImageGridCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    
    [self.view addSubview:_gridView];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[ver objectAtIndex:0] intValue] <= 6)
    {
    
        [_gridView setContentInset:UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height, 5, 0, -5)];
    }
    
    images_array_to_share = [[NSMutableArray alloc] init];
    library = [[ALAssetsLibrary alloc] init];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
}
- (void) orientationChanged:(NSNotification *)note
{
    
    
    CGFloat width_tbl,height_tbl;
//    UIDevice * device = note.object;
    
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationPortrait ||
        orientation == UIDeviceOrientationLandscapeLeft ||
        orientation == UIDeviceOrientationLandscapeRight)
    {
        switch(orientation)
        {
//            case UIDeviceOrientationFaceDown:
//            case UIDeviceOrientationFaceUp:
//            case UIDeviceOrientationUnknown:
//                break;
            case UIDeviceOrientationPortraitUpsideDown:
                
                break;
            case UIDeviceOrientationPortrait:
            {
               
                height_tbl = [[UIScreen mainScreen]bounds].size.height-114/2;
                width_tbl = [[UIScreen mainScreen]bounds].size.width;
                
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
                {
                    _gridView.frame = CGRectMake(0, 0, width_tbl, height_tbl-20);
                }
                else
                {
                    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"started"] isEqualToString:@"yes"])
                        _gridView.frame = CGRectMake(0, -40, width_tbl, height_tbl+20-40);
                    else
                    _gridView.frame = CGRectMake(0, 0, width_tbl, height_tbl+20);
                }
            }
                break;
            case UIDeviceOrientationLandscapeLeft:
            case UIDeviceOrientationLandscapeRight:
            {
               
                width_tbl = [[UIScreen mainScreen]bounds].size.height;
                height_tbl = [[UIScreen mainScreen]bounds].size.width-20;
                
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
                {
                    _gridView.frame = CGRectMake(0, 0, width_tbl, height_tbl-20);
                }
                else
                {
                    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"started"] isEqualToString:@"yes"])
                        _gridView.frame = CGRectMake(0, -40, width_tbl, height_tbl+20-40);
                    else
                    _gridView.frame = CGRectMake(0, 0, width_tbl, height_tbl+20);
                }
            }
                break;
        }
        
       // [_gridView reloadData];
    }
   
//    CGFloat width_tbl,height_tbl;
//    switch (self.interfaceOrientation) {
//        case UIInterfaceOrientationLandscapeLeft:
//        case UIInterfaceOrientationLandscapeRight:
//        {
//            width_tbl = [[UIScreen mainScreen]bounds].size.height;
//            height_tbl = [[UIScreen mainScreen]bounds].size.width-20;
//            
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//            {
//                _gridView.frame = CGRectMake(0, 0, width_tbl, height_tbl-20);
//            }
//            else
//            {
//                _gridView.frame = CGRectMake(0, 0, width_tbl, height_tbl+20);
//            }
//        }
//            break;
//        case UIInterfaceOrientationPortraitUpsideDown:
//            break;
//        case UIInterfaceOrientationPortrait:
//        {
//            height_tbl = [[UIScreen mainScreen]bounds].size.height-114/2;
//            width_tbl = [[UIScreen mainScreen]bounds].size.width;
//            
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//            {
//                _gridView.frame = CGRectMake(0, 0, width_tbl, height_tbl-20);
//            }
//            else
//            {
//                _gridView.frame = CGRectMake(0, 0, width_tbl, height_tbl+20);
//            }
//        }
//            break;
//    }

    
    
    
}

#pragma mark -
#pragma mark Collection View Data Source

- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
   
    
    [library assetForURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[image_urls objectAtIndex:indexPath.row]]] resultBlock:^(ALAsset *asset) {
        
        if(asset)
        {
            cell.image.image=[UIImage imageWithCGImage:[asset thumbnail] scale:1.0 orientation:[[asset defaultRepresentation] orientation]];

        }
    } failureBlock:^(NSError *error) {
        
    }];
    cell.contentView.tag = indexPath.row;
    
    return cell;
}
- (CGSize)collectionView:(PSUICollectionView *)collectionView layout:(PSUICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CollectionViewCellSize;
}

- (NSInteger)collectionView:(PSUICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [image_urls count];
}

#pragma mark -
#pragma mark Collection View Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (type ==Email || type == FTP)
     {
       if([images_array_to_share count]<10)
        {
         [images_array_to_share addObject:[NSString stringWithFormat:@"%@",[image_urls objectAtIndex:indexPath.row]]];
         ImageGridCell *cell = (ImageGridCell*)[collectionView cellForItemAtIndexPath:indexPath];
         cell.overlayView.hidden = NO;
        }
       else
        {
         [SVProgressHUD showErrorWithStatus:@"User can select only 10 images"];
        }
     }
    else
    {
        if([images_array_to_share count]<5)
        {
            [images_array_to_share addObject:[NSString stringWithFormat:@"%@",[image_urls objectAtIndex:indexPath.row]]];
            ImageGridCell *cell = (ImageGridCell*)[collectionView cellForItemAtIndexPath:indexPath];
            cell.overlayView.hidden = NO;
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"User can select only 5 images"];
        }

    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [images_array_to_share removeObject:[NSString stringWithFormat:@"%@",[image_urls objectAtIndex:indexPath.row]]];
    ImageGridCell *cell = (ImageGridCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.overlayView.hidden = YES;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 0, 0);
}
- (CGFloat)collectionView:(PSUICollectionView *)collectionView layout:(PSUICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (DBRestClient*)restClient {
    if (restClient == nil) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}

-(void)showsts:(NSString *)status
{
    [SVProgressHUD showSuccessWithStatus:status];
}


//-(void)targetMethod
//{
//    NSLog(@"now etay dhuklo");
//    NSMutableArray *second_array = [[NSMutableArray alloc]init];
//    for (int imgnos= 5; imgnos< [images_array_to_share count]; imgnos++)
//    {
//        [second_array addObject:[images_array_to_share objectAtIndex:imgnos]];
//    }
//    NSLog(@"now etay dhuklo %d",[second_array count]);
//
//    if( [[DBSession sharedSession] isLinked])
//    {
//        NSLog(@"in dropbox if");
//        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
//        restClient.delegate = self;
//        ALAssetsLibrary *library_of_phone = [[ALAssetsLibrary alloc] init];
//        for (NSString *yourImagePath in second_array)
//        {
//            NSLog(@"called once");
//            [library_of_phone assetForURL:[NSURL URLWithString:yourImagePath] resultBlock:^(ALAsset *asset)
//             {
//                 NSString* originalFileName = [[asset defaultRepresentation] filename];
//                 
//                 NSLog(@"filename tulche: %@",originalFileName);
//                 NSArray* foo = [originalFileName componentsSeparatedByString: @"."];
//                 NSString* originalfn = [foo objectAtIndex: 0];
//                 
//                 NSDateFormatter *formatter;
//                 NSString        *dateString;
//                 
//                 formatter = [[NSDateFormatter alloc] init];
//                 [formatter setDateFormat:@"dd-MM-yyyyHH:mm:ss"];
//                 
//                 dateString = [formatter stringFromDate:[NSDate date]];
//                 NSLog(@"datestring gives: %@",dateString);
//                 
//                 
//                 
//                 NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:1.0 orientation:[[asset defaultRepresentation] orientation]], 1.0);
//                 
//                 UIImage *newimage = [UIImage imageWithData:imageData];
//                 
//                 //                     NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//                 //                     NSMutableString *randomString = [NSMutableString stringWithCapacity: 12];
//                 //                     for (int i=0; i<12; i++)
//                 //                     {
//                 //                         [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
//                 //                     }
//                 NSString *upldstr= [NSString stringWithFormat:@"%@%@",originalfn,dateString];
//                 NSLog(@"upldstr --------- %@",upldstr);
//                 
//                 filename = [NSString stringWithFormat:@"%@.png",upldstr];
//                 NSString *tmpPngFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Temp.png"];
//                 
//                 
//                 [UIImagePNGRepresentation(newimage) writeToFile:tmpPngFile atomically:YES];
//                 
//                 //                NSString *destDir = @"/";
//                 NSString *destDir = @"/pXc Photos";
//                 [restClient uploadFile:filename toPath:destDir
//                          withParentRev:nil fromPath:tmpPngFile];
//                 
//                  [NSThread detachNewThreadSelector:@selector(showsts:) toTarget:self withObject:@"Image has been successfully uploaded to the pXc Photos folder of your Dropbox"];
//             } failureBlock:^(NSError *error) {}];
//        }
//    }
//    [timera invalidate];
//}
@end