//
//  AssetTablePicker.m
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "ELCAssetTablePicker.h"
#import "ELCAssetCell.h"
#import "ELCAsset.h"
#import "ELCAlbumPickerController.h"

@interface ELCAssetTablePicker (){
    
    UIButton *button;
    
}

@property (nonatomic, assign) int columns;

@end

@implementation ELCAssetTablePicker

@synthesize parent = _parent;;
@synthesize selectedAssetsLabel = _selectedAssetsLabel;
@synthesize assetGroup = _assetGroup;
@synthesize elcAssets = _elcAssets;
@synthesize singleSelection = _singleSelection;
@synthesize columns = _columns;

- (void)viewDidLoad
{

    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setAllowsSelection:NO];

    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    self.elcAssets = tempArray;
    [tempArray release];
	
    if (self.immediateReturn) {
        
    } else {
        UIBarButtonItem *doneBack = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Show"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(doneAction:)];
        self.navigationItem.RightBarButtonItem = doneBack;
        [doneBack setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
//        UIBarButtonItem *doneButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)] autorelease];
//        [self.navigationItem setRightBarButtonItem:doneButtonItem];
        [self.navigationItem setTitle:@"Loading..."];
        
        button =  [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(returnBack)forControlEvents:UIControlEventTouchUpInside];
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
        
        self.navigationItem.hidesBackButton = YES;
        
    }

	[self performSelectorInBackground:@selector(preparePhotos) withObject:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.columns = self.view.bounds.size.width / 80;
}
-(void)returnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    self.columns = self.view.bounds.size.width / 80;
    [self.tableView reloadData];
}

- (void)preparePhotos
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if(result == nil) {
            return;
        }

        ELCAsset *elcAsset = [[ELCAsset alloc] initWithAsset:result];
        [elcAsset setParent:self];
        
        BOOL isAssetFiltered = NO;
        if (self.assetPickerFilterDelegate &&
           [self.assetPickerFilterDelegate respondsToSelector:@selector(assetTablePicker:isAssetFilteredOut:)])
        {
	        isAssetFiltered = [self.assetPickerFilterDelegate assetTablePicker:self isAssetFilteredOut:(ELCAsset*)elcAsset];
        }

        if (!isAssetFiltered) {
	        [self.elcAssets addObject:elcAsset];
        }
        
        [elcAsset release];
     }];
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        
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
        UIView *toast_view = [[UIView alloc] initWithFrame:CGRectMake(10, y_axis/2-100, x_axis-20, 100)];
        toast_view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.76f];
        toast_view.alpha= 1.0;
        toast_view.layer.zPosition = 1.0;
        
        UILabel *text_for_show = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, toast_view.frame.size.width, 100)];
        text_for_show.backgroundColor = [UIColor clearColor];
        text_for_show.font = [UIFont boldSystemFontOfSize:19];
        text_for_show.text=@"Tap on the images to show";
        text_for_show.textColor = [UIColor redColor];
        text_for_show.textAlignment = NSTextAlignmentCenter;
        [toast_view addSubview:text_for_show];
        [self.view addSubview:toast_view];
        
        if([self.elcAssets count]>0)
        {
            
            [UIView transitionWithView: toast_view
                              duration: 3.75f
                               options: UIViewAnimationOptionTransitionCrossDissolve
                            animations: ^(void)
            {
                [self.tableView reloadData];
                toast_view.alpha = 0.0;
            }
                            completion: ^(BOOL isFinished){
                                // scroll to bottom
//                                long section = [self numberOfSectionsInTableView:self.tableView] - 1;
//                                long row = [self tableView:self.tableView numberOfRowsInSection:section] - 1;
//                                if (section >= 0 && row >= 0) {
//                                    NSIndexPath *ip = [NSIndexPath indexPathForRow:row
//                                                                         inSection:section];
//                                    [self.tableView scrollToRowAtIndexPath:ip
//                                                          atScrollPosition:UITableViewScrollPositionBottom
//                                                                  animated:NO];
//                                }

                            }];
            
            
            if([self.elcAssets count]>1)
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
            
        [self.navigationItem setTitle:self.singleSelection ? @"Pick Photo" : @"There are no photos"];
        }
    });
    
    [pool release];

}

- (void)doneAction:(id)sender
{
	NSMutableArray *selectedAssetsImages = [[[NSMutableArray alloc] init] autorelease];
	    
	for(ELCAsset *elcAsset in self.elcAssets) {

		if([elcAsset selected]) {
			
			[selectedAssetsImages addObject:[elcAsset asset]];
		}
	}
        
    [self.parent selectedAssets:selectedAssetsImages];
}


- (BOOL)shouldSelectAsset:(ELCAsset *)asset {
    NSUInteger selectionCount = 0;
    for (ELCAsset *elcAsset in self.elcAssets) {
        if (elcAsset.selected) selectionCount++;
    }
    BOOL shouldSelect = YES;
    if ([self.parent respondsToSelector:@selector(shouldSelectAsset:previousCount:)]) {
        shouldSelect = [self.parent shouldSelectAsset:asset previousCount:selectionCount];
    }
    return shouldSelect;
}

- (void)assetSelected:(id)asset
{
    if (self.singleSelection) {

        for(ELCAsset *elcAsset in self.elcAssets) {
            if(asset != elcAsset) {
                elcAsset.selected = NO;
            }
        }
    }
    if (self.immediateReturn) {
        NSArray *singleAssetArray = [NSArray arrayWithObject:[asset asset]];
        [(NSObject *)self.parent performSelector:@selector(selectedAssets:) withObject:singleAssetArray afterDelay:0];
    }
}

#pragma mark UITableViewDataSource Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ceil([self.elcAssets count] / (float)self.columns);
}

- (NSArray *)assetsForIndexPath:(NSIndexPath *)path
{
    long index = path.row * self.columns;
    long length = MIN(self.columns, [self.elcAssets count] - index);
    return [self.elcAssets subarrayWithRange:NSMakeRange(index, length)];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"Cell";
        
    ELCAssetCell *cell = (ELCAssetCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {		        
        cell = [[[ELCAssetCell alloc] initWithAssets:[self assetsForIndexPath:indexPath] reuseIdentifier:CellIdentifier] autorelease];

    } else {		
		[cell setAssets:[self assetsForIndexPath:indexPath]];
	}
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	return 79;
}

- (int)totalSelectedAssets {
    
    int count = 0;
    
    for(ELCAsset *asset in self.elcAssets) {
		if([asset selected]) {   
            count++;	
		}
	}
    
    return count;
}

- (void)dealloc 
{
    [_assetGroup release];    
    [_elcAssets release];
    [_selectedAssetsLabel release];
    [super dealloc];    
}

@end
