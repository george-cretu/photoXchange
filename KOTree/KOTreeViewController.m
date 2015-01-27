//
//  KOSelectingViewController.m
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "AFNetworking.h"
#import "KOTreeViewController.h"
#import "KOTreeTableViewCell.h"
#import "KOTreeItem.h"
#import "SVProgressHUD.h"
#import "ImageDetailViewController.h"
#import "AFHTTPRequestOperation.h"
#import "FTPListingViewController.h"
@implementation KOTreeViewController
{
    NSMutableArray *all_folder_data;
    NSString *path_new, *thumb_new_path;
    NSString *check_path, *imageSelected;
    NSMutableArray *success_Array;
    UIAlertView *alert, *copyAlert;
    UIButton *button;
}
@synthesize treeTableView;
@synthesize treeItems,another_new_array,folder_path_to_be_moved,img_to_be_shared,asset_url;
@synthesize selectedTreeItems,type;
@synthesize img_to_shared_array,original_array;
@synthesize image_to_be_copy;
@synthesize imageName;

- (id) init
{
    self = [super init];
    if (!self) return nil;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"queueFinished"
                                               object:nil];
    
    return self;
}
- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"queueFinished"])
    {

            int count_uploaded_success=0;
        
        if([img_to_shared_array count] == [success_Array count])
        {
            for (int j=0;j<[img_to_shared_array count];j++)
            {
                if([[success_Array objectAtIndex:j] isEqualToString:@"1"])
                {
                    count_uploaded_success  ++;
                }
            }
            if([img_to_shared_array count]== count_uploaded_success && [success_Array count]>0)
            {
                [SVProgressHUD dismiss];
                
                [SVProgressHUD showSuccessWithStatus:@"All images have been uploaded successfully"];
                
                NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@PXC_dropdownjson.php?ftp=../user/%@",mydomainurl,[[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                NSLog(@" path is %@",[NSString stringWithFormat:@"%@PXC_dropdownjson.php?ftp=../user/%@",mydomainurl,[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]]);
                AFJSONRequestOperation *operation =
                [AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:requestURL]
                 // 3
                                                                success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                 {
                     all_folder_data = [[NSMutableArray alloc] init];
                     
                     all_folder_data = [(NSDictionary *)JSON objectForKey:@"root"];
                     self.treeItems = [[NSMutableArray alloc] init];
                     self.treeItems = [self initializeArray :all_folder_data];
                     
                     [treeTableView reloadData];
                     
                 }
                                                                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                                                                                 message:@"There is an issue with your internet connectivity"
                                                                                                                delegate:nil
                                                                                                       cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                                    [av show];
                                                                }];
                
                [operation start];
            }
            else
            {
                [SVProgressHUD dismiss];
                
                [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%d images have been uploaded successfully",count_uploaded_success]];
                
                
                NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@PXC_dropdownjson.php?ftp=../user/%@",mydomainurl,[[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                NSLog(@" path is %@",[NSString stringWithFormat:@"%@PXC_dropdownjson.php?ftp=../user/%@",mydomainurl,[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]]);
                AFJSONRequestOperation *operation =
                [AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:requestURL]
                 // 3
                                                                success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                 {
                     all_folder_data = [[NSMutableArray alloc] init];
                     self.treeItems = [[NSMutableArray alloc] init];
                     all_folder_data = [(NSDictionary *)JSON objectForKey:@"root"];
                     self.treeItems = [self initializeArray :all_folder_data];
                     
                     [treeTableView reloadData];
                     
                 }
                                                                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                                                                                 message:@"There is an issue with your internet connectivity"
                                                                                                                delegate:nil
                                                                                                       cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                                    [av show];
                                                                }];
                
                [operation start];
                
            }
        }
    }
}


- (NSMutableArray *)listItemsAtPath:(NSString *)path {
    
    NSMutableArray *returnable_array = [[NSMutableArray alloc] init];
    NSMutableArray *initial_array = [self initializeArray:all_folder_data];
    for (KOTreeItem *obj in initial_array)
    {
        [self addchildren:obj:path:returnable_array];
        
    }
    return returnable_array;
}
-(void)addchildren :(KOTreeItem *)node_to_be_searched :(NSString *)path :(NSMutableArray *)array
{
    if([node_to_be_searched.path isEqualToString:path])
    {
       [array addObject:node_to_be_searched];
    }
    else if([node_to_be_searched numberOfSubitems]>0)
    {
        for (int count=0;count<[node_to_be_searched numberOfSubitems];count++)
        {
            [self addchildren:[node_to_be_searched.ancestorSelectingItems objectAtIndex:count ] :path :array];
        }
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"jbeinij");
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[ver objectAtIndex:0] intValue] >= 7)
    {
        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars=NO;
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    [super viewWillAppear:NO];
}
- (void)viewDidLoad
{
    all_folder_data = [[NSMutableArray alloc] init];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"top-bar@2x.png"]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationItem setTitle:@"Choose Folder"];
    self.navigationItem.titleView.tintColor= [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    
    
    button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(goToFTP)forControlEvents:UIControlEventTouchUpInside];
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
    
    [super viewDidLoad];
	self.selectedTreeItems = [NSMutableArray array];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg@2x.png"]]];
    
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@PXC_dropdownjson.php?ftp=../user/%@",mydomainurl,[[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    NSLog(@" path is %@",[NSString stringWithFormat:@"%@PXC_dropdownjson.php?ftp=../user/%@",mydomainurl,[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]]);
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:requestURL]
     // 3
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
     {
         all_folder_data = [(NSDictionary *)JSON objectForKey:@"root"];
         self.treeItems = [self initializeArray :all_folder_data];
         
         CGFloat width_tbl,height_tbl;
         switch (self.interfaceOrientation) {
             case UIInterfaceOrientationLandscapeLeft:
             case UIInterfaceOrientationLandscapeRight:
             {
//                 treeTableView = [[UITableView alloc] init];
                 width_tbl = [[UIScreen mainScreen]bounds].size.height;
                 height_tbl = [[UIScreen mainScreen]bounds].size.width-20;
                 
                 if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
                 {
//                     treeTableView = [[UITableView alloc] init];
                     treeTableView.frame = CGRectMake(0, 0, width_tbl, height_tbl-20);
                 }
                 else
                 {
                     if([type isEqualToString:@"MOVE"])
                         treeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width_tbl, height_tbl) style:UITableViewStylePlain];
                     else
                     {
                     NSLog(@"eta appear er landscape");
                         if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"started"] isEqualToString:@"yes"])
                         {
//                             treeTableView = [[UITableView alloc] init];
                             treeTableView.frame = CGRectMake(0, 25-35, width_tbl, height_tbl);
                         }
                         else
                         {
//                             treeTableView = [[UITableView alloc] init];
                             treeTableView.frame = CGRectMake(0, 25, width_tbl, height_tbl);
                         }
                     }
                 }
             }
                 break;
             case UIInterfaceOrientationPortraitUpsideDown:
             case UIInterfaceOrientationPortrait:
             {
//                 treeTableView = [[UITableView alloc] init];
                 height_tbl = [[UIScreen mainScreen]bounds].size.height-114/2;
                 width_tbl = [[UIScreen mainScreen]bounds].size.width;
                 
                 if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
                 {
                     treeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width_tbl, height_tbl-20) style:UITableViewStylePlain];
                 }
                 else
                 {
                     if([type isEqualToString:@"MOVE"])
                       treeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width_tbl, height_tbl) style:UITableViewStylePlain];
                     else
                     {
                     NSLog(@"eta appear er portrait");
                         if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"started"] isEqualToString:@"yes"])
                     treeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45-43, width_tbl, height_tbl) style:UITableViewStylePlain];
                         else
                     treeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, width_tbl, height_tbl) style:UITableViewStylePlain];
                     }
                 }
             }
                 break;
         }
         if([self.treeItems count]>0)
         {
            
//           [treeTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
             [treeTableView setBackgroundColor:[UIColor clearColor]];
             [treeTableView setBackgroundColor:[UIColor colorWithRed:1 green:0.976 blue:0.957 alpha:1]];
             [treeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
             [treeTableView setRowHeight:65.0f];
             [treeTableView setDelegate:(id<UITableViewDelegate>)self];
             [treeTableView setDataSource:(id<UITableViewDataSource>)self];
            
             [self.view addSubview:treeTableView];
         }
         
     }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                                                                     message:@"There is an issue with your internet connectivity"
                                                                                                    delegate:nil
                                                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                        [av show];
                                                    }];
    
	 [operation start];
    
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
//    if([type isEqualToString:@"COPY"])
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:@"COPY" forKey:@"function_type"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"function_type"];
//    }
}
- (void) orientationChanged:(NSNotification *)note
{
    CGFloat width_tbl,height_tbl;
        UIDevice * device = note.object;
        switch(device.orientation)
        {
                    case UIInterfaceOrientationLandscapeLeft:
                    case UIInterfaceOrientationLandscapeRight:
                    {
//                        treeTableView = [[UITableView alloc] init];
                        width_tbl = [[UIScreen mainScreen]bounds].size.height;
                        height_tbl = [[UIScreen mainScreen]bounds].size.width-20;
                        
                        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
                        {
//                            treeTableView = [[UITableView alloc] init];
                             treeTableView.frame = CGRectMake(0, 0, width_tbl, height_tbl-20);
                        }
                        else
                        {
                            if([type isEqualToString:@"MOVE"])
                            {
//                                treeTableView = [[UITableView alloc] init];
                                treeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width_tbl, height_tbl) style:UITableViewStylePlain];
                            }
                            else
                            {
                            NSLog(@"eta orientation er landscape");
                                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"started"] isEqualToString:@"yes"])
                                {
//                                    treeTableView = [[UITableView alloc] init];
                                    treeTableView.frame = CGRectMake(0, 25-35, width_tbl, height_tbl);
                                }
                                else
                                {
//                                    treeTableView = [[UITableView alloc] init];
                                    treeTableView.frame = CGRectMake(0, 25, width_tbl, height_tbl);
                                }
                            }
                        }
                       
                    }
                        break;
                
                    case UIInterfaceOrientationPortrait:
                    {
//                        treeTableView = [[UITableView alloc] init];
                        height_tbl = [[UIScreen mainScreen]bounds].size.height-114/2;
                        width_tbl = [[UIScreen mainScreen]bounds].size.width;
                        
                        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
                        {
//                            treeTableView = [[UITableView alloc] init];
                            treeTableView.frame = CGRectMake(0, 0, width_tbl, height_tbl);
                            NSLog(@"tree table view height: --> %f",treeTableView.frame.size.height);
                        }
                        else
                        {
                            if([type isEqualToString:@"MOVE"])
                            {
//                                treeTableView = [[UITableView alloc] init];
                                treeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width_tbl, height_tbl) style:UITableViewStylePlain];
                            }
                            else
                            {
                            NSLog(@"eta orientation er portrait");
                            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"started"] isEqualToString:@"yes"])
                            {
//                                treeTableView = [[UITableView alloc] init];
                                treeTableView.frame = CGRectMake(0, 45-43, width_tbl, height_tbl);
                            }
                            else
                            {
//                                treeTableView = [[UITableView alloc] init];
                                treeTableView.frame = CGRectMake(0, 45, width_tbl, height_tbl);
                            }
                          }
                        }
                    }
                        break;
            case UIDeviceOrientationPortraitUpsideDown:
            case UIDeviceOrientationFaceDown:
            case UIDeviceOrientationFaceUp:
            case UIDeviceOrientationUnknown:
                break;
        }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

-(void)goToFTP
{
    FTPListingViewController *reset = [[FTPListingViewController alloc]init];
    reset.selectedIndexPaths=[[NSMutableArray alloc]init];

    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];

}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	treeTableView = [[UITableView alloc] init];
	[[[self treeTableView] delegate] tableView:treeTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

-(NSMutableArray *)initializeArray :(NSMutableArray *)return_data
{
    NSMutableArray *initial_array = [[NSMutableArray alloc] init];
    for (NSDictionary *folder_dict in return_data)
    {
        KOTreeItem *tree_item = [[KOTreeItem alloc] init];
        [tree_item setSubmersionLevel:0];
        [tree_item setBase:[folder_dict objectForKey:@"name"]];
        [tree_item setPath:[folder_dict objectForKey:@"path"]];
        [tree_item setNumberOfImages:[[folder_dict objectForKey:@"number_of_images"] integerValue]];
        [tree_item setParentSelectingItem:nil];
        
        NSMutableArray *children = (NSMutableArray *)[folder_dict objectForKey:@"child"];
        [tree_item setNumberOfSubitems:[children count]];
        
        NSMutableArray *get_child_objects = [[NSMutableArray alloc] init];
        if([children count]>0)
        {
            for ( int x= 0;x<[children count];x++)
            {
                KOTreeItem *return_child_obj = [self returnNewKOTreeItem:1 :(NSDictionary*)[children objectAtIndex:x] :tree_item];
                [get_child_objects addObject: return_child_obj];
            }
        }
        [tree_item setAncestorSelectingItems:get_child_objects];
        
         [initial_array addObject:tree_item];
    }
    return initial_array;
}
-(KOTreeItem *)returnNewKOTreeItem :(int)Submersionlevel :(NSDictionary *)child_folder :(KOTreeItem *)ParentSelectingItem
{
    KOTreeItem *child_item = [[KOTreeItem alloc] init];
    [child_item setSubmersionLevel:Submersionlevel];
	[child_item setBase:[child_folder objectForKey:@"name"]];
	[child_item setPath:[child_folder objectForKey:@"path"]];
    [child_item setNumberOfImages:[[child_folder objectForKey:@"number_of_images"] integerValue]];
	[child_item setParentSelectingItem:ParentSelectingItem];
    
    NSMutableArray *children = (NSMutableArray *)[child_folder objectForKey:@"child"];
	[child_item setNumberOfSubitems:[children count]];
    
    NSMutableArray *get_child_objects = [[NSMutableArray alloc] init];
    if([children count]>0)
    {
        for ( int x= 0;x<[children count];x++)
        {
            KOTreeItem *return_child_obj = [self returnNewKOTreeItem:Submersionlevel+1 :(NSDictionary*)[children objectAtIndex:x] :child_item];
            [get_child_objects addObject: return_child_obj];
        }
    }
    [child_item setAncestorSelectingItems:get_child_objects];
    return child_item;
}
#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.treeItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	KOTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectingTableViewCell"];
	if (!cell)
		cell = [[KOTreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectingTableViewCell"];
	
	KOTreeItem *treeItem = [self.treeItems objectAtIndex:indexPath.row];
	
	cell.treeItem = treeItem;
	
    if(![type isEqualToString:@"MOVE"])
    {
        [cell.iconButton setHidden:YES];
        [cell.upload_button setHidden:NO];
    }
    else
    {
        [cell.iconButton setHidden:NO];
        [cell.upload_button setHidden:YES];
    }
	[cell.iconButton setSelected:[self.selectedTreeItems containsObject:cell.treeItem]];
	

    if ([treeItem numberOfSubitems]> 0)
    {
       [cell.countLabel setText:@"Enter"];
        [cell.countLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"item-counter"]]];
    }
	else{
        
        [cell.countLabel setHidden:NO];
        [cell.countLabel setText:@""];
        [cell.countLabel setBackgroundColor:[UIColor clearColor]];
    }
		
	if([treeItem numberOfImages]>0)
    {
        [cell.titleTextField setText:[NSString stringWithFormat:@"%@ (%d)",[treeItem base],[treeItem numberOfImages]]];
    }
    else
    {
        [cell.titleTextField setText:[treeItem base]];
    }
	

   
	[cell.titleTextField sizeToFit];
	
	[cell setDelegate:(id<KOTreeTableViewCellDelegate>)self];

	[cell setLevel:[treeItem submersionLevel]];
	
	return cell;
}

- (void)selectingItemsToDelete:(KOTreeItem *)selItems saveToArray:(NSMutableArray *)deleteSelectingItems{
	for (KOTreeItem *obj in selItems.ancestorSelectingItems) {
		[self selectingItemsToDelete:obj saveToArray:deleteSelectingItems];
	}
	
	[deleteSelectingItems addObject:selItems];
}

- (NSMutableArray *)removeIndexPathForTreeItems:(NSMutableArray *)treeItemsToRemove {
	NSMutableArray *result = [NSMutableArray array];
	
	for (NSInteger i = 0; i < [treeTableView numberOfRowsInSection:0]; ++i) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
		KOTreeTableViewCell *cell = (KOTreeTableViewCell *)[treeTableView cellForRowAtIndexPath:indexPath];

		for (KOTreeItem *tmpTreeItem in treeItemsToRemove) {
			if ([cell.treeItem isEqualToSelectingItem:tmpTreeItem])
				[result addObject:indexPath];
		}
	}	
	
	return result;
}
- (void)tableViewAction:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath {
	
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self tableViewAction:tableView withIndexPath:indexPath];
	
	KOTreeTableViewCell *cell = (KOTreeTableViewCell *)[treeTableView cellForRowAtIndexPath:indexPath];
	
	NSInteger insertTreeItemIndex = [self.treeItems indexOfObject:cell.treeItem];
	NSMutableArray *insertIndexPaths = [NSMutableArray array];
	NSMutableArray *insertselectingItems = [self listItemsAtPath:[cell.treeItem.path stringByAppendingPathComponent:cell.treeItem.base]];
  
	
	NSMutableArray *removeIndexPaths = [NSMutableArray array];
	NSMutableArray *treeItemsToRemove = [NSMutableArray array];
	
	for (KOTreeItem *tmpTreeItem in insertselectingItems) {
        
		[tmpTreeItem setPath:[cell.treeItem.path stringByAppendingPathComponent:cell.treeItem.base]];
		[tmpTreeItem setParentSelectingItem:cell.treeItem];
		
		[cell.treeItem.ancestorSelectingItems removeAllObjects];
		[cell.treeItem.ancestorSelectingItems addObjectsFromArray:insertselectingItems];
        
		insertTreeItemIndex++;
		
		BOOL contains = NO;
		
		for (KOTreeItem *tmp2TreeItem in self.treeItems) {
			if ([tmp2TreeItem isEqualToSelectingItem:tmpTreeItem]) {
				contains = YES;
				[self selectingItemsToDelete:tmp2TreeItem saveToArray:treeItemsToRemove];
				
				removeIndexPaths = [self removeIndexPathForTreeItems:(NSMutableArray *)treeItemsToRemove];
			}
		}
		
		for (KOTreeItem *tmp2TreeItem in treeItemsToRemove) {
			[self.treeItems removeObject:tmp2TreeItem];
			
			for (KOTreeItem *tmp3TreeItem in self.selectedTreeItems) {
				if ([tmp3TreeItem isEqualToSelectingItem:tmp2TreeItem]) {
					NSLog(@"%@", tmp3TreeItem.base);
					[self.selectedTreeItems removeObject:tmp2TreeItem];
					break;
				}
			}
		}
		
		if (!contains) {
			[tmpTreeItem setSubmersionLevel:tmpTreeItem.submersionLevel];
			
			[self.treeItems insertObject:tmpTreeItem atIndex:insertTreeItemIndex];
			
			NSIndexPath *indexPth = [NSIndexPath indexPathForRow:insertTreeItemIndex inSection:0];
			[insertIndexPaths addObject:indexPth];
		}
        
	}
	
	if ([insertIndexPaths count])
		[treeTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
	
	if ([removeIndexPaths count])
		[treeTableView deleteRowsAtIndexPaths:removeIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
}

#pragma mark - Actions

- (void)iconButtonAction:(KOTreeTableViewCell *)cell treeItem:(KOTreeItem *)tmpTreeItem {
   
	if ([self.selectedTreeItems containsObject:cell.treeItem]) {
		[cell.iconButton setSelected:NO];		
		[self.selectedTreeItems removeObject:cell.treeItem];
	} else {
		[cell.iconButton setSelected:YES];
		
		[self.selectedTreeItems removeAllObjects];
		[self.selectedTreeItems addObject:cell.treeItem];
		
		[treeTableView reloadData];
	}
}

#pragma mark - KOTreeTableViewCellDelegate

- (void)treeTableViewCell:(KOTreeTableViewCell *)cell didTapIconWithTreeItem:(KOTreeItem *)tmpTreeItem {
     path_new = [NSString stringWithFormat:@"%@/%@",[tmpTreeItem path],[tmpTreeItem base]];
//    NSLog(@" type is %@",type);
    thumb_new_path = [path_new stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"];
    
    NSLog(@"thumb bhaswar: %@",thumb_new_path);
    
    if ([type isEqualToString:@"COPY"]) {  //========================================================================COPY IMAGE================<<
        
        check_path = [NSString stringWithFormat:@"%@",image_to_be_copy];
        imageSelected = [NSString stringWithFormat:@"%@",imageName];
        
        
        copyAlert = [[UIAlertView alloc] initWithTitle:@"Accept" message:@"Do you want to copy your image here" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [copyAlert setTag:909];
        [copyAlert show];
        
        [self iconButtonAction:cell treeItem:tmpTreeItem];

    }
    else if([type isEqualToString:@"MOVE"])
    {
        check_path = [NSString stringWithFormat:@"%@",folder_path_to_be_moved];
        
        
        alert = [[UIAlertView alloc] initWithTitle:@"Accept" message:@"Do you want to move your folder here" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alert setTag:1];
        [alert show];
        
        [self iconButtonAction:cell treeItem:tmpTreeItem];
    }
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Do you want to upload your image here" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alert.tag = 2;
        [alert show];
    }
  
}
-(void)treeTableViewCell:(KOTreeTableViewCell *)cell uploadImageTo:(KOTreeItem *)treeItem
{
//    path_new = [NSString stringWithFormat:@"%@/%@",[treeItem path],[treeItem base]];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Do you want to upload your image here" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    alert.tag = 2;
//    [alert show];
    
    path_new = [NSString stringWithFormat:@"%@/%@",[treeItem path],[treeItem base]];
    
    thumb_new_path = [path_new stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"];
    
    NSLog(@"thumb bhaswar 2: %@",thumb_new_path);

    //    NSLog(@" type is %@",type);
    if([type isEqualToString:@"MOVE"])
    {
        check_path = [NSString stringWithFormat:@"%@",folder_path_to_be_moved];
        
        
        alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Do you want to move your folder here?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alert setTag:1];
        [alert show];
        
        [self iconButtonAction:cell treeItem:treeItem];
    }
    else
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Do you want to upload your image here?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alert.tag = 2;
        [alert show];
    }
    
}
//- (void)treeTableViewCell:(KOTreeTableViewCell *)cell copyImageTo:(KOTreeItem *)tmpTreeItem {
//    path_new = [NSString stringWithFormat:@"%@/%@",[tmpTreeItem path],[tmpTreeItem base]];
//    
//    NSLog(@"NEW PATH IS===============> %@",path_new);
//    
//    if([type isEqualToString:@"COPY"])
//    {
//        check_path = [NSString stringWithFormat:@"%@",image_to_be_copy];
//        imageSelected = [NSString stringWithFormat:@"%@",imageName];
//        
//        
//        copyAlert = [[UIAlertView alloc] initWithTitle:@"Accept" message:@"Do you want to copy your image here" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//        [copyAlert setTag:909];
//        [copyAlert show];
//        
//        [self iconButtonAction:cell treeItem:tmpTreeItem];
//    }
//    else
//    {
//        copyAlert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Do you want to copy your image here" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//        copyAlert.tag = 2;
//        [copyAlert show];
//    }
    
//}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if([alertView tag]==1)
    {
       
        switch (buttonIndex) {
            case 0:
            {
                NSLog(@"Cancelled");
            }
                break;
                
            case 1:
            {
                NSString *url_string = [[NSString alloc] init];
                
                url_string = [NSString stringWithFormat:@"%@iosphoto_action.php?action=move&dir=%@&old_name=%@&new_name=%@&old_name_thumb=%@&new_name_thumb=%@&user_id=%@",mydomainurl,[[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[check_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[path_new stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [[check_path stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[path_new stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]];
                NSLog(@" url is %@",url_string);
               
                [SVProgressHUD show];
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url_string]
                                                         cachePolicy:nil
                                                     timeoutInterval:2.0];
                AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                
                
                [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
                 {
                    
                     if([operation.response statusCode]==200)
                     {
                          [SVProgressHUD dismiss];
                         [self goToFTP];
                         
                     }
                     
                     
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                 {
                     NSLog(@" error is %@",error.localizedDescription);
                 }];
                
                [operation start];
                
                
            }
                break;
        }
    }
    else
    {
       
       
        switch (buttonIndex) {
            case 0:
               
                break;
                
            case 1:
            {
                 [SVProgressHUD showWithStatus:@"Uploading..." maskType:SVProgressHUDMaskTypeBlack];

                 success_Array = [[NSMutableArray alloc] initWithCapacity:[img_to_shared_array count]];
                  ALAssetsLibrary *library_of_phone = [[ALAssetsLibrary alloc] init];
                    self.networkQueue = [[NSOperationQueue alloc] init];
                    self.networkQueue.name = @"com.domain.app.networkqueue";
                   self.networkQueue.maxConcurrentOperationCount=[img_to_shared_array count];
                
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
                {
                    for (int j=0;j<[img_to_shared_array count];j++)
                    {
                        @try {
                            
                        [library_of_phone assetForURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[img_to_shared_array objectAtIndex:j]]] resultBlock:^(ALAsset *asset) {
                            
                            if(asset)
                            {
                                NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:1.0 orientation:[[asset defaultRepresentation] orientation]], 1.0);
                                
                                
                                NSString *asset_local_url=[NSString stringWithFormat:@"%@",[img_to_shared_array objectAtIndex:j]];
                                NSBlockOperation *operation_up = [NSBlockOperation blockOperationWithBlock:^{
                                
                                   
                                        NSString *boundary =[NSString stringWithFormat:@"%0.9u",arc4random()];
                                        NSMutableData *body = [NSMutableData data];
                                        
                                        if (imageData) {
                                            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image_upload\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                                            [body appendData:imageData];
                                            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                        }
                                        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                        
                                        
                                        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
                                        sessionConfiguration.HTTPAdditionalHeaders = @{
                                                                                       @"Content-Type"  : [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary]
                                                                                       };
                                        
                                        // Create the session
                                        // We can use the delegate to track upload progress
                                        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
                                        
                                        
                                        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@iosphoto_action.php?action=image_upload&url_of_image=%@&dir=%@&thumb_dir=%@&user_id=%@",mydomainurl,[[NSString stringWithFormat:@"%@",asset_local_url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[path_new stringByReplacingOccurrencesOfString:@".." withString:@""] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[thumb_new_path stringByReplacingOccurrencesOfString:@".." withString:@""] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]]];
                                    
                                    NSLog(@"url fired: %@",url);
                                    
                                        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                                        request.HTTPMethod = @"POST";
                                        request.HTTPBody = body;
                                        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:request completionHandler:^(NSData *returnData, NSURLResponse *response, NSError *error) {
                                            
                                            if(error)
                                            {
                                                NSLog(@" error is %@",error.localizedDescription);
                                                [success_Array addObject:@"0"];
                                                
                                                if([img_to_shared_array count]== [success_Array count])
                                                {
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"queueFinished" object:self];
                                                }
                                            }
                                            else
                                            {
                                                NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
                                                NSLog(@" returned data is %@",returnString);
                                                
                                                if ([returnString isEqualToString:@"too large file"])
                                                {
//                                                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Uploading"
//                                                                                                 message:@"You have exceeded the space limit, Please delete some files"
//                                                                                                delegate:nil
//                                                                                       cancelButtonTitle:@"OK" otherButtonTitles:nil];
////                                                    [av show];
                                                    [self performSelectorOnMainThread:@selector(showalert)
                                                                           withObject:nil
                                                                        waitUntilDone:YES];

                                                }
                                                [success_Array addObject:@"1"];
                                                
                                                if([img_to_shared_array count]== [success_Array count])
                                                {
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"queueFinished" object:self];
                                                }

                                                
                                            }
                                        }];
                                        [uploadTask resume];
                                }];
                                
                                [self.networkQueue addOperation:operation_up];
                                
//                                if(j== [img_to_shared_array count]-1)
//                                {
//                                    [self performSelectorInBackground:@selector(waitForQueue) withObject:nil];
//                                }
                                
                            }
                         
                        } failureBlock:^(NSError *error) {
                            
                        }];
                            
                        }
                        @catch (NSException *exception) {
                            NSLog( @"NSException caught" );
                            NSLog( @"Name: %@", exception.name);
                            NSLog( @"Reason: %@", exception.reason );
                        }
                        @finally {
                        }

                    }
                }
                        else
                        {
                            @try {
                                __block int count_for_j = 0;
                                for (int j=0;j<[img_to_shared_array count];j++)
                                {
                                    [library_of_phone assetForURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[img_to_shared_array objectAtIndex:j]]] resultBlock:^(ALAsset *asset) {
                                        
                                        if(asset)
                                        {
                                            count_for_j = j;
                                            
                                            NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:1.0 orientation:[[asset defaultRepresentation] orientation]], 1.0);
                                            
                                            
                                            NSString *asset_local_url=[NSString stringWithFormat:@"%@",[img_to_shared_array objectAtIndex:j]];
                                            
                                            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@iosphoto_action.php?action=image_upload&url_of_image=%@&dir=%@&thumb_dir=%@&user_id=%@",mydomainurl,[[NSString stringWithFormat:@"%@",asset_local_url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[path_new stringByReplacingOccurrencesOfString:@".." withString:@""] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[thumb_new_path stringByReplacingOccurrencesOfString:@".." withString:@""] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]]];
                                            
                                            NSLog(@"url fired: %@",url);
                                            
                                            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                                            
                                            [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
                                            
                                            [request setHTTPShouldHandleCookies:NO];
                                            
                                            [request setURL:url];
                                            
                                            [request setTimeoutInterval:10];
                                            
                                            [request setHTTPMethod:@"POST"];
                                            
                                            
                                            
                                            
                                            
                                            NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
                                            
                                            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
                                            
                                            [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
                                            
                                            
                                            
                                            NSMutableData *body = [NSMutableData data];
                                            
                                            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                            
                                            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image_upload\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                            
                                            [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                            
                                            [body appendData:[NSData dataWithData:imageData]];
                                            
                                            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                            
                                            [request setHTTPBody:body];
                                            
                                            
                                            
                                            
                                            
                                            [request setHTTPBody:body];
                                            
                                            
                                            
                                            [NSURLConnection sendAsynchronousRequest:request queue:self.networkQueue completionHandler:^(NSURLResponse *response, NSData *returnData, NSError *error)
                                             
                                             
                                             
                                             {
                                                 if(error)
                                                 {
                                                     NSLog(@" error is %@",error.localizedDescription);
                                                     
                                                     [success_Array addObject:@"0"];
                                                     
                                                     if([img_to_shared_array count]== [success_Array count])
                                                     {
                                                         [[NSNotificationCenter defaultCenter] postNotificationName:@"queueFinished" object:self];
                                                     }
                                                 }
                                                 else
                                                 {
                                                     NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
                                                     
                                                     NSLog(@" returned data is %@",returnString);
                                                     
                                                     
                                                     if ([returnString isEqualToString:@"too large file"])
                                                     {
//                                                         UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Uploading"
//                                                                                                      message:@"You have exceeded the space limit, Please delete some files"
//                                                                                                     delegate:nil
//                                                                                            cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                                                         [av show];
                                                         
                                                         [self performSelectorOnMainThread:@selector(showalert)
                                                                                withObject:nil
                                                                             waitUntilDone:YES];
                                                     }
                                                     
                                                     [success_Array addObject:@"1"];
                                                     
                                                     if([img_to_shared_array count]== [success_Array count])
                                                     {
                                                         [[NSNotificationCenter defaultCenter] postNotificationName:@"queueFinished" object:self];
                                                     }
                                                     
                                                 }
                                                 
                                             }];
                                            
                                        }
                                    } failureBlock:^(NSError *error) {  }];
                                }
                            }
                            @catch (NSException *exception) {
                                NSLog(@"exception is : %@",exception);
                            }
                            @finally {
                                
                            }
                            
                        }
                }
                //[self.networkQueue addObserver:self forKeyPath:@"operations" options:0 context:NULL];
                break;
            }
    }
    if ([copyAlert tag]== 909) {
        
        switch (buttonIndex) {
            case 0:
                
                break;
                
            case 1:
            {
                
                @try {
                
                    NSString *encodedimgstr = [self encodeToPercentEscapeString:imageSelected];
                [SVProgressHUD showWithStatus:@"Copying..." maskType:SVProgressHUDMaskTypeBlack];
                NSString *renameURL = [NSString stringWithFormat:@"%@photo_operation.php?action=copy_image&originalpath=%@&destinationpath=%@&originalpath_thumb=%@&destinationpath_thumb=%@&imagename=%@",mydomainurl, [check_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[path_new stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [[check_path stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[path_new stringByReplacingOccurrencesOfString:@"user/" withString:@"thumb/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],encodedimgstr];
                
                NSError *error=Nil;
                NSLog(@"FIRED URLlll===========================>%@",renameURL);
                NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:renameURL]options:NSDataReadingUncached error:&error];
                    
                    if (data == nil)
                    {
                        alert = [[UIAlertView alloc] initWithTitle:@"Error in Server Connection!"
                                                           message:nil
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"  otherButtonTitles:Nil, nil];
                        [alert show];
                    }
                    else
                    {

                NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data //1
                                    
                                                                   options:kNilOptions
                                    
                                                                     error:&error];
                
                NSLog(@"JSON==============>%@",json);
                
                if ([[json objectForKey:@"msg"]  isEqual: @"success"]) {
                    
                    UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Successfully copied" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [renameAlert show];
                    
                    [SVProgressHUD dismiss];
                    
                   
                    
//                    [self starttheftplisting];
                    
                    
                    
                }else if ([[json objectForKey:@"msg"] isEqualToString:@"file with this name already exits"])
                {
                    [SVProgressHUD dismiss];
                    
                    UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"An Image with the same name already exists!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [renameAlert show];
                }
                else if ([[json objectForKey:@"msg"] isEqualToString:@"file is too large"])
                        {
                            //                                                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Uploading"
                            //                                                                                                 message:@"You have exceeded the space limit, Please delete some files"
                            //                                                                                                delegate:nil
                            //                                                                                       cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            ////                                                    [av show];
                            [SVProgressHUD dismiss];
                            [self performSelectorOnMainThread:@selector(showalert)
                                                   withObject:nil
                                                waitUntilDone:YES];
                            
                        }

                else{
                    
                    [SVProgressHUD dismiss];
                    
//                    UIAlertView *renameAlert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Unsucessful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                    [renameAlert show];
                    }
                }
                    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@PXC_dropdownjson.php?ftp=../user/%@",mydomainurl,[[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                    NSLog(@" path is %@",[NSString stringWithFormat:@"%@PXC_dropdownjson.php?ftp=../user/%@",mydomainurl,[[NSUserDefaults standardUserDefaults] objectForKey:@"ftp_path"]]);
                    AFJSONRequestOperation *operation =
                    [AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:requestURL]
                     // 3
                                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                     {
                         all_folder_data = [[NSMutableArray alloc] init];
                         self.treeItems = [[NSMutableArray alloc] init];
                         all_folder_data = [(NSDictionary *)JSON objectForKey:@"root"];
                         self.treeItems = [self initializeArray :all_folder_data];
                         
                         [treeTableView reloadData];
                         
                     }
                                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                                                                                     message:@"There is an issue with your internet connectivity"
                                                                                                                    delegate:nil
                                                                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                                        [av show];
                                                                    }];
                    
                    [operation start];

                }
                @catch (NSException *exception) {
                    NSLog(@"exception dropbox: %@",exception);
                }
                @finally {
                }
            }
                break;
        }
    }
}
- (void)waitForQueue {
    [self.networkQueue waitUntilAllOperationsAreFinished];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"queueFinished" object:self];
}

-(void)showalert{
    
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Uploading"
                                                 message:@"You have exceeded the space limit, Please delete some files"
                                                delegate:nil
                                                cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
    
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