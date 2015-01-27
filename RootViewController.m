#import "RootViewController.h"
#import "AlbumContentsViewController.h"
#import "AssetsDataIsInaccessibleViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "FTPListingViewController.h"

@interface RootViewController ()
{
    UITableView *tablefortest11;
    int x_postion_for_drop_down_menu,y_position_for_name_view,height_for_drop_down_menu;
    UIButton *button;
}
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *groups;

@end

#pragma mark -

@implementation RootViewController
@synthesize name_view = _name_view;

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor blackColor];
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
    [self.navigationItem setTitle:@"Photo Albums"];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                           UITextAttributeFont: [UIFont fontWithName:@"MyriadPro-Bold" size:18.5],
                                                           }];
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

    UIBarButtonItem *btn_for_ftp = [[UIBarButtonItem alloc]
                                    initWithTitle:@"More"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(editItem:)];
    [btn_for_ftp setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_for_ftp;

}

-(void)viewDidAppear :(BOOL)animated
{
    if (self.assetsLibrary == nil) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    if (self.groups == nil) {
        _groups = [[NSMutableArray alloc] init];
    } else {
        [self.groups removeAllObjects];
    }
    
    // setup our failure view controller in case enumerateGroupsWithTypes fails
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        
        AssetsDataIsInaccessibleViewController *assetsDataInaccessibleViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"inaccessibleViewController"];
        
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
        
        assetsDataInaccessibleViewController.explanation = errorMessage;
        [self presentViewController:assetsDataInaccessibleViewController animated:NO completion:nil];
    };
    
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
            [self.groups insertObject:group atIndex:0];
        }
        else {
            [self.groups addObject:group];
        }
        // Reload albums
        [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
    };
    
    // Group Enumerator Failure Block
    void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@, Please enable Photo Access in Settings", [error localizedDescription]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        //                                                                                              [alert release];
        NSLog(@"A problem occured %@", [error description]);
    };
    
    // Enumerate Albums
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                      usingBlock:assetGroupEnumerator
                                    failureBlock:assetGroupEnumberatorFailure];
    // enumerate only photos
//    NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
//    [self.assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];
    
    tablefortest11 = [[UITableView alloc] init];
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        tablefortest11.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.frame.size.height-5);
    }
    else
    {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"started"] isEqualToString:@"yes"])
           tablefortest11.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.frame.size.height-50);
        else
           tablefortest11.frame= CGRectMake(0, 50, self.view.bounds.size.width, self.view.frame.size.height-50);
    }
    [tablefortest11 setDelegate:self];
    [tablefortest11 setDataSource:self];
    [tablefortest11 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tablefortest11 setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tablefortest11];
    
    
    // Load Albums into assetGroups
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
            NSLog(@"left");
            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
        }
            break;
        case UIInterfaceOrientationLandscapeRight:
        {
            NSLog(@"right");
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
    
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
    _name_view = [[UIView alloc] initWithFrame:CGRectMake((x_postion_for_drop_down_menu-300)/2, (y_position_for_name_view - 220)/2, 300, 90)];    }
    else
    {

    _name_view = [[UIView alloc] initWithFrame:CGRectMake((x_postion_for_drop_down_menu-300)/2, (y_position_for_name_view - 260)/2, 300, 90)];
    }
    NSLog(@"name view y: %f",_name_view.frame.origin.y);
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

    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChangedinThisView:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}

#pragma mark - UITableViewDataSource

// determine the number of rows in the table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.groups.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


// determine the appearance of table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tablefortest11 dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    ALAssetsGroup *groupForCell = self.groups[indexPath.row];
    CGImageRef posterImageRef = [groupForCell posterImage];
    UIImage *posterImage = [UIImage imageWithCGImage:posterImageRef];
    cell.imageView.image = posterImage;
    cell.textLabel.text =[NSString stringWithFormat:@"%@  (%d)",[groupForCell valueForProperty:ALAssetsGroupPropertyName], groupForCell.numberOfAssets];
    cell.textLabel.textColor= [UIColor whiteColor];
    cell.detailTextLabel.text = [@(groupForCell.numberOfAssets) stringValue];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *selectedIndexPath = [tablefortest11 indexPathForSelectedRow];
    if (self.groups.count > (NSUInteger)selectedIndexPath.row) {
        
        // hand off the asset group (i.e. album) to the next view controller
        AlbumContentsViewController *albumContentsViewController = [[AlbumContentsViewController alloc]init];
        albumContentsViewController.assetsGroup = self.groups[selectedIndexPath.row];
        NSLog(@"%@ .. ",self.groups[selectedIndexPath.row]);
        [[NSUserDefaults standardUserDefaults]setObject: [NSString stringWithFormat:@"%@",self.groups[selectedIndexPath.row]] forKey:@"albumname"];
        [self.navigationController pushViewController:albumContentsViewController animated:NO];
    }
}

-(void)goBack: (id)sender
{
    HomeViewController *albumContentsViewController = [[HomeViewController alloc]init];
    [self.navigationController pushViewController:albumContentsViewController animated:NO];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [tablefortest11 removeFromSuperview];
    tablefortest11=Nil;
    
    if (tablefortest11) {
        [tablefortest11 reloadData];
        [tablefortest11 removeFromSuperview];
        tablefortest11 = Nil;
    }
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"started"];
    [super viewDidDisappear:YES];
}

-(void)editItem:(id)sender
{    
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
//            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            delegate.libopen = NO;
            FTPListingViewController *list = [[FTPListingViewController alloc] init];
            [self.navigationController pushViewController:list animated:NO];
        }
            break;
    }
}


-(void)btn_functions:(UIButton *)sender
{
    if([[NSString stringWithFormat:@"%@",[sender titleForState:UIControlStateNormal]] isEqualToString:@"Your Web Folders"])
    {
//        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        delegate.libopen = NO;
        FTPListingViewController *list = [[FTPListingViewController alloc] init];
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
                        
                        
                        [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum
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
                            [self.assetsLibrary addAssetsGroupAlbumWithName:album_name
                                                          resultBlock:^(ALAssetsGroup *group) {
                                                              {
                                                                  [UIView transitionWithView: _name_view
                                                                                    duration: 1.00f
                                                                                     options: UIViewAnimationOptionTransitionCrossDissolve
                                                                                  animations: ^(void)
                                                                   {
                                                                       _name_view.hidden = YES;
                                                                       
                                                                       NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                                                                       self.groups = tempArray;
//                                                                       [tempArray release];
                                                                       ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
                                                                       self.assetsLibrary = assetLibrary;
                                                                       [assetLibrary release];
                                                                       // Load Albums into assetGroups
                                                                       dispatch_async(dispatch_get_main_queue(), ^
                                                                                      {
//                                                                                          NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
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
                                                                                                  [self.groups insertObject:group atIndex:0];
                                                                                              }
                                                                                              else {
                                                                                                  [self.groups addObject:group];
                                                                                              }
                                                                                              // Reload albums
                                                                                              [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
                                                                                          };
                                                                                          // Group Enumerator Failure Block
                                                                                          void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
                                                                                              
                                                                                              UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                                                                              [alert show];
//                                                                                              [alert release];
                                                                                              NSLog(@"A problem occured %@", [error description]);
                                                                                          };
                                                                                          // Enumerate Albums
                                                                                          [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                                                                                                      usingBlock:assetGroupEnumerator
                                                                                                                    failureBlock:assetGroupEnumberatorFailure];
                                                                                          
//                                                                                          [pool release];
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
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    delegate.libopen = NO;
    FTPListingViewController *list = [[FTPListingViewController alloc] init];
    [self.navigationController pushViewController:list animated:NO];
}

- (void)reloadTableView
{
    tablefortest11.backgroundColor = [UIColor blackColor];
    tablefortest11.separatorStyle = UITableViewCellSeparatorStyleNone;
	[tablefortest11 reloadData];

    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed:@"top-bar@2x.png"].CGImage;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"top-bar@2x.png"]];
	[self.navigationItem setTitle:@"Select an album"];
}

- (void) orientationChangedinThisView:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
        {
            x_postion_for_drop_down_menu =[[UIScreen mainScreen]bounds].size.width;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.height;
            
            NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
            if ([[ver objectAtIndex:0] intValue] >= 7)
            {
                tablefortest11.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.frame.size.height-5);
            }
            else
            {
                tablefortest11.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.frame.size.height-5);
            }
            
            if ([[ver objectAtIndex:0] intValue] >= 7)
            {
              _name_view.frame =CGRectMake((x_postion_for_drop_down_menu-300)/2, (y_position_for_name_view - 220)/2, 300, 90);
            }
            else
            {
              _name_view.frame =CGRectMake((x_postion_for_drop_down_menu-300)/2, (y_position_for_name_view - 260)/2, 300, 90);
            }
        }
            break;
            
        case UIDeviceOrientationLandscapeRight:
        case UIDeviceOrientationLandscapeLeft:
        {
            x_postion_for_drop_down_menu = [[UIScreen mainScreen] bounds].size.height;
            y_position_for_name_view =[[UIScreen mainScreen] bounds].size.width;
            NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
            if ([[ver objectAtIndex:0] intValue] >= 7)
            {
                tablefortest11.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.frame.size.height-5);
            }
            else
            {
                tablefortest11.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.frame.size.height-5);
            }
            if ([[ver objectAtIndex:0] intValue] >= 7)
            {
                _name_view.frame =CGRectMake((x_postion_for_drop_down_menu-300)/2, (y_position_for_name_view - 220)/2, 300, 90);
            }
            else
            {
                _name_view.frame =CGRectMake((x_postion_for_drop_down_menu-300)/2, (y_position_for_name_view - 260)/2, 300, 90);
            }

        }
            break;
            
        case UIDeviceOrientationUnknown:
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationFaceUp:
        {}
            break;
    }
    
    if(!_name_view.hidden)
    {
        NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
        CGRect frame_name_view = _name_view.frame;
        frame_name_view.origin.x = (x_postion_for_drop_down_menu - 300)/2;
        if ([[ver objectAtIndex:0] intValue] >= 7)
        {
            frame_name_view.origin.y = (y_position_for_name_view-220)/2;
        }
        else
        {
            frame_name_view.origin.y = (y_position_for_name_view-260)/2;
        }
//        frame_name_view.origin.y = (y_position_for_name_view-220)/2;
        _name_view.frame = frame_name_view;
    }
}
@end