//
//  AlbumPickerController.m
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "ELCAlbumPickerController.h"
#import "ELCImagePickerController.h"
#import "ELCAssetTablePicker.h"
#import "FTPListingViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"
@interface ELCAlbumPickerController () <UIActionSheetDelegate>
{
    int x_postion_for_drop_down_menu,y_position_for_name_view,height_for_drop_down_menu;
}
@property (nonatomic, retain) ALAssetsLibrary *library;

@end

@implementation ELCAlbumPickerController

@synthesize parent = _parent;
@synthesize assetGroups = _assetGroups;
@synthesize library = _library;
@synthesize drop_dow_menu = _drop_dow_menu;
@synthesize name_view = _name_view;
#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"yes elc album picker");
    

    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar@2x.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top-bar.png"] forBarMetrics:nil];
    }
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationItem setTitle:@"Loading..."];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];

    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"Back"
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(goToHome)];
    [btnBack setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = btnBack;
    
    UIBarButtonItem *btn_for_ftp = [[UIBarButtonItem alloc]
                                initWithTitle:@"More"
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(editItem:)];
    [btn_for_ftp setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
     self.navigationItem.rightBarButtonItem = btn_for_ftp;
//    UIImage *background = [UIImage imageNamed:@"more@2x.png"];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self action:@selector(editItem:) forControlEvents:UIControlEventTouchUpInside]; //adding action
//    [button setBackgroundImage:background forState:UIControlStateNormal];
//    button.frame = CGRectMake(0 ,0,35,35);
//    
//    UIBarButtonItem *editButton= [[UIBarButtonItem alloc] initWithCustomView:button ];
//    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:editButton, nil];


    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.assetGroups = tempArray;
    [tempArray release];
    
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    self.library = assetLibrary;
    [assetLibrary release];

    // Load Albums into assetGroups
    dispatch_async(dispatch_get_main_queue(), ^
    {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        // Group enumerator Block
        void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop) 
        {
            if (group == nil) {
                return;
            }
            
            
            NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
            NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
            
//            if ([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] && nType == ALAssetsGroupSavedPhotos) {
//                [self.assetGroups insertObject:group atIndex:0];
//            }
//            else {
//                [self.assetGroups addObject:group];
//            }
            
            if (([[sGroupPropertyName lowercaseString] isEqualToString:@"saved photos"] || [[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"]) && nType == ALAssetsGroupSavedPhotos) {
                [self.assetGroups insertObject:group atIndex:0];
            }
            else {
                [self.assetGroups addObject:group];
            }

            [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
        };
        
        // Group Enumerator Failure Block
        void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            NSLog(@"A problem occured %@", [error description]);	                                 
        };	
                
       
        [self.library enumerateGroupsWithTypes:ALAssetsGroupAll
                               usingBlock:assetGroupEnumerator 
                             failureBlock:assetGroupEnumberatorFailure];
        
        [pool release];
    });
    
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
   
    switch (self.interfaceOrientation) {
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
    
    _drop_dow_menu = [[UIView alloc] initWithFrame:CGRectMake(x_postion_for_drop_down_menu-150, 0, 150, 0)];
    _drop_dow_menu.backgroundColor = [UIColor clearColor];
    _drop_dow_menu.autoresizesSubviews = YES;
//    _drop_dow_menu.layer.borderColor=[[UIColor lightGrayColor] CGColor];
//    _drop_dow_menu.layer.borderWidth=0.75f;
    _drop_dow_menu.clipsToBounds = YES;
    [_drop_dow_menu layoutSubviews];
    
    for (int count = 0;count<2;count++)
    {
       CGRect btn_frame =  CGRectMake(0, 0, 150, 0);
        NSString *title=nil;
        switch (count) {
            case 0:
            {
                title=@"Add Album";
            }
                break;
            case 1:
            {
                title = @"Your Web Folders";
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
        
        [btn addTarget:self action:@selector(btn_functions:) forControlEvents:UIControlEventTouchUpInside];
        [_drop_dow_menu addSubview:btn];
    }
   
    _name_view = [[UIView alloc] initWithFrame:CGRectMake((x_postion_for_drop_down_menu-300)/2, (y_position_for_name_view - 220)/2, 300, 90)];
    _name_view.backgroundColor = [UIColor whiteColor];
    _name_view.hidden = YES;
    _name_view.userInteractionEnabled = YES;
    
    UITextField *txt_view = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 280, 45)];
    txt_view.placeholder = @"Provide Album Name";
    txt_view.delegate = self;
    txt_view.textAlignment = NSTextAlignmentCenter;
    [_name_view addSubview:txt_view];
    
    for (int count = 0;count<2;count++)
    {
        UIButton *name_view_btn = [[UIButton alloc] init];
        CGRect btn_frame = CGRectMake(0, 46, 300/2-5, 44);
        NSString *title= nil;
        switch (count) {
            case 0:
            {
                btn_frame.origin.x=3;
                title = @"Add";
            }
                break;
                
            case 1:
            {
                btn_frame.origin.x=300/2+1;
                title = @"Cancel";
            }
                break;
        }
        name_view_btn.frame = btn_frame;
        [name_view_btn setTitle:title forState:UIControlStateNormal];
        [name_view_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [name_view_btn setTag:count];
        [name_view_btn setBackgroundColor:[UIColor colorWithRed:(105.0f/255.0f) green:(164.0f/255.0f) blue:(194.0f/255.0f) alpha:1.0]];
        [name_view_btn addTarget:self action:@selector(name_view_functions:) forControlEvents:UIControlEventTouchUpInside];
        [_name_view addSubview:name_view_btn];
    }
    [self.view addSubview:_name_view];
    [self.view bringSubviewToFront:_name_view];
    
    [self.view addSubview:_drop_dow_menu];
}

-(void)viewDidAppear:(BOOL)animated
{
     [super viewDidAppear:YES];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars=NO;
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChangedinThisView:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
}
- (void) orientationChangedinThisView:(NSNotification *)note
{
    UIDevice * device = note.object;
    
    
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
        {
            
             x_postion_for_drop_down_menu =[[UIScreen mainScreen]bounds].size.width;
              y_position_for_name_view =[[UIScreen mainScreen] bounds].size.height;
        }
            break;
            
        case UIDeviceOrientationLandscapeRight:
        case UIDeviceOrientationLandscapeLeft:
        {
           
            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
              y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
        }
            break;
       
        case UIDeviceOrientationPortraitUpsideDown:
        case UIDeviceOrientationUnknown:
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationFaceUp:
        {
            
        }
            break;
    }
    

        if(_drop_dow_menu.frame.size.height>0)
        {
            _drop_dow_menu.frame =CGRectMake(x_postion_for_drop_down_menu-150, 0, 150, height_for_drop_down_menu);
            
            for (UIView *sub in _drop_dow_menu.subviews)
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
            
        }
        else
        {
            _drop_dow_menu.frame =CGRectMake(x_postion_for_drop_down_menu-150, 0, 150, 0);
            for (UIView *sub in _drop_dow_menu.subviews)
            {
                if([sub isKindOfClass:[UIButton class]])
                {
                    UIButton *btn = (UIButton *)sub;
                    CGRect frame_btn = btn.frame;
                    frame_btn.size.height = 0;
                    frame_btn.origin.y=0;
                    btn.frame = frame_btn;
                }
            }
        }
    
    if(!_name_view.hidden)
    {
        CGRect frame_name_view = _name_view.frame;
        frame_name_view.origin.x = (x_postion_for_drop_down_menu - 300)/2;
        frame_name_view.origin.y = (y_position_for_name_view-220)/2;
        _name_view.frame = frame_name_view;
    }
}
-(void)editItem:(id)sender
{
    
//    if(_drop_dow_menu.frame.size.height>0)
//    {
//        [UIView animateWithDuration:0.5 animations:^{
//           
//            _drop_dow_menu.frame =CGRectMake(x_postion_for_drop_down_menu-150, 0, 150, 0);
//            for (UIView *sub in _drop_dow_menu.subviews)
//            {
//                if([sub isKindOfClass:[UIButton class]])
//                {
//                    UIButton *btn = (UIButton *)sub;
//                    CGRect frame_btn = btn.frame;
//                    frame_btn.size.height = 0;
//                    btn.frame = frame_btn;
//                }
//            }
//            
//            self.tableView.userInteractionEnabled = YES;
//            [UIView transitionWithView: _name_view
//                              duration: 1.00f
//                               options: UIViewAnimationOptionTransitionCrossDissolve
//                            animations: ^(void)
//             {
//                 _name_view.hidden = YES;
//             }
//                            completion: ^(BOOL isFinished){ }];
//        }];
//    }
//    else
//    {
//        [UIView animateWithDuration:0.5 animations:^{
//            _drop_dow_menu.frame =CGRectMake(x_postion_for_drop_down_menu-150, 0, 150, height_for_drop_down_menu);
//            
//            for (UIView *sub in _drop_dow_menu.subviews)
//            {
//                if([sub isKindOfClass:[UIButton class]])
//                {
//                    UIButton *btn = (UIButton *)sub;
//                    CGRect frame_btn = btn.frame;
//                    switch (btn.tag) {
//                        case 0:
//                        {
//                            frame_btn.origin.y=0;
//                        }
//                            break;
//                        case 1:
//                        {
//                            if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad)
//                            {
//                                 frame_btn.origin.y=height_for_drop_down_menu/2+1.0f;
//                            }
//                            else
//                            {
//                                 frame_btn.origin.y=height_for_drop_down_menu/4+1.0f;
//                            }
//                           
//                        }
//                            break;
//                    }
//                    if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad)
//                    {
//                        CGFloat height = height_for_drop_down_menu/2;
//                        frame_btn.size.height = height;
//                        btn.frame = frame_btn;
//                    }
//                    else
//                    {
//                        CGFloat height = height_for_drop_down_menu/4;
//                        frame_btn.size.height = height;
//                        btn.frame = frame_btn;
//                    }
//                   
//                }
//            }
//            
//            if(!_name_view.hidden)
//            {
//                [UIView transitionWithView: _name_view
//                                  duration: 1.00f
//                                   options: UIViewAnimationOptionTransitionCrossDissolve
//                                animations: ^(void)
//                 {
//                     _name_view.hidden = YES;
//                 }completion: ^(BOOL isFinished)
//                 { }];
//                
//            }
//        }];
//    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Your Action"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel Button"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Add Album", @"Your Web Folders",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    

    if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad)
    {
      [actionSheet addButtonWithTitle:@"Cancel"];
    }
    [actionSheet showInView:self.view];
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Image from..."
//                                                             delegate:self
//                                                    cancelButtonTitle:@"Cancel"
//                                               destructiveButtonTitle:@"Cancel"
//                                                    otherButtonTitles:@"Take Photo", @"Choose from library", nil];
//    
//    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
//    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
//    [actionSheet showInView:self.view];
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {

        case 0:
          {
              NSLog(@"here here");
              [UIView transitionWithView: _name_view
                                duration: 1.00f
                                 options: UIViewAnimationOptionTransitionCrossDissolve
                              animations: ^(void)
               {
                   [UIView animateWithDuration:0.5 animations:^{
                       _drop_dow_menu.frame =CGRectMake(x_postion_for_drop_down_menu-150, 0, 150, 0);
                       for (UIView *sub in _drop_dow_menu.subviews)
                       {
                           if([sub isKindOfClass:[UIButton class]])
                           {
                               UIButton *btn = (UIButton *)sub;
                               CGRect frame_btn = btn.frame;
                               frame_btn.size.height = 0;
                               btn.frame = frame_btn;
                           }
                       }
                   }];
                   
                   _name_view.hidden = NO;
               }completion: ^(BOOL isFinished)
               { }];

          }
            break;
            
        case 1:
          {
              AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
              delegate.libopen = NO;
              
              FTPListingViewController *list = [[FTPListingViewController alloc] init];
              CATransition* transition = [CATransition animation];
              transition.duration = 0.5;
              transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
              transition.type = kCATransitionFade;
              [self.navigationController.view.layer addAnimation:transition forKey:nil];
              [self.navigationController pushViewController:list animated:NO];

          }
            break;
    }
}




-(void)btn_functions:(UIButton *)sender
{
    if([[NSString stringWithFormat:@"%@",[sender titleForState:UIControlStateNormal]] isEqualToString:@"Your Web Folders"])
    {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.libopen = NO;
        
        FTPListingViewController *list = [[FTPListingViewController alloc] init];
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:list animated:NO];
    }
    else
    {
        switch (sender.tag) {
            case 0:
            {
                NSLog(@"here here");
                [UIView transitionWithView: _name_view
                                  duration: 1.00f
                                   options: UIViewAnimationOptionTransitionCrossDissolve
                                animations: ^(void)
                 {
                     [UIView animateWithDuration:0.5 animations:^{
                         _drop_dow_menu.frame =CGRectMake(x_postion_for_drop_down_menu-150, 0, 150, 0);
                         for (UIView *sub in _drop_dow_menu.subviews)
                         {
                             if([sub isKindOfClass:[UIButton class]])
                             {
                                 UIButton *btn = (UIButton *)sub;
                                 CGRect frame_btn = btn.frame;
                                 frame_btn.size.height = 0;
                                 btn.frame = frame_btn;
                             }
                         }
                     }];
                     
                     _name_view.hidden = NO;
                 }completion: ^(BOOL isFinished)
                 { }];
            }
                break;
                
            case 1:
            {
                NSLog(@"there there");
                [UIView transitionWithView: _name_view
                                  duration: 1.00f
                                   options: UIViewAnimationOptionTransitionCrossDissolve
                                animations: ^(void)
                 {
                     _name_view.hidden = YES;
                     for (UIView *sub in _name_view.subviews)
                     {
                         if([sub isKindOfClass:[UITextField class]])
                         {
                             UITextField *txt = (UITextField *)sub;
                             [txt resignFirstResponder];
                         }
                     }
                 }
                                completion: ^(BOOL isFinished){ }];
                
            }
                break;
        }
    }

}
-(void)name_view_functions:(UIButton *)sender
{
    NSLog(@" sender tag is %d",[sender tag]);
    switch (sender.tag) {
        case 0:
        {
            NSString *album_name = nil;
            for (UIView *sub in _name_view.subviews)
            {
                if([sub isKindOfClass:[UITextField class]])
                {
                    UITextField *txt = (UITextField *)sub;
                    album_name = txt.text;
                    if([[album_name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0)
                    {
                        __block BOOL *present = NO;
                      
                       
                        [self.library enumerateGroupsWithTypes:ALAssetsGroupAlbum
                                                    usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                                        if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:album_name]) {
                                                           
                                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Album already exists" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                                            [alert show];
                                                            present = YES;
                                                        }
                                                    }
                                                  failureBlock:^(NSError* error) {
                                                      NSLog(@"failed to enumerate albums:\nError: %@", [error localizedDescription]);
                                                  }];
                        
                        if(!present)
                        {
                            [self.library addAssetsGroupAlbumWithName:album_name
                                                          resultBlock:^(ALAssetsGroup *group) {
                                                              
                                                              {
                                                                  
                                                                  [UIView transitionWithView: _name_view
                                                                                    duration: 1.00f
                                                                                     options: UIViewAnimationOptionTransitionCrossDissolve
                                                                                  animations: ^(void)
                                                                   {
                                                                       _name_view.hidden = YES;
                                                                       
                                                                       NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                                                                       self.assetGroups = tempArray;
                                                                       [tempArray release];
                                                                       
                                                                       ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
                                                                       self.library = assetLibrary;
                                                                       [assetLibrary release];
                                                                       
                                                                       // Load Albums into assetGroups
                                                                       dispatch_async(dispatch_get_main_queue(), ^
                                                                                      {
                                                                                          NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
                                                                                          
                                                                                          // Group enumerator Block
                                                                                          void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
                                                                                          {
                                                                                              if (group == nil) {
                                                                                                  return;
                                                                                              }
                                                                                              
                                                                                              // added fix for camera albums order
                                                                                              NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                                                                                              NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
                                                                                              
                                                                                              if ([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] && nType == ALAssetsGroupSavedPhotos) {
                                                                                                  [self.assetGroups insertObject:group atIndex:0];
                                                                                              }
                                                                                              else {
                                                                                                  [self.assetGroups addObject:group];
                                                                                              }
                                                                                              
                                                                                              // Reload albums
                                                                                              [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
                                                                                          };
                                                                                          
                                                                                          // Group Enumerator Failure Block
                                                                                          void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
                                                                                              
                                                                                              UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                                                                              [alert show];
                                                                                              [alert release];
                                                                                              
                                                                                              NSLog(@"A problem occured %@", [error description]);
                                                                                          };
                                                                                          
                                                                                          // Enumerate Albums
                                                                                          [self.library enumerateGroupsWithTypes:ALAssetsGroupAll
                                                                                                                      usingBlock:assetGroupEnumerator
                                                                                                                    failureBlock:assetGroupEnumberatorFailure];
                                                                                          
                                                                                          [pool release];
                                                                                      });
                                                                       
                                                                       for (UIView *sub in _name_view.subviews)
                                                                       {
                                                                           if([sub isKindOfClass:[UITextField class]])
                                                                           {
                                                                               UITextField *txt = (UITextField *)sub;
                                                                               [txt resignFirstResponder];
                                                                           }
                                                                       }
                                                                   }
                                                                                  completion: ^(BOOL isFinished){ }];
                                                                  
                                                                  
                                                              }
                                                          }
                                                         failureBlock:^(NSError *error) {
                                                             NSLog(@"error adding album");
                                                         }];
                          
                        }
                    }
                    else
                    {
                            [UIView transitionWithView: _name_view
                                              duration: 1.00f
                                               options: UIViewAnimationOptionTransitionCrossDissolve
                                            animations: ^(void)
                             {
                                 _name_view.hidden = YES;
                                 
                                 for (UIView *sub in _name_view.subviews)
                                 {
                                     if([sub isKindOfClass:[UITextField class]])
                                     {
                                         UITextField *txt = (UITextField *)sub;
                                         [txt resignFirstResponder];
                                     }
                                 }
                             }
                                            completion: ^(BOOL isFinished){ }];
                    }
                    [txt resignFirstResponder];
                }
            }
        }
            break;
            
        case 1:
        {
            [UIView transitionWithView: _name_view
                              duration: 1.00f
                               options: UIViewAnimationOptionTransitionCrossDissolve
                            animations: ^(void)
            {
                _name_view.hidden = YES;
                
                for (UIView *sub in _name_view.subviews)
                {
                    if([sub isKindOfClass:[UITextField class]])
                    {
                        UITextField *txt = (UITextField *)sub;
                        [txt resignFirstResponder];
                    }
                }
            }
                            completion: ^(BOOL isFinished){ }];
        }
            break;
    }
}
-(void)goToListing
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.libopen = NO;
    
    FTPListingViewController *list = [[FTPListingViewController alloc] init];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:list animated:NO];
}
-(void)goToHome
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.libopen = NO;
    
    HomeViewController *list = [[HomeViewController alloc] init];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:list animated:NO];
}
- (void)reloadTableView
{
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.tableView reloadData];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed:@"top-bar@2x.png"].CGImage;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"top-bar@2x.png"]];
    
	[self.navigationItem setTitle:@"Select an album"];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
}
- (BOOL)shouldSelectAsset:(ELCAsset *)asset previousCount:(NSUInteger)previousCount {
    return [self.parent shouldSelectAsset:asset previousCount:previousCount];
}

- (void)selectedAssets:(NSArray*)assets
{
	[_parent selectedAssets:assets];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.assetGroups count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.backgroundColor = [UIColor clearColor];
    // Get count
    ALAssetsGroup *g = (ALAssetsGroup*)[self.assetGroups objectAtIndex:indexPath.row];
    [g setAssetsFilter:[ALAssetsFilter allPhotos]];
    NSInteger gCount = [g numberOfAssets];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",[g valueForProperty:ALAssetsGroupPropertyName], (long)gCount];
    cell.textLabel.textColor = [UIColor whiteColor];
    [cell.imageView setImage:[UIImage imageWithCGImage:[(ALAssetsGroup*)[self.assetGroups objectAtIndex:indexPath.row] posterImage]]];
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if(_name_view.hidden)
    {
	ELCAssetTablePicker *picker = [[ELCAssetTablePicker alloc] initWithNibName: nil bundle: nil];
	picker.parent = self;

        ALAssetsGroup *g = (ALAssetsGroup*)[self.assetGroups objectAtIndex:indexPath.row];
        [g setAssetsFilter:[ALAssetsFilter allPhotos]];
        NSInteger gCount = [g numberOfAssets];
        if(gCount>0)
        {
            picker.assetGroup = [self.assetGroups objectAtIndex:indexPath.row];
            [picker.assetGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
            
            picker.assetPickerFilterDelegate = self.assetPickerFilterDelegate;
            
            [self.navigationController pushViewController:picker animated:YES];
            [picker release];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 57;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}
-(void)viewWillDisappear:(BOOL)animated
{
    if(_drop_dow_menu.frame.size.height>0)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            _drop_dow_menu.frame =CGRectMake(x_postion_for_drop_down_menu-150, 0, 150, 0);
            for (UIView *sub in _drop_dow_menu.subviews)
            {
                if([sub isKindOfClass:[UIButton class]])
                {
                    UIButton *btn = (UIButton *)sub;
                    CGRect frame_btn = btn.frame;
                    frame_btn.size.height = 0;
                    btn.frame = frame_btn;
                }
            }
            
            self.tableView.userInteractionEnabled = YES;
            [UIView transitionWithView: _name_view
                              duration: 1.00f
                               options: UIViewAnimationOptionTransitionCrossDissolve
                            animations: ^(void)
             {
                 _name_view.hidden = YES;
             }
                            completion: ^(BOOL isFinished){ }];
        }];
    }
    
    [super viewWillDisappear:YES];
}

- (void)dealloc 
{	
    [_assetGroups release];
    [_library release];
    [super dealloc];
}

@end

