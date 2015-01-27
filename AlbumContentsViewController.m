#import "AlbumContentsViewController.h"
#import "ImageDetailViewController.h"
#import "RootViewController.h"
@interface AlbumContentsViewController ()
{
    int senderval,numb;
    UIView *toast_view;
    UIButton *button;
}
@end

@implementation AlbumContentsViewController
#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
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
    [self.navigationItem setTitle:[self.assetsGroup valueForProperty:ALAssetsGroupPropertyName]];
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
                                    initWithTitle:@"Show"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(showPics:)];
    [btn_for_ftp setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_for_ftp;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    self.view.backgroundColor= [UIColor blackColor];
    //    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    if (!self.assets) {
        _assets = [[NSMutableArray alloc] init];
    } else {
        [self.assets removeAllObjects];
    }
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [self.assets addObject:result];
        }
    };
    ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
    [self.assetsGroup setAssetsFilter:onlyPhotosFilter];
    [self.assetsGroup enumerateAssetsUsingBlock:assetsEnumerationBlock];
    //    [self.collectionView reloadData];
    img_url_array=[[NSMutableArray alloc]init];
    uiimage_array=[[NSMutableArray alloc]init];
    select_deselect=[[NSMutableArray alloc]init];
    
    if (testtable) {
        [testtable reloadData];
        [testtable removeFromSuperview];
        testtable = Nil;
    }
    testtable = [[UITableView alloc] init];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    //    if ([[ver objectAtIndex:0] intValue] >= 7)
    //    {
    //        testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height-5);
    //    }
    //    else
    //        testtable.frame= CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height-50);
    
    [testtable setDelegate:self];
    [testtable setDataSource:self];
    [testtable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [testtable setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:testtable];
    
    NSLog(@"co ord: %f",testtable.frame.origin.y);
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPad:
        {
            switch(self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        testtable.frame= CGRectMake(24, 5, self.view.bounds.size.width-48, self.view.bounds.size.height- 5);
                        numb = self.view.bounds.size.width/80;
                    }
                    else
                    {
                        testtable.frame= CGRectMake(24, 5, self.view.bounds.size.width-48, self.view.bounds.size.height- 5);
                        numb = self.view.bounds.size.width/80;
                    }
                }
                    break;
                    
                case UIDeviceOrientationLandscapeRight:
                case UIDeviceOrientationLandscapeLeft:
                {
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        testtable.frame= CGRectMake(32, 5, self.view.bounds.size.width-64, self.view.bounds.size.height- 5);
                        numb = self.view.bounds.size.width/80;
                    }
                    else
                    {
                        testtable.frame= CGRectMake(32, 5, self.view.bounds.size.width-64, self.view.bounds.size.height- 5);
                        numb = self.view.bounds.size.width/80;
                    }
                }
                    break;
            }
        }
            break;
        case UIUserInterfaceIdiomPhone:
        {
            switch(self.interfaceOrientation)
            {
                case UIDeviceOrientationPortrait:
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height- 5);
                        numb = self.view.bounds.size.width/80;
                    }
                    else
                    {
                        testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height- 5);
                        numb = self.view.bounds.size.width/80;
                    }
                }
                    break;
                    
                case UIDeviceOrientationLandscapeRight:
                case UIDeviceOrientationLandscapeLeft:
                {
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        testtable.frame= CGRectMake(4, 5, self.view.bounds.size.width-8, self.view.bounds.size.height- 5);
                        numb = self.view.bounds.size.width/80;
                    }
                    else
                    {
                        testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height- 5);
                        numb = self.view.bounds.size.width/80;
                    }
                }
                    break;
            }
        }
            break;
    }
    
    //    switch (self.interfaceOrientation) {
    //        case UIDeviceOrientationPortrait:
    //        case UIInterfaceOrientationPortraitUpsideDown:
    //        {
    //            if ([[ver objectAtIndex:0] intValue] >= 7)
    //            {
    //                testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height-5);
    ////                numb = self.view.bounds.size.width/80;
    //            }
    //            else
    //                testtable.frame= CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height-50);
    ////                numb = self.view.bounds.size.width/80;
    //        }
    //            break;
    //        case UIInterfaceOrientationLandscapeLeft:
    //        {
    //            NSLog(@"left");
    //            if ([[ver objectAtIndex:0] intValue] >= 7)
    //            {
    //                testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height-5);
    ////                numb = self.view.bounds.size.width/80;
    //            }
    //            else
    //                testtable.frame= CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height-50);
    ////                numb = self.view.bounds.size.width/80;
    //        }
    //            break;
    //        case UIInterfaceOrientationLandscapeRight:
    //        {
    //            NSLog(@"right");
    //            if ([[ver objectAtIndex:0] intValue] >= 7)
    //            {
    //                testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height-5);
    ////                numb = self.view.bounds.size.width/80;
    //            }
    //            else
    //                testtable.frame= CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height-50);
    ////                numb = self.view.bounds.size.width/80;
    //        }
    //            break;
    //    }
    
    //    dispatch_sync(dispatch_get_main_queue(), ^{
    
    CGFloat y_axis=0;
    CGFloat x_axis=0;
    switch (self.interfaceOrientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            x_axis =[[UIScreen mainScreen]bounds].size.height;
            y_axis = [[UIScreen mainScreen] bounds].size.width;
        }
            break;
            
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            x_axis =[[UIScreen mainScreen] bounds].size.width;
            y_axis =[[UIScreen mainScreen] bounds].size.height;
        }
            break;
    }
    
    toast_view = [[UIView alloc] init];
    if ([[ver objectAtIndex:0] intValue] >= 7)
        //    {
        toast_view.frame = CGRectMake(10, y_axis/2-100+50, x_axis-20, 100);
    else
        toast_view.frame = CGRectMake(10, y_axis/2-100, x_axis-20, 100);
    toast_view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.76f];
    toast_view.alpha= 1.0;
    toast_view.layer.zPosition = 1.0;
    
    UILabel *text_for_show = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, toast_view.frame.size.width, 100)];
    text_for_show.backgroundColor = [UIColor clearColor];
    text_for_show.font = [UIFont boldSystemFontOfSize:19];
    text_for_show.text=@"Tap on the images to show";
    text_for_show.textColor = [UIColor whiteColor];
    text_for_show.textAlignment = NSTextAlignmentCenter;
    [toast_view addSubview:text_for_show];
    [self.view addSubview:toast_view];
    
    UITapGestureRecognizer *tapontoast = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap_on_toast:)];
    tapontoast.delegate=self;
    toast_view.userInteractionEnabled = YES;
    [toast_view addGestureRecognizer:tapontoast];
    
    if([self.assets count]>0)
    {
        //            [UIView transitionWithView: toast_view
        //                              duration: 5.0f
        //                               options: UIViewAnimationOptionTransitionCrossDissolve
        //                            animations: ^(void)
        //             {
        //                 [testtable reloadData];
        ////                 toast_view.alpha = 0.0;
        //             }
        //                            completion: ^(BOOL isFinished){
        //                                // scroll to bottom
        //                                //                                long section = [self numberOfSectionsInTableView:self.tableView] - 1;
        //                                //                                long row = [self tableView:self.tableView numberOfRowsInSection:section] - 1;
        //                                //                                if (section >= 0 && row >= 0) {
        //                                //                                    NSIndexPath *ip = [NSIndexPath indexPathForRow:row
        //                                //                                                                         inSection:section];
        //                                //                                    [self.tableView scrollToRowAtIndexPath:ip
        //                                //                                                          atScrollPosition:UITableViewScrollPositionBottom
        //                                //                                                                  animated:NO];
        //                                //                                }
        //
        //                                toast_view.hidden=YES;
        //                            }];
        
        
        if([self.assets count]>1)
        {
            [self.navigationItem setTitle:@"Pick Photos"];
        }
        else
        {
            [self.navigationItem setTitle:@"Pick Photo"];
        }
    }
    else
    {
        text_for_show.text=@"There are no images to select";
        
        //            [self.navigationItem setTitle:self.singleSelection ? @"Pick Photo" : @"There are no photos"];
    }
    //    });
    
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChangedinThisView:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.assets.count ==0)
        return 0;
    else
    {
        //        UIDevice * device = [[UIDevice currentDevice] userInterfaceIdiom];
        switch(self.interfaceOrientation)
        {
            case UIDeviceOrientationPortrait:
            case UIDeviceOrientationPortraitUpsideDown:
            {
                NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                if ([[ver objectAtIndex:0] intValue] >= 7)
                {
                    numb = self.view.bounds.size.width/80;
                    if (self.assets.count % numb == 0)
                        return self.assets.count/numb;
                    else
                        return self.assets.count/numb + 1;
                    [testtable reloadData];
                }
                else
                {
                    numb = self.view.bounds.size.width/80;
                    if (self.assets.count % numb == 0)
                        return self.assets.count/numb;
                    else
                        return self.assets.count/numb + 1;
                    [testtable reloadData];
                }
            }
                break;
                
            case UIDeviceOrientationLandscapeRight:
            case UIDeviceOrientationLandscapeLeft:
            {
                NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                if ([[ver objectAtIndex:0] intValue] >= 7)
                {
                    numb = self.view.bounds.size.width/80;
                    if (self.assets.count % numb == 0)
                        return self.assets.count/numb;
                    else
                        return self.assets.count/numb + 1;
                    [testtable reloadData];
                }
                else
                {
                    numb = self.view.bounds.size.width/80;
                    if (self.assets.count % numb == 0)
                        return self.assets.count/numb;
                    else
                        return self.assets.count/numb + 1;
                    [testtable reloadData];
                }
            }
                break;
        }
    }
}


-(void)goBack: (id)sender
{
    //    [self.navigationController popViewControllerAnimated:NO];
    RootViewController *root = [[RootViewController alloc]init];
    [self.navigationController pushViewController:root animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 81.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [testtable dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    [cell setBackgroundColor:[UIColor greenColor]];
    
    NSUInteger firstPhotoInCell = indexPath.row * numb;
    NSUInteger lastPhotoInCell  = firstPhotoInCell + numb;
    
    if (self.assets.count <= firstPhotoInCell) {
        NSLog(@"We are out of range, asking to start with photo %ld but we only have %ld", (unsigned long)firstPhotoInCell, (unsigned long)self.assets.count);
        return nil;
    }
    else
    {
        NSUInteger currentPhotoIndex = 0;
        NSUInteger lastPhotoIndex = MIN(lastPhotoInCell, self.assets.count);
        for ( ; firstPhotoInCell + currentPhotoIndex < lastPhotoIndex ; currentPhotoIndex++) {
            
            ALAsset *asset = [self.assets objectAtIndex:firstPhotoInCell + currentPhotoIndex];
            CGImageRef thumbnailImageRef = [asset thumbnail];
            
            UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];
            
            float padLeft = (currentPhotoIndex * 77.5f+ (currentPhotoIndex+1)*2);
            UIImageView *albumV = [[UIImageView alloc] initWithFrame:CGRectMake(padLeft,0, 77.5f, 78)];
            albumV.userInteractionEnabled = YES;
            albumV.tag = firstPhotoInCell + currentPhotoIndex;
            albumV.image = thumbnail;
            [cell addSubview:albumV];
            [cell bringSubviewToFront:albumV];
            albumV.tag = firstPhotoInCell + currentPhotoIndex;
            
            //                    UIButton *albumbutton= [UIButton alloc]initWithFrame:<#(CGRect)#>
            
            UITapGestureRecognizer *tapalbum = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(select_image:)];
            tapalbum.Delegate=self;
            tapalbum.numberOfTapsRequired = 1;
            albumV.userInteractionEnabled = YES;
            [albumV addGestureRecognizer:tapalbum];
            
            
            //        UIImageView *overlay = [[UIImageView alloc]initWithFrame:albumV.frame];
            //        overlay.image=[UIImage imageNamed:@"Overlay.png"];
            //        [albumV addSubview:overlay];
            
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setSelectionStyle:UITableViewCellEditingStyleNone];
            
            for (int ik=0; ik < [img_url_array count]; ik++)
            {
                if ([select_deselect containsObject:[NSString stringWithFormat:@"%d",albumV.tag]])
                {
                    for (UIView *subview in albumV.subviews)
                    {
                        if([subview isKindOfClass:[UIImageView class]])
                        {
                            [subview removeFromSuperview];
                            
                        }
                    }
                    CGRect rect = [albumV frame];
                    NSLog(@"rect %f %f %f %f",rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
                    UIImageView *overlay = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, albumV.frame.size.width, albumV.frame.size.height)];
                    overlay.image=[UIImage imageNamed:@"Overlay.png"];
                    [albumV addSubview:overlay];
                    [albumV bringSubviewToFront:overlay];
                    
                }
            }
        }
    }
    return cell;
}

-(void)select_image: (UIGestureRecognizer *)sender
{
    //    NSLog(@"assets are: %@",self.assets);
    toast_view.hidden=YES;
    
    if (![select_deselect containsObject:[NSString stringWithFormat:@"%d",sender.view.tag]]) {
        
        [select_deselect addObject:[NSString stringWithFormat:@"%d",sender.view.tag]];
        NSLog(@"%@ added", [NSString stringWithFormat:@"%d",sender.view.tag]);
        
        NSLog(@"else else");
        ALAsset *asset = [self.assets objectAtIndex:sender.view.tag];
        UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
        
        NSString *uti = [[asset defaultRepresentation] UTI];
        NSURL *URL = [[asset valueForProperty:ALAssetPropertyURLs] valueForKey:uti];
        [img_url_array addObject:URL];
        [uiimage_array addObject:image];
        [select_deselect addObject:[NSString stringWithFormat:@"%d",sender.view.tag]];
        
        CGRect rect = [sender.view frame];
        NSLog(@"rect %f %f %f %f",rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
        UIImageView *overlay = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sender.view.frame.size.width, sender.view.frame.size.height)];
        overlay.image=[UIImage imageNamed:@"Overlay.png"];
        [sender.view addSubview:overlay];
        [sender.view bringSubviewToFront:overlay];
        
    } else {
        [select_deselect removeObject:[NSString stringWithFormat:@"%d",sender.view.tag]];
        NSLog(@"%@ deleted", [NSString stringWithFormat:@"%d",sender.view.tag]);
        
        ALAsset *asset = [self.assets objectAtIndex:sender.view.tag];
        NSString *uti = [[asset defaultRepresentation] UTI];
        NSURL *URL = [[asset valueForProperty:ALAssetPropertyURLs] valueForKey:uti];
        
        if ([img_url_array containsObject:URL])
        {
            NSUInteger index = [img_url_array indexOfObject:URL];
            [img_url_array removeObject:URL];
            [uiimage_array removeObjectAtIndex:index];
            
            for (UIImageView *img in sender.view.subviews)
            {
                [img removeFromSuperview];
            }
        }
    }
    
}


-(void)showPics: (id)sender
{
    if ([img_url_array count] == 0 || [uiimage_array count]==0)
    {
        UIAlertView *noImageAlert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                               message:@"Please select image(s) to display!"
                                                              delegate:self
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles:nil];
        noImageAlert.tag = 2;
        [noImageAlert show];
    }
    else
    {
        NSLog(@"image array ta: %@",uiimage_array);
        ImageDetailViewController *image_detail = [[ImageDetailViewController alloc] init];
        
        image_detail.url_of_images = [[NSMutableArray alloc] init];
        image_detail.image_data_from_library = [[NSMutableArray alloc]init];
        image_detail.url_of_images= [img_url_array mutableCopy];
        image_detail.image_data_from_library= [uiimage_array mutableCopy];
        
        image_detail.imgtypestatic=NO;
        image_detail.selected_image = [[UIImage alloc] init];
        image_detail.selected_image = (UIImage *)[image_detail.image_data_from_library objectAtIndex:0];
        image_detail.url_of_image = [image_detail.url_of_images objectAtIndex:0];
        image_detail.tag = 0;
        NSLog(@"imagedetail.urlofimg = %@",image_detail.url_of_images);
        NSLog(@"image dtl uiimage %@",image_detail.image_data_from_library);
        
        [self.navigationController pushViewController:image_detail animated:NO];
    }
    //    [image_detail.url_of_images addObject:URL];
    //    [image_detail.image_data_from_library addObject:image];
}

- (void)viewDidDisappear:(BOOL)animated {
    [testtable removeFromSuperview];
    testtable=Nil;
    
    if (testtable) {
        [testtable reloadData];
        [testtable removeFromSuperview];
        testtable = Nil;
    }
    [super viewDidDisappear:YES];
    
}

- (void) orientationChangedinThisView:(NSNotification *)note
{
    //    UIDevice * device = note.object;
    //
    //    switch(device.orientation)
    //    {
    //        case UIDeviceOrientationPortrait:
    //        case UIDeviceOrientationPortraitUpsideDown:
    //        {
    //            NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    //            if ([[ver objectAtIndex:0] intValue] >= 7)
    //            {
    //                testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height-5);
    ////                numb = self.view.bounds.size.width/80;
    //                [testtable reloadData];
    //            }
    //            else
    //                testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height-5);
    ////                numb = self.view.bounds.size.width/80;
    //            [testtable reloadData];
    //        }
    //            break;
    //
    //        case UIDeviceOrientationLandscapeRight:
    //        case UIDeviceOrientationLandscapeLeft:
    //        {
    //
    //            NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    //            if ([[ver objectAtIndex:0] intValue] >= 7)
    //            {
    //                testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height-5);
    ////                numb = self.view.bounds.size.width/80;
    //                [testtable reloadData];
    //            }
    //            else
    //                testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height-5);
    ////                numb = self.view.bounds.size.width/80;
    //            [testtable reloadData];
    //        }
    //            break;
    //
    //        case UIDeviceOrientationUnknown:
    //        case UIDeviceOrientationFaceDown:
    //        case UIDeviceOrientationFaceUp:
    //        {
    //
    //        }
    //            break;
    //    }
    
    
    
    
    switch ([[UIDevice currentDevice] userInterfaceIdiom])
    {
        case  UIUserInterfaceIdiomPhone:
        {
            UIDevice * device = note.object;
            switch(device.orientation)
            {
                case UIDeviceOrientationPortrait:
                {
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height-5);
                        //                numb = self.view.bounds.size.width/80;
                    }
                    else
                        testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height-5);
                    //                numb = self.view.bounds.size.width/80;
                    [testtable reloadData];
                    
                }
                    break;
                    
                case UIDeviceOrientationLandscapeRight:
                {
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        testtable.frame= CGRectMake(4, 5, self.view.bounds.size.width-8, self.view.bounds.size.height-5);
                        //                numb = self.view.bounds.size.width/80;
                    }
                    else
                        testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height-5);
                    //                numb = self.view.bounds.size.width/80;
                    [testtable reloadData];
                    
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                {
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        testtable.frame= CGRectMake(4, 5, self.view.bounds.size.width-8, self.view.bounds.size.height-5);
                        //                numb = self.view.bounds.size.width/80;
                        [testtable reloadData];
                    }
                    else
                        testtable.frame= CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height-5);
                    //                numb = self.view.bounds.size.width/80;
                    [testtable reloadData];
                }
                    break;
            };
            
        }
            break;
        case  UIUserInterfaceIdiomPad:
        {
            UIDevice * device = note.object;
            switch(device.orientation)
            {
                case UIDeviceOrientationPortrait:
                case UIDeviceOrientationPortraitUpsideDown:
                {
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        [testtable removeFromSuperview];
                        testtable = [[UITableView alloc] init];
                        [testtable setDelegate:self];
                        [testtable setDataSource:self];
                        [testtable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                        [testtable setBackgroundColor:[UIColor clearColor]];
                        [self.view addSubview:testtable];
                        
                        testtable.frame= CGRectMake(24, 65, self.view.bounds.size.width-48, self.view.bounds.size.height- 65);
                        //                numb = self.view.bounds.size.width/80;
                    }
                    else
                        testtable.frame= CGRectMake(24, 5, self.view.bounds.size.width-48, self.view.bounds.size.height-5);
                    //                numb = self.view.bounds.size.width/80;
                    [testtable reloadData];
                    
                }
                    break;
                    
                case UIDeviceOrientationLandscapeRight:
                {
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        NSLog(@"wid = %f",self.view.bounds.size.width);
                        
                        [testtable removeFromSuperview];
                        testtable = [[UITableView alloc] init];
                        [testtable setDelegate:self];
                        [testtable setDataSource:self];
                        [testtable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                        [testtable setBackgroundColor:[UIColor clearColor]];
                        [self.view addSubview:testtable];
                        
                        testtable.frame= CGRectMake(32, 65, self.view.bounds.size.width-64, self.view.bounds.size.height- 65);
                        //                numb = self.view.bounds.size.width/80;
                    }
                    else
                        testtable.frame= CGRectMake(32, 5, self.view.bounds.size.width-64, self.view.bounds.size.height-5);
                    //                numb = self.view.bounds.size.width/80;
                    [testtable reloadData];
                    
                }
                    break;
                case UIDeviceOrientationLandscapeLeft:
                {
                    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
                    if ([[ver objectAtIndex:0] intValue] >= 7)
                    {
                        NSLog(@"wid = %f",self.view.bounds.size.width);
                        
                        [testtable removeFromSuperview];
                        testtable = [[UITableView alloc] init];
                        [testtable setDelegate:self];
                        [testtable setDataSource:self];
                        [testtable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                        [testtable setBackgroundColor:[UIColor clearColor]];
                        [self.view addSubview:testtable];
                        
                        testtable.frame= CGRectMake(32, 65, self.view.bounds.size.width-64, self.view.bounds.size.height- 65);
                        //                numb = self.view.bounds.size.width/80;
                    }
                    else
                        testtable.frame= CGRectMake(32, 5, self.view.bounds.size.width-64, self.view.bounds.size.height-5);
                    //                numb = self.view.bounds.size.width/80;
                    [testtable reloadData];
                    
                }
                    break;
                    
            };
            
        }
            break;
    }
    
}

-(void)tap_on_toast:(UIGestureRecognizer *)sender
{
    NSLog(@"peyche");
    toast_view.hidden=YES;
}

@end